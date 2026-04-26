package com.beveragestore.servlet;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.beveragestore.dao.ProductDAO;
import com.beveragestore.util.SessionUtil;

/**
 * Admin Product Management servlet.
 * Handles product CRUD operations (Create, Read, Update, Delete/Deactivate).
 */
public class AdminProductServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AdminProductServlet.class);
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Verify user is admin
            if (!SessionUtil.isAdmin(request.getSession())) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Get all products (including inactive ones for admin view)
            var products = productDAO.getAllProducts();
            request.setAttribute("products", products);

            request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);

        } catch (ExecutionException | InterruptedException e) {
            logger.error("Error loading products for admin", e);
            request.setAttribute("error", "Error loading products. Please try again.");
            try {
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                logger.error("Error forwarding to error page", ex);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Verify user is admin
            if (!SessionUtil.isAdmin(request.getSession())) {
                response.sendError(403, "Forbidden");
                return;
            }

            String action = request.getParameter("action");

            if ("deactivate".equals(action)) {
                String productId = request.getParameter("productId");
                productDAO.deactivateProduct(productId);
                logger.info("Product deactivated: {}", productId);
            }

            response.sendRedirect(request.getContextPath() + "/admin/products");

        } catch (ExecutionException | InterruptedException e) {
            logger.error("Error processing product action", e);
            request.setAttribute("error", "Error processing request. Please try again.");
            try {
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                logger.error("Error forwarding to error page", ex);
            }
        }
    }
}
