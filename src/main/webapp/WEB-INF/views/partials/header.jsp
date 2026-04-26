<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beveragestore.util.SessionUtil" %>
<%@ page import="com.beveragestore.model.User" %>

<%
    User currentUser = SessionUtil.getUserFromSession(request.getSession(false));
%>

<header class="site-header">
    <div class="container">
        <div class="brand-logo">
            <a href="${pageContext.request.contextPath}/">The Grindery</a>
        </div>
        
        <nav class="main-nav">
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/products?category=Coffee">Coffee</a>
            <a href="${pageContext.request.contextPath}/products?category=Tea">Tea</a>
            <a href="${pageContext.request.contextPath}/products">Goods</a>
        </nav>

        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/products" title="Search">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </a>
            
            <% if (currentUser != null) { %>
                <% if (currentUser.isAdmin()) { %>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" title="Admin Dashboard">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
                    </a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/customer/orders" title="Account">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                    </a>
                <% } %>
                <a href="${pageContext.request.contextPath}/customer/cart" title="Cart">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                </a>
                <a href="${pageContext.request.contextPath}/logout" title="Logout" style="margin-left: 10px; font-size: 13px; text-transform: uppercase;">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" title="Login">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                </a>
                <a href="${pageContext.request.contextPath}/customer/cart" title="Cart">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                </a>
            <% } %>
        </div>
    </div>
</header>

<!-- Hidden elements to pass server messages to JS -->
<% if (request.getAttribute("error") != null) { %>
    <div id="server-error-msg" style="display:none;"><%= request.getAttribute("error") %></div>
<% } %>
<% if (request.getAttribute("success") != null) { %>
    <div id="server-success-msg" style="display:none;"><%= request.getAttribute("success") %></div>
<% } %>
