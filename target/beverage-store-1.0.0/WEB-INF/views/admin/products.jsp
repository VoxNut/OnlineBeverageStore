<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beveragestore.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - Admin Dashboard</title>
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
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .page-header {
            background: white;
            padding: 20px 0;
            margin-bottom: 20px;
        }

        .page-header h1 {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .back-link {
            display: inline-block;
            color: #667eea;
            text-decoration: none;
            margin: 20px 0;
            font-weight: 600;
        }

        .products-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f9f9f9;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #eee;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .action-btn {
            padding: 6px 12px;
            margin-right: 8px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 600;
        }

        .btn-edit {
            background: #667eea;
            color: white;
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .status-active {
            color: #27ae60;
            font-weight: 600;
        }

        .status-inactive {
            color: #e74c3c;
            font-weight: 600;
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
        <div onclick="window.location='${pageContext.request.contextPath}/'" style="cursor: pointer; color: white; font-weight: bold;">🧃 BeverageStore</div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h1>📦 Manage Products</h1>
    </div>
</div>

<div class="container">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-link">← Back to Dashboard</a>

    <div class="products-table">
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                %>
                <tr>
                    <td><%= product.getProductId().substring(0, 8) %>...</td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getCategory() %></td>
                    <td>$<%= String.format("%.2f", product.getPrice()) %></td>
                    <td><%= product.getStock() %></td>
                    <td>
                        <span class="<%= product.isActive() ? "status-active" : "status-inactive" %>">
                            <%= product.isActive() ? "Active" : "Inactive" %>
                        </span>
                    </td>
                    <td>
                        <button class="action-btn btn-edit" onclick="alert('Edit feature coming soon')">Edit</button>
                        <button class="action-btn btn-delete" onclick="if(confirm('Deactivate this product?')) { alert('Delete feature coming soon'); }">Deactivate</button>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" style="text-align: center; padding: 30px; color: #999;">No products found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <p>&copy; 2026 Online Beverage Store - Admin Panel</p>
</footer>
</body>
</html>
