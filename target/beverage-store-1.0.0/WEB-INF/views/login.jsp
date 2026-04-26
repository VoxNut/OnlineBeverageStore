<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Online Beverage Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 420px;
            width: 100%;
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h1 {
            text-align: center;
            color: #1a1a2e;
            margin-bottom: 8px;
            font-size: 28px;
            font-weight: 700;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 28px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #374151;
            font-weight: 600;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            transition: border-color 0.3s, box-shadow 0.3s;
            background: #f9fafb;
        }

        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
            background: white;
        }

        .error-message {
            background-color: #fef2f2;
            color: #dc2626;
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #dc2626;
            font-size: 14px;
            font-weight: 500;
        }

        .success-message {
            background-color: #f0fdf4;
            color: #16a34a;
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #16a34a;
            font-size: 14px;
            font-weight: 500;
        }

        .btn-login {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 5px;
            font-family: 'Inter', sans-serif;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        /* Divider */
        .divider {
            display: flex;
            align-items: center;
            margin: 24px 0;
            gap: 16px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e5e7eb;
        }

        .divider span {
            color: #9ca3af;
            font-size: 13px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Google Sign-In Button */
        .btn-google {
            width: 100%;
            padding: 13px;
            background: white;
            color: #374151;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-family: 'Inter', sans-serif;
        }

        .btn-google:hover {
            border-color: #4285f4;
            background: #f8faff;
            box-shadow: 0 4px 15px rgba(66, 133, 244, 0.15);
            transform: translateY(-1px);
        }

        .btn-google:active {
            transform: translateY(0);
        }

        .btn-google svg {
            width: 20px;
            height: 20px;
            flex-shrink: 0;
        }

        .btn-google:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Loading spinner */
        .spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 3px solid #e5e7eb;
            border-top-color: #667eea;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .links {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
            color: #6b7280;
        }

        .links a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.2s;
        }

        .links a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .back-home {
            text-align: center;
            margin-top: 16px;
        }

        .back-home a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.2s;
        }

        .back-home a:hover {
            color: #764ba2;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🧃 Welcome Back</h1>
    <p class="subtitle">Sign in to your BeverageStore account</p>

    <%
        String error = (String) request.getAttribute("error");
        String success = (String) request.getAttribute("success");
    %>

    <% if (error != null) { %>
    <div class="error-message"><%= error %></div>
    <% } %>

    <% if (success != null) { %>
    <div class="success-message"><%= success %></div>
    <% } %>

    <div id="google-error" class="error-message" style="display: none;"></div>

    <!-- Google Sign-In Button -->
    <button type="button" id="googleSignInBtn" class="btn-google" onclick="signInWithGoogle()">
        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 01-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z" fill="#4285F4"/>
            <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
            <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
            <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
        </svg>
        <span id="googleBtnText">Sign in with Google</span>
        <div id="googleSpinner" class="spinner"></div>
    </button>

    <div class="divider">
        <span>or sign in with email</span>
    </div>

    <form method="POST" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required placeholder="you@example.com">
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="••••••••">
        </div>

        <button type="submit" class="btn-login">Sign In</button>
    </form>

    <div class="links">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register">Register here</a>
    </div>

    <div class="back-home">
        <a href="${pageContext.request.contextPath}/">← Back to Home</a>
    </div>
</div>

<!-- Firebase JS SDK (Compat mode for simplicity with JSP) -->
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.12.0/firebase-auth-compat.js"></script>

<script>
    // Firebase configuration
    const firebaseConfig = {
        apiKey: "AIzaSyDTnkGdaUarDWFLt6De6KkuSuxc9zjOJHk",
        authDomain: "online-beverage-store.firebaseapp.com",
        projectId: "online-beverage-store",
        storageBucket: "online-beverage-store.firebasestorage.app",
        messagingSenderId: "888665427739",
        appId: "1:888665427739:web:87ddb2c4a29902114c4dbe",
        measurementId: "G-TV7SR6N282"
    };

    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);

    function signInWithGoogle() {
        const btn = document.getElementById('googleSignInBtn');
        const btnText = document.getElementById('googleBtnText');
        const spinner = document.getElementById('googleSpinner');
        const errorDiv = document.getElementById('google-error');

        // Disable button and show spinner
        btn.disabled = true;
        btnText.textContent = 'Signing in...';
        spinner.style.display = 'inline-block';
        errorDiv.style.display = 'none';

        const provider = new firebase.auth.GoogleAuthProvider();

        firebase.auth().signInWithPopup(provider)
            .then(function(result) {
                // Get the Firebase ID token
                return result.user.getIdToken();
            })
            .then(function(idToken) {
                // Send the token to our backend for verification
                return fetch('${pageContext.request.contextPath}/google-auth', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ idToken: idToken })
                });
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    // Redirect to the URL provided by the backend
                    window.location.href = data.redirectUrl;
                } else {
                    throw new Error(data.error || 'Authentication failed');
                }
            })
            .catch(function(error) {
                console.error('Google Sign-In error:', error);

                // Reset button state
                btn.disabled = false;
                btnText.textContent = 'Sign in with Google';
                spinner.style.display = 'none';

                // Show error message (ignore popup closed by user)
                if (error.code !== 'auth/popup-closed-by-user' && 
                    error.code !== 'auth/cancelled-popup-request') {
                    errorDiv.textContent = error.message || 'Google Sign-In failed. Please try again.';
                    errorDiv.style.display = 'block';
                }
            });
    }
</script>
</body>
</html>
