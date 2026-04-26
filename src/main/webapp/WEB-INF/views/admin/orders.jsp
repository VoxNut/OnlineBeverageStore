<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Admin Dashboard</title>
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
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            background: white;
            padding: 20px 0;
            margin-bottom: 20px;
        }

        .page-header h1 {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .back-link {
            display: inline-block;
            color: #667eea;
            text-decoration: none;
            margin: 20px 0;
            font-weight: 600;
        }

        .orders-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f9f9f9;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #eee;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .status {
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
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1>📋 Manage Orders</h1>
    </div>
</div>

<div class="container">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-link">← Back to Dashboard</a>

    <div class="orders-table">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Order> orders = (List<Order>) request.getAttribute("orders");
                    if (orders != null && !orders.isEmpty()) {
                        for (Order order : orders) {
                %>
                <tr>
                    <td><%= order.getOrderId().substring(0, 8) %>...</td>
                    <td><%= order.getUserId().substring(0, 8) %>...</td>
                    <td><%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(order.getCreatedAt()) %></td>
                    <td>$<%= String.format("%.2f", order.getTotalAmount()) %></td>
                    <td>
                        <span class="status status-<%= order.getStatus().toLowerCase() %>">
                            <%= order.getStatus() %>
                        </span>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" style="text-align: center; padding: 30px; color: #999;">No orders found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store - Admin Panel</p>
</footer>
</body>
</html>
