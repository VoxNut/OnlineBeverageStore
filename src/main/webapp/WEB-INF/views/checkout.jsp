<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Online Beverage Store</title>
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
            color: white;
            text-decoration: none;
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

        .checkout-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        @media (max-width: 768px) {
            .checkout-content {
                grid-template-columns: 1fr;
            }
        }

        .checkout-form {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.2);
        }

        .error-message {
            background-color: #fee;
            color: #c33;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #c33;
        }

        .order-summary {
            background: white;
            border-radius: 10px;
            padding: 20px;
            height: fit-content;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .summary-items {
            margin-bottom: 20px;
            max-height: 400px;
            overflow-y: auto;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: bold;
            color: #667eea;
            padding-top: 10px;
            border-top: 2px solid #667eea;
        }

        .place-order-btn {
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

        .place-order-btn:hover {
            background: #764ba2;
        }

        .back-link {
            text-align: center;
            margin-top: 10px;
        }

        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
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
        <a href="${pageContext.request.contextPath}/" class="logo">🧃 BeverageStore</a>
        <div>
            <a href="${pageContext.request.contextPath}/products">Shop</a>
            <a href="${pageContext.request.contextPath}/customer/orders">Orders</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1>💳 Checkout</h1>
    </div>
</div>

<div class="container">
    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
    <div class="error-message"><%= error %></div>
    <% } %>

    <div class="checkout-content">
        <div class="checkout-form">
            <h2 style="margin-bottom: 20px;">Shipping Information</h2>

            <form method="POST" action="${pageContext.request.contextPath}/customer/checkout">
                <div class="form-group">
                    <label for="shippingAddress">Shipping Address *</label>
                    <textarea id="shippingAddress" name="shippingAddress" required placeholder="123 Main St, City, State, ZIP">
</textarea>
                </div>

                <div class="form-group">
                    <label for="notes">Delivery Notes (Optional)</label>
                    <textarea id="notes" name="notes" placeholder="Special instructions for delivery...">
</textarea>
                </div>

                <button type="submit" class="place-order-btn">Place Order</button>
            </form>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/customer/cart">← Back to Cart</a>
            </div>
        </div>

        <div class="order-summary">
            <h3 style="margin-bottom: 20px;">Order Summary</h3>

            <div class="summary-items">
                <%
                    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
                    if (cartItems != null) {
                        for (CartItem item : cartItems) {
                %>
                <div class="summary-item">
                    <span><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
                    <span>$<%= String.format("%.2f", item.getSubtotal()) %></span>
                </div>
                <%
                        }
                    }
                %>
            </div>

            <div class="summary-row">
                <span>Subtotal:</span>
                <span>$<%= String.format("%.2f", request.getAttribute("cartTotal")) %></span>
            </div>

            <div class="summary-row">
                <span>Shipping:</span>
                <span>Free</span>
            </div>

            <div class="summary-row">
                <span>Tax (8%):</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 0.08)) %></span>
            </div>

            <div class="summary-total">
                <span>Total:</span>
                <span>$<%= String.format("%.2f", ((double) request.getAttribute("cartTotal") * 1.08)) %></span>
            </div>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
</footer>
</body>
</html>
