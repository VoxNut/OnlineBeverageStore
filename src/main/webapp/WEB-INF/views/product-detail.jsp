<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.model.Product" %>
<%@ page import="com.beveragestore.util.SessionUtil" %>
<%@ page import="com.beveragestore.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Online Beverage Store</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            background: #f5f5f5;
        }

        /* Navigation */
        nav {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
            text-decoration: none;
            color: white;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            transition: opacity 0.3s;
        }

        nav a:hover {
            opacity: 0.8;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Breadcrumb */
        .breadcrumb {
            background: white;
            padding: 15px 0;
            font-size: 14px;
        }

        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
            margin: 0 5px;
        }

        /* Product Detail */
        .product-detail {
            background: white;
            padding: 40px 0;
            margin: 20px 0;
            border-radius: 10px;
        }

        .detail-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }

        @media (max-width: 768px) {
            .detail-container {
                grid-template-columns: 1fr;
            }
        }

        .product-image-large {
            width: 100%;
            height: 400px;
            background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 150px;
            overflow: hidden;
        }

        .product-image-large img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .detail-info h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .detail-brand {
            color: #667eea;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .detail-category {
            display: inline-block;
            background: #f0f0f0;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 20px;
            color: #667eea;
        }

        .detail-price {
            font-size: 40px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 20px;
        }

        .detail-description {
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 20px;
            color: #555;
        }

        .detail-specs {
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            padding: 20px 0;
            margin: 20px 0;
        }

        .spec-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 10px 0;
        }

        .spec-label {
            font-weight: 600;
            color: #333;
        }

        .spec-value {
            color: #666;
        }

        .stock-status {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .stock-available {
            color: #27ae60;
        }

        .stock-low {
            color: #e74c3c;
        }

        .stock-out {
            color: #999;
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .quantity-selector label {
            font-weight: 600;
        }

        .quantity-selector input {
            width: 70px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
        }

        .actions {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
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

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #667eea;
            text-decoration: none;
            margin-top: 20px;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        footer {
            background: #333;
            color: white;
            padding: 30px 20px;
            margin-top: 60px;
            text-align: center;
        }
    </style>
</head>
<body>
<%
    Product product = (Product) request.getAttribute("product");
    User currentUser = SessionUtil.getUserFromSession(session);
%>

<!-- Navigation -->
<nav>
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="logo">🧃 BeverageStore</a>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/products">Shop</a>
            <%
                if (currentUser != null) {
            %>
            <% if (currentUser.isAdmin()) { %>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/customer/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/customer/orders">Orders</a>
            <% } %>
            <span><%= currentUser.getFullName() %></span>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
            <%
                } else {
            %>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
            <%
                }
            %>
        </div>
    </div>
</nav>

<!-- Breadcrumb -->
<div class="container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Home</a> /
        <a href="${pageContext.request.contextPath}/products">Products</a> /
        <a href="${pageContext.request.contextPath}/products?category=<%= product.getCategory() %>"><%= product.getCategory() %></a> /
        <strong><%= product.getName() %></strong>
    </div>
</div>

<!-- Product Detail -->
<div class="container">
    <div class="product-detail">
        <div class="detail-container">
            <!-- Product Image -->
            <div class="product-image-large">
                <%
                    if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
                %>
                <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                <%
                    } else {
                %>
                🧃
                <%
                    }
                %>
            </div>

            <!-- Product Info -->
            <div class="detail-info">
                <div class="detail-category"><%= product.getCategory() %></div>
                <h1><%= product.getName() %></h1>
                <div class="detail-brand"><%= product.getBrand() %></div>
                <div class="detail-price">$<%= String.format("%.2f", product.getPrice()) %></div>

                <div class="detail-description">
                    <%= product.getDescription() %>
                </div>

                <!-- Specifications -->
                <div class="detail-specs">
                    <div class="spec-row">
                        <span class="spec-label">Category:</span>
                        <span class="spec-value"><%= product.getCategory() %></span>
                    </div>
                    <div class="spec-row">
                        <span class="spec-label">Brand:</span>
                        <span class="spec-value"><%= product.getBrand() %></span>
                    </div>
                    <div class="spec-row">
                        <span class="spec-label">Stock:</span>
                        <span class="spec-value">
                            <% if (product.getStock() > 10) { %>
                                <span class="stock-available"><%= product.getStock() %> units available</span>
                            <% } else if (product.getStock() > 0) { %>
                                <span class="stock-low"><%= product.getStock() %> units left (Low Stock!)</span>
                            <% } else { %>
                                <span class="stock-out">Out of Stock</span>
                            <% } %>
                        </span>
                    </div>
                </div>

                <!-- Add to Cart -->
                <% if (currentUser != null && currentUser.isCustomer()) { %>
                <form method="POST" action="${pageContext.request.contextPath}/customer/cart" style="display: contents;">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                    
                    <div class="quantity-selector">
                        <label for="quantity">Quantity:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStock() %>" <% if (product.getStock() == 0) { %>disabled<% } %>>
                    </div>

                    <div class="actions">
                        <button type="submit" class="btn btn-primary" <% if (product.getStock() == 0) { %>disabled<% } %>>Add to Cart</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location='${pageContext.request.contextPath}/customer/cart'">View Cart</button>
                    </div>
                </form>
                <% } else if (currentUser == null) { %>
                <div class="actions">
                    <button type="button" class="btn btn-primary" onclick="window.location='${pageContext.request.contextPath}/login'">Login to Purchase</button>
                </div>
                <% } %>

                <a href="${pageContext.request.contextPath}/products" class="back-link">← Back to Products</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer>
    <div class="container">
        <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
    </div>
</footer>
</body>
</html>
