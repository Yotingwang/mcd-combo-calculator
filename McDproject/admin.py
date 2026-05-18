import streamlit as st
import pandas as pd
from sqlalchemy import create_engine, text
import time  # 引入 time 模組以處理延遲刷新
import re # 記得在檔案最上面加上這行 import
from datetime import datetime
import json
from collections import defaultdict


# ---------------- Streamlit 頁面設定 ----------------
st.set_page_config(
    page_title="McD Combo Admin Pro",
    page_icon="🍔",
    layout="wide",
)


# ---------------- 資料庫連線設定 ----------------
@st.cache_resource
def get_engine():
    try:
        mysql_conf = st.secrets["mysql"]
        conn_str = (
            f"mysql+pymysql://"
            f"{mysql_conf['user']}:{mysql_conf['password']}"
            f"@{mysql_conf['host']}:{mysql_conf['port']}/{mysql_conf['database']}"
        )
        return create_engine(conn_str)
    except Exception as e:
        st.error(f"資料庫連線失敗，請檢查 .streamlit/secrets.toml 設定。錯誤訊息: {e}")
        return None


engine = get_engine()


# ID 生成器：根據方案生成關聯的 combination_id
def generate_combo_id_by_option(conn, option_id):
    opt_num = re.search(r'\d+', option_id)
    if not opt_num:
        return generate_new_id(conn, "all_combinations", "combination_id", "C", width=5)
    
    prefix = opt_num.group()
    
    sql = """
    SELECT combination_id FROM all_combinations 
    WHERE option_id = :opt AND combination_id LIKE :prefix
    ORDER BY LENGTH(combination_id) DESC, combination_id DESC 
    LIMIT 1
    """
    result = conn.execute(text(sql), {"opt": option_id, "prefix": f"C{prefix}%"}).fetchone()
    
    if result:
        try:
            match = re.search(r'\d+', result[0])
            if match:
                new_num = int(match.group()) + 1
            else:
                new_num = 1
        except ValueError:
            new_num = 1
    else:
        new_num = 1
    
    return f"C{prefix}{str(new_num).zfill(3)}"


# 通用 ID 生成器
def generate_new_id(conn, table_name, id_column, prefix="", width=5):
    sql = f"""
    SELECT {id_column} FROM {table_name} 
    WHERE {id_column} LIKE :prefix 
    ORDER BY LENGTH({id_column}) DESC, {id_column} DESC 
    LIMIT 1
    """
    result = conn.execute(text(sql), {"prefix": f"{prefix}%"}).fetchone()

    if result:
        try:
            match = re.search(r'\d+', result[0])
            if match:
                new_num = int(match.group()) + 1
            else:
                new_num = 1
        except ValueError:
            new_num = 1
    else:
        new_num = 1

    return f"{prefix}{str(new_num).zfill(width)}"


# 通用的 CUD (Create, Update, Delete) 執行函式
def execute_cud(sql, params):
    try:
        with engine.begin() as conn:
            conn.execute(text(sql), params)
        st.success("✅ 操作成功！")
        return True
    except Exception as e:
        st.error(f"❌ 發生錯誤：{e}")
        return False


# 1. 刪除「組合」的專用函式 (連同明細一起刪)
def _do_delete_combinations(id_list):
    if not id_list:
        return

    user_id = selected_admin
    # 生成批次 ID，確保多筆刪除時能被正確歸類
    batch_id = f"COMBO_DEL_{datetime.now():%Y%m%d_%H%M%S}"
    
    id_params = {f"id{i}": cid for i, cid in enumerate(id_list)}
    in_clause = ", ".join([f":id{i}" for i in range(len(id_list))])

    try:
        with engine.begin() as conn:
            # A. 刪除前：抓取包含 Option 與 Detail 的完整資料
            rows = conn.execute(
                text(f"""
                    SELECT
                        ac.combination_id,
                        mo.option_name,
                        ac.price,
                        i.item_name
                    FROM all_combinations ac
                    JOIN menu_options mo ON ac.option_id = mo.option_id
                    LEFT JOIN combinations_detail cd
                        ON ac.combination_id = cd.combination_id
                    LEFT JOIN items i ON cd.item_id = i.item_id
                    WHERE ac.combination_id IN ({in_clause})
                """),
                id_params
            ).mappings().all()

            combo_map = {}

            for r in rows:
                cid = r["combination_id"]

                if cid not in combo_map:
                    combo_map[cid] = {
                        "combination_id": cid,
                        "option_name": r["option_name"],
                        "price": r["price"],
                        "combination_name": []  # ⭐ 這裡定義為清單
                    }

                if r["item_name"]:
                    # ⭐ 這裡必須使用跟上面完全一樣的 Key 名稱 "combination_name"
                    combo_map[cid]["combination_name"].append(r["item_name"])

            # B. 寫入 edit_log（DELETE）
            for cid, data in combo_map.items():
                # 為了讓 Log 內容易讀，將 list 轉為字串（例如 "漢堡 + 可樂"）
                log_data = data.copy()
                if isinstance(log_data["combination_name"], list):
                    log_data["combination_name"] = " + ".join(log_data["combination_name"])
                
                insert_edit_log(
                    conn,
                    table="all_combinations",
                    pk=cid,
                    action="DELETE",
                    old_data=log_data,
                    new_data=None,
                    admin=user_id,
                    batch_id=batch_id
                )

            # C. 真正執行刪除動作 (順序：先細項，再主檔)
            conn.execute(
                text(f"DELETE FROM combinations_detail WHERE combination_id IN ({in_clause})"),
                id_params
            )
            conn.execute(
                text(f"DELETE FROM all_combinations WHERE combination_id IN ({in_clause})"),
                id_params
            )

        st.success(f"✅ 已成功刪除 {len(id_list)} 筆套餐組合！")
        return True

    except Exception as e:
        st.error(f"刪除組合失敗: {e}")

# 2. 刪除「方案 (Option)」的專用函式 (連同該方案的所有組合一起刪)
def _do_delete_options(opt_id_list):
    if not opt_id_list:
        return

    user_id = selected_admin
    batch_id = str(uuid.uuid4())
    
    id_params = {f"id{i}": oid for i, oid in enumerate(opt_id_list)}
    in_clause = ", ".join([f":id{i}" for i in range(len(opt_id_list))])

    try:
        with engine.begin() as conn:
            # 1. 抓取受影響的詳細資料
            rows = conn.execute(
                text(f"""
                    SELECT 
                        mo.option_id, mo.option_name,
                        ac.combination_id, ac.combination_name, ac.price
                    FROM menu_options mo
                    LEFT JOIN all_combinations ac ON mo.option_id = ac.option_id
                    WHERE mo.option_id IN ({in_clause})
                """),
                id_params
            ).mappings().all()

            # 2. 分類資料
            opts_data = {}  # 方案資料
            combs_data = [] # 組合資料

            for r in rows:
                if r["option_id"] not in opts_data:
                    opts_data[r["option_id"]] = {"option_id": r["option_id"], "option_name": r["option_name"]}
                
                if r["combination_id"]:
                    combs_data.append({
                        "table": "all_combinations",
                        "pk": r["combination_id"],
                        "data": {"combination_id": r["combination_id"], "detail": r["combination_name"], "price": r["price"]}
                    })

            # 🔥 關鍵修正 1：刪除原本的 BATCH 總結 Log (它是造成摺疊框出現「奇怪資料」的主因)
            # 不要執行原本那個 insert_edit_log(..., pk=f"BATCH_...")

            # ⭐ B. 為每一個「方案」寫入獨立 Log (這會成為清單的主標題)
            for oid, odata in opts_data.items():
                insert_edit_log(
                    conn, table="menu_options", pk=oid,
                    action="DELETE", old_data=odata,
                    new_data=None, admin=user_id, batch_id=batch_id
                )

            # 🔥 關鍵修正 2：只有當真的「有組合資料」時，才寫入連動 Log
            # 這樣如果沒有組合被刪除，就不會生成 batch_id 關聯的明細，摺疊框就不會出現
            if combs_data:
                for comb in combs_data:
                    insert_edit_log(
                        conn, table=comb["table"], pk=comb["pk"],
                        action="DELETE", old_data=comb["data"],
                        new_data=None, admin=user_id, batch_id=batch_id
                    )

            # 3. 執行物理刪除
            conn.execute(
                text(f"DELETE FROM combinations_detail WHERE combination_id IN (SELECT combination_id FROM all_combinations WHERE option_id IN ({in_clause}))"),
                id_params
            )
            conn.execute(text(f"DELETE FROM all_combinations WHERE option_id IN ({in_clause})"), id_params)
            conn.execute(text(f"DELETE FROM menu_options WHERE option_id IN ({in_clause})"), id_params)

        st.success(f"✅ 已成功刪除方案！")
        return True

    except Exception as e:
        st.error(f"刪除失敗: {e}")

