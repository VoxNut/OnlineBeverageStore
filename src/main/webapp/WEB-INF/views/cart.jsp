<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - The Grindery</title>
    
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
        <h1>Your Cart</h1>
    </div>
</div>

<div class="container">
    <%
        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
        if (cartItems != null && !cartItems.isEmpty()) {
    %>
    <div class="cart-layout">
        <div class="cart-items-container">
            <% for (CartItem item : cartItems) { %>
            <div class="cart-item">
                <div class="item-image">
                    <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                        <img src="<%= item.getImageUrl() %>" alt="<%= item.getName() %>">
                    <% } else { %>
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="var(--border-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
                    <% } %>
                </div>
                <div class="item-details">
                    <h3><%= item.getName() %></h3>
                    <p>$<%= String.format("%.2f", item.getPrice()) %> each</p>
                </div>
                <div class="item-price">$<%= String.format("%.2f", item.getSubtotal()) %></div>
                <form method="POST" action="${pageContext.request.contextPath}/customer/cart" class="item-qty-form" style="display: contents;">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                    <input type="number" name="quantity" class="qty-input" value="<%= item.getQuantity() %>" min="1" max="999" onchange="this.form.submit();">
                </form>
                <form method="POST" action="${pageContext.request.contextPath}/customer/cart" class="item-remove-form" style="display: contents;">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                    <button type="submit" class="btn-remove" title="Remove Item">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line></svg>
                    </button>
                </form>
            </div>
            <% } %>
        </div>

        <div class="cart-summary">
            <h3>Order Summary</h3>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>$<%= String.format("%.2f", request.getAttribute("cartTotal")) %></span>
            </div>

            <div class="summary-row">
                <span>Shipping</span>
                <span>Calculated at checkout</span>
            </div>

            <div class="summary-row">
                <span>Estimated Tax (8%)</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 0.08)) %></span>
            </div>

            <div class="summary-total">
                <span>Total</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 1.08)) %></span>
            </div>

            <div class="summary-actions">
                <form method="GET" action="${pageContext.request.contextPath}/customer/checkout" style="display: contents;">
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Checkout</button>
                </form>
                
                <button type="button" class="btn btn-secondary" onclick="window.location='${pageContext.request.contextPath}/products'" style="width: 100%;">Continue Shopping</button>
                
                <form method="POST" action="${pageContext.request.contextPath}/customer/cart" style="display: contents;">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" style="background: none; border: none; color: var(--text-light); text-decoration: underline; margin-top: var(--spacing-md); cursor: pointer; font-family: var(--font-body); font-size: 13px;">Clear Cart</button>
                </form>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="empty-cart" style="max-width: 600px; margin: 0 auto; margin-bottom: var(--spacing-xxl);">
        <h2>Your cart is currently empty.</h2>
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="margin-top: var(--spacing-md);">Shop Now</a>
    </div>
    <% } %>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
