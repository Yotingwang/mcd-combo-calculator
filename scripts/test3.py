import sys
import json
import io
import os
from dotenv import load_dotenv
original_stdout = sys.stdout
sys.stdout = sys.stderr
import io

# -*- coding: utf-8 -*-
from pulp import LpProblem, LpVariable, lpSum, LpMinimize, PULP_CBC_CMD
import pymysql
import pymysql.cursors
from collections import defaultdict, Counter
import itertools

# 使用者輸入品項與數量
def get_required_items_from_user():
    import sys
    if len(sys.argv) > 1:
        try:
            data = json.loads(sys.argv[1])
            if "cart" in data:
                sweetheart = data.get("sweetheart", True)
                return sweetheart, data["cart"], data.get("mustHave", {})
            else:
                return True, data, {}
        except:
            pass
    return True, {
        "B00007": 2, "D00005": 2, "F00004": 2, "F00006": 2,
        "B00004": 1, "D00021": 1, "D00023": 1, "D00018": 1,    
    }, {}

# 替代群定義（可以自定義，主要就是同性質的食物就可以擺在同一個替代群）
def get_substitute_groups():
    return [
        {"D00004", "D00005", "D00006"},
        {"D00018", "D00020", "D00016", "D00017"},
        {"D00007", "D00008", "D00009", "D00010", "D00021", "D00022", "D00023"},
        {"D00014", "D00015", "D00011", "D00012", "D00013"},
    ]

# 使用者指定「有幾份是一定要吃到、不能被替代」的品項
def get_items_user_must_have():
    return {
        # 隨時可以備注掉，測試用，用以觀察系統是否可以保留這裏所宣告的食物（不要被替代）
        #"D00023": 1,  # 至少要有1份麥克鷄塊（10塊）
    }

# 資料庫連線
def connect_to_db(config):
    try:
        conn = pymysql.connect(
            host=config['host'],
            user=config['user'],
            password=config['password'],
            database=config['database'],
            charset=config['charset'],
            cursorclass=pymysql.cursors.DictCursor
        )
        return conn, conn.cursor()
    except Exception as err:
        print("資料庫錯誤：", err)
        return None, None

# 取得品項名稱對照表
def get_item_map(cursor):
    cursor.execute("SELECT item_id, item_name, item_type FROM items")
    rows = cursor.fetchall()
    name_map = {row['item_id']: row['item_name'] for row in rows}
    type_map = {row['item_id']: row['item_type'] for row in rows}
    return name_map, type_map

# 查詢價格
def fetch_item_prices(cursor, required_items, item_name_map):
    item_ids_str = ", ".join(f"'{i}'" for i in required_items.keys())
    cursor.execute(f"SELECT item_id, price FROM items WHERE item_id IN ({item_ids_str})")
    prices = cursor.fetchall()

    single_total_price = 0
    print("\\n📋 所需品項與單點價格如下：")
    for item in prices:
        qty = required_items[item["item_id"]]
        subtotal = qty * item["price"]
        name = item_name_map.get(item["item_id"], "未知品項")
        print(f"- {item['item_id']} ({name}) x {qty}：單價 {item['price']} 元，小計 {subtotal} 元")
        single_total_price += subtotal
    print(f"\\n✅ 單點總價格為：{single_total_price} 元")
    return single_total_price

def get_group_links(cursor):
    cursor.execute("SELECT parent_item_id, child_item_id, extra_cost FROM item_group_links")
    links = cursor.fetchall()
    group_map = defaultdict(list)
    for row in links:
        group_map[row['parent_item_id']].append((row['child_item_id'], row['extra_cost']))
    return group_map

def fetch_active_promotions(cursor):
    cursor.execute("""
        SELECT p.*, i.item_name AS reward_name
        FROM promotions p
        LEFT JOIN items i ON p.reward_item_id = i.item_id
        WHERE p.is_active = 1
          AND (p.start_time IS NULL OR p.start_time <= NOW())
          AND (p.end_time IS NULL OR p.end_time >= NOW())
    """)
    return cursor.fetchall()

