require('dotenv').config();
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const path = require('path');
const session = require('express-session');
const { execFile } = require('child_process');


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

app.get('/api/combos', (req, res) => {
  const sql = 'SELECT * FROM combos';
  connection.query(sql, (err, results) => {
    if (err) {
      res.json({ status: 'error', message: err.message });
      return;
    }
    res.json({ status: 'success', data: results });
  });
});

app.post('/api/register', (req, res) => {
  const { username, password } = req.body;
  
  const checkSql = 'SELECT * FROM users WHERE username = ?';
  connection.query(checkSql, [username], (err, results) => {
    if (err) {
      res.json({ status: 'error', message: err.message });
      return;
    }
    if (results.length > 0) {
      res.json({ status: 'error', message: '帳號已被註冊' });
      return;
    }
    
    const insertSql = 'INSERT INTO users (username, password) VALUES (?, ?)';
    connection.query(insertSql, [username, password], (err, results) => {
      if (err) {
        res.json({ status: 'error', message: err.message });
        return;
      }
      req.session.user = username;
      res.json({ status: 'success', message: '註冊成功' });
    });
  });
});

app.post('/api/login', (req, res) => {
  const { username, password } = req.body;
  
  const sql = 'SELECT * FROM users WHERE username = ? AND password = ?';
  connection.query(sql, [username, password], (err, results) => {
    if (err) {
      res.json({ status: 'error', message: err.message });
      return;
    }
    if (results.length > 0) {
      req.session.user = username;
      res.json({ status: 'success', message: '登入成功', username: username });
    } else {
      res.json({ status: 'error', message: '帳號或密碼錯誤' });
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
