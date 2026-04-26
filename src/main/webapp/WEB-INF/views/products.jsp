<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - The Grindery</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    
    <!-- Global CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .page-header {
            padding: var(--spacing-xxl) 0 var(--spacing-xl);
            text-align: center;
        }

        .page-header h1 {
            font-size: 40px;
            margin-bottom: var(--spacing-md);
        }

        .filters {
            background: var(--bg-white);
            padding: var(--spacing-lg);
            border-radius: var(--border-radius);
            margin-bottom: var(--spacing-xl);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
            border: 1px solid var(--border-color);
        }

        .filter-group {
            display: flex;
            gap: var(--spacing-md);
            flex-wrap: wrap;
            align-items: flex-end;
        }

        .filter-item {
            flex: 1;
            min-width: 200px;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: var(--spacing-xl);
            margin-bottom: var(--spacing-xxl);
        }

        .product-card {
            background: var(--bg-white);
            border-radius: var(--border-radius);
            overflow: hidden;
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }

        .product-image {
            width: 100%;
            height: 250px;
            background: var(--bg-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 60px;
            padding: var(--spacing-lg);
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .product-info {
            padding: var(--spacing-lg);
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .product-category {
            color: var(--accent-primary);
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 1px;
            margin-bottom: var(--spacing-xs);
        }

        .product-name {
            font-family: var(--font-heading);
            font-size: 20px;
            margin-bottom: var(--spacing-xs);
        }

        .product-brand {
            color: var(--text-light);
            font-size: 13px;
            margin-bottom: var(--spacing-md);
        }

        .product-description {
            font-size: 14px;
            color: var(--text-secondary);
            margin-bottom: var(--spacing-lg);
            flex: 1;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-md);
            padding-top: var(--spacing-md);
            border-top: 1px solid var(--border-color);
        }

        .product-price {
            font-size: 20px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .product-stock {
            font-size: 12px;
            font-weight: 500;
        }

        .stock-available { color: var(--success-text); }
        .stock-low { color: var(--error-text); }

        .product-actions {
            display: flex;
            gap: 10px;
        }

        .btn-small {
            flex: 1;
            padding: 10px;
            border-radius: 40px;
            font-size: 12px;
        }

        .no-products {
            text-align: center;
            padding: var(--spacing-xxl) var(--spacing-lg);
            background: var(--bg-white);
            border-radius: var(--border-radius);
            border: 1px dashed var(--border-color);
        }

        .no-products h2 {
            margin-bottom: var(--spacing-md);
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="page-header">
    <div class="container">
        <h1>${pageTitle}</h1>
        <p style="color: var(--text-secondary);">Discover our curated collection of fine beverages.</p>
    </div>
</div>

<div class="container">
    <div class="filters">
        <form method="GET" action="${pageContext.request.contextPath}/products" style="display: contents;">
            <div class="filter-group">
                <div class="filter-item">
                    <label for="category" class="form-label">Category</label>
                    <select id="category" name="category" class="form-control" onchange="this.form.submit();">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat}" <c:if test="${cat == selectedCategory}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-item" style="flex: 2;">
                    <label for="search" class="form-label">Search</label>
                    <input type="text" id="search" name="search" class="form-control" placeholder="Search by product name..." value="${searchTerm}">
                </div>
                <div class="filter-item" style="flex: 0 0 auto;">
                    <button type="submit" class="btn btn-primary" style="padding: 14px 28px;">Search</button>
                </div>
            </div>
        </form>
    </div>

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
                                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--border-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="product-info">
                            <div class="product-category">${product.category}</div>
                            <h3 class="product-name">${product.name}</h3>
                            <div class="product-brand">${product.brand}</div>
                            <div class="product-description">${product.description}</div>
                            <div class="product-footer">
                                <div class="product-price">$${product.price}</div>
                                <div class="product-stock">
                                    <c:choose>
                                        <c:when test="${product.stock > 10}">
                                            <span class="stock-available">In Stock</span>
                                        </c:when>
                                        <c:when test="${product.stock > 0}">
                                            <span class="stock-low">Low Stock</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-low">Out of Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="product-actions">
                                <button class="btn btn-secondary btn-small" onclick="window.location='${pageContext.request.contextPath}/product?id=${product.productId}'">View</button>
                                
                                <%@ page import="com.beveragestore.model.User" %>
                                <%@ page import="com.beveragestore.util.SessionUtil" %>
                                <% User pUser = SessionUtil.getUserFromSession(request.getSession(false)); %>
                                
                                <% if (pUser != null && pUser.isCustomer()) { %>
                                    <button class="btn btn-primary btn-small" onclick="addToCart('${product.productId}')" <c:if test="${product.stock == 0}">disabled</c:if>>Add to Cart</button>
                                <% } else if (pUser == null) { %>
                                    <button class="btn btn-primary btn-small" onclick="window.location='${pageContext.request.contextPath}/login'">Log in</button>
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
                <p style="color: var(--text-secondary); margin-bottom: var(--spacing-lg);">Try adjusting your search or category filters.</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Clear Filters</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />

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
                showAlert('Product added to cart!', 'success');
            } else {
                showAlert('Failed to add to cart. Please try again.', 'error');
            }
        }).catch(err => {
            showAlert('An error occurred.', 'error');
        });
    }
</script>
