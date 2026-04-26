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
            
            <a href="${pageContext.request.contextPath}/customer/cart" title="Cart">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
            </a>

            <% if (currentUser != null) { %>
                <div class="user-menu">
                    <div class="avatar-container" onclick="toggleDropdown()">
                        <% if (currentUser.getPhotoUrl() != null && !currentUser.getPhotoUrl().isEmpty()) { %>
                            <img src="<%= currentUser.getPhotoUrl() %>" alt="User Avatar" class="user-avatar">
                        <% } else { %>
                            <div class="default-avatar"><%= currentUser.getFullName() != null && !currentUser.getFullName().isEmpty() ? currentUser.getFullName().substring(0, 1).toUpperCase() : "U" %></div>
                        <% } %>
                    </div>
                    <div class="dropdown-menu" id="userDropdown">
                        <div class="dropdown-header">
                            <strong style="display:block; font-size: 14px;"><%= currentUser.getFullName() != null ? currentUser.getFullName() : currentUser.getEmail() %></strong>
                            <span style="display:block; font-size:12px; color:var(--text-secondary); text-transform:uppercase; margin-top:4px;"><%= currentUser.getRole() %></span>
                        </div>
                        <hr>
                        <% if (currentUser.isAdmin() || currentUser.isShopOwner() || currentUser.isShipper()) { %>
                            <a href="${pageContext.request.contextPath}/admin/dashboard">🛠️ Dashboard</a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/customer/orders">📦 My Orders</a>
                        <hr>
                        <a href="${pageContext.request.contextPath}/logout" style="color: var(--error-text);">🚪 Logout</a>
                    </div>
                </div>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login" title="Login" style="margin-left: 10px;">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
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

<script>
function toggleDropdown() {
    document.getElementById("userDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
    if (!event.target.matches('.user-avatar') && !event.target.matches('.default-avatar') && !event.target.closest('.avatar-container')) {
        var dropdowns = document.getElementsByClassName("dropdown-menu");
        for (var i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains('show')) {
                openDropdown.classList.remove('show');
            }
        }
    }
}
</script>