# 3. 刪除「單品 (Item)」的專用函式 (連同包含該單品的組合一起刪)
def _do_delete_items(item_id_list):
    if not item_id_list: return

    user_id = selected_admin
    # 生成唯一批次 ID
    batch_id = f"ITEM_DEL_{datetime.now():%Y%m%d_%H%M%S}"
    
    id_params = {f"id{i}": iid for i, iid in enumerate(item_id_list)}
    in_clause = ", ".join([f":id{i}" for i in range(len(item_id_list))])

    try:
        with engine.begin() as conn:
            # 1. 先抓取單品的原始資料 (備份到 Log)
            items_to_del = conn.execute(
                text(f"SELECT * FROM items WHERE item_id IN ({in_clause})"),
                id_params
            ).mappings().all()

            # 2. 找出受影響的組合資料 (備份到 Log)
            # 我們改用 item_id 直接關聯 combinations_detail 比較精準
            sql_find_combos = f"""
                SELECT DISTINCT ac.combination_id, ac.combination_name, ac.price 
                FROM all_combinations ac
                JOIN combinations_detail cd ON ac.combination_id = cd.combination_id
                WHERE cd.item_id IN ({in_clause})
            """
            combos_to_del = conn.execute(text(sql_find_combos), id_params).mappings().all()
            combo_ids = [r["combination_id"] for r in combos_to_del]

            # --- 🌟 寫入 Log 階段 (在物理刪除前) ---

            # A. 為每一個被刪除的「單品」寫入獨立 Log (這會是列表的主角)
            for item in items_to_del:
                insert_edit_log(
                    conn, table="items", pk=item["item_id"],
                    action="DELETE", old_data=dict(item),
                    new_data=None, admin=user_id, batch_id=batch_id
                )

            # B. 為每一筆連帶刪除的「組合」寫入獨立 Log (這會被折疊)
            for combo in combos_to_del:
                insert_edit_log(
                    conn, table="all_combinations", pk=combo["combination_id"],
                    action="DELETE", old_data=dict(combo),
                    new_data=None, admin=user_id, batch_id=batch_id
                )

            # --- 🌟 執行物理刪除 ---
            if combo_ids:
                c_params = {f"c{i}": cid for i, cid in enumerate(combo_ids)}
                c_clause = ", ".join([f":c{i}" for i in range(len(combo_ids))])
                
                # 刪除順序：細項 -> 組合
                conn.execute(text(f"DELETE FROM combinations_detail WHERE combination_id IN ({c_clause})"), c_params)
                conn.execute(text(f"DELETE FROM all_combinations WHERE combination_id IN ({c_clause})"), c_params)

            # 最後刪除 items
            conn.execute(text(f"DELETE FROM items WHERE item_id IN ({in_clause})"), id_params)

        st.success(f"✅ 已成功刪除單品，並連帶清理了 {len(combo_ids)} 筆組合紀錄！")
        return True

    except Exception as e:
        st.error(f"連動刪除失敗: {e}")


def get_edit_logs(engine):
    sql = text("""
        SELECT
            log_id,
            table_name,
            record_id,
            action_type,
            old_data,
            new_data,
            user_id, 
            created_at
        FROM edit_logs
        ORDER BY created_at DESC
    """)
    with engine.connect() as conn:
        return conn.execute(sql).mappings().all()

import uuid
def insert_edit_log(conn, table, pk, action, old_data, new_data, admin, batch_id=None):
    def convert_to_native(obj):
        if isinstance(obj, dict):
            return {k: convert_to_native(v) for k, v in obj.items()}
        elif isinstance(obj, (list, tuple)):
            return [convert_to_native(i) for i in obj]
        elif hasattr(obj, 'item'):
            return obj.item()
        return obj
    
    conn.execute(
        text("""
            INSERT INTO edit_logs
            (table_name, record_id, action_type, old_data, new_data, user_id, batch_id)
            VALUES (:table, :pk, :action, :old, :new, :admin, :batch)
        """),
        {
            "table": table,
            "pk": pk,
            "action": action,
            "old": json.dumps(convert_to_native(old_data), ensure_ascii=False) if old_data else "{}",
            "new": json.dumps(convert_to_native(new_data), ensure_ascii=False) if new_data else "{}",
            "admin": admin,
            "batch": batch_id
        }
    )


# 資料表欄位定義
TABLE_COLUMNS = {
    "all_combinations": ["combination_id", "combination_name", "option_id", "price"],
    "combinations_detail": ["detail_id", "combination_id", "item_id","item_name","item_type", "quantity"],
    "item_group_links": ["parent_item_id", "child_item_id", "extra_cost"],
    "items": ["item_id", "item_name", "item_type", "price"],
    "menu_options": ["option_id", "option_name"],
}

# ---------------- 側邊欄：全域導覽 ----------------
st.sidebar.title("🍔 麥當勞省錢後台")
st.sidebar.divider()

mode = st.sidebar.radio(
    "功能導覽",
    ["🔍 瀏覽與查詢", "➕ 新增資料", "✏️ 修改資料", "🗑 刪除資料", "📋編輯紀錄", "❓ 使用導覽"],
)

# 核心邏輯：如果偵測到模式切換，就清空特定的狀態
if "current_mode" not in st.session_state:
    st.session_state["current_mode"] = mode

# 當使用者點擊側邊欄，導致 mode 變更時
if st.session_state["current_mode"] != mode:
    # 這裡清空你 Tab 3 所有的快照與訊息狀態
    if "orig_options" in st.session_state:
        del st.session_state["orig_options"]
    if "edit_success_tab3" in st.session_state:
        st.session_state["edit_success_tab3"] = False
    
    # 更新目前模式
    st.session_state["current_mode"] = mode

admin_list = ["王祐霆","魏甄儀"]
selected_admin = st.sidebar.selectbox("👤 當前操作者", admin_list, key="user_id")
# ==============================================================================
# 🎯 功能一：瀏覽與查詢 (完全保留你原本的程式碼)
# ==============================================================================
if mode == "🔍 瀏覽與查詢":
    st.title("🔎 資料查詢中心")

    tab1, tab2 = st.tabs(["📄 單一資料表查詢", "🍟 套餐組合分析 (JOIN)"])

    # --- 子功能 A: 單一資料表查詢 ---
    with tab1:
        st.subheader("瀏覽單一資料表內容")
        with st.container(border=True):
            col1, col2, col3, col4 = st.columns([1.5, 1.5, 2, 2])
            with col1:
                table_name = st.selectbox("選擇資料表", options=list(TABLE_COLUMNS.keys()))
            columns = TABLE_COLUMNS[table_name]
            with col2:
                search_col = st.selectbox("搜尋欄位", ["全部欄位"] + columns)
            with col3:
                keyword = st.text_input("關鍵字搜尋 (可留空)", value="")
            with col4:
                limit = st.slider("顯示筆數 (Limit)", min_value=10, max_value=1000, value=100, step=10)
            run_single_query = st.button("🚀 執行查詢", key="btn_single", use_container_width=True)

        if run_single_query:
            base_sql = f"SELECT * FROM {table_name}"
            params = {}
            where_clauses = []

            if keyword:
                if search_col == "全部欄位":
                    like_group = []
                    for idx, c in enumerate(columns):
                        param_key = f"kw{idx}"
                        like_group.append(f"{c} LIKE :{param_key}")
                        params[param_key] = f"%{keyword}%"
                    where_clauses.append("(" + " OR ".join(like_group) + ")")
                else:
                    where_clauses.append(f"{search_col} LIKE :kw")
                    params["kw"] = f"%{keyword}%"

            if where_clauses:
                base_sql += " WHERE " + " AND ".join(where_clauses)
            base_sql += " LIMIT :limit"
            params["limit"] = limit

            try:
                with engine.connect() as conn:
                    df = pd.read_sql(text(base_sql), conn, params=params)
                st.write(f"📊 查詢結果：共 {len(df)} 筆")
                st.dataframe(df, use_container_width=True)
            except Exception as e:
                st.error(f"查詢錯誤：{e}")

        # -------------------------------------------------------
        # 子功能 B: 套餐組合分析 (多表 JOIN 查詢)
        # -------------------------------------------------------
        with tab2:
            st.subheader("🍟 跨表查詢套餐組合細節")

            # 1. 準備篩選器的下拉選單資料
            try:
                with engine.connect() as conn:
                    df_opts = pd.read_sql("SELECT * FROM menu_options", conn)
                    df_types = pd.read_sql("SELECT DISTINCT item_type FROM items", conn)
                    opt_list = df_opts["option_name"].tolist()
                    type_list = df_types["item_type"].tolist()
            except Exception as e:
                st.error(f"讀取選單失敗: {e}")
                opt_list, type_list = [], []

            # 2. 篩選條件設定區 (中央區塊)
            with st.container(border=True):
                st.markdown("##### 🛠️ 設定篩選條件")

                # 第一排：多選過濾器
                c1, c2 = st.columns(2)
                with c1:
                    option_filter = st.multiselect("依套餐選項 (Menu Options)", opt_list)
                with c2:
                    item_type_filter = st.multiselect("依包含品項類型 (Item Type)", type_list)

                # 第二排：關鍵字、數量滑桿、按鈕
                c3, c4, c5 = st.columns([2, 2, 1])

                with c3:
                    combo_keyword = st.text_input("關鍵字 (搜尋組合描述或品項名稱)", key="combo_kw")

                with c4:
                    # ✅ 顯示筆數滑桿
                    limit_combo = st.slider(
                        "顯示筆數限制 (Limit)",
                        min_value=10,
                        max_value=5000,
                        value=300,
                        step=10,
                        key="limit_combo_slider"
                    )

                with c5:
                    # 稍微調整按鈕位置以對齊
                    st.write("")
                    st.write("")
                    run_combo_query = st.button("🚀 搜尋組合", key="btn_combo", use_container_width=True)

            # 3. 執行查詢邏輯
            if run_combo_query:
                # SQL：欄位設計與原本 app.py 一致
                sql_str = """
                SELECT
                    ac.combination_id,
                    ac.combination_name,
                    ac.price AS combo_price,
                    mo.option_name,
                    cd.detail_id,
                    cd.item_id,
                    i.item_name,
                    i.item_type,
                    i.price AS item_price
                FROM all_combinations ac
                LEFT JOIN menu_options mo 
                    ON ac.option_id = mo.option_id
                LEFT JOIN combinations_detail cd 
                    ON ac.combination_id = cd.combination_id
                LEFT JOIN items i 
                    ON cd.item_id = i.item_id
                """

                wheres = []
                p = {}

                # (A) 選項過濾
                if option_filter:
                    keys = [f"opt{i}" for i in range(len(option_filter))]
                    for k, v in zip(keys, option_filter): p[k] = v
                    wheres.append(f"mo.option_name IN ({', '.join([':' + k for k in keys])})")

                # (B) 類型過濾
                if item_type_filter:
                    keys = [f"type{i}" for i in range(len(item_type_filter))]
                    for k, v in zip(keys, item_type_filter): p[k] = v
                    wheres.append(f"i.item_type IN ({', '.join([':' + k for k in keys])})")

                # (C) 關鍵字過濾
                if combo_keyword:
                    wheres.append("(ac.combination_name LIKE :kw OR i.item_name LIKE :kw)")
                    p["kw"] = f"%{combo_keyword}%"

                # 組合 SQL
                if wheres:
                    sql_str += " WHERE " + " AND ".join(wheres)

                # 排序與限制
                sql_str += " ORDER BY ac.combination_id, cd.detail_id LIMIT :limit"
                p["limit"] = limit_combo

                # 4. 顯示結果
                try:
                    with engine.connect() as conn:
                        df_combo = pd.read_sql(text(sql_str), conn, params=p)

                    if df_combo.empty:
                        st.info("查無符合條件的組合。")
                    else:
                        st.success(f"📊 查詢完成，共顯示 {len(df_combo)} 筆資料 (若達上限請拉大滑桿)")
                        st.dataframe(df_combo, use_container_width=True)

                        # CSV 下載按鈕
                        csv_combo = df_combo.to_csv(index=False).encode("utf-8-sig")
                        st.download_button(
                            label="📥 下載組合結果 CSV",
                            data=csv_combo,
                            file_name="combo_query_results.csv",
                            mime="text/csv"
                        )

                except Exception as e:
                    st.error(f"查詢失敗：{e}")

