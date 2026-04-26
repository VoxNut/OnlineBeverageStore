package com.beveragestore.model;

import java.io.Serializable;

/**
 * CartItem model representing a product in the user's cart.
 * Stored in the "cart" subcollection under each user's document.
 * Accessed via: db.collection("cart").document(userId).collection("items").document(productId)
 */
public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private String productId;
    private String name;
    private double price;
    private int quantity;
    private String imageUrl;
    private long addedAt;           // Timestamp when added to cart

    // Constructors
    public CartItem() {}

    public CartItem(String productId, String name, double price, int quantity, String imageUrl) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
        this.addedAt = System.currentTimeMillis();
    }

    // Getters and Setters
    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
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

    public long getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(long addedAt) {
        this.addedAt = addedAt;
    }

    /**
     * Calculate subtotal for this item (price * quantity)
     */
    public double getSubtotal() {
        return price * quantity;
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "productId='" + productId + '\'' +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", subtotal=" + getSubtotal() +
                '}';
    }
}