def check_promotions_for_combo(combo_entry, promotions):
    if not promotions:
        return None
    combo_id = combo_entry["combination_id"]
    option_id = combo_entry.get("option_id", "")
    items = combo_entry.get("item_counts", {})
    base_combo_id = combo_id.split("_")[0]
    for promo in promotions:
        cond_type = promo["condition_type"]
        cond_values = [v.strip() for v in promo["condition_value"].split(",")]
        matched = False
        if cond_type == "OPTION":
            if option_id in cond_values:
                matched = True
        elif cond_type == "COMBINATION":
            if base_combo_id in cond_values or combo_id in cond_values:
                matched = True
        elif cond_type == "ITEM":
            if any(item_id in cond_values for item_id in items):
                matched = True
        if matched:
            return {
                "promo_id": promo["promo_id"],
                "promo_name": promo["promo_name"],
                "reward_item_id": promo["reward_item_id"],
                "reward_name": promo.get("reward_name", ""),
                "extra_cost": promo["extra_cost"]
            }
    return None

def fetch_all_combos_from_db(cursor, include_sweetheart):
    exclude_clause = "" if include_sweetheart else "AND ac.option_id != 'O009'"
    sql = f"""
        SELECT ac.combination_id, ac.combination_name, ac.price, mo.option_name, ac.option_id, cd.item_id, cd.quantity
        FROM all_combinations ac
        JOIN menu_options mo ON ac.option_id = mo.option_id
        JOIN combinations_detail cd ON ac.combination_id = cd.combination_id
        WHERE 1=1 {exclude_clause}
    """
    cursor.execute(sql)
    rows = cursor.fetchall()

    combo_dict = defaultdict(lambda: {"option_name": "", "combination_name": "", "price": 0, "option_id": "", "items": []})
    for r in rows:
        cid = r["combination_id"]
        combo_dict[cid]["option_name"] = r["option_name"]
        combo_dict[cid]["combination_name"] = r["combination_name"]
        combo_dict[cid]["price"] = r["price"]
        combo_dict[cid]["option_id"] = r["option_id"]
        for _ in range(r["quantity"]):
            combo_dict[cid]["items"].append(r["item_id"])
    return combo_dict

def expand_combos(combo_dict, item_type_map, group_map, item_name_map):
    expanded_combos = []
    
    for cid, data in combo_dict.items():
        base_price = data["price"]
        items = data["items"]
        
        # 分離出實體單品與虛擬群組
        solid_items = []
        groups = []
        
        for item in items:
            if item_type_map.get(item) == "GROUP":
                groups.append(item)
            else:
                solid_items.append(item)
                
        # 若沒有群組，就直接是原本的套餐
        if not groups:
            expanded_combos.append({
                "combination_id": cid,
                "option_name": data["option_name"],
                "option_id": data["option_id"],
                "combination_detail": data["combination_name"],
                "price": base_price,
                "item_counts": dict(Counter(solid_items))
            })
            continue
            
        # 若有群組，取得每個群組可能的替換清單
        group_choices = []
        for g in groups:
            choices = group_map.get(g, [])
            if not choices:
                choices = [("NONE", 0)]
            group_choices.append(choices)
            
        # 笛卡兒積展開所有替換可能
        for choice_combo in itertools.product(*group_choices):
            extra_price_sum = sum(c[1] for c in choice_combo)
            child_items = [c[0] for c in choice_combo]
            
            names = [item_name_map.get(c, "未知") for c in child_items]
            detail_name = f"{data['combination_name']} ({'+'.join(names)})"
            
            virtual_cid = f"{cid}_{'_'.join(child_items)}"
            
            final_items = solid_items + child_items
            expanded_combos.append({
                "combination_id": virtual_cid,
                "option_name": data["option_name"],
                "option_id": data["option_id"],
                "combination_detail": detail_name,
                "price": base_price + extra_price_sum,
                "item_counts": dict(Counter(final_items))
            })
            
    return expanded_combos

