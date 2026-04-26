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
            <button class="btn btn-secondary btn-small" onclick="event.stopPropagation(); window.location='${pageContext.request.contextPath}/customer/order-detail?id=<%= order.getOrderId() %>'">View Details →</button>
        </div>
        <% } %>
    </div>

    <%
        } else {
    %>
    <div class="empty-state">
        <h2>No Orders Yet</h2>
        <p style="color: var(--text-secondary); margin-bottom: var(--spacing-lg);">Start shopping to place your first order!</p>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Browse Products</a>
    </div>
    <% } %>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />

</body>
</html>
