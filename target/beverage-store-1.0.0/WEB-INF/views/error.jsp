<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            text-align: center;
            background: white;
            padding: 60px 40px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 500px;
        }

        h1 {
            font-size: 72px;
            color: #d32f2f;
            margin-bottom: 20px;
        }

        h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 24px;
        }

        p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        a {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            transition: transform 0.2s;
        }

        a:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>500</h1>
    <h2>Server Error</h2>
    <p>Something went wrong on our server. Our team has been notified. Please try again later.</p>
    <a href="${pageContext.request.contextPath}/">← Back to Home</a>
</div>
</body>
</html>
