package com.java_web.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationFilter implements Filter {

    
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/",
        "/home",
        "/login",
        "/register",
        "/logout",
        "/jobs",
        "/job",
        "/css",
        "/js",
        "/images"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        
        boolean isPublicPath = PUBLIC_PATHS.stream()
                .anyMatch(publicPath -> path.startsWith(publicPath));
        
        if (isPublicPath) {
            
            chain.doFilter(request, response);
            return;
        }
        
        
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            
            chain.doFilter(request, response);
        } else {
            
            String loginURL = contextPath + "/login";
            
            
            session = httpRequest.getSession(true);
            session.setAttribute("redirectAfterLogin", requestURI);
            
            httpResponse.sendRedirect(loginURL);
        }
    }

    @Override
    public void destroy() {
        
    }
}