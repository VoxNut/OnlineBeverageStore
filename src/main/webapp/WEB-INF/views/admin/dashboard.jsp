<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - The Grindery</title>
    
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
        }

        .stat-card {
            background: var(--bg-white);
            padding: var(--spacing-xl);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
            text-align: center;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: var(--spacing-sm);
        }

        .stat-value {
            font-family: var(--font-heading);
            font-size: 36px;
            color: var(--text-primary);
        }

        .stat-card.revenue .stat-value {
            color: var(--success-text);
        }
        
        .stat-card.warning .stat-value {
            color: var(--error-text);
        }

        .quick-actions {
            background: var(--bg-white);
            padding: var(--spacing-xl);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
        }

        .quick-actions h3 {
            font-family: var(--font-body);
            margin-bottom: var(--spacing-lg);
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: var(--spacing-md);
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
        <h1>Admin Portal</h1>
    </div>
</div>

<div class="container admin-container">
    <div class="admin-sidebar">
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
        </nav>
    </div>

    <div class="admin-content">
        <h2 style="font-family: var(--font-body); margin-bottom: var(--spacing-lg);">Overview</h2>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Total Orders</div>
                <div class="stat-value"><%= request.getAttribute("totalOrders") %></div>
            </div>
            <div class="stat-card revenue">
                <div class="stat-label">Total Revenue</div>
                <div class="stat-value">$<%= String.format("%.2f", (double) request.getAttribute("totalRevenue")) %></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Registered Users</div>
                <div class="stat-value"><%= request.getAttribute("totalUsers") %></div>
            </div>
            <div class="stat-card <% if ((int)request.getAttribute("lowStockCount") > 0) { %>warning<% } %>">
                <div class="stat-label">Low Stock Items</div>
                <div class="stat-value"><%= request.getAttribute("lowStockCount") %></div>
            </div>
        </div>

        <div class="quick-actions">
            <h3>Quick Actions</h3>
            <div class="action-grid">
                <a href="${pageContext.request.contextPath}/admin/products?action=create" class="btn btn-primary" style="text-align:center;">Add New Product</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary" style="text-align:center;">View Pending Orders</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
