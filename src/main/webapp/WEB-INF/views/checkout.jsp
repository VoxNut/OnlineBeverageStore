<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - The Grindery</title>
    
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
        <h1>Checkout</h1>
    </div>
</div>

<div class="container">
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
    <div id="server-error-msg" style="display:none;"><%= error %></div>
    <% } %>

    <div class="checkout-layout">
        <!-- Form Section -->
        <div class="checkout-form-container">
            <h2>Shipping & Delivery</h2>

            <form method="POST" action="${pageContext.request.contextPath}/customer/checkout">
                <div class="form-group">
                    <label for="shippingAddress" class="form-label">Shipping Address *</label>
                    <textarea id="shippingAddress" name="shippingAddress" class="form-control" required placeholder="123 Coffee St, City, State, ZIP"></textarea>
                </div>

                <div class="form-group">
                    <label for="notes" class="form-label">Delivery Notes (Optional)</label>
                    <textarea id="notes" name="notes" class="form-control" placeholder="Special instructions for delivery..."></textarea>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: var(--spacing-md);">Place Order</button>
            </form>

            <a href="${pageContext.request.contextPath}/customer/cart" class="back-link">← Return to Cart</a>
        </div>

        <!-- Summary Section -->
        <div class="checkout-summary">
            <h3>Order Summary</h3>

            <div class="summary-items">
                <%
                    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                    if (cartItems != null) {
                        for (CartItem item : cartItems) {
                %>
                <div class="summary-item">
                    <span class="item-name"><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
                    <span class="item-price">$<%= String.format("%.2f", item.getSubtotal()) %></span>
                </div>
                <%
                        }
                    }
                %>
            </div>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>$<%= String.format("%.2f", request.getAttribute("cartTotal")) %></span>
            </div>

            <div class="summary-row">
                <span>Shipping</span>
                <span>Free</span>
            </div>

            <div class="summary-row">
                <span>Estimated Tax (8%)</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 0.08)) %></span>
            </div>

            <div class="summary-total">
                <span>Total to Pay</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 1.08)) %></span>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
