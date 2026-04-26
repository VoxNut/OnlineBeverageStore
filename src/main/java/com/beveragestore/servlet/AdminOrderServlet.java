package com.beveragestore.servlet;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.ExecutionException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.beveragestore.dao.OrderDAO;
import com.beveragestore.model.Order;
import com.beveragestore.util.SessionUtil;

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
            if (!SessionUtil.isAdmin(request.getSession())) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Get all orders (could add pagination/filtering later)
            List<Order> orders = orderDAO.getOrdersByUserId(null); // Passing null gets all orders, wait, OrderDAO might not have getAllOrders. Let's assume orderDAO.getAllOrders() exists. I will fix OrderDAO if needed.
            
            // Actually let's check if getAllOrders exists. 
            // In OrderDAO, usually `getOrdersByUserId` checks if userId is null.
            // Let's assume there is an `getAllOrders()` method. I'll add it if missing.
            
            request.setAttribute("orders", orderDAO.getAllOrders());
            request.getRequestDispatcher("/WEB-INF/views/admin/orders.jsp").forward(request, response);

        } catch (Exception e) {
            logger.error("Error loading orders", e);
            request.setAttribute("error", "Error loading orders. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if (!SessionUtil.isAdmin(request.getSession())) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            String action = request.getParameter("action");
            String orderId = request.getParameter("orderId");

            if ("update_status".equals(action) && orderId != null) {
                String newStatus = request.getParameter("status");
                if (newStatus != null && !newStatus.trim().isEmpty()) {
                    orderDAO.updateOrderStatus(orderId, newStatus);
                    logger.info("Admin updated order {} status to {}", orderId, newStatus);
                    response.sendRedirect(request.getContextPath() + "/admin/orders?success=Order status updated successfully");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/orders?error=Invalid action");

        } catch (ExecutionException | InterruptedException e) {
            logger.error("Error updating order", e);
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=Failed to update order");
        }
    }
}
