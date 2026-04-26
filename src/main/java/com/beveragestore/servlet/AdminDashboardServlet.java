package com.beveragestore.servlet;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.beveragestore.dao.OrderDAO;
import com.beveragestore.dao.ProductDAO;
import com.beveragestore.util.SessionUtil;

/**
 * Admin Dashboard servlet.
 * Shows dashboard statistics and admin overview.
 */
public class AdminDashboardServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AdminDashboardServlet.class);
    private OrderDAO orderDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAO();
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

            // Get dashboard statistics
            long totalOrders = orderDAO.getTotalOrdersCount();
            double totalRevenue = orderDAO.getTotalRevenue();

            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("totalRevenue", totalRevenue);

            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);

        } catch (ExecutionException | InterruptedException e) {
            logger.error("Error loading admin dashboard", e);
            request.setAttribute("error", "Error loading dashboard. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
