<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.model.Product" %>
<%@ page import="com.beveragestore.util.SessionUtil" %>
<%@ page import="com.beveragestore.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - The Grindery</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    
    <!-- Global CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .breadcrumb {
            padding: var(--spacing-lg) 0;
            font-size: 13px;
            color: var(--text-secondary);
        }

        .breadcrumb a {
            color: var(--text-light);
            margin: 0 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .breadcrumb a:first-child { margin-left: 0; }

        .product-detail-section {
            background: var(--bg-white);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            margin-bottom: var(--spacing-xxl);
            overflow: hidden;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
        }

        @media (max-width: 768px) {
            .detail-grid { grid-template-columns: 1fr; }
        }

        .detail-image-col {
            background: var(--bg-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--spacing-xl);
            min-height: 500px;
        }

        .detail-image-col img {
            max-width: 100%;
            max-height: 500px;
            object-fit: contain;
            mix-blend-mode: multiply; /* Helps white background images blend in */
        }

        .detail-info-col {
            padding: var(--spacing-xl) var(--spacing-xxl);
        }

        .detail-category {
            display: inline-block;
            color: var(--accent-primary);
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: var(--spacing-sm);
        }

        .detail-title {
            font-size: 40px;
            margin-bottom: var(--spacing-xs);
        }

        .detail-brand {
            font-size: 16px;
            color: var(--text-secondary);
            margin-bottom: var(--spacing-lg);
        }

        .detail-price {
            font-size: 32px;
            font-weight: 500;
            margin-bottom: var(--spacing-xl);
            font-family: var(--font-heading);
        }

        .detail-description {
            font-size: 15px;
            color: var(--text-secondary);
            line-height: 1.8;
            margin-bottom: var(--spacing-xl);
        }

        .detail-specs {
            border-top: 1px solid var(--border-color);
            border-bottom: 1px solid var(--border-color);
            padding: var(--spacing-lg) 0;
            margin-bottom: var(--spacing-xl);
        }

        .spec-row {
            display: flex;
            justify-content: space-between;
            padding: var(--spacing-xs) 0;
            font-size: 14px;
        }

        .spec-label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .spec-value {
            font-weight: 600;
        }

        .quantity-wrap {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-xl);
        }

        .quantity-wrap label {
            font-size: 14px;
            font-weight: 500;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .quantity-input {
            width: 80px;
            text-align: center;
        }

        .action-buttons {
            display: flex;
            gap: var(--spacing-md);
            flex-wrap: wrap;
        }

        .action-buttons .btn {
            flex: 1;
            min-width: 200px;
            padding: 16px;
        }
    </style>
</head>
<body>

<%
    Product product = (Product) request.getAttribute("product");
%>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/">Home</a> /
        <a href="${pageContext.request.contextPath}/products">Shop</a> /
        <a href="${pageContext.request.contextPath}/products?category=<%= product.getCategory() %>"><%= product.getCategory() %></a> /
        <span style="color: var(--text-primary);"><%= product.getName() %></span>
    </div>

    <div class="product-detail-section">
        <div class="detail-grid">
            <div class="detail-image-col">
                <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                <% } else { %>
                    <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="var(--border-color)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
                <% } %>
            </div>

            <div class="detail-info-col">
                <div class="detail-category"><%= product.getCategory() %></div>
                <h1 class="detail-title"><%= product.getName() %></h1>
                <div class="detail-brand">By <%= product.getBrand() %></div>
                
                <div class="detail-price">$<%= String.format("%.2f", product.getPrice()) %></div>

                <div class="detail-description">
                    <%= product.getDescription() %>
                </div>

                <div class="detail-specs">
                    <div class="spec-row">
                        <span class="spec-label">Availability</span>
                        <span class="spec-value">
                            <% if (product.getStock() > 10) { %>
                                <span style="color: var(--success-text);">In Stock</span>
                            <% } else if (product.getStock() > 0) { %>
                                <span style="color: var(--error-text);">Only <%= product.getStock() %> Left</span>
                            <% } else { %>
                                <span style="color: var(--text-light);">Out of Stock</span>
                            <% } %>
                        </span>
                    </div>
                </div>

                <% User currentUser = SessionUtil.getUserFromSession(session); %>
                <% if (currentUser != null && currentUser.isCustomer()) { %>
                    <form method="POST" action="${pageContext.request.contextPath}/customer/cart" id="addToCartForm">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                        
                        <div class="quantity-wrap">
                            <label for="quantity">Quantity</label>
                            <input type="number" id="quantity" name="quantity" class="form-control quantity-input" value="1" min="1" max="<%= product.getStock() %>" <% if (product.getStock() == 0) { %>disabled<% } %>>
                        </div>

                        <div class="action-buttons">
                            <button type="button" class="btn btn-primary" onclick="addToCartAjax()" <% if (product.getStock() == 0) { %>disabled<% } %>>Add to Cart</button>
                            <button type="button" class="btn btn-secondary" onclick="window.location='${pageContext.request.contextPath}/customer/cart'">View Cart</button>
                        </div>
                    </form>
                <% } else if (currentUser == null) { %>
                    <div class="action-buttons">
                        <button type="button" class="btn btn-primary" onclick="window.location='${pageContext.request.contextPath}/login'">Sign in to Purchase</button>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />

<script>
    function addToCartAjax() {
        const form = document.getElementById('addToCartForm');
        const formData = new URLSearchParams(new FormData(form));

        fetch('${pageContext.request.contextPath}/customer/cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData.toString()
        }).then(response => {
            if (response.ok) {
                showAlert('Item added to your cart.', 'success');
            } else {
                showAlert('Failed to add item to cart.', 'error');
            }
        }).catch(err => {
            showAlert('An error occurred.', 'error');
        });
    }
</script>
</body>
</html>
