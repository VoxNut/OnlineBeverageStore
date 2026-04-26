<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - The Grindery Admin</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1.1">

    <style>
        .admin-container {
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: var(--spacing-xl);
            min-height: calc(100vh - 200px);
            margin-bottom: var(--spacing-xxl);
        }

        .admin-sidebar {
            background: var(--bg-white);
            border-right: 1px solid var(--border-color);
            padding: var(--spacing-lg) 0;
            border-radius: var(--border-radius);
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            align-self: start;
        }

        .admin-nav {
            display: flex;
            flex-direction: column;
        }

        .admin-nav a {
            padding: var(--spacing-md) var(--spacing-lg);
            color: var(--text-secondary);
            font-weight: 500;
            border-left: 3px solid transparent;
            transition: all 0.2s;
        }

        .admin-nav a:hover, .admin-nav a.active {
            color: var(--accent-primary);
            background: var(--bg-secondary);
            border-left-color: var(--accent-primary);
        }

        .admin-content {
            padding: var(--spacing-lg) 0;
        }

        .table-container {
            background: var(--bg-white);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: var(--spacing-md) var(--spacing-lg);
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: var(--bg-secondary);
        }

        td {
            font-size: 14px;
        }

        .product-image {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 4px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active { background: #e8f5e9; color: #388e3c; }
        .status-inactive { background: #ffebee; color: #d32f2f; }
        .stock-low { color: #d32f2f; font-weight: 600; }

        .action-links a, .action-links button {
            display: inline-block;
            margin-right: 10px;
            font-size: 13px;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-lg);
        }

        @media (max-width: 768px) {
            .admin-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="page-header" style="text-align:center; padding: var(--spacing-xl) 0 var(--spacing-md);">
    <div class="container">
        <h1>Manage Products</h1>
    </div>
</div>

<div class="container admin-container">
    <div class="admin-sidebar">
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/products" class="active">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
        </nav>
    </div>

    <div class="admin-content">
        <% String success = request.getParameter("success");
           String error = request.getParameter("error");
           if (success != null) { %>
            <div id="server-success-msg" style="display:none;"><%= success %></div>
        <% } if (error != null) { %>
            <div id="server-error-msg" style="display:none;"><%= error %></div>
        <% } %>

        <div class="header-actions">
            <h2 style="font-family: var(--font-body);">All Products</h2>
            <a href="${pageContext.request.contextPath}/admin/products?action=create" class="btn btn-primary">Add New Product</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Product> products = (List<Product>) request.getAttribute("products");
                       if (products != null && !products.isEmpty()) {
                           for (Product p : products) {
                    %>
                    <tr>
                        <td>
                            <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
                                <img src="<%= p.getImageUrl() %>" class="product-image" alt="Product">
                            <% } else { %>
                                <div class="product-image" style="background:#eee; display:flex; align-items:center; justify-content:center;">☕</div>
                            <% } %>
                        </td>
                        <td style="font-weight: 500;"><%= p.getName() %></td>
                        <td><%= p.getCategory() %></td>
                        <td>$<%= String.format("%.2f", p.getPrice()) %></td>
                        <td>
                            <span class="<%= p.getStock() < 10 ? "stock-low" : "" %>"><%= p.getStock() %></span>
                        </td>
                        <td>
                            <% if (p.isActive()) { %>
                                <span class="status-badge status-active">Active</span>
                            <% } else { %>
                                <span class="status-badge status-inactive">Inactive</span>
                            <% } %>
                        </td>
                        <td class="action-links">
                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=<%= p.getProductId() %>" style="color:var(--accent-primary);">Edit</a>
                            <form method="POST" action="${pageContext.request.contextPath}/admin/products" style="display:inline;">
                                <input type="hidden" name="action" value="toggle_status">
                                <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                <button type="submit" style="background:none; border:none; color:var(--text-secondary); cursor:pointer; text-decoration:underline;">
                                    <%= p.isActive() ? "Deactivate" : "Activate" %>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%      }
                       } else { %>
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 40px;">No products found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
