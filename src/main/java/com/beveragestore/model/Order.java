package com.beveragestore.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Order model representing a customer's order.
 * Stored in the "orders" Firestore collection.
 */
public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    // Order status constants
    public static final String STATUS_PENDING = "PENDING";
    public static final String STATUS_PROCESSING = "PROCESSING";
    public static final String STATUS_SHIPPED = "SHIPPED";
    public static final String STATUS_DELIVERED = "DELIVERED";
    public static final String STATUS_CANCELLED = "CANCELLED";

    private String orderId;         // Firestore document ID
    private String userId;          // Reference to user
    private List<OrderItem> items;  // List of items in this order
    private double totalAmount;
    private String status;          // PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
    private String shippingAddress;
    private Date createdAt;
    private Date updatedAt;
    private String notes;           // Optional notes/instructions

    // Constructors
    public Order() {
        this.items = new ArrayList<>();
        this.status = STATUS_PENDING;
    }

    public Order(String orderId, String userId, List<OrderItem> items, double totalAmount, String shippingAddress) {
        this.orderId = orderId;
        this.userId = userId;
        this.items = items;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.status = STATUS_PENDING;
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public int getTotalItems() {
        if (items == null) return 0;
        return items.stream().mapToInt(OrderItem::getQuantity).sum();
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId='" + orderId + '\'' +
                ", userId='" + userId + '\'' +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", itemCount=" + getTotalItems() +
                ", createdAt=" + createdAt +
                '}';
    }

    /**
     * Nested class representing a single item within an order.
     */
    public static class OrderItem implements Serializable {
        private static final long serialVersionUID = 1L;

        private String productId;
        private String productName;
        private double unitPrice;
        private int quantity;
        private String imageUrl;

        // Constructors
        public OrderItem() {}

        public OrderItem(String productId, String productName, double unitPrice, int quantity, String imageUrl) {
            this.productId = productId;
            this.productName = productName;
            this.unitPrice = unitPrice;
            this.quantity = quantity;
            this.imageUrl = imageUrl;
        }

        // Getters and Setters
        public String getProductId() {
            return productId;
        }

        public void setProductId(String productId) {
            this.productId = productId;
        }

        public String getProductName() {
            return productName;
        }

        public void setProductName(String productName) {
            this.productName = productName;
        }

        public double getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(double unitPrice) {
            this.unitPrice = unitPrice;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }

        public double getSubtotal() {
            return unitPrice * quantity;
        }

        @Override
        public String toString() {
            return "OrderItem{" +
                    "productId='" + productId + '\'' +
                    ", productName='" + productName + '\'' +
                    ", quantity=" + quantity +
                    ", subtotal=" + getSubtotal() +
                    '}';
        }
    }
}