# ==============================================================================
# 🎯 功能二：新增資料 (不自動刷新，確保你看得到 ID)
# ==============================================================================
elif mode == "➕ 新增資料":
    st.header("➕ 新增資料")
    st.caption("提示：新增成功後訊息會保留在畫面上，請手動刷新頁面以更新下拉選單。")


    tab1, tab2, tab3, tab4 = st.tabs(["🍔 新增單品", "🍟 新增套餐", "🏷️ 新增方案", "🔗 新增群組項目"])

    # --- 1. 新增單品 (維持 5 位數) ---
    with tab1:
        st.subheader("新增單品 (Items)")
        with st.form("add_item"):
            name = st.text_input("商品名稱")
            type_map = {"FOOD": "F", "DESSERT": "D", "BEVERAGE": "B", "GROUP": "G"}
            itype = st.selectbox("分類", list(type_map.keys()))
            price = st.number_input("價格", min_value=0)

            if st.form_submit_button("確認新增單品"):
                if not name:
                    st.error("請輸入名稱")
                else:
                    try:
                        with engine.connect() as conn:
                            with conn.begin():
                                nid = generate_new_id(conn, "items", "item_id", type_map[itype], width=5)
                                conn.execute(text(
                                    "INSERT INTO items (item_id, item_name, item_type, price) VALUES (:id, :name, :type, :price)"),
                                             {"id": nid, "name": name, "type": itype, "price": price})
                                user_id = selected_admin
                                new_item_data = {
                                    "item_id": nid,
                                    "item_name": name,
                                    "item_type": itype,
                                    "price": price
                                }
                                insert_edit_log(
                                    conn,
                                    table="items",           
                                    pk=nid,                  
                                    action="INSERT",         
                                    old_data=None,
                                    new_data=new_item_data,
                                    admin=user_id           
                                )

                        st.success(f"✅ 單品新增成功！新 ID 為：{nid}")
                        st.balloons()
                    except Exception as e:
                        st.error(f"新增失敗: {e}")


    # --- 2. 新增套餐 (顯示 Detail IDs) ---
    with tab2:
        st.subheader("新增套餐 (Combinations)")
        with engine.connect() as conn:
            opts = pd.read_sql(text("SELECT option_id, option_name FROM menu_options"), conn)
            items = pd.read_sql(text("SELECT item_id, item_name, item_type FROM items"), conn)
        
        item_map = dict(zip(items['item_name'], items['item_id']))
        opt_labels = opts.apply(lambda x: f"{x['option_id']} - {x['option_name']}", axis=1)
        
        sel_opt = st.selectbox("優惠方案", opt_labels)
        sel_items = st.multiselect("選擇內容物", items['item_name'].tolist())
        
        item_quantities = {}
        if sel_items:
            st.markdown("##### 設定各項數量")
            cols = st.columns(len(sel_items)) if len(sel_items) <= 4 else st.columns(4)
            for i, item in enumerate(sel_items):
                with cols[i % 4]:
                    item_quantities[item] = st.number_input(
                        f"{item}", min_value=1, max_value=10, value=1, step=1, key=f"qty_{item}"
                    )
        
        total_price = st.number_input("套餐總價", min_value=0)
        
        if st.button("確認建立套餐"):
            if not sel_items:
                st.error("❌ 請至少選擇一個商品")
            else:
                try:
                    opt_id = sel_opt.split(" - ")[0]
                    detail_parts = []
                    for item, qty in item_quantities.items():
                        detail_parts.append(f"{item} x{qty}")
                    detail_str = " + ".join(detail_parts)

                    created_detail_ids = []

                    user_id = selected_admin
                    with engine.connect() as conn:
                        with conn.begin():
                            cid = generate_combo_id_by_option(conn, opt_id)
                            conn.execute(
                                text(
                                    "INSERT INTO all_combinations (combination_id, combination_name, option_id, price) VALUES (:id, :det, :oid, :pr)"),
                                {"id": cid, "det": detail_str, "oid": opt_id, "pr": total_price}
                            )

                            sql_check = "SELECT detail_id FROM combinations_detail WHERE detail_id LIKE 'DT%' ORDER BY LENGTH(detail_id) DESC, detail_id DESC LIMIT 1"
                            last_did_row = conn.execute(text(sql_check)).fetchone()

                            current_num = 0
                            if last_did_row:
                                match = re.search(r'\d+', last_did_row[0])
                                if match:
                                    current_num = int(match.group())

                            for item, qty in item_quantities.items():
                                for _ in range(qty):
                                    current_num += 1
                                    did = f"DT{str(current_num).zfill(5)}"
                                    conn.execute(
                                        text(
                                            "INSERT INTO combinations_detail (detail_id, combination_id, item_id, quantity) VALUES (:did, :cid, :iid, 1)"),
                                        {"did": did, "cid": cid, "iid": item_map[item]}
                                    )
                                    created_detail_ids.append(did)
                            
                            insert_edit_log(
                                conn,
                                table="all_combinations",
                                pk=cid,
                                action="INSERT",
                                old_data=None,
                                new_data={
                                    "combination_id": cid,
                                    "combination_name": detail_str,
                                    "option_id": opt_id,
                                    "price": total_price
                                },
                                admin=user_id
                            )

                    st.success(f"✅ 套餐建立成功！新 ID 為：{cid}")
                    st.info(f"包含內容：{detail_str}")
                    st.warning(f"🔢 產生的明細編號 (Detail IDs)：{', '.join(created_detail_ids)}")
                    st.balloons()

                except Exception as e:
                    st.error(f"❌ 發生錯誤: {e}")

    # --- 3. 新增選項 (3 位數) ---
    with tab3:
        st.subheader("新增方案 (Options)")
        with st.form("add_opt"):
            opt_name = st.text_input("方案名稱")
            if st.form_submit_button("確認新增方案"):
                if opt_name:
                    try:
                        with engine.connect() as conn:
                            with conn.begin():
                                user_id = selected_admin
                                # 選項維持 3 位數 (O008)
                                oid = generate_new_id(conn, "menu_options", "option_id", "O", width=3)
                                conn.execute(
                                    text("INSERT INTO menu_options (option_id, option_name) VALUES (:id, :name)"),
                                    {"id": oid, "name": opt_name})
                                new_option_data = {
                                    "option_id": oid,
                                    "option_name": opt_name
                                }
                                insert_edit_log(
                                    conn,
                                    table="menu_options", # 改為 table
                                    pk=oid,               # 改為 pk
                                    action="INSERT",      # 改為 action
                                    old_data=None,
                                    new_data=new_option_data,
                                    admin=user_id        # 改為 admin
                                )


                        st.success(f"✅ 選項新增成功！新 ID 為：{oid}")
                        st.balloons()
                    except Exception as e:
                        st.error(str(e))

    # --- 4. 新增群組綁定 (item_group_links) ---
    with tab4:
        st.subheader("新增群組項目 (Group Links)")
        with engine.connect() as conn:
            import pandas as pd
            df_items = pd.read_sql("SELECT item_id, item_name, item_type FROM items", conn)
        
        # 篩選母節點(只能是 GROUP) 跟子節點(不限，通常是單品)
        group_items = df_items[df_items["item_type"] == "GROUP"]
        
        if group_items.empty:
            st.warning("⚠️ 目前資料庫中沒有類型為 GROUP 的項目。請先到「新增單品」建立一個群組 (例：冷飲群組)。")
        else:
            with st.form("add_group_link"):
                group_labels = group_items.apply(lambda x: f"{x['item_id']} - {x['item_name']}", axis=1)
                sel_parent = st.selectbox("請選擇母群組 (Parent)", group_labels)
                
                child_labels = df_items.apply(lambda x: f"{x['item_id']} - {x['item_name']}", axis=1)
                sel_child = st.selectbox("請選擇內容物 (Child)", child_labels)
                
                extra_cost = st.number_input("替換加價 (Extra Cost)", min_value=0, value=0, step=1)
                
                if st.form_submit_button("確認綁定"):
                    try:
                        pid = sel_parent.split(" - ")[0]
                        cid = sel_child.split(" - ")[0]
                        admin_id = selected_admin
                        
                        with engine.begin() as conn:
                            # 檢查是否重複
                            from sqlalchemy import text
                            check = conn.execute(text("SELECT 1 FROM item_group_links WHERE parent_item_id=:p AND child_item_id=:c"), {"p":pid, "c":cid}).fetchone()
                            if check:
                                st.error("❌ 此綁定關聯已存在，若要修改費用請至「修改資料」區。")
                            else:
                                conn.execute(
                                    text("INSERT INTO item_group_links (parent_item_id, child_item_id, extra_cost) VALUES (:p, :c, :cost)"),
                                    {"p":pid, "c":cid, "cost":extra_cost}
                                )
                                insert_edit_log(
                                    conn, table="item_group_links", pk=f"{pid}_{cid}", action="INSERT",
                                    old_data=None, new_data={"parent_item_id":pid, "child_item_id":cid, "extra_cost":extra_cost}, admin=admin_id
                                )
                                st.success("✅ 綁定成功！")
                                st.balloons()
                    except Exception as e:
                        st.error(f"❌ 綁定失敗: {e}")


