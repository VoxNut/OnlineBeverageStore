<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - Online Beverage Store</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .confirmation {
            background: white;
            border-radius: 10px;
            padding: 40px;
            margin: 40px 0;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .success-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }

        h1 {
            color: #27ae60;
            margin-bottom: 20px;
        }

        .order-id {
            background: #f0f0f0;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            font-family: monospace;
            font-size: 18px;
            word-break: break-all;
        }

        .order-details {
            text-align: left;
            margin: 30px 0;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            padding: 20px 0;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
        }

        .detail-label {
            font-weight: 600;
        }

        .order-items {
            text-align: left;
            margin: 20px 0;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
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
    <%
        Order order = (Order) request.getAttribute("order");
        if (order != null) {
    %>
    <div class="confirmation">
        <div class="success-icon">✅</div>
        <h1>Order Confirmed!</h1>
        <p>Thank you for your order. Your beverages will be prepared and shipped shortly.</p>

        <div class="order-id">
            Order ID: <%= order.getOrderId() %>
        </div>

        <div class="order-details">
            <div class="detail-row">
                <span class="detail-label">Date Placed:</span>
                <span><%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(order.getCreatedAt()) %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Status:</span>
                <span style="color: #ff9800; font-weight: 600;"><%= order.getStatus() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Shipping Address:</span>
                <span><%= order.getShippingAddress() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Total Amount:</span>
                <span style="color: #667eea; font-weight: 600; font-size: 18px;">$<%= String.format("%.2f", order.getTotalAmount()) %></span>
            </div>
        </div>

        <div class="order-items">
            <h3 style="margin-bottom: 15px;">Items Ordered</h3>
            <% for (Order.OrderItem item : order.getItems()) { %>
            <div class="item-row">
                <span><%= item.getProductName() %> (x<%= item.getQuantity() %>)</span>
                <span>$<%= String.format("%.2f", item.getSubtotal()) %></span>
            </div>
            <% } %>
        </div>

        <p style="color: #999; margin: 20px 0;">You can track your order status in your account.</p>

        <div class="buttons">
            <a href="${pageContext.request.contextPath}/customer/orders" class="btn btn-primary">View My Orders</a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Continue Shopping</a>
        </div>
    </div>
    <% } else { %>
    <div class="confirmation">
        <h1>Order Not Found</h1>
        <p>We couldn't find your order. Please check your order ID and try again.</p>
        <div class="buttons">
            <a href="${pageContext.request.contextPath}/customer/orders" class="btn btn-primary">View My Orders</a>
        </div>
    </div>
    <% } %>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
</footer>
</body>
</html>
