package com.beveragestore.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Product model representing a beverage product.
 * Stored in the "products" Firestore collection.
 */
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private String productId;       // Firestore document ID
    private String name;
    private String category;        // e.g., "Water", "Soft Drinks", "Coffee", "Juice", "Tea", "Alcohol", "Energy Drinks"
    private String brand;
    private String description;
    private double price;
    private int stock;              // Available quantity
    private String imageUrl;        // URL to product image
    private boolean isActive;       // Soft delete
    private Date createdAt;
    private Date updatedAt;

    // Constructors
    public Product() {}

    public Product(String productId, String name, String category, String brand, String description,
                   double price, int stock, String imageUrl, boolean isActive) {
        this.productId = productId;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.imageUrl = imageUrl;
        this.isActive = isActive;
        this.createdAt = new Date();
        this.updatedAt = new Date();
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
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

    public boolean isLowStock() {
        return stock < 10;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId='" + productId + '\'' +
                ", name='" + name + '\'' +
                ", category='" + category + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", isActive=" + isActive +
                '}';
    }
}
