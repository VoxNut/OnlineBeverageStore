<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The Grindery - Elevate Your Daily Ritual</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    
    <!-- Global CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        /* Page-specific styles for Home */
        .hero-section {
            display: flex;
            align-items: center;
            background-color: var(--bg-secondary);
            margin: var(--spacing-md) var(--spacing-lg);
            border-radius: var(--border-radius);
            overflow: hidden;
            min-height: 500px;
        }

        .hero-content {
            flex: 1;
            padding: var(--spacing-xxl) var(--spacing-xl);
            max-width: 500px;
        }

        .hero-title {
            font-size: 48px;
            margin-bottom: var(--spacing-md);
            letter-spacing: -0.5px;
        }

        .hero-subtitle {
            font-size: 16px;
            color: var(--text-secondary);
            margin-bottom: var(--spacing-xl);
        }

        .hero-image {
            flex: 1.2;
            height: 100%;
            min-height: 500px;
            background-image: url('https://res.cloudinary.com/dbpl94opl/image/upload/v1777211160/Gemini_Generated_Image_7uac5r7uac5r7uac_uiknst.png');
            background-size: cover;
            background-position: center;
        }

        /* Featured Section */
        .featured-section {
            padding: var(--spacing-xxl) 0;
        }

        .section-header {
            margin-bottom: var(--spacing-xl);
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .section-title {
            font-size: 24px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-family: var(--font-body);
            font-weight: 400;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: var(--spacing-lg);
        }

        .product-card {
            display: flex;
            background: var(--bg-secondary);
            border-radius: var(--border-radius);
            padding: var(--spacing-md);
            gap: var(--spacing-md);
        }

        .product-card-img-wrap {
            width: 100px;
            height: 120px;
            background: var(--bg-white);
            border-radius: 4px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-card-info {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .product-card-title {
            font-size: 16px;
            margin-bottom: var(--spacing-xs);
        }

        .product-card-desc {
            font-size: 12px;
            color: var(--text-secondary);
            margin-bottom: auto;
        }

        .btn-add {
            background: var(--accent-primary);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            align-self: flex-start;
            margin-top: var(--spacing-sm);
        }

        @media (max-width: 768px) {
            .hero-section {
                flex-direction: column-reverse;
            }
            .hero-image {
                width: 100%;
                min-height: 300px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<main>
    <section class="hero-section">
        <div class="hero-content">
            <h1 class="hero-title">ELEVATE YOUR<br>DAILY RITUAL</h1>
            <p class="hero-subtitle">Small-Batch Coffee, Teas, & Curated Provisions. Sourced with care.</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Shop Our Collection</a>
        </div>
        <div class="hero-image"></div>
    </section>

    <section class="featured-section container">
        <div class="section-header">
            <h2 class="section-title">Featured Favorites</h2>
            <a href="${pageContext.request.contextPath}/products" style="font-size: 14px; text-decoration: underline;">View All</a>
        </div>
        
        <div class="product-grid">
            <!-- Mock Product 1 -->
            <div class="product-card">
                <div class="product-card-img-wrap">
                    <img src="https://images.unsplash.com/photo-1559525839-b184a4d698c7?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Coffee" style="max-height:100%; max-width:100%; object-fit:contain;">
                </div>
                <div class="product-card-info">
                    <h3 class="product-card-title">Craft Coffee Bag</h3>
                    <p class="product-card-desc">High-quality beans for artisanal drinks.</p>
                    <button class="btn-add">Add to Cart</button>
                </div>
            </div>

            <!-- Mock Product 2 -->
            <div class="product-card">
                <div class="product-card-img-wrap">
                    <img src="https://images.unsplash.com/photo-1594808381830-4e3d3663a75d?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Tea" style="max-height:100%; max-width:100%; object-fit:contain;">
                </div>
                <div class="product-card-info">
                    <h3 class="product-card-title">Herbal Tea Jar</h3>
                    <p class="product-card-desc">Small-batch teas crafted with care.</p>
                    <button class="btn-add">Add to Cart</button>
                </div>
            </div>

            <!-- Mock Product 3 -->
            <div class="product-card">
                <div class="product-card-img-wrap">
                    <img src="https://images.unsplash.com/photo-1622483767028-3f66f32aef97?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Kombucha" style="max-height:100%; max-width:100%; object-fit:contain;">
                </div>
                <div class="product-card-info">
                    <h3 class="product-card-title">Kombucha Bottle</h3>
                    <p class="product-card-desc">Handcrafted refreshing kombucha.</p>
                    <button class="btn-add">Add to Cart</button>
                </div>
            </div>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
