<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.beveragestore.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${mode == 'edit' ? 'Edit Product' : 'Add Product'} - The Grindery Admin</title>
    
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

        .form-container {
            background: var(--bg-white);
            padding: var(--spacing-xl);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            max-width: 800px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-md);
        }

        @media (max-width: 768px) {
            .admin-container { grid-template-columns: 1fr; }
            .form-row { grid-template-columns: 1fr; gap: 0; }
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }

        .checkbox-group input {
            width: 18px;
            height: 18px;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="page-header" style="text-align:center; padding: var(--spacing-xl) 0 var(--spacing-md);">
    <div class="container">
        <h1>${mode == 'edit' ? 'Edit Product' : 'Add New Product'}</h1>
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
        <div class="form-container">
            <% Product p = (Product) request.getAttribute("product"); %>
            
            <form method="POST" action="${pageContext.request.contextPath}/admin/products">
                <input type="hidden" name="action" value="${mode == 'edit' ? 'update' : 'create'}">
                <% if (p != null) { %><input type="hidden" name="productId" value="<%= p.getProductId() %>"><% } %>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Product Name *</label>
                        <input type="text" name="name" class="form-control" required value="<%= p != null ? p.getName() : "" %>">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Category *</label>
                        <select name="category" class="form-control" required>
                            <option value="Coffee" <%= p != null && "Coffee".equals(p.getCategory()) ? "selected" : "" %>>Coffee</option>
                            <option value="Tea" <%= p != null && "Tea".equals(p.getCategory()) ? "selected" : "" %>>Tea</option>
                            <option value="Goods" <%= p != null && "Goods".equals(p.getCategory()) ? "selected" : "" %>>Goods</option>
                            <option value="Water" <%= p != null && "Water".equals(p.getCategory()) ? "selected" : "" %>>Water</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Brand</label>
                        <input type="text" name="brand" class="form-control" value="<%= p != null ? p.getBrand() : "" %>">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Price ($) *</label>
                        <input type="number" name="price" step="0.01" min="0" class="form-control" required value="<%= p != null ? p.getPrice() : "" %>">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Initial Stock *</label>
                        <input type="number" name="stock" min="0" class="form-control" required value="<%= p != null ? p.getStock() : "0" %>">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Image URL</label>
                        <input type="url" name="imageUrl" class="form-control" placeholder="https://res.cloudinary.com/..." value="<%= p != null && p.getImageUrl() != null ? p.getImageUrl() : "" %>">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control"><%= p != null ? p.getDescription() : "" %></textarea>
                </div>

                <% if (p != null) { %>
                <div class="form-group checkbox-group">
                    <input type="checkbox" id="isActive" name="isActive" <%= p.isActive() ? "checked" : "" %>>
                    <label for="isActive">Product is Active (Visible to customers)</label>
                </div>
                <% } %>

                <div style="margin-top: var(--spacing-xl); display: flex; gap: var(--spacing-md);">
                    <button type="submit" class="btn btn-primary">${mode == 'edit' ? 'Save Changes' : 'Create Product'}</button>
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
