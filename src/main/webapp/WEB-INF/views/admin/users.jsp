<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - The Grindery Admin</title>
    
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

        .role-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .role-admin { background: #e3f2fd; color: #1976d2; }
        .role-customer { background: #f5f5f5; color: #616161; }
        .role-shipper { background: #fff3e0; color: #f57c00; }
        .role-shop_owner { background: #e8f5e9; color: #388e3c; }

        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active { background: #e8f5e9; color: #388e3c; }
        .status-inactive { background: #ffebee; color: #d32f2f; }

        .action-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        select.form-control {
            padding: 6px 12px;
            font-size: 13px;
            width: auto;
            display: inline-block;
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
        <h1>Manage Users</h1>
    </div>
</div>

<div class="container admin-container">
    <div class="admin-sidebar">
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="active">Manage Users</a>
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

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<User> users = (List<User>) request.getAttribute("users");
                       if (users != null && !users.isEmpty()) {
                           for (User u : users) {
                    %>
                    <tr>
                        <td><%= u.getFullName() != null ? u.getFullName() : "N/A" %></td>
                        <td><%= u.getEmail() %></td>
                        <td>
                            <span class="role-badge role-<%= u.getRole() %>"><%= u.getRole() %></span>
                        </td>
                        <td>
                            <% if (u.isActive()) { %>
                                <span class="status-badge status-active">Active</span>
                            <% } else { %>
                                <span class="status-badge status-inactive">Inactive</span>
                            <% } %>
                        </td>
                        <td>
                            <form method="POST" action="${pageContext.request.contextPath}/admin/users" class="action-form" style="margin-bottom: 8px;">
                                <input type="hidden" name="action" value="update_role">
                                <input type="hidden" name="uid" value="<%= u.getUid() %>">
                                <select name="role" class="form-control">
                                    <option value="customer" <%= "customer".equals(u.getRole()) ? "selected" : "" %>>Customer</option>
                                    <option value="admin" <%= "admin".equals(u.getRole()) ? "selected" : "" %>>Admin</option>
                                    <option value="shipper" <%= "shipper".equals(u.getRole()) ? "selected" : "" %>>Shipper</option>
                                    <option value="shop_owner" <%= "shop_owner".equals(u.getRole()) ? "selected" : "" %>>Shop Owner</option>
                                </select>
                                <button type="submit" class="btn btn-primary" style="padding: 6px 12px; font-size: 12px;">Update</button>
                            </form>
                            <form method="POST" action="${pageContext.request.contextPath}/admin/users" class="action-form">
                                <input type="hidden" name="action" value="toggle_status">
                                <input type="hidden" name="uid" value="<%= u.getUid() %>">
                                <button type="submit" class="btn btn-secondary" style="padding: 6px 12px; font-size: 12px;">
                                    <%= u.isActive() ? "Deactivate" : "Activate" %>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%      }
                       } else { %>
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 40px;">No users found.</td>
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
