<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Online Beverage Store</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #667eea;
            text-decoration: none;
            margin: 20px 0;
            font-weight: 600;
        }

        .order-header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .order-header h1 {
            margin-bottom: 20px;
        }

        .header-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        .header-item {
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
        }

        .header-label {
            font-size: 12px;
            text-transform: uppercase;
            color: #999;
            margin-bottom: 8px;
        }

        .header-value {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }

        .order-status {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
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

        .timeline {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .timeline h3 {
            margin-bottom: 20px;
        }

        .timeline-item {
            display: flex;
            gap: 20px;
            padding: 15px 0;
            border-left: 3px solid #ddd;
            padding-left: 20px;
            margin-left: 0;
        }

        .timeline-item.completed {
            border-left-color: #27ae60;
        }

        .timeline-dot {
            width: 15px;
            height: 15px;
            background: #ddd;
            border-radius: 50%;
            margin-top: 2px;
            margin-left: -28px;
        }

        .timeline-item.completed .timeline-dot {
            background: #27ae60;
        }

        .timeline-content h4 {
            margin-bottom: 5px;
        }

        .timeline-content p {
            color: #666;
            font-size: 14px;
        }

        .order-items {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table thead {
            background: #f9f9f9;
        }

        .items-table th {
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #eee;
        }

        .items-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        .items-table tr:last-child td {
            border-bottom: none;
        }

        .summary-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: bold;
            color: #667eea;
            padding-top: 15px;
            border-top: 2px solid #667eea;
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

<div class="container">
    <a href="${pageContext.request.contextPath}/customer/orders" class="back-link">← Back to Orders</a>

    <%
        Order order = (Order) request.getAttribute("order");
        if (order != null) {
    %>

    <div class="order-header">
        <h1>Order #<%= order.getOrderId() %></h1>
        <div class="header-grid">
            <div class="header-item">
                <div class="header-label">Status</div>
                <div class="header-value">
                    <span class="order-status status-<%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span>
                </div>
            </div>
            <div class="header-item">
                <div class="header-label">Order Date</div>
                <div class="header-value"><%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(order.getCreatedAt()) %></div>
            </div>
            <div class="header-item">
                <div class="header-label">Total Amount</div>
                <div class="header-value" style="color: #667eea;">$<%= String.format("%.2f", order.getTotalAmount()) %></div>
            </div>
        </div>
    </div>

    <!-- Status Timeline -->
    <div class="timeline">
        <h3>Order Timeline</h3>
        <div class="timeline-item completed">
            <div class="timeline-dot"></div>
            <div class="timeline-content">
                <h4>Order Placed</h4>
                <p><%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(order.getCreatedAt()) %></p>
            </div>
        </div>
        <div class="timeline-item <%= order.getStatus().equals("PROCESSING") || order.getStatus().equals("SHIPPED") || order.getStatus().equals("DELIVERED") ? "completed" : "" %>">
            <div class="timeline-dot"></div>
            <div class="timeline-content">
                <h4>Processing</h4>
                <p>We're preparing your order</p>
            </div>
        </div>
        <div class="timeline-item <%= order.getStatus().equals("SHIPPED") || order.getStatus().equals("DELIVERED") ? "completed" : "" %>">
            <div class="timeline-dot"></div>
            <div class="timeline-content">
                <h4>Shipped</h4>
                <p>Your package is on the way</p>
            </div>
        </div>
        <div class="timeline-item <%= order.getStatus().equals("DELIVERED") ? "completed" : "" %>">
            <div class="timeline-dot"></div>
            <div class="timeline-content">
                <h4>Delivered</h4>
                <p>Order delivered</p>
            </div>
        </div>
    </div>

    <!-- Order Items -->
    <div class="order-items">
        <h3 style="margin-bottom: 20px;">Order Items</h3>
        <table class="items-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order.OrderItem item : order.getItems()) { %>
                <tr>
                    <td><%= item.getProductName() %></td>
                    <td>$<%= String.format("%.2f", item.getUnitPrice()) %></td>
                    <td><%= item.getQuantity() %></td>
                    <td>$<%= String.format("%.2f", item.getSubtotal()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Order Summary -->
    <div class="summary-section">
        <h3 style="margin-bottom: 20px;">Order Summary</h3>

        <div class="summary-row">
            <span>Subtotal:</span>
            <span>$<%= String.format("%.2f", order.getTotalAmount()) %></span>
        </div>

        <div class="summary-row">
            <span>Shipping:</span>
            <span>Free</span>
        </div>

        <div class="summary-row">
            <span>Tax (8%):</span>
            <span>$<%= String.format("%.2f", (order.getTotalAmount() * 0.08)) %></span>
        </div>

        <div class="summary-total">
            <span>Total Paid:</span>
            <span>$<%= String.format("%.2f", (order.getTotalAmount() * 1.08)) %></span>
        </div>

        <h3 style="margin-top: 30px; margin-bottom: 15px;">Shipping Address</h3>
        <p style="white-space: pre-wrap; color: #666;"><%= order.getShippingAddress() %></p>

        <% if (order.getNotes() != null && !order.getNotes().isEmpty()) { %>
        <h3 style="margin-top: 30px; margin-bottom: 15px;">Delivery Notes</h3>
        <p style="color: #666;"><%= order.getNotes() %></p>
        <% } %>
    </div>

    <% } else { %>
    <div style="background: white; padding: 60px 20px; text-align: center; border-radius: 10px; margin: 20px 0;">
        <h2>Order Not Found</h2>
        <a href="${pageContext.request.contextPath}/customer/orders" style="display: inline-block; margin-top: 20px; padding: 12px 30px; background: #667eea; color: white; text-decoration: none; border-radius: 5px;">Back to Orders</a>
    </div>
    <% } %>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
</footer>
</body>
</html>
