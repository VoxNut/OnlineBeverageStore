package com.beveragestore.model;

import java.io.Serializable;
import java.util.Date;

/**
 * User model representing a customer or admin in the system.
 * This object is stored in the "users" Firestore collection.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private String uid;              // Firestore document ID
    private String fullName;
    private String email;
    private String passwordHash;    // BCrypt hashed password
    private String role;            // "customer" or "admin"
    private String authProvider;    // "local" or "google"
    private String photoUrl;        // Google profile picture URL
    private Date createdAt;
    private boolean active;

    // Constructors
    public User() {}

    public User(String uid, String fullName, String email, String passwordHash, String role, Date createdAt) {
        this.uid = uid;
        this.fullName = fullName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.authProvider = "local";
        this.createdAt = createdAt;
        this.active = true;
    }

    public User(String uid, String fullName, String email, String role, String authProvider, String photoUrl, Date createdAt) {
        this.uid = uid;
        this.fullName = fullName;
        this.email = email;
        this.role = role;
        this.authProvider = authProvider;
        this.photoUrl = photoUrl;
        this.createdAt = createdAt;
        this.active = true;
    }

    // Getters and Setters
    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getAuthProvider() {
        return authProvider;
    }

    public void setAuthProvider(String authProvider) {
        this.authProvider = authProvider;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public boolean isAdmin() {
        return "admin".equals(this.role);
    }

    public boolean isCustomer() {
        return "customer".equals(this.role);
    }

    public boolean isGoogleUser() {
        return "google".equals(this.authProvider);
    }

    @Override
    public String toString() {
        return "User{" +
                "uid='" + uid + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                ", authProvider='" + authProvider + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