def inject_promo_variants(expanded_combos, promotions, item_name_map):
    """針對每個已展開套餐，比對優惠規則，生成含贈品的虛擬套餐變體。
    使 ILP 解題器能自動評估是否使用優惠券來免費獲得贈品。」"""
    if not promotions:
        return expanded_combos
    promo_variants = []
    for combo in expanded_combos:
        combo_id = combo["combination_id"]
        option_id = combo.get("option_id", "")
        items = combo.get("item_counts", {})
        base_combo_id = combo_id.split("_")[0]
        for promo in promotions:
            cond_type = promo["condition_type"]
            cond_values = [v.strip() for v in promo["condition_value"].split(",")]
            matched = False
            if cond_type == "OPTION":
                if option_id in cond_values:
                    matched = True
            elif cond_type == "COMBINATION":
                if base_combo_id in cond_values or combo_id in cond_values:
                    matched = True
            elif cond_type == "ITEM":
                if any(item_id in cond_values for item_id in items):
                    matched = True
            if matched:
                reward_id = promo["reward_item_id"]
                new_item_counts = dict(combo["item_counts"])
                new_item_counts[reward_id] = new_item_counts.get(reward_id, 0) + 1
                new_combo_id = f"{combo_id}_PROMO_{promo['promo_id']}"
                new_price = combo["price"] + promo["extra_cost"]
                promo_variant = dict(combo)
                promo_variant["combination_id"] = new_combo_id
                promo_variant["item_counts"] = new_item_counts
                promo_variant["price"] = new_price
                promo_variant["promo"] = {
                    "promo_id": promo["promo_id"],
                    "promo_name": promo["promo_name"],
                    "reward_item_id": reward_id,
                    "reward_name": promo.get("reward_name", item_name_map.get(reward_id, reward_id)),
                    "extra_cost": promo["extra_cost"]
                }
                promo_variants.append(promo_variant)
    return expanded_combos + promo_variants

# 篩選完全符合需求的套餐 (已在展開後)
def filter_strict_combos(expanded_combos, required_items):
    req_set = set(required_items.keys())
    return [c for c in expanded_combos if set(c["item_counts"].keys()).issubset(req_set)]

# 篩選允許替代品的套餐 (已在展開後)
def filter_flexible_combos(expanded_combos, required_items, substitute_groups, must_have_items):
    filtered_groups = [
        group for group in substitute_groups if group.isdisjoint(set(must_have_items.keys()))
    ]
    item_to_group = {item: group for group in filtered_groups for item in group}
    
    valid_items = set()
    for item in required_items:
        valid_items.update(item_to_group.get(item, {item}))
        
    return [c for c in expanded_combos if set(c["item_counts"].keys()).issubset(valid_items)]

# ILP 模型（實現功能一：完全符合）
def build_ilp_strict(required_items, combo_data):
    problem = LpProblem("Strict_Mode", LpMinimize)
    vars = {
        c["combination_id"]: LpVariable(f"var_{c['combination_id']}", 0, None, cat='Integer')
        for c in combo_data
    }
    problem += lpSum(vars[c["combination_id"]] * c["price"] for c in combo_data), "Total_Cost"
    for item_id, qty in required_items.items():
        problem += (
            lpSum(vars[c["combination_id"]] * c["item_counts"].get(item_id, 0) for c in combo_data) >= qty,
            f"Require_{item_id}"
        )
    return problem, vars

