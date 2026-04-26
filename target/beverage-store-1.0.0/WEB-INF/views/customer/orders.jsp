<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - Online Beverage Store</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            background: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }

        .page-header h1 {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .orders-list {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .order-card {
            padding: 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            transition: background 0.2s;
        }

        .order-card:hover {
            background: #f9f9f9;
        }

        .order-card:last-child {
            border-bottom: none;
        }

        .order-info h3 {
            margin-bottom: 8px;
            color: #333;
        }

        .order-meta {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }

        .order-amount {
            font-size: 18px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .order-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-processing {
            background: #cfe2ff;
            color: #084298;
        }

        .status-shipped {
            background: #d1e7dd;
            color: #0f5132;
        }

        .status-delivered {
            background: #d1e7dd;
            color: #0f5132;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #842029;
        }

        .view-btn {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
        }

        .view-btn:hover {
            background: #764ba2;
        }

        .empty-state {
            padding: 60px 20px;
            text-align: center;
            color: #999;
        }

        .empty-state h2 {
            margin-bottom: 20px;
        }

        .empty-state a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
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
            <a href="${pageContext.request.contextPath}/products" style="color: white; text-decoration: none; margin: 0 15px;">Shop</a>
            <a href="${pageContext.request.contextPath}/customer/cart" style="color: white; text-decoration: none; margin: 0 15px;">Cart</a>
            <a href="${pageContext.request.contextPath}/logout" style="color: white; text-decoration: none; margin: 0 15px;">Logout</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1>📦 My Orders</h1>
    </div>
</div>

<div class="container">
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
    <div class="orders-list">
        <% for (Order order : orders) { %>
        <div class="order-card" onclick="window.location='${pageContext.request.contextPath}/customer/order-detail?id=<%= order.getOrderId() %>'">
            <div class="order-info">
                <h3>Order #<%= order.getOrderId().substring(0, 8) %>...</h3>
                <div class="order-meta">
                    <span>Date: <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(order.getCreatedAt()) %></span>
                    <span><%= order.getTotalItems() %> items</span>
                </div>
                <div class="order-amount">$<%= String.format("%.2f", order.getTotalAmount()) %></div>
                <span class="order-status status-<%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span>
            </div>
            <button class="view-btn" onclick="event.stopPropagation();">View Details →</button>
        </div>
        <% } %>
    </div>

    <%
        } else {
    %>
    <div class="empty-state">
        <h2>No Orders Yet</h2>
        <p>Start shopping to place your first order!</p>
        <a href="${pageContext.request.contextPath}/products">Browse Products</a>
    </div>
    <% } %>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
</footer>
</body>
</html>
