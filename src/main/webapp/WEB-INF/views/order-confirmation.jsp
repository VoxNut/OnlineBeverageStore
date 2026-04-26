<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - Online Beverage Store</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    
    <!-- Global CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/store.css?v=1.0">
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="container">
    <%
        Order order = (Order) request.getAttribute("order");
        if (order != null) {
    %>
    <div class="confirmation-container">
        <div class="success-icon">✅</div>
        <h1>Order Confirmed!</h1>
        <p style="color: var(--text-secondary); margin-bottom: var(--spacing-xl);">Thank you for your order. Your beverages will be prepared and shipped shortly.</p>

        <div class="order-id-box">
            Order ID: <%= order.getOrderId() %>
        </div>

        <div class="confirmation-details">
            <div class="summary-row">
                <span style="font-weight: 500; color: var(--text-primary);">Date Placed:</span>
                <span><%= new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(order.getCreatedAt()) %></span>
            </div>
            <div class="summary-row">
                <span style="font-weight: 500; color: var(--text-primary);">Status:</span>
                <span style="color: #f57c00; font-weight: 600;"><%= order.getStatus() %></span>
            </div>
            <div class="summary-row">
                <span style="font-weight: 500; color: var(--text-primary);">Shipping Address:</span>
                <span style="text-align: right;"><%= order.getShippingAddress() %></span>
            </div>
            <div class="summary-row" style="margin-top: var(--spacing-md);">
                <span style="font-weight: 500; color: var(--text-primary);">Total Amount:</span>
                <span style="color: var(--accent-primary); font-weight: 600; font-size: 18px;">$<%= String.format("%.2f", order.getTotalAmount()) %></span>
            </div>
        </div>

        <div class="confirmation-items">
            <h3>Items Ordered</h3>
            <% for (Order.OrderItem item : order.getItems()) { %>
            <div class="summary-row">
                <span><%= item.getProductName() %> (x<%= item.getQuantity() %>)</span>
                <span style="font-weight: 500;">$<%= String.format("%.2f", item.getSubtotal()) %></span>
            </div>
            <% } %>
        </div>

        <p style="color: var(--text-light); margin: var(--spacing-xxl) 0;">You can track your order status in your account.</p>

        <div class="action-buttons" style="justify-content: center; gap: var(--spacing-lg);">
            <a href="${pageContext.request.contextPath}/customer/orders" class="btn btn-primary" style="padding: 12px 30px; min-width: auto;">View My Orders</a>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary" style="padding: 12px 30px; min-width: auto;">Continue Shopping</a>
        </div>
    </div>
    <% } else { %>
    <div class="confirmation-container">
        <h1 style="color: var(--error-text);">Order Not Found</h1>
        <p style="color: var(--text-secondary); margin-bottom: var(--spacing-xl);">We couldn't find your order. Please check your order ID and try again.</p>
        <div class="action-buttons" style="justify-content: center;">
            <a href="${pageContext.request.contextPath}/customer/orders" class="btn btn-primary" style="padding: 12px 30px; min-width: auto;">View My Orders</a>
        </div>
    </div>
    <% } %>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />

</body>
</html>
