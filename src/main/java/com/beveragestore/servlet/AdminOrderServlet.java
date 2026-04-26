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
import com.beveragestore.util.SessionUtil;

/**
 * Admin Order Management servlet.
 * Handles admin view of all orders and order status updates.
 */
public class AdminOrderServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AdminOrderServlet.class);
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Verify user is admin
            if (!SessionUtil.isAdmin(request.getSession())) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Get all orders
            var orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);

            request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);

        } catch (ExecutionException | InterruptedException e) {
            logger.error("Error loading orders for admin", e);
            request.setAttribute("error", "Error loading orders. Please try again.");
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

            String orderId = request.getParameter("orderId");
            String newStatus = request.getParameter("status");

            if (orderId != null && newStatus != null) {
                orderDAO.updateOrderStatus(orderId, newStatus);
                logger.info("Order status updated: {} -> {}", orderId, newStatus);
            }

            response.sendRedirect(request.getContextPath() + "/admin/orders");

        } catch (ExecutionException | InterruptedException e) {
            logger.error("Error processing order status update", e);
            request.setAttribute("error", "Error updating order. Please try again.");
            try {
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                logger.error("Error forwarding to error page", ex);
            }
        }
    }
}