# ILP 模型（實現功能二：允許替代）
def build_ilp_with_substitutes(required_items, combo_data, substitute_groups, must_have_items):
    problem = LpProblem("Flexible_Mode", LpMinimize)
    vars = {
        c["combination_id"]: LpVariable(f"var_{c['combination_id']}", 0, None, cat='Integer')
        for c in combo_data
    }

    # 目標式
    problem += lpSum(vars[c["combination_id"]] * c["price"] for c in combo_data), "Total_Cost"

    # 替代群滿足條件
    item_to_group = {i: frozenset(g) for g in substitute_groups for i in g}
    grouped_req = defaultdict(int)
    for i, q in required_items.items():
        group = item_to_group.get(i, frozenset([i]))
        grouped_req[group] += q

    for group, qty in grouped_req.items():
        problem += (
            lpSum(vars[c["combination_id"]] * sum(c["item_counts"].get(i, 0) for i in group) for c in combo_data) >= qty,
            f"RequireGroup_{'_'.join(sorted(group))}"
        )

    # 必須出現的原始品項（不可替代）
    for item_id, qty in must_have_items.items():
        problem += (
            lpSum(vars[c["combination_id"]] * c["item_counts"].get(item_id, 0) for c in combo_data) >= qty,
            f"MustHave_{item_id}"
        )

    return problem, vars

# 解題與輸出，並比較差異
def solve_and_display(problem, combo_data, variables, single_total_price, item_name_map, required_items, substitute_groups, silent=False, must_have_items=None, promotions=None):
    problem.solve(PULP_CBC_CMD(msg=False))

    if problem.status != 1: # 1 is optimal
        print("\\n❌ 找不到合適的組合搭配！")
        return None

    group_lookup = {item: group for group in substitute_groups for item in group}

    optimal = {
        c["combination_id"]: int(variables[c["combination_id"]].varValue)
        for c in combo_data
        if variables[c["combination_id"]].varValue and variables[c["combination_id"]].varValue > 0
    }

    print("\\n✅ 最佳點餐組合如下：")
    result_payload = {
        "status": "success",
        "combos": [],
        "single_items": [],
        "extra_items": [],
        "total": problem.objective.value(),
        "savings": round(single_total_price - problem.objective.value(), 2),
        "original_total": single_total_price,
        "replaced": []
    }
    
    for cid, qty in optimal.items():
        c = next(x for x in combo_data if x["combination_id"] == cid)
        items_names = []
        for i, count in c["item_counts"].items():
            name = item_name_map.get(i, i)
            items_names.extend([name] * count)
        combo_entry = {
            "combo_name": c['combination_detail'],
            "option_name": c['option_name'],
            "qty": qty,
            "price": c['price'],
            "items": items_names
        }
        if "promo" in c:
            reward_id = c["promo"]["reward_item_id"]
            reward_name = item_name_map.get(reward_id, reward_id)
            c["promo"]["reward_name"] = reward_name
            combo_entry["promo"] = c["promo"]
            if reward_name in items_names:
                items_names.remove(reward_name)
            combo_entry["items"] = items_names
        result_payload["combos"].append(combo_entry)
        if not silent: print(f"- {c['option_name']} - {c['combination_detail']}: {qty} 份")

    cost = problem.objective.value()
    if not silent: print(f"\n💰 最低總價格：{cost} 元")
    print(f"🧮 節省金額：{round(single_total_price - cost, 2)} 元")

    optimized_items = defaultdict(int)
    for c in combo_data:
        cid = c["combination_id"]
        if cid in optimal:
            for item_id, count in c["item_counts"].items():
                optimized_items[item_id] += optimal[cid] * count
                
    unchanged = []
    replaced = []
    extra = []
    replaced_set = set()

    user_left = required_items.copy()
    optimized_left = optimized_items.copy()

    for item_id in list(user_left.keys()):
        while user_left[item_id] > 0:
            opt_qty = optimized_left.get(item_id, 0)
            user_qty = user_left[item_id]

            if opt_qty > 0:
                used = min(user_qty, opt_qty)
                user_left[item_id] -= used
                optimized_left[item_id] -= used
                unchanged.append((item_id, used))
            else:
                # must_have 品項不允許透過替代群滿足，直接記為未滿足跳出
                if must_have_items and item_id in must_have_items:
                    replaced.append((item_id, None, user_left[item_id], 0))
                    break
                group = group_lookup.get(item_id, {item_id})
                found_sub = False
                for alt in group:
                    if alt == item_id:
                        continue
                    alt_qty = optimized_left.get(alt, 0)
                    if alt_qty > 0:
                        used = min(user_left[item_id], alt_qty)
                        user_left[item_id] -= used
                        optimized_left[alt] -= used
                        replaced.append((item_id, alt, used))
                        replaced_set.add(alt)
                        result_payload["replaced"].append({"from": item_name_map.get(item_id, item_id), "to": item_name_map.get(alt, alt), "qty": used})
                        found_sub = True
                        break
                if not found_sub:
                    replaced.append((item_id, None, user_left[item_id], 0))
                    break  

    extra_pool = {}
    for item_id, qty in optimized_left.items():
        if qty > 0:
            extra.append((item_id, qty))
            extra_pool[item_id] = qty
            result_payload["extra_items"].append({"name": item_name_map.get(item_id, item_id), "qty": qty})

    # 將 extra items 歸屬到產生它們的 combo
    for combo_entry in result_payload["combos"]:
        combo_extras = []
        for cid, qty in optimal.items():
            c = next(x for x in combo_data if x["combination_id"] == cid)
            if c["combination_detail"] != combo_entry["combo_name"] or c["option_name"] != combo_entry["option_name"]:
                continue
            for item_id, count in c["item_counts"].items():
                total = count * qty
                if item_id in extra_pool and extra_pool[item_id] > 0:
                    taken = min(total, extra_pool[item_id])
                    if taken > 0:
                        combo_extras.append({"name": item_name_map.get(item_id, item_id), "qty": taken})
                        extra_pool[item_id] -= taken
        if combo_extras:
            combo_entry["combo_extra_items"] = combo_extras

    # 重建 extra_items：只保留未被任何 combo 認領的部分
    result_payload["extra_items"] = [
        {"name": item_name_map.get(item_id, item_id), "qty": qty}
        for item_id, qty in extra_pool.items()
        if qty > 0
    ]

    for item_id, qty in user_left.items():
        if qty > 0:
            result_payload["single_items"].append({"name": item_name_map.get(item_id, item_id), "qty": qty})

    return result_payload



