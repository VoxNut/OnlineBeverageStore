<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Online Beverage Store</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
        }

        nav {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 0;
        }

        nav .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            background: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }

        .page-header h1 {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            text-align: center;
        }

        .stat-label {
            color: #999;
            font-size: 14px;
            margin-bottom: 10px;
            text-transform: uppercase;
        }

        .stat-value {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .stat-card.revenue .stat-value {
            color: #27ae60;
        }

        .admin-links {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .admin-links h3 {
            margin-bottom: 20px;
        }

        .link-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .admin-btn {
            padding: 15px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-weight: 600;
            transition: background 0.3s;
        }

        .admin-btn:hover {
            background: #764ba2;
        }

        footer {
            background: #333;
            color: white;
            padding: 30px 20px;
            text-align: center;
            margin-top: 60px;
        }
    </style>
</head>
<body>
<nav>
    <div class="container">
        <div onclick="window.location='${pageContext.request.contextPath}/'" style="cursor: pointer; color: white; font-weight: bold;">🧃 BeverageStore</div>
        <div>
            <a href="${pageContext.request.contextPath}/products" style="color: white; text-decoration: none; margin: 0 15px;">View Store</a>
            <a href="${pageContext.request.contextPath}/logout" style="color: white; text-decoration: none; margin: 0 15px;">Logout</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1>🛠️ Admin Dashboard</h1>
    </div>
</div>

<div class="container">
    <!-- Statistics -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-label">Total Orders</div>
            <div class="stat-value"><%= request.getAttribute("totalOrders") %></div>
            <p style="color: #666; font-size: 14px;">All time</p>
        </div>
        <div class="stat-card revenue">
            <div class="stat-label">Total Revenue</div>
            <div class="stat-value">$<%= String.format("%.2f", (double) request.getAttribute("totalRevenue")) %></div>
            <p style="color: #666; font-size: 14px;">All time</p>
        </div>
    </div>

    <!-- Admin Links -->
    <div class="admin-links">
        <h3>Management Tools</h3>
        <div class="link-grid">
            <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn">📦 Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="admin-btn">📋 Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/products?action=create" class="admin-btn">➕ Add New Product</a>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store - Admin Panel</p>
</footer>
</body>
</html>
