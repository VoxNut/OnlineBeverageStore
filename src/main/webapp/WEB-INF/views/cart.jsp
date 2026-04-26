<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Online Beverage Store</title>
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
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
        }

        .page-header {
            background: white;
            padding: 30px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .page-header h1 {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .cart-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        @media (max-width: 768px) {
            .cart-content {
                grid-template-columns: 1fr;
            }
        }

        .cart-items {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr 150px 100px 50px;
            gap: 20px;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #eee;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 100px;
            height: 100px;
            background: #f0f0f0;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            overflow: hidden;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .item-details h3 {
            margin-bottom: 5px;
        }

        .item-details p {
            color: #666;
            font-size: 14px;
        }

        .item-price {
            font-weight: 600;
            color: #667eea;
        }

        .item-quantity {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .item-quantity input {
            width: 50px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-align: center;
        }

        .item-remove {
            background: #ff6b6b;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 3px;
            cursor: pointer;
        }

        .item-remove:hover {
            background: #ff5252;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-cart h2 {
            margin-bottom: 20px;
        }

        .empty-cart a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .cart-summary {
            background: white;
            border-radius: 10px;
            padding: 20px;
            height: fit-content;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
            padding-top: 15px;
            border-top: 2px solid #667eea;
        }

        .checkout-btn {
            width: 100%;
            padding: 15px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
        }

        .checkout-btn:hover {
            background: #764ba2;
        }

        .continue-shopping {
            width: 100%;
            padding: 12px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            margin-top: 10px;
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
        <div class="logo" onclick="window.location='${pageContext.request.contextPath}/'">🧃 BeverageStore</div>
        <div>
            <a href="${pageContext.request.contextPath}/products">Shop</a>
            <a href="${pageContext.request.contextPath}/customer/orders">Orders</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1>🛒 Shopping Cart</h1>
    </div>
</div>

<div class="container">
    <div class="cart-content">
        <div class="cart-items">
            <%
                List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                if (cartItems != null && !cartItems.isEmpty()) {
            %>
            <% for (CartItem item : cartItems) { %>
            <div class="cart-item">
                <div class="item-image">
                    <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getName() %>">
                    <% } else { %>
                    🧃
                    <% } %>
                </div>
                <div class="item-details">
                    <h3><%= item.getName() %></h3>
                    <p>Price: $<%= String.format("%.2f", item.getPrice()) %></p>
                </div>
                <div class="item-price">$<%= String.format("%.2f", item.getSubtotal()) %></div>
                <form method="POST" action="${pageContext.request.contextPath}/customer/cart" style="display: contents;">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                    <div class="item-quantity">
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="999" onchange="this.form.submit();">
                    </div>
                </form>
                <form method="POST" action="${pageContext.request.contextPath}/customer/cart" style="display: contents;">
                    <input type="hidden" name="action" value="remove">
                    <input type="hidden" name="productId" value="<%= item.getProductId() %>">
                    <button type="submit" class="item-remove">Remove</button>
                </form>
            </div>
            <% } %>

            <%
                } else {
            %>
            <div class="empty-cart">
                <h2>Your cart is empty</h2>
                <p>Start shopping to add items to your cart</p>
                <a href="${pageContext.request.contextPath}/products">Continue Shopping</a>
            </div>
            <% } %>
        </div>

        <% if (cartItems != null && !cartItems.isEmpty()) { %>
        <div class="cart-summary">
            <h3 style="margin-bottom: 20px;">Order Summary</h3>

            <div class="summary-row">
                <span>Subtotal:</span>
                <span>$<%= String.format("%.2f", request.getAttribute("cartTotal")) %></span>
            </div>

            <div class="summary-row">
                <span>Shipping:</span>
                <span>Free</span>
            </div>

            <div class="summary-row">
                <span>Tax (estimated):</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 0.08)) %></span>
            </div>

            <div class="summary-total">
                <span>Total:</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 1.08)) %></span>
            </div>

            <form method="GET" action="${pageContext.request.contextPath}/customer/checkout" style="display: contents;">
                <button type="submit" class="checkout-btn">Proceed to Checkout</button>
            </form>

            <button type="button" class="continue-shopping" onclick="window.location='${pageContext.request.contextPath}/products'">Continue Shopping</button>

            <form method="POST" action="${pageContext.request.contextPath}/customer/cart" style="display: contents;">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="continue-shopping" style="background: #ffe0e0; color: #ff6b6b; border-color: #ff6b6b; margin-top: 10px;">Clear Cart</button>
            </form>
        </div>
        <% } %>
    </div>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
</footer>
</body>
</html>