# ==============================================================================
# 🎯 功能三：修改資料 (Update) - 已修正 ID 型別問題
# ==============================================================================
elif mode == "✏️ 修改資料":
    st.header("✏️ 修改資料中心")

    # 初始化 Session State
    if "confirm_item_update" not in st.session_state:
        st.session_state["confirm_item_update"] = False
        st.session_state["update_payload"] = {}

    tab1, tab2, tab3, tab4 = st.tabs(["🍔 修改單品 (Items)", "🍟 修改組合 (Combinations)", "🏷️ 修改方案 (Options)", "🔗 修改群組加價"])

    # ----------------------------------------------------------------------
    # Tab 1: 修改單品 (含連動價格功能)
    # ----------------------------------------------------------------------
    with tab1:
        st.subheader("1. 修改單品資料")

        # 1. 讀取與篩選
        with engine.connect() as conn:
            df_items = pd.read_sql("SELECT * FROM items ORDER BY item_id ASC", conn)

        col_filter, col_select = st.columns([1, 2])
        with col_filter:
            filter_name = st.text_input("🔍 篩選單品名稱 (Item Name)", key="filter_item_edit")

        if filter_name:
            df_items = df_items[df_items["item_name"].str.contains(filter_name, case=False)]

        if df_items.empty:
            st.warning("查無符合單品")
        else:
            with col_select:
                item_options = df_items.apply(lambda x: f"{x['item_id']} - {x['item_name']} (${x['price']})", axis=1)
                selected_item_str = st.selectbox("選擇要修改的單品", item_options, key="sel_item_edit")
                selected_id = selected_item_str.split(" - ")[0]

            # 2. 顯示原始資料與編輯表單
            current_row = df_items[df_items["item_id"] == selected_id].iloc[0]
            original_price = float(current_row["price"])

            st.info(f"正在編輯：**{current_row['item_name']}** (目前價格: {original_price})")

            with st.form("edit_item_form"):
                c1, c2, c3 = st.columns(3)
                with c1:
                    new_name = st.text_input("單品名稱", value=current_row["item_name"])
                with c2:
                    type_opts = ["FOOD", "BEVERAGE", "DESSERT", "GROUP"]
                    curr_type = current_row["item_type"] if current_row["item_type"] in type_opts else type_opts[0]
                    new_type = st.selectbox("分類", type_opts, index=type_opts.index(curr_type))
                with c3:
                    new_price = st.number_input("價格", value=original_price, step=1.0)

                st.markdown("---")
                # 🌟 功能 4: 勾選連動修改所有組合
                update_related_combos = st.checkbox("🔄 同步更新包含此單品的所有組合價格 (Bulk Price Update)",
                                                    help="若勾選，系統將計算價差，並將所有包含此單品的套餐價格加上該價差。")

                submit = st.form_submit_button("💾 提交修改")

            if submit:
                # 暫存修改請求，進入確認階段
                st.session_state["update_payload"] = {
                    "id": selected_id,
                    "name": new_name,
                    "type": new_type,
                    "new_price": new_price,
                    "old_price": original_price,
                    "update_combos": update_related_combos
                }
                st.session_state["confirm_item_update"] = True

            # 🌟 功能 5: 確認提示視窗
            if st.session_state["confirm_item_update"]:
                p = st.session_state["update_payload"]
                price_diff = p["new_price"] - p["old_price"]

                with st.container(border=True):
                    st.warning("⚠️ **請確認修改內容**")
                    st.write(f"**單品**: {p['id']} - {p['name']}")
                    st.write(f"**價格變動**: {p['old_price']} ➝ {p['new_price']} (價差: {price_diff})")

                    affected_count = 0
                    if p["update_combos"] and price_diff != 0:
                        # 預先計算受影響的組合數量
                        with engine.connect() as conn:
                            sql_count = "SELECT COUNT(DISTINCT combination_id) FROM combinations_detail WHERE item_id = :iid"
                            affected_count = conn.execute(text(sql_count), {"iid": p["id"]}).scalar()
                        st.error(f"🔴 **注意**：您勾選了連動更新，將有 **{affected_count}** 筆相關組合的價格會同步調整！")
                    else:
                        st.info("僅修改單品本身，不影響其他組合。")

                    col_yes, col_no = st.columns(2)
                    with col_yes:
                        if st.button("✅ 確認執行", type="primary", use_container_width=True):
                            try:
                                with engine.begin() as conn:
                                    user_id = selected_admin
                                    
                                    # ⭐ 核心：在這裡先生成批次 ID
                                    batch_id = f"PRICE_SYNC_{datetime.now():%Y%m%d_%H%M%S}"

                                    # ===============================
                                    # 1️⃣ 處理單品 (Items) 的修改
                                    # ===============================
                                    old_item = conn.execute(
                                        text("SELECT * FROM items WHERE item_id = :i"),
                                        {"i": p["id"]}
                                    ).mappings().first()
                                    old_item_data = dict(old_item)

                                    conn.execute(
                                        text("""
                                            UPDATE items
                                            SET item_name = :n, item_type = :t, price = :p
                                            WHERE item_id = :i
                                        """),
                                        {"n": p["name"], "t": p["type"], "p": p["new_price"], "i": p["id"]}
                                    )

                                    new_item = conn.execute(
                                        text("SELECT * FROM items WHERE item_id = :i"),
                                        {"i": p["id"]}
                                    ).mappings().first()
                                    new_item_data = dict(new_item)

                                    # 🌟 這裡最重要：單品的 Log 也要帶上 batch_id
                                    if old_item_data != new_item_data:
                                        insert_edit_log(
                                            conn,
                                            table="items",             
                                            pk=p["id"],
                                            action="UPDATE",
                                            old_data=old_item_data,
                                            new_data=new_item_data,
                                            admin=user_id,
                                            batch_id=batch_id  # <--- 加在這裡，它就不會獨立排在外面了
                                        )

                                    # ==================================================
                                    # 2️⃣ 處理組合 (all_combinations) 的連動修改
                                    # ==================================================
                                    if p["update_combos"] and price_diff != 0:
                                        # 這裡建議把原本那個「BATCH_PRICE_SYNC」的 insert_edit_log 刪除或註解掉
                                        # 因為它會產生一筆 record_id 為亂碼的紀錄，讓列表變醜

                                        affected_combos = conn.execute(
                                            text("""
                                                SELECT DISTINCT c.combination_id, c.price
                                                FROM all_combinations c
                                                JOIN combinations_detail d ON c.combination_id = d.combination_id
                                                WHERE d.item_id = :iid
                                            """),
                                            {"iid": p["id"]}
                                        ).mappings().all()

                                        # 批次更新 SQL
                                        conn.execute(
                                            text("""
                                                UPDATE all_combinations
                                                SET price = price + :diff
                                                WHERE combination_id IN (
                                                    SELECT combination_id FROM combinations_detail WHERE item_id = :iid
                                                )
                                            """),
                                            {"diff": price_diff, "iid": p["id"]}
                                        )

                                        # 逐筆寫組合 Log，同樣帶上 batch_id
                                        for combo in affected_combos:
                                            insert_edit_log(
                                                conn,
                                                table="all_combinations",
                                                pk=combo["combination_id"],
                                                action="UPDATE",
                                                old_data={"price": combo["price"]},
                                                new_data={"price": combo["price"] + price_diff},
                                                admin=user_id,
                                                batch_id=batch_id  # <--- 這裡也要有一樣的 batch_id
                                            )

                                st.success("修改成功！")
                                st.session_state["confirm_item_update"] = False
                                time.sleep(1.5)
                                st.rerun()
                            except Exception as e:
                                st.error(f"更新失敗: {e}")

                    with col_no:
                        if st.button("❌ 取消", use_container_width=True):
                            st.session_state["confirm_item_update"] = False
                            st.rerun()

    # ----------------------------------------------------------------------
    # Tab 2: 修改組合 (All Combinations)
    # ----------------------------------------------------------------------
    with tab2:
        st.subheader("2. 修改組合資料")

        # 1. 準備篩選器資料 (修正 SQL Error 3065)
        with engine.connect() as conn:
            # 修改：不使用 SELECT DISTINCT，改用 Python 的 unique() 處理
            df_i = pd.read_sql("SELECT item_name FROM items ORDER BY item_id", conn)
            item_list = df_i["item_name"].unique().tolist()

            df_o = pd.read_sql("SELECT option_name FROM menu_options ORDER BY option_id", conn)
            opt_list = df_o["option_name"].unique().tolist()

        c1, c2, c3 = st.columns([2, 2, 1])
        with c1:
            filter_items = st.multiselect("🔍 篩選包含單品 (Item Name)", item_list)
        with c2:
            filter_opts = st.multiselect("🔍 篩選方案 (Option Name)", opt_list)
        with c3:
            st.write("")
            st.write("")
            btn_search = st.button("查詢組合", use_container_width=True)

        if btn_search or "edit_combo_df" in st.session_state:
            # 構建查詢
            sql = """
                SELECT 
                    ac.combination_id, 
                    ac.combination_name, 
                    mo.option_name,
                    ac.price,
                    ac.option_id
                FROM all_combinations ac
                LEFT JOIN menu_options mo ON ac.option_id = mo.option_id
                LEFT JOIN combinations_detail cd ON ac.combination_id = cd.combination_id
                LEFT JOIN items i ON cd.item_id = i.item_id
                WHERE 1=1
            """
            params = {}
            if filter_items:
                sql += f" AND i.item_name IN ({','.join([f':i{k}' for k in range(len(filter_items))])})"
                params.update({f"i{k}": v for k, v in enumerate(filter_items)})
            if filter_opts:
                sql += f" AND mo.option_name IN ({','.join([f':o{k}' for k in range(len(filter_opts))])})"
                params.update({f"o{k}": v for k, v in enumerate(filter_opts)})

            sql += " GROUP BY ac.combination_id ORDER BY ac.combination_id"  # 去重

            with engine.connect() as conn:
                df_combos = pd.read_sql(text(sql), conn, params=params)

            st.session_state["edit_combo_df"] = df_combos

            if df_combos.empty:
                st.info("沒有符合的資料。")
            else:
                st.write(f"顯示 {len(df_combos)} 筆資料，請直接在表格中修改價格。")

                # 使用 Data Editor 進行修改
                edited_df = st.data_editor(
                    df_combos,
                    column_config={
                        "combination_id": st.column_config.TextColumn("ID", disabled=True),
                        "combination_name": st.column_config.TextColumn("組合內容", disabled=True, width="large"),
                        "option_name": st.column_config.TextColumn("目前方案", disabled=True),
                        "price": st.column_config.NumberColumn("價格 (可修改)", min_value=0, step=1),
                        "option_id": None  # 隱藏
                    },
                    hide_index=True,
                    use_container_width=True,
                    key="combo_editor"
                )

                if st.button("💾 儲存組合變更"):
                    # 找出有變動的 Rows
                    changes = []
                    for index, row in edited_df.iterrows():
                        orig_row = df_combos.iloc[index]
                        if row["price"] != orig_row["price"]:
                            changes.append({"cid": row["combination_id"], "price": row["price"]})

                    if changes:
                        try:
                            with engine.begin() as conn:
                                user_id = selected_admin

                                for index, row in edited_df.iterrows():
                                    orig_row = df_combos.iloc[index]

                                    if row["price"] != orig_row["price"]:
                                        cid = row["combination_id"]

                                        # ⭐ 1️⃣ UPDATE 前
                                        old_row = conn.execute(
                                            text("""
                                                SELECT
                                                    ac.combination_id,
                                                    ac.combination_name,
                                                    ac.price,
                                                    mo.option_id,
                                                    mo.option_name
                                                FROM all_combinations ac
                                                LEFT JOIN menu_options mo ON ac.option_id = mo.option_id
                                                WHERE ac.combination_id = :cid
                                            """),
                                            {"cid": cid}
                                        ).mappings().first()

                                        old_data = dict(old_row)

                                        # ⭐ 2️⃣ UPDATE
                                        conn.execute(
                                            text("""
                                                UPDATE all_combinations
                                                SET price = :price
                                                WHERE combination_id = :cid
                                            """),
                                            {"price": row["price"], "cid": cid}
                                        )

                                        # ⭐ 3️⃣ UPDATE 後
                                        new_row = conn.execute(
                                            text("""
                                                SELECT
                                                    ac.combination_id,
                                                    ac.combination_name,
                                                    ac.price,
                                                    mo.option_id,
                                                    mo.option_name
                                                FROM all_combinations ac
                                                LEFT JOIN menu_options mo ON ac.option_id = mo.option_id
                                                WHERE ac.combination_id = :cid
                                            """),
                                            {"cid": cid}
                                        ).mappings().first()
                                        new_data = dict(new_row)

                                        # ⭐ 4️⃣ 寫入 edit_logs
                                        insert_edit_log(
                                            conn,
                                            table="all_combinations",
                                            pk=cid,
                                            action="UPDATE",
                                            old_data={
                                                "combination_id": old_row["combination_id"],
                                                "combination_name": old_row["combination_name"],
                                                "option_id": old_row["option_id"],
                                                "option_name": old_row["option_name"],
                                                "price": old_row["price"]
                                            },
                                            new_data={
                                                "combination_id": new_row["combination_id"],
                                                "combination_name": new_row["combination_name"],
                                                "option_id": new_row["option_id"],
                                                "option_name": new_row["option_name"],
                                                "price": new_row["price"]
                                            },
                                            admin=user_id
                                        )


                            st.success(f"✅ 成功更新 {len(changes)} 筆組合價格！")
                            time.sleep(1)
                            st.rerun()
                        except Exception as e:
                            st.error(f"更新錯誤: {e}")
                    else:
                        st.info("沒有檢測到變更。")

    # ----------------------------------------------------------------------
    # Tab 3: 修改方案 (Option Name)
    # ----------------------------------------------------------------------
    with tab3:
        st.subheader("3. 修改方案名稱")

        filter_opt_name = st.text_input("🔍 搜尋方案名稱", key="filter_opt_edit")

        sql = "SELECT * FROM menu_options ORDER BY option_id"
        with engine.connect() as conn:
            df_all_opts = pd.read_sql(sql, conn)   # ⭐ 永遠的完整原始資料

        # ⭐ 只在第一次進來時存快照
        if "orig_options" not in st.session_state:
            st.session_state.orig_options = df_all_opts.copy()

        # 🔍 篩選只影響顯示
        df_opts = df_all_opts
        if filter_opt_name:
            df_opts = df_opts[df_opts["option_name"].str.contains(filter_opt_name, case=False)]

        edited_opts = st.data_editor(
            df_opts,
            column_config={
                "option_id": st.column_config.TextColumn("ID", disabled=True),
                "option_name": st.column_config.TextColumn("方案名稱 (可修改)")
            },
            hide_index=True,
            use_container_width=True,
            key="opts_editor"
        )

        if st.button("💾 儲存方案修改"):
            user_id = selected_admin
            orig_df = st.session_state.orig_options
            updated_count = 0

            try:
                with engine.begin() as conn:
                    for _, row in edited_opts.iterrows():
                        oid = row["option_id"]
                        new_name = row["option_name"]

                        match = orig_df.loc[orig_df["option_id"] == oid, "option_name"]
                        if not match.empty:
                            old_name = match.values[0]

                            if old_name != new_name:
                                conn.execute(
                                    text("""
                                        UPDATE menu_options
                                        SET option_name = :name
                                        WHERE option_id = :id
                                    """),
                                    {"name": new_name, "id": oid}
                                )

                                insert_edit_log(
                                    conn,
                                    table="menu_options",
                                    pk=oid,
                                    action="UPDATE",
                                    old_data={"option_name": old_name},
                                    new_data={"option_name": new_name},
                                    admin=user_id
                                )

                                updated_count += 1

                # ⭐ 一次性更新快照（最重要）
                if updated_count > 0:
                    st.session_state.orig_options = df_all_opts.copy()
                    st.session_state["edit_success_tab3"] = True
                    st.session_state["last_count_tab3"] = updated_count   
                    st.rerun()
                else:
                    st.info("無資料變更。")

            except Exception as e:
                st.error(f"更新失敗: {e}")
        if st.session_state.get("edit_success_tab3", False):
            st.write("") # 隔開一點空間
            st.success(f"✅ 成功更新 {st.session_state.get('last_count_tab3', 0)} 筆方案名稱！")

    # ----------------------------------------------------------------------
    # Tab 4: 修改群組加價 (item_group_links)
    # ----------------------------------------------------------------------
    with tab4:
        st.subheader("4. 修改群組加價")
        try:
            with engine.connect() as conn:
                from sqlalchemy import text
                import pandas as pd
                sql_link = """
                    SELECT l.parent_item_id, p.item_name AS parent_name, 
                           l.child_item_id, c.item_name AS child_name, 
                           l.extra_cost
                    FROM item_group_links l
                    JOIN items p ON l.parent_item_id = p.item_id
                    JOIN items c ON l.child_item_id = c.item_id
                    ORDER BY l.parent_item_id, l.child_item_id
                """
                df_links = pd.read_sql(text(sql_link), conn)
            
            if df_links.empty:
                st.info("目前無任何群組關聯。")
            else:
                col1, col2 = st.columns([2, 2])
                with col1:
                    filter_parent = st.text_input("🔍 篩選母群組名稱", key="filter_parent_link")
                with col2:
                    filter_child = st.text_input("🔍 篩選子品項名稱", key="filter_child_link")
                
                df_filtered = df_links.copy()
                if filter_parent:
                    df_filtered = df_filtered[df_filtered["parent_name"].str.contains(filter_parent, case=False)]
                if filter_child:
                    df_filtered = df_filtered[df_filtered["child_name"].str.contains(filter_child, case=False)]
                
                st.write(f"顯示 {len(df_filtered)} / {len(df_links)} 筆資料")
                st.write("請直接在表格中修改 `加價 (extra_cost)`。")
                edited_links = st.data_editor(
                    df_filtered,
                    column_config={
                        "parent_item_id": st.column_config.TextColumn("母群組ID", disabled=True),
                        "parent_name": st.column_config.TextColumn("母群組名稱", disabled=True),
                        "child_item_id": st.column_config.TextColumn("子品項ID", disabled=True),
                        "child_name": st.column_config.TextColumn("子品項名稱", disabled=True),
                        "extra_cost": st.column_config.NumberColumn("加價 (可修改)", min_value=0, step=1)
                    },
                    hide_index=True, use_container_width=True, key="editor_links_update"
                )
                
                if st.button("💾 儲存加價變更"):
                    changes_made = 0
                    admin_id = selected_admin
                    try:
                        with engine.begin() as conn:
                            for idx, row in edited_links.iterrows():
                                orig_row = df_filtered.iloc[idx]
                                if row["extra_cost"] != orig_row["extra_cost"]:
                                    pid = row["parent_item_id"]
                                    cid = row["child_item_id"]
                                    conn.execute(
                                        text("UPDATE item_group_links SET extra_cost=:ec WHERE parent_item_id=:p AND child_item_id=:c"),
                                        {"ec": int(row["extra_cost"]), "p": pid, "c": cid}
                                    )
                                    insert_edit_log(
                                        conn, table="item_group_links", pk=f"{pid}_{cid}", action="UPDATE",
                                        old_data={"extra_cost": int(orig_row["extra_cost"])}, new_data={"extra_cost": int(row["extra_cost"])}, admin=admin_id
                                    )
                                    changes_made += 1
                        if changes_made > 0:
                            st.success(f"✅ 成功更新 {changes_made} 筆加價！")
                            import time
                            time.sleep(1)
                            st.rerun()
                        else:
                            st.info("沒有變更。")
                    except Exception as e:
                        st.error(f"更新失敗: {e}")
        except Exception as e:
            st.error(f"讀取資料失敗: {e}")


