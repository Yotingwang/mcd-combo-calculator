require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');
const session = require('express-session');
const { execFile } = require('child_process');
const bcrypt = require('bcrypt');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
  secret: 'mcd_secret_key',
  resave: false,
  saveUninitialized: true
}));

const connection = mysql.createConnection({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'mcdonalds_db'
});

connection.connect((err) => {
  if (err) {
    console.error('連接失敗: ' + err.stack);
    return;
  }
  console.log('連接成功');
});

// ── 基礎 API ──────────────────────────────────
app.get('/api/items', (req, res) => {
  const sql = 'SELECT * FROM items ORDER BY item_type, item_name';
  connection.query(sql, (err, results) => {
    if (err) {
      res.json({ status: 'error', message: err.message });
      return;
    }
    res.json({ status: 'success', data: results });
  });
});

// ── 驗證 API ──────────────────────────────────
app.post('/api/register', async (req, res) => {
  let { username, email, password } = req.body;
  email = email ? email.trim() : null;

  if (!username || !password) {
    return res.json({ status: 'error', message: '請輸入帳號與密碼' });
  }

  if (email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return res.json({ status: 'error', message: 'Email 格式不正確' });
    }
  }

  connection.query('SELECT id FROM users WHERE username = ?', [username], async (err, results) => {
    if (err) return res.json({ status: 'error', message: err.message });
    if (results.length > 0) return res.json({ status: 'error', message: '帳號已被使用' });

    const proceedRegistration = async () => {
      try {
        const hashedPassword = await bcrypt.hash(password, 10);
        const insertSql = 'INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)';
        connection.query(insertSql, [username, email, hashedPassword], (err) => {
          if (err) return res.json({ status: 'error', message: err.message });
          req.session.user = username;
          res.json({ status: 'success', message: '註冊成功' });
        });
      } catch (hashError) {
        res.json({ status: 'error', message: '密碼加密失敗' });
      }
    };

    if (email) {
      connection.query('SELECT id FROM users WHERE email = ?', [email], (err, emailResults) => {
        if (err) return res.json({ status: 'error', message: err.message });
        if (emailResults.length > 0) return res.json({ status: 'error', message: '此 Email 已被註冊' });
        proceedRegistration();
      });
    } else {
      proceedRegistration();
    }
  });
});

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;

  const sql = 'SELECT * FROM users WHERE username = ?';
  connection.query(sql, [username], async (err, results) => {
    if (err) {
      res.json({ status: 'error', message: err.message });
      return;
    }
    if (results.length > 0) {
      const user = results[0];
      const match = await bcrypt.compare(password, user.password_hash);
      if (match) {
        req.session.user = username;
        res.json({ status: 'success', message: '登入成功', username: username });
      } else {
        res.json({ status: 'error', message: '帳號或密碼錯誤' });
      }
    } else {
      res.json({ status: 'error', message: '帳號或密碼錯誤' });
    }
  });
});

app.post('/api/reset-password', async (req, res) => {
  const { username, email, newPassword } = req.body;
  if (!username || !email || !newPassword) {
    return res.json({ status: 'error', message: '請輸入完整資訊' });
  }

  // 同時比對帳號與 email，確認身份
  const checkSql = 'SELECT * FROM users WHERE username = ? AND email = ?';
  connection.query(checkSql, [username, email], async (err, results) => {
    if (err) {
      return res.json({ status: 'error', message: err.message });
    }
    if (results.length === 0) {
      return res.json({ status: 'error', message: '帳號與 Email 不符，請確認後重試' });
    }

    try {
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      const updateSql = 'UPDATE users SET password_hash = ? WHERE username = ?';
      connection.query(updateSql, [hashedPassword, username], (err) => {
        if (err) {
          return res.json({ status: 'error', message: err.message });
        }
        res.json({ status: 'success', message: '密碼重設成功，請重新登入！' });
      });
    } catch (e) {
      res.json({ status: 'error', message: '重設失敗，請稍後再試' });
    }
  });
});

app.post('/api/logout', (req, res) => {
  req.session.destroy();
  res.json({ status: 'success', message: '已登出' });
});

app.get('/api/check-session', (req, res) => {
  if (req.session.user) {
    res.json({ status: 'success', username: req.session.user });
  } else {
    res.json({ status: 'error', message: '未登入' });
  }
});

// ── 歷史紀錄 API ──────────────────────────────
app.post('/api/history', (req, res) => {
  if (!req.session.user) return res.status(401).json({ status: 'error', message: '未登入' });

  const planData = req.body;
  if (!planData || Object.keys(planData).length === 0)
    return res.status(400).json({ status: 'error', message: '無效的方案資料' });

  connection.query('SELECT id FROM users WHERE username = ?', [req.session.user], (err, results) => {
    if (err || results.length === 0)
      return res.status(500).json({ status: 'error', message: '無法取得使用者資訊' });

    const userId = results[0].id;
    connection.query(
      'INSERT INTO order_history (user_id, plan_data) VALUES (?, ?)',
      [userId, JSON.stringify(planData)],
      (err) => {
        if (err) return res.status(500).json({ status: 'error', message: err.message });

        const deleteSql = `
          DELETE FROM order_history 
          WHERE user_id = ? 
            AND id NOT IN (
              SELECT id FROM (
                SELECT id FROM order_history 
                WHERE user_id = ? 
                ORDER BY created_at DESC 
                LIMIT 50
              ) AS temp
            )
        `;
        connection.query(deleteSql, [userId, userId], (err) => {
          if (err) console.error('清理舊歷史紀錄失敗:', err.message);
          res.json({ status: 'success' });
        });
      }
    );
  });
});

