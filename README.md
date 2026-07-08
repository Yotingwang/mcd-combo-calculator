# McDonald's Combo Assistant

This is a web application that optimizes McDonald's meal combinations based on your cart to find the most cost-effective way to order, taking into account combo rules and sweetheart card (甜心卡) discounts.

## Prerequisites
- Node.js (v14 or higher recommended)
- MySQL Server
- Python 3.x (with necessary integer linear programming libraries)

## Installation

1. Install Node.js dependencies:
   ```bash
   npm install
   ```

2. Configure the environment variables:
   Create a `.env` file in the root directory and update it with your database credentials (you can copy from `.env.example` if available, or refer to the format below):
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=mcdonalds_db
   ```

3. Initialize the Database:
   Run the provided `mcdonalds_db_dump.sql` script in your MySQL server. This file contains both the schema and the required preset data (items, combos, and relations).

## Running the Application

### 1. Main Web Application
Start the Node.js backend server:
```bash
node server.js
```
The user application will be accessible at `http://localhost:3000`.

### 2. Database Admin Panel (Backend Management)
The project includes a Streamlit-based admin interface to manage the menu, combos, and items.
To run the admin panel, first ensure you have the required Python packages (e.g., `streamlit`, `pandas`, `sqlalchemy`), then run:
```bash
cd admin
streamlit run admin.py
```

## Architecture
- **Web Backend**: Express.js (Node.js) handling API requests, sessions, and database connections.
- **Web Frontend**: Vanilla HTML/JS/CSS with responsive design.
- **Algorithm Engine**: Python script (`test3.py`) running Integer Linear Programming (ILP) calculations to generate optimal combinations.
- **Admin Panel**: Python Streamlit application (`McDproject/admin.py`) for comprehensive database management and configuration.