# 主程式
if __name__ == "__main__":
    has_sweetheart_card, input_req, input_must_have = get_required_items_from_user()
    substitute_groups = get_substitute_groups()
    load_dotenv()
    config = {
        'host': os.getenv('DB_HOST', 'localhost'),
        'user': os.getenv('DB_USER', 'root'),
        'password': os.getenv('DB_PASSWORD', 'mark1015'),
        'database': os.getenv('DB_NAME', 'mcdonalds_db'),
        'charset': 'utf8mb4'
    }
    
    conn, cursor = connect_to_db(config)
    if cursor is None:
        print("無法連線至資料庫，請確認 .env 檔案中的密碼是否正確！")
        import sys
        sys.exit(1)
        
    try:
        item_name_map, item_type_map = get_item_map(cursor)
        name_to_id = {v: k for k, v in item_name_map.items()}
        required_items = {}
        for k, v in input_req.items():
            if k in name_to_id:
                required_items[name_to_id[k]] = v
            else:
                required_items[k] = v # fallback if already ID
                

        must_have_items = {}
        for k, v in input_must_have.items():
            # 只保留實際在 required_items 中的品項（避免舊殘留資料造成無解）
            if v is False:
                continue
            id_val = name_to_id.get(k, k)
            if id_val in required_items:
                must_have_items[id_val] = required_items[id_val]

        with open("debug_musthave.txt", "w", encoding="utf-8") as df:
            df.write(f"sys.argv: {sys.argv}\n")
            df.write(f"input_req: {input_req}\n")
            df.write(f"input_must_have: {input_must_have}\n")
            df.write(f"required_items: {required_items}\n")
            df.write(f"must_have_items: {must_have_items}\n")


        group_map = get_group_links(cursor)
        active_promotions = fetch_active_promotions(cursor)
        
        total_price = fetch_item_prices(cursor, required_items, item_name_map)

        # 1. 從資料庫拉出所有實體與虛擬套餐
        raw_combos = fetch_all_combos_from_db(cursor, has_sweetheart_card)
        
        # 2. 展開：將有 GROUP 的套餐，依據 item_group_links 自動長出替換品項變種
        expanded_combos = expand_combos(raw_combos, item_type_map, group_map, item_name_map)

        # 3. 促銷注入：對每組已展開套餐，生成含贈品的虛擬套餐變體
        expanded_combos = inject_promo_variants(expanded_combos, active_promotions, item_name_map)

        res_1 = None
        res_2 = None
        res_3 = None
        res_4 = None

        if has_sweetheart_card:
            print("\\n🎯【功能一】完全符合需求的最佳組合（不使用替代群）")
            combos_1 = filter_strict_combos(expanded_combos, required_items)
            if combos_1:
                problem_1, vars_1 = build_ilp_strict(required_items, combos_1)
                res_1 = solve_and_display(problem_1, combos_1, vars_1, total_price, item_name_map, required_items, substitute_groups, must_have_items=must_have_items, promotions=active_promotions)

            print("\\n🔄【功能二】允許替代群的進階最佳化組合（含甜心卡）")
            combos_2 = filter_flexible_combos(expanded_combos, required_items, substitute_groups, must_have_items)
            if combos_2:
                problem_2, vars_2 = build_ilp_with_substitutes(required_items, combos_2, substitute_groups, must_have_items)
                res_2 = solve_and_display(problem_2, combos_2, vars_2, total_price, item_name_map, required_items, substitute_groups, must_have_items=must_have_items, promotions=active_promotions)

            print("\n💡【功能四】加價湊套餐（Upsell）")
            # 決定計算底價 (優先用 res_2，若無則用 res_1)
            target_base = res_2 if (res_2 and res_2.get("status") == "success") else res_1
            if target_base and target_base.get("status") == "success":
                base_cost = target_base["total"]
                candidates = ["F00006", "D00005", "D00004", "D00018", "D00021", "D00014"]
                upsell_plans = []
                for cand_id in candidates:
                    cursor.execute(f"SELECT price FROM items WHERE item_id = '{cand_id}'")
                    p_row = cursor.fetchone()
                    if not p_row: continue
                    cand_price = p_row["price"]
                    
                    # 複製現有需求，並加點該候選商品
                    temp_req = required_items.copy()
                    temp_req[cand_id] = temp_req.get(cand_id, 0) + 1
                    
                    # 在計算 upsell 時放寬 must_have 約束，避免把加點商品強制鎖定
                    temp_must_have = must_have_items.copy()
                    # 加點品項本身必須出現在方案中，不可被替代群取代
                    temp_must_have[cand_id] = temp_req[cand_id]
                    
                    # 重新篩選適用 combo 並求解
                    combos_4 = filter_flexible_combos(expanded_combos, temp_req, substitute_groups, temp_must_have)
                    if not combos_4: continue
                    
                    import pulp
                    problem_4, vars_4 = build_ilp_with_substitutes(temp_req, combos_4, substitute_groups, temp_must_have)
                    problem_4.solve(pulp.PULP_CBC_CMD(msg=False))
                    if problem_4.status == 1:
                        new_cost = problem_4.objective.value()
                        extra_cost = new_cost - base_cost
                        
                        # 重寫判斷條件：只要加價金額小於原品項單點價 (包含小於等於 0 的超值升級)
                        if extra_cost < cand_price:
                            temp_total_price = total_price + cand_price
                            r4 = solve_and_display(problem_4, combos_4, vars_4, temp_total_price, item_name_map, temp_req, substitute_groups, silent=True, must_have_items=temp_must_have, promotions=active_promotions)
                            if r4:
                                r4["upsell"] = {
                                    "item_id": cand_id,
                                    "item_name": item_name_map.get(cand_id, cand_id),
                                    "extra_cost": extra_cost,
                                    "original_price": cand_price
                                }
                                upsell_plans.append(r4)
                if upsell_plans:
                    upsell_plans.sort(key=lambda x: x["upsell"]["original_price"] - x["upsell"]["extra_cost"], reverse=True)
                    res_4 = upsell_plans

        else:
            print("\n🚫 無甜心卡方案")
            raw_combos_no_sweetheart = fetch_all_combos_from_db(cursor, include_sweetheart=False)
            expanded_combos_no_sweetheart = expand_combos(raw_combos_no_sweetheart, item_type_map, group_map, item_name_map)
            expanded_combos_no_sweetheart = inject_promo_variants(expanded_combos_no_sweetheart, active_promotions, item_name_map)

            print("\n🎯 完全符合需求（無甜心卡）")
            combos_1 = filter_strict_combos(expanded_combos_no_sweetheart, required_items)
            if combos_1:
                problem_1, vars_1 = build_ilp_strict(required_items, combos_1)
                res_1 = solve_and_display(problem_1, combos_1, vars_1, total_price, item_name_map, required_items, substitute_groups, must_have_items=must_have_items, promotions=active_promotions)

            print("\n🔄 允許替代（無甜心卡）")
            combos_2 = filter_flexible_combos(expanded_combos_no_sweetheart, required_items, substitute_groups, must_have_items)
            if combos_2:
                problem_2, vars_2 = build_ilp_with_substitutes(required_items, combos_2, substitute_groups, must_have_items)
                res_2 = solve_and_display(problem_2, combos_2, vars_2, total_price, item_name_map, required_items, substitute_groups, must_have_items=must_have_items, promotions=active_promotions)

            print("\n💡 升級推薦（無甜心卡）")
            target_base = res_2 if (res_2 and res_2.get("status") == "success") else res_1
            if target_base and target_base.get("status") == "success":
                base_cost = target_base["total"]
                candidates = ["F00006", "D00005", "D00004", "D00018", "D00021", "D00014"]
                upsell_plans = []
                for cand_id in candidates:
                    cursor.execute(f"SELECT price FROM items WHERE item_id = '{cand_id}'")
                    p_row = cursor.fetchone()
                    if not p_row: continue
                    cand_price = p_row["price"]
                    
                    temp_req = required_items.copy()
                    temp_req[cand_id] = temp_req.get(cand_id, 0) + 1
                    
                    temp_must_have = must_have_items.copy()
                    # 加點品項本身必須出現在方案中，不可被替代群取代
                    temp_must_have[cand_id] = temp_req[cand_id]
                    
                    combos_4 = filter_flexible_combos(expanded_combos_no_sweetheart, temp_req, substitute_groups, temp_must_have)
                    if not combos_4: continue
                    
                    import pulp
                    problem_4, vars_4 = build_ilp_with_substitutes(temp_req, combos_4, substitute_groups, temp_must_have)
                    problem_4.solve(pulp.PULP_CBC_CMD(msg=False))
                    if problem_4.status == 1:
                        new_cost = problem_4.objective.value()
                        extra_cost = new_cost - base_cost
                        if extra_cost < cand_price:
                            temp_total_price = total_price + cand_price
                            r4 = solve_and_display(problem_4, combos_4, vars_4, temp_total_price, item_name_map, temp_req, substitute_groups, silent=True, must_have_items=temp_must_have, promotions=active_promotions)
                            if r4:
                                r4["upsell"] = {
                                    "item_id": cand_id,
                                    "item_name": item_name_map.get(cand_id, cand_id),
                                    "extra_cost": extra_cost,
                                    "original_price": cand_price
                                }
                                upsell_plans.append(r4)
                if upsell_plans:
                    upsell_plans.sort(key=lambda x: x["upsell"]["original_price"] - x["upsell"]["extra_cost"], reverse=True)
                    res_4 = upsell_plans

        final_output = {"func1": res_1, "func2": res_2, "func3": res_3, "func4": res_4}
        sys.stdout = original_stdout
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8') if hasattr(sys.stdout, 'buffer') else sys.stdout
        print(json.dumps(final_output, ensure_ascii=False))
    finally:
        if cursor: cursor.close()
        if conn: conn.close()
