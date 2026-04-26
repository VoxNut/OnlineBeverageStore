<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.beveragestore.util.SessionUtil" %>
<%@ page import="com.beveragestore.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Online Beverage Store</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            line-height: 1.6;
            background: #f5f5f5;
        }

        /* Navigation */
        nav {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
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

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Page Header */
        .page-header {
            background: white;
            padding: 30px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .page-header h1 {
            font-size: 32px;
            margin-bottom: 15px;
        }

        /* Filters */
        .filters {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .filter-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: flex-end;
        }

        .filter-item {
            flex: 1;
            min-width: 200px;
        }

        .filter-item label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .filter-item select,
        .filter-item input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .filter-item button {
            width: 100%;
            padding: 10px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }

        .filter-item button:hover {
            background: #764ba2;
        }

        /* Products Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .product-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .product-image {
            width: 100%;
            height: 220px;
            background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .product-info {
            padding: 20px;
        }

        .product-category {
            color: #667eea;
            font-size: 12px;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .product-name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }

        .product-brand {
            color: #999;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .product-description {
            font-size: 13px;
            color: #666;
            margin-bottom: 12px;
            line-height: 1.4;
            min-height: 40px;
        }

        .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #667eea;
        }

        .product-stock {
            font-size: 12px;
        }

        .stock-available {
            color: #27ae60;
            font-weight: 600;
        }

        .stock-low {
            color: #e74c3c;
            font-weight: 600;
        }

        .product-actions {
            display: flex;
            gap: 10px;
        }

        .btn-small {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: transform 0.2s;
        }

        .btn-view {
            background: #667eea;
            color: white;
        }

        .btn-cart {
            background: #27ae60;
            color: white;
        }

        .btn-small:hover {
            transform: translateY(-2px);
        }

        /* No Products */
        .no-products {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
        }

        .no-products h2 {
            color: #999;
            margin-bottom: 20px;
        }

        /* Footer */
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
<!-- Navigation -->
<nav>
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="logo">🧃 BeverageStore</a>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/products">Shop</a>
            <%
                User currentUser = SessionUtil.getUserFromSession(session);
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

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1>${pageTitle}</h1>
    </div>
</div>

<!-- Filters -->
<div class="container">
    <div class="filters">
        <form method="GET" action="${pageContext.request.contextPath}/products" style="display: contents;">
            <div class="filter-group">
                <div class="filter-item">
                    <label for="category">Filter by Category</label>
                    <select id="category" name="category" onchange="this.form.submit();">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}" <c:if test="${cat == selectedCategory}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-item">
                    <label for="search">Search Products</label>
                    <input type="text" id="search" name="search" placeholder="Search by product name..." value="${searchTerm}">
                </div>
                <div class="filter-item">
                    <button type="submit">Search</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Products -->
<div class="container">
    <c:choose>
        <c:when test="${not empty products}">
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <div class="product-image">
                            <c:choose>
                                <c:when test="${not empty product.imageUrl}">
                                    <img src="${product.imageUrl}" alt="${product.name}">
                                </c:when>
                                <c:otherwise>
                                    🧃
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="product-info">
                            <div class="product-category">${product.category}</div>
                            <div class="product-name">${product.name}</div>
                            <div class="product-brand">${product.brand}</div>
                            <div class="product-description">${product.description}</div>
                            <div class="product-footer">
                                <div class="product-price">$${product.price}</div>
                                <div class="product-stock">
                                    <c:choose>
                                        <c:when test="${product.stock > 10}">
                                            <span class="stock-available">In Stock (${product.stock})</span>
                                        </c:when>
                                        <c:when test="${product.stock > 0}">
                                            <span class="stock-low">Low Stock (${product.stock})</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-low">Out of Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="product-actions">
                                <button class="btn-small btn-view" onclick="window.location='${pageContext.request.contextPath}/product?id=${product.productId}'">View Details</button>
                                <% if (currentUser != null && currentUser.isCustomer()) { %>
                                <button class="btn-small btn-cart" onclick="addToCart('${product.productId}')">Add to Cart</button>
                                <% } else if (currentUser == null) { %>
                                <button class="btn-small btn-cart" onclick="window.location='${pageContext.request.contextPath}/login'">Login to Buy</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-products">
                <h2>No products found</h2>
                <p>Try adjusting your search or category filters.</p>
                <a href="${pageContext.request.contextPath}/products" style="color: #667eea; text-decoration: none; font-weight: 600;">View All Products</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer>
    <div class="container">
        <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
    </div>
</footer>

<script>
    function addToCart(productId) {
        fetch('${pageContext.request.contextPath}/customer/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=add&productId=' + productId + '&quantity=1'
        }).then(response => {
            if (response.ok) {
                alert('Product added to cart!');
            } else {
                alert('Failed to add to cart. Please try again.');
            }
        });
    }
</script>
</body>
</html>