# ==============================================================================
# 🎯 功能四：刪除資料 (完整版：含組合、單品、方案)
# ==============================================================================
elif mode == "🗑 刪除資料":
    if st.session_state.get("last_mode") != mode:
        st.session_state["del_df"] = None # 清空 Tab 1 的查詢結果
        st.session_state["confirm_stage_tab1"] = False
        st.session_state["del_success_tab1"] = False
        st.session_state["last_mode"] = mode # 紀錄當前模式
    st.header("🗑 資料刪除中心")

    tab1, tab2, tab3, tab4 = st.tabs(["📦 刪除組合套餐", "🍔 刪除基本單品 (Items)", "🍟 刪除方案 (Options)", "🔗 刪除群組項目"])

    # --------------------------------------------------------------------------
    # Tab 1: 刪除組合套餐 - 🔥 新增預覽功能
    # --------------------------------------------------------------------------
    with tab1:
        st.subheader("管理組合資料")
        st.caption("利用多選篩選器查詢資料，勾選後進行刪除。")

        # 1. 準備篩選清單
        try:
            with engine.connect() as conn:
                items_df = pd.read_sql("SELECT item_name FROM items ORDER BY item_id ASC", conn)
                options_df = pd.read_sql("SELECT option_name FROM menu_options ORDER BY option_id ASC", conn)
        except Exception as e:
            items_df, options_df = pd.DataFrame(), pd.DataFrame()

        item_list = items_df['item_name'].unique().tolist()
        option_list = options_df['option_name'].unique().tolist()

        # 2. 篩選器 UI
        with st.container(border=True):
            c1, c2, c3 = st.columns([2, 2, 1])
            with c1:
                sel_items = st.multiselect("1️⃣ 篩選品項 (依 ID 排序)", item_list, key="del_mul_items")
            with c2:
                sel_options = st.multiselect("2️⃣ 篩選方案 (依 ID 排序)", option_list, key="del_mul_options")
            with c3:
                st.write("")
                st.write("")
                btn_query = st.button("🔍 查詢資料", key="btn_del_query", use_container_width=True)

        # 3. 查詢邏輯
        if btn_query:
            st.session_state["del_success_tab1"] = False
            if "del_df" in st.session_state: del st.session_state["del_df"]
            st.session_state["confirm_stage_tab1"] = False

            sql = """
                SELECT DISTINCT 
                    ac.combination_id, 
                    ac.combination_name AS '組合內容', 
                    mo.option_name AS '搭配方案', 
                    ac.price AS '價格'
                FROM all_combinations ac
                LEFT JOIN menu_options mo ON ac.option_id = mo.option_id
                LEFT JOIN combinations_detail cd ON ac.combination_id = cd.combination_id
                LEFT JOIN items i ON cd.item_id = i.item_id
                WHERE 1=1
            """
            params = {}
            if sel_items:
                keys = [f"i{i}" for i in range(len(sel_items))]
                params.update({k: v for k, v in zip(keys, sel_items)})
                sql += f" AND i.item_name IN ({', '.join([':' + k for k in keys])})"
            if sel_options:
                keys = [f"o{i}" for i in range(len(sel_options))]
                params.update({k: v for k, v in zip(keys, sel_options)})
                sql += f" AND mo.option_name IN ({', '.join([':' + k for k in keys])})"

            sql += " ORDER BY ac.combination_id ASC"

            try:
                with engine.connect() as conn:
                    df_res = pd.read_sql(text(sql), conn, params=params)
                if not df_res.empty:
                    df_res.insert(0, "刪除?", False)
                st.session_state["del_df"] = df_res
                st.session_state["last_sel_items"] = sel_items
                st.session_state["last_sel_options"] = sel_options
            except Exception as e:
                st.error(f"查詢失敗: {e}")

        # 4. 顯示與操作
        # --- A. 表格顯示區塊 ---
        if "del_df" in st.session_state and st.session_state["del_df"] is not None:
            df = st.session_state["del_df"]
            if not df.empty:
                st.write(f"📊 查詢結果：共 {len(df)} 筆")
                select_all = st.checkbox("全選", key="chk_all_combo")
                if select_all:
                    df["刪除?"] = True

                edited_df = st.data_editor(
                    df,
                    column_config={
                        "刪除?": st.column_config.CheckboxColumn("刪除?", width="small"),
                        "combination_id": st.column_config.TextColumn("ID", disabled=True),
                        "組合內容": st.column_config.TextColumn("組合內容", disabled=True, width="large"),
                        "搭配方案": st.column_config.TextColumn("搭配方案", disabled=True),
                        "價格": st.column_config.NumberColumn("價格", disabled=True)
                    },
                    hide_index=True,
                    use_container_width=True,
                    key="editor_del_combo"
                )

                # ⭐ 這裡只負責「觸發」準備刪除，並把結果存進 session_state
                temp_rows = edited_df[edited_df["刪除?"] == True]
                if not temp_rows.empty:
                    if st.button(f"🗑 準備刪除這 {len(temp_rows)} 筆", key="btn_prep_del_combo"):
                        st.session_state["confirm_stage_tab1"] = True
                        st.session_state["pending_ids_tab1"] = temp_rows["combination_id"].tolist()
                        st.session_state["pending_count_tab1"] = len(temp_rows) # 紀錄筆數供後續顯示

        # --- B. 確認視窗區塊 (完全移出，並改用 session_state) ---
        if st.session_state.get("confirm_stage_tab1", False):
            # 💡 重要：這裡不要再用到 edited_df 這個變數名！
            pending_ids = st.session_state.get("pending_ids_tab1", [])
            pending_count = st.session_state.get("pending_count_tab1", 0)
            
            st.markdown("---")
            with st.container(border=True):
                st.error(f"⚠️ **確認提示**：您確定要刪除這 {pending_count} 筆組合嗎？")
                
                # (預覽清單 SQL 代碼...)
                
                col_yes, col_no = st.columns(2)
                with col_yes:
                    if st.button("✅ 確認刪除", key="btn_conf_tab1", type="primary", use_container_width=True):
                        # 1. 執行刪除
                        target_ids = st.session_state.get("pending_ids_tab1", [])
                        _do_delete_combinations(target_ids)
                        
                        # 2. 紀錄成功狀態（為了顯示下方的成功訊息）
                        st.session_state["del_success_tab1"] = True
                        st.session_state["last_del_count_tab1"] = len(target_ids)
                        
                        # 3. 關閉確認視窗（這會讓紅框消失，但表格會因為 del_df 還在而留著）
                        st.session_state["confirm_stage_tab1"] = False
                        
                        # 4. 🔥 重點：不要在這裡執行 del st.session_state["del_df"]
                        # 如果你希望表格「更新」成刪除後的樣子，可以在這裡重新跑一次查詢邏輯更新 del_df
                        
                        st.rerun()

                with col_no:
                    if st.button("❌ 取消", key="btn_canc_tab1", use_container_width=True):
                        st.session_state["confirm_stage_tab1"] = False
                        st.rerun()

        if st.session_state.get("del_success_tab1", False):
            st.write("") # 加點間距
            st.success(f"✅ 已成功刪除 {st.session_state.get('last_del_count_tab1', 0)} 筆套餐組合！")

    # --------------------------------------------------------------------------
    # Tab 2: 刪除基本單品 (Items) - 維持不變 (已包含預覽)
    # --------------------------------------------------------------------------
    with tab2:
        st.subheader("🍔 管理基本單品")
        st.warning("⚠️ 刪除單品將連動刪除相關組合。")

        try:
            with engine.connect() as conn:
                df_items = pd.read_sql("SELECT * FROM items ORDER BY item_id ASC", conn)

            if not df_items.empty:
                df_items.insert(0, "刪除?", False)
                if st.checkbox("全選單品", key="chk_all_items"):
                    df_items["刪除?"] = True

                edited_items = st.data_editor(
                    df_items,
                    column_config={
                        "刪除?": st.column_config.CheckboxColumn("刪除?", width="small"),
                        "item_id": st.column_config.TextColumn("ID", disabled=True),
                        "item_name": st.column_config.TextColumn("名稱", disabled=True)
                    },
                    hide_index=True,
                    use_container_width=True,
                    key="editor_del_items"
                )

                rows_del = edited_items[edited_items["刪除?"] == True]

                if not rows_del.empty:
                    st.write("")
                    if st.button(f"🗑 準備刪除 {len(rows_del)} 項單品", key="btn_prep_del_items"):
                        st.session_state["confirm_stage_tab2"] = True
                        st.session_state["pending_ids_tab2"] = rows_del["item_id"].tolist()

                if st.session_state.get("confirm_stage_tab2", False):
                    st.markdown("---")
                    with st.container(border=True):
                        st.error("⚠️ **確認提示**：再次確定將有關此 Item 的全部資料刪除？")

                        # 預覽受影響組合
                        p_ids = st.session_state["pending_ids_tab2"]
                        try:
                            with engine.connect() as conn:
                                p_keys = {f"p{i}": pid for i, pid in enumerate(p_ids)}
                                p_clause = ", ".join([f":{k}" for k in p_keys])
                                sql_names = f"SELECT item_name FROM items WHERE item_id IN ({p_clause})"
                                names_res = conn.execute(text(sql_names), p_keys).fetchall()
                                target_names = [r[0] for r in names_res]

                                df_preview = pd.DataFrame()
                                if target_names:
                                    n_keys = {f"n{i}": n for i, n in enumerate(target_names)}
                                    n_clause = ", ".join([f":{k}" for k in n_keys])
                                    sql_preview = f"""
                                        SELECT DISTINCT 
                                            ac.combination_id AS 'ID', 
                                            ac.combination_name AS '組合內容',
                                            mo.option_name AS '搭配方案'
                                        FROM all_combinations ac
                                        JOIN combinations_detail cd ON ac.combination_id = cd.combination_id
                                        LEFT JOIN menu_options mo ON ac.option_id = mo.option_id
                                        WHERE i.item_name IN ({n_clause})
                                        ORDER BY ac.combination_id ASC
                                    """
                                    df_preview = pd.read_sql(text(sql_preview), conn, params=n_keys)
                        except Exception:
                            df_preview = pd.DataFrame()

                        if not df_preview.empty:
                            st.write(f"🔻 **下列 {len(df_preview)} 筆相關組合也將一併被刪除：**")
                            st.dataframe(df_preview, hide_index=True, use_container_width=True)
                        else:
                            st.info("ℹ️ 此單品目前未被用於任何組合，將單獨刪除。")

                        col_yes, col_no = st.columns(2)
                        with col_yes:
                            if st.button("✅ 確認刪除", key="btn_conf_tab2", type="primary", use_container_width=True):
                                _do_delete_items(st.session_state["pending_ids_tab2"])
                                st.session_state["confirm_stage_tab2"] = False
                        with col_no:
                            if st.button("❌ 取消", key="btn_canc_tab2", use_container_width=True):
                                st.session_state["confirm_stage_tab2"] = False
                                st.rerun()

            else:
                st.info("無資料。")

        except Exception as e:
            st.error(f"Error: {e}")

    # --------------------------------------------------------------------------
    # Tab 3: 刪除方案 (Options) - 🔥 新增：預覽受影響組合
    # --------------------------------------------------------------------------
    with tab3:
        st.subheader("🍟 管理方案")
        st.warning("⚠️ 刪除方案將連動刪除相關組合。")

        try:
            with engine.connect() as conn:
                df_opts = pd.read_sql("SELECT * FROM menu_options ORDER BY option_id ASC", conn)

            if not df_opts.empty:
                df_opts.insert(0, "刪除?", False)
                if st.checkbox("全選方案", key="chk_all_opts"):
                    df_opts["刪除?"] = True

                edited_opts = st.data_editor(
                    df_opts,
                    column_config={
                        "刪除?": st.column_config.CheckboxColumn("刪除?", width="small"),
                        "option_id": st.column_config.TextColumn("ID", disabled=True),
                        "option_name": st.column_config.TextColumn("名稱", disabled=True)
                    },
                    hide_index=True,
                    use_container_width=True,
                    key="editor_del_opts"
                )

                rows_del = edited_opts[edited_opts["刪除?"] == True]

                if not rows_del.empty:
                    st.write("")
                    if st.button(f"🗑 準備刪除 {len(rows_del)} 個方案", key="btn_prep_del_opts"):
                        st.session_state["confirm_stage_tab3"] = True
                        st.session_state["pending_ids_tab3"] = rows_del["option_id"].tolist()

                # Tab 3 確認視窗 (含預覽)
                if st.session_state.get("confirm_stage_tab3", False):
                    st.markdown("---")
                    with st.container(border=True):
                        st.error("⚠️ **確認提示**：再次確定將有關此 Option 的全部資料刪除？")

                        # ----- 🔥 預覽受影響組合邏輯 -----
                        try:
                            o_ids = st.session_state["pending_ids_tab3"]
                            with engine.connect() as conn:
                                o_keys = {f"o{i}": oid for i, oid in enumerate(o_ids)}
                                o_clause = ", ".join([f":{k}" for k in o_keys])

                                # 查詢該方案下的組合
                                sql_prev_opt = f"""
                                    SELECT 
                                        ac.combination_id AS 'ID', 
                                        ac.combination_name AS '組合內容',
                                        mo.option_name AS '搭配方案'
                                    FROM all_combinations ac
                                    LEFT JOIN menu_options mo ON ac.option_id = mo.option_id
                                    WHERE ac.option_id IN ({o_clause})
                                    ORDER BY ac.combination_id ASC
                                """
                                df_prev_opt = pd.read_sql(text(sql_prev_opt), conn, params=o_keys)

                                if not df_prev_opt.empty:
                                    st.write(f"🔻 **下列 {len(df_prev_opt)} 筆相關組合也將一併被刪除：**")
                                    st.dataframe(df_prev_opt, hide_index=True, use_container_width=True)
                                else:
                                    st.info("ℹ️ 此方案目前無相關組合。")
                        except Exception:
                            st.warning("無法載入預覽")
                        # -----------------------------------

                        col_yes, col_no = st.columns(2)
                        with col_yes:
                            if st.button("✅ 確認刪除", key="btn_conf_tab3", type="primary", use_container_width=True):
                                _do_delete_options(st.session_state["pending_ids_tab3"])
                                st.session_state["confirm_stage_tab3"] = False
                        with col_no:
                            if st.button("❌ 取消", key="btn_canc_tab3", use_container_width=True):
                                st.session_state["confirm_stage_tab3"] = False
            else:
                st.info("無資料。")
        except Exception as e:
            st.error(f"Error: {e}")


    # --------------------------------------------------------------------------
    # Tab 4: 刪除群組關聯 (item_group_links)
    # --------------------------------------------------------------------------
    with tab4:
        st.subheader("🔗 刪除群組項目")
        try:
            with engine.connect() as conn:
                from sqlalchemy import text
                import pandas as pd
                sql_link_del = """
                    SELECT l.parent_item_id, p.item_name AS parent_name, 
                           l.child_item_id, c.item_name AS child_name, 
                           l.extra_cost
                    FROM item_group_links l
                    JOIN items p ON l.parent_item_id = p.item_id
                    JOIN items c ON l.child_item_id = c.item_id
                    ORDER BY l.parent_item_id, l.child_item_id
                """
                df_links_del = pd.read_sql(text(sql_link_del), conn)

            if not df_links_del.empty:
                col1, col2 = st.columns([2, 2])
                with col1:
                    filter_parent_del = st.text_input("🔍 篩選母群組名稱", key="filter_parent_del")
                with col2:
                    filter_child_del = st.text_input("🔍 篩選子品項名稱", key="filter_child_del")

                df_filtered_del = df_links_del.copy()
                if filter_parent_del:
                    df_filtered_del = df_filtered_del[df_filtered_del["parent_name"].str.contains(filter_parent_del, case=False)]
                if filter_child_del:
                    df_filtered_del = df_filtered_del[df_filtered_del["child_name"].str.contains(filter_child_del, case=False)]

                st.write(f"顯示 {len(df_filtered_del)} / {len(df_links_del)} 筆資料")

                df_filtered_del.insert(0, "刪除?", False)
                if st.checkbox("全選關聯", key="chk_all_links"):
                    df_filtered_del["刪除?"] = True

                edited_del_links = st.data_editor(
                    df_filtered_del,
                    column_config={
                        "刪除?": st.column_config.CheckboxColumn("刪除?", width="small"),
                        "parent_item_id": st.column_config.TextColumn("母群組ID", disabled=True),
                        "parent_name": st.column_config.TextColumn("母群組名稱", disabled=True),
                        "child_item_id": st.column_config.TextColumn("子品項ID", disabled=True),
                        "child_name": st.column_config.TextColumn("子品項名稱", disabled=True),
                        "extra_cost": st.column_config.NumberColumn("加價", disabled=True)
                    },
                    hide_index=True, use_container_width=True, key="editor_del_links"
                )

                rows_del_links = edited_del_links[edited_del_links["刪除?"] == True]

                if not rows_del_links.empty:
                    if st.button(f"🗑 確定刪除這 {len(rows_del_links)} 個群組關聯", key="btn_del_links"):
                        admin_id = selected_admin
                        try:
                            with engine.begin() as conn:
                                for _, row in rows_del_links.iterrows():
                                    pid = row["parent_item_id"]
                                    cid = row["child_item_id"]
                                    conn.execute(
                                        text("DELETE FROM item_group_links WHERE parent_item_id=:p AND child_item_id=:c"),
                                        {"p": pid, "c": cid}
                                    )
                                    insert_edit_log(
                                        conn, table="item_group_links", pk=f"{pid}_{cid}", action="DELETE",
                                        old_data={"extra_cost": int(row["extra_cost"])}, new_data=None, admin=admin_id
                                    )
                            st.success("✅ 成功刪除！")
                            import time
                            time.sleep(1)
                            st.rerun()
                        except Exception as e:
                            st.error(f"刪除失敗: {e}")
            else:
                st.info("目前無任何綁定關聯。")
        except Exception as e:
            st.error(f"Error: {e}")