app.get('/api/history', (req, res) => {
  if (!req.session.user) return res.status(401).json({ status: 'error', message: '請先登入' });

  const sql = `
    SELECT h.id, h.plan_data, h.created_at
    FROM order_history h
    JOIN users u ON h.user_id = u.id
    WHERE u.username = ?
    ORDER BY h.created_at DESC
  `;
  connection.query(sql, [req.session.user], (err, results) => {
    if (err) return res.status(500).json({ status: 'error', message: err.message });
    res.json({ status: 'success', data: results });
  });
});

app.delete('/api/history/:id', (req, res) => {
  if (!req.session.user) return res.status(401).json({ status: 'error', message: '請先登入' });

  const sql = `
    DELETE h FROM order_history h
    JOIN users u ON h.user_id = u.id
    WHERE h.id = ? AND u.username = ?
  `;
  connection.query(sql, [req.params.id, req.session.user], (err, results) => {
    if (err) return res.status(500).json({ status: 'error', message: err.message });
    if (results.affectedRows === 0)
      return res.status(404).json({ status: 'error', message: '找不到該筆紀錄' });
    res.json({ status: 'success', message: '已刪除紀錄' });
  });
});

// ── 收藏清單 API ──────────────────────────────
app.get('/api/favorites', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ status: 'error', message: '請先登入' });
  }

  const sql = `
    SELECT f.id, f.plan_data, f.created_at
    FROM favorites f
    JOIN users u ON f.user_id = u.id
    WHERE u.username = ?
    ORDER BY f.created_at DESC
  `;
  connection.query(sql, [req.session.user], (err, results) => {
    if (err) return res.status(500).json({ status: 'error', message: err.message });
    res.json({ status: 'success', data: results });
  });
});

app.delete('/api/favorites/:id', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ status: 'error', message: '請先登入' });
  }

  const favoriteId = req.params.id;
  const sql = `
    DELETE f FROM favorites f
    JOIN users u ON f.user_id = u.id
    WHERE f.id = ? AND u.username = ?
  `;
  connection.query(sql, [favoriteId, req.session.user], (err, results) => {
    if (err) return res.status(500).json({ status: 'error', message: err.message });
    if (results.affectedRows === 0) {
      return res.status(404).json({ status: 'error', message: '找不到該筆收藏' });
    }
    res.json({ status: 'success', message: '已刪除收藏' });
  });
});

app.post('/api/favorites', (req, res) => {
  if (!req.session.user) {
    return res.status(401).json({ status: 'error', message: '請先登入' });
  }

  const planData = req.body;
  if (!planData || Object.keys(planData).length === 0) {
    return res.status(400).json({ status: 'error', message: '無效的方案資料' });
  }

  const getUserSql = 'SELECT id FROM users WHERE username = ?';
  connection.query(getUserSql, [req.session.user], (err, results) => {
    if (err || results.length === 0) {
      return res.status(500).json({ status: 'error', message: '無法取得使用者資訊' });
    }

    const userId = results[0].id;

    const countSql = 'SELECT COUNT(*) AS count FROM favorites WHERE user_id = ?';
    connection.query(countSql, [userId], (err, countResults) => {
      if (err) {
        return res.status(500).json({ status: 'error', message: '無法取得收藏數量' });
      }

      if (countResults[0].count >= 50) {
        return res.status(400).json({
          status: 'error',
          message: '您的收藏清單已達 50 筆上限，請刪除部分收藏後再試。'
        });
      }

      const insertSql = 'INSERT INTO favorites (user_id, plan_data) VALUES (?, ?)';
      connection.query(insertSql, [userId, JSON.stringify(planData)], (err, results) => {
        if (err) {
          return res.status(500).json({ status: 'error', message: '儲存失敗：' + err.message });
        }
        res.json({ status: 'success', message: '收藏成功' });
      });
    });
  });
});

app.post('/api/optimize', (req, res) => {
  const cart = req.body.cart;
  if (!cart || Object.keys(cart).length === 0) {
    return res.json({ status: 'error', message: '購物車為空' });
  }

  const requestData = {
    cart: req.body.cart,
    mustHave: req.body.mustHave || {},
    sweetheart: req.body.sweetheart !== undefined ? req.body.sweetheart : true
  };
  const requestJson = JSON.stringify(requestData);

  execFile('python', ['scripts/test3.py', requestJson], { cwd: __dirname }, (error, stdout, stderr) => {
    if (error) {
      console.error(`執行錯誤: ${error}`);
      return res.json({ status: 'error', message: '最佳化計算失敗' });
    }
    try {
      const result = JSON.parse(stdout.trim());
      res.json(result);
    } catch (parseErr) {
      console.error(`解析 JSON 失敗: ${parseErr}`);
      console.error(`原始輸出: ${stdout}`);
      res.json({ status: 'error', message: '解析計算結果失敗' });
    }
  });
});

app.listen(3000, () => {
  console.log('伺服器運行於 http://localhost:3000');
});
