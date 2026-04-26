<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.util.SessionUtil" %>
<%@ page import="com.beveragestore.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Beverage Store - Premium Drinks</title>
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

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 20px;
            text-align: center;
        }

        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .hero p {
            font-size: 20px;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .hero-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s, box-shadow 0.2s;
            font-weight: 600;
        }

        .btn-primary {
            background: white;
            color: #667eea;
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Categories Section */
        .categories {
            background: #f8f9fa;
            padding: 40px 20px;
            margin: 40px 0;
        }

        .categories .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .categories h3 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .category-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }

        .category-btn {
            padding: 15px;
            border: 2px solid #ddd;
            background: white;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            color: #333;
            text-align: center;
            font-weight: 600;
            transition: all 0.3s;
        }

        .category-btn:hover {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }

        /* Featured Section */
        .featured {
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 20px;
            text-align: center;
        }

        .featured h2 {
            margin-bottom: 30px;
            font-size: 32px;
        }

        /* Footer */
        footer {
            background: #333;
            color: white;
            padding: 40px 20px;
            margin-top: 60px;
            text-align: center;
        }

        footer p {
            margin-bottom: 15px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav>
    <div class="container">
        <div class="logo">🧃 BeverageStore</div>
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
            <div style="display: flex; gap: 15px; align-items: center;">
                <span><%= currentUser.getFullName() %></span>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
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

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1>Welcome to BeverageStore</h1>
        <p>Your one-stop shop for premium beverages from around the world</p>
        <div class="hero-buttons">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Shop Now</a>
            <% if (currentUser == null) { %>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-secondary">Join Us</a>
            <% } %>
        </div>
    </div>
</section>

<!-- Categories Section -->
<section class="categories">
    <div class="container">
        <h3>Browse by Category</h3>
        <div class="category-list">
            <a href="${pageContext.request.contextPath}/products?category=Water" class="category-btn">💧 Water</a>
            <a href="${pageContext.request.contextPath}/products?category=Soft Drinks" class="category-btn">🥤 Soft Drinks</a>
            <a href="${pageContext.request.contextPath}/products?category=Coffee" class="category-btn">☕ Coffee</a>
            <a href="${pageContext.request.contextPath}/products?category=Tea" class="category-btn">🫖 Tea</a>
            <a href="${pageContext.request.contextPath}/products?category=Juice" class="category-btn">🧉 Juice</a>
            <a href="${pageContext.request.contextPath}/products?category=Energy Drinks" class="category-btn">⚡ Energy</a>
            <a href="${pageContext.request.contextPath}/products?category=Alcohol" class="category-btn">🍷 Alcohol</a>
        </div>
    </div>
</section>

<!-- Featured Section -->
<section class="featured">
    <h2>🌟 Featured Beverages</h2>
    <p style="color: #999; margin-bottom: 30px;">Browse our complete collection of premium drinks</p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <p>&copy; 2026 Online Beverage Store. All rights reserved.</p>
        <p>Premium beverages delivered to your door.</p>
    </div>
</footer>
</body>
</html>