elif mode == "📋編輯紀錄":

    # ==============================
    # Session State
    # ==============================
    if "selected_log_id" not in st.session_state:
        st.session_state.selected_log_id = None

    # ==============================
    # 讀取 logs（時間新 → 舊）
    # ==============================
    with engine.connect() as conn:
        logs = conn.execute(text("""
            SELECT *
            FROM edit_logs
            ORDER BY created_at DESC
            LIMIT 500
        """)).mappings().all()

    if not logs:
        st.info("目前尚無編輯紀錄")
        st.stop()

    st.subheader("📋 編輯紀錄列表")

    # ==============================
    # 用來避免同一個 batch 顯示多次
    # ==============================
    rendered_batch_ids = set()

    # ==============================
    # Header
    # ==============================
    header = st.columns([1, 2, 2, 2, 3, 1])
    header[0].markdown("**ID**")
    header[1].markdown("**資料表**")
    header[2].markdown("**資料 ID / 筆數**")
    header[3].markdown("**操作**")
    header[4].markdown("**時間**")
    header[5].markdown("**查看**")

    st.divider() # 加一條線區隔標題與內容

    # ============================================================
    # 🌟 重點：建立一個固定高度的容器，裡面的內容過長會自動出現捲軸
    # ============================================================
    with st.container(height=500): # 500 可以根據你的螢幕大小調整
        
        rendered_batch_ids = set()
    # ==============================
    # 主列表（單一時間序）
    # ==============================
        for log in logs:
            is_selected = (st.session_state.get("selected_log_id") == log["log_id"])
            
            b = "**" if is_selected else ""
            prefix = "🎯 " if is_selected else ""

            if log["batch_id"]:
                
                batch_id = log["batch_id"]
                if batch_id in rendered_batch_ids:
                    continue
                rendered_batch_ids.add(batch_id)

                batch_logs_all = [l for l in logs if l["batch_id"] == batch_id]

                # --- 🏆 決定誰排在外面當主角 ---
                # 優先順序：
                # 1. 刪除方案時：選 menu_options
                # 2. 批量改價時：選 items (這就解決了 ID 39 的問題)
                # 3. 如果都沒有，才選其他的
                main_log = next((l for l in batch_logs_all if l["table_name"] == "menu_options"), None)
                if not main_log:
                    main_log = next((l for l in batch_logs_all if l["table_name"] == "items"), None)
                if not main_log:
                    # 排除掉那種 record_id 是亂碼的 BATCH Log
                    real_data = [l for l in batch_logs_all if "BATCH" not in l["action_type"]]
                    main_log = real_data[0] if real_data else batch_logs_all[0]

                # 摺疊內容：排除掉外面那個主角，也排除掉討厭的 BATCH 噪音 Log
                detail_logs = [
                    l for l in batch_logs_all 
                    if l["log_id"] != main_log["log_id"] and "BATCH" not in l["action_type"]
                ]

                # --- 顯示外層紀錄 (標題列) ---
                cols = st.columns([1, 2, 2, 2, 3, 1])
                cols[0].markdown(f"{b}{prefix}{main_log['log_id']}{b}")
                cols[1].markdown(f"{b}{main_log['table_name']}{b}")
                cols[2].markdown(f"{b}{main_log['record_id']}{b}")
                cols[3].markdown(f"{b}{main_log['action_type']}{b}")
                cols[4].markdown(f"{b}{main_log['created_at']}{b}")

                if cols[5].button("查看", key=f"view_{main_log['log_id']}"):
                    st.session_state.selected_log_id = main_log["log_id"]
                    st.rerun() # 點擊後立即重新渲染以顯示標記

                # --- 顯示摺疊明細 ---
                if detail_logs:
                    label = "連動組合修改" if main_log["table_name"] == "items" else "連動刪除明細"
                    with st.expander(f"└─ 🔗 包含 {len(detail_logs)} 筆{label}"):
                        st.dataframe(
                            pd.DataFrame(detail_logs)[["table_name", "record_id", "action_type", "created_at"]],
                            use_container_width=True, hide_index=True
                        )
                continue
        # --- 單筆無 batch 資料 ---
        # ... 原本的 cols 程式碼 ...

            # --- 以下是正常的單筆 log 顯示 (無 batch_id) ---
            cols = st.columns([1, 2, 2, 2, 3, 1])
            cols[0].markdown(f"{b}{prefix}{log['log_id']}{b}")
            cols[1].markdown(f"{b}{log['table_name']}{b}")
            cols[2].markdown(f"{b}{log['record_id']}{b}")
            cols[3].markdown(f"{b}{log['action_type']}{b}")
            cols[4].markdown(f"{b}{log['created_at']}{b}")

            if cols[5].button("查看", key=f"view_{log['log_id']}"):
                st.session_state.selected_log_id = log["log_id"]
                st.rerun()
    # ==============================
    # 🔍 單筆詳細修改紀錄
    # ==============================
    if st.session_state.selected_log_id:

        with engine.connect() as conn:
            detail = conn.execute(
                text("SELECT * FROM edit_logs WHERE log_id = :id"),
                {"id": st.session_state.selected_log_id}
            ).mappings().first()

        old_data = json.loads(detail["old_data"]) if detail["old_data"] else {}
        new_data = json.loads(detail["new_data"]) if detail["new_data"] else {}

        st.markdown("---")
        st.subheader("🔍 詳細修改紀錄")

        c1, c2, c3 = st.columns(3)
        c1.markdown(f"**資料表**：`{detail['table_name']}`")
        c2.markdown(f"**管理員**：`{detail['user_id']}`")
        c3.markdown(f"**時間**：{detail['created_at']}")

        rows = []
        # ⭐ 防呆：DELETE 時 new_data 可能是 None
        old_dict = old_data or {}
        new_dict = new_data or {}

        for k in sorted(set(old_dict.keys()) | set(new_dict.keys())):
            old_val = old_dict.get(k, "")
            new_val = new_dict.get(k, "")
            
            # ⭐ 新增：如果資料是 list 或 dict，轉成字串避免 PyArrow 噴錯
            if isinstance(old_val, (list, dict)):
                import json
                old_val = json.dumps(old_val, ensure_ascii=False)
            if isinstance(new_val, (list, dict)):
                import json
                new_val = json.dumps(new_val, ensure_ascii=False)

            rows.append({
                "欄位": k,
                "舊資料": old_val,
                "新資料": new_val
            })

        st.table(pd.DataFrame(rows))


