<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .error-page {
            min-height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .error-content {
            background: var(--bg-white);
            padding: var(--spacing-xxl);
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            max-width: 500px;
            width: 100%;
        }

        .error-content h1 {
            font-size: 80px;
            color: var(--error-text);
            margin-bottom: var(--spacing-sm);
        }

        .error-content h2 {
            font-family: var(--font-body);
            font-size: 24px;
            margin-bottom: var(--spacing-md);
        }

        .error-content p {
            color: var(--text-secondary);
            margin-bottom: var(--spacing-xl);
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/partials/header.jsp" />

<div class="container error-page">
    <div class="error-content">
        <h1>500</h1>
        <h2>Server Error</h2>
        <p>Something went wrong on our end. Our team has been notified. Please try again later.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Return to Home</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/partials/footer.jsp" />
</body>
</html>