elif mode == "❓ 使用導覽":
    st.header("❓ 麥當勞省錢後台 - 使用導覽")
    
    st.markdown("""
    ## 📌 功能總覽
    
    本後台系統提供以下五大功能：
    """)
    
    with st.expander("📖 1. 瀏覽與查詢", expanded=True):
        st.markdown("""
        - **單一資料表查詢**：可選擇任一資料表（單品、套餐、選項、群組），輸入關鍵字進行搜尋
        - **套餐組合分析 (JOIN)**：跨表查詢套餐與品項的關聯，可依方案、類型、關鍵字篩選
        - 支援匯出 CSV 檔案
        """)
    
    with st.expander("➕ 2. 新增資料"):
        st.markdown("""
        - **新增單品**：新增單品項目（漢堡、飲料、甜點等）
            - 系統自動生成 ID（格式：Fxxxx, Bxxxx, Dxxxx, Gxxxx）
            - ID 自動遞增
        - **新增套餐**：建立套餐組合
            - 先選擇方案，再選擇包含的品項
            - 可設定各品項數量
            - combination_id 會與 option_id 關聯（例如：O004 → C004001）
        - **新增選項**：新增優惠方案（如經典配餐、超值全餐）
        - **新增群組項目**：建立品項群組與綁定關係
        """)
    
    with st.expander("✏️ 3. 修改資料"):
        st.markdown("""
        - **修改單品**：修改單品名稱、分類、價格
            - 可勾選連動更新，自動調整所有包含此單品的套餐價格
        - **修改套餐**：修改套餐價格
            - 支援篩選後批次修改
        - **修改選項**：修改方案名稱
        - **修改群組加價**：修改群組替換加價費用
        """)
    
    with st.expander("🗑 4. 刪除資料"):
        st.markdown("""
        - **刪除套餐**：刪除特定套餐（連同明細一起刪）
        - **刪除方案**：刪除方案（連同該方案下所有套餐一起刪）
        - **刪除單品**：刪除單品（連同包含此單品的套餐一起刪）
        - **刪除群組項目**：刪除品項群組的綁定關聯
        - 刪除前會顯示預覽，確認後才執行
        """)
    
    with st.expander("📋 5. 編輯紀錄"):
        st.markdown("""
        - 查看所有新增、修改、刪除的歷史紀錄
        - 顯示操作者、操作時間、變更前/後資料
        - 同一批次操作會摺疊顯示
        """)
    
    st.markdown("---")
    st.markdown("""
    ## 📖 名詞解釋
    
    | 名詞 | 說明 |
    |------|------|
    | **單品 (Items)** | 最基本的商品單位，如大麥克、可樂、薯條等，每個單品有獨立的價格 |
    | **方案 (Options)** | 優惠套餐的分類，例如「單點配餐」、「超值全餐」等，用於區分套餐類型 |
    | **套餐 (Combinations)** | 由多個單品組成的組合，如「大麥克套餐」，包含漢堡+薯條+飲料，擁有統一價格 |
    | **群組 (Group)** | 用於品項替換的分類，例如「冷飲群組」可包含可口可樂、雪碧等，替換時可設定加價 |
    | **母群組** | 群組的父項目，作為可替換品項的分類容器（如冷飲群組） |
    | **子品項** | 屬於群組內的實際商品，可作為替換選項（如可口可樂、雪碧） |
    | **加價 (Extra Cost)** | 替換群組品項時需要額外支付的費用，例如汽水換奶茶加5元 |
    
    ## 💡 使用提示
    
    1. **ID 生成規則**：
       - 單品 ID：F/B/D/G + 5位數（如 F00001）
       - 方案 ID：O + 3位數（如 O001）
       - 套餐 ID：C + 方案數字 + 3位數（如 C001001 屬於 O001 方案）
    
    2. **價格同步**：
       - O001-單點 的套餐價格會與 Items 表單品價格總和一致
       - 其他方案（O002、O004等）套餐價格可獨立設定
    
    3. **資料操作**：
       - 新增/修改後不會自動刷新，需手動刷新頁面
       - 刪除前會顯示確認預覽
    
    4. **操作者**：
       - 需先在側邊欄選擇當前操作者姓名
       - 所有操作紀錄會記錄操作者
    """)
    
    st.markdown("---")
    st.caption("麥當勞省錢後台 v2.0")


