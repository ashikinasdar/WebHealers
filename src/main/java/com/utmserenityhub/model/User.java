package com.utmserenityhub.model;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String email;
    private String passwordHash;
    private String fullName;
    private UserType userType;
    private String phone;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isActive;
    private Timestamp lastLogin;
    
    // Enum for user types
    public enum UserType {
        STUDENT, COUNSELOR, ADMIN
    }
    
    // Constructors
    public User() {}
    
    public User(String email, String passwordHash, String fullName, UserType userType) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.userType = userType;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
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
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public UserType getUserType() {
        return userType;
    }
    
    public void setUserType(UserType userType) {
        this.userType = userType;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public Timestamp getLastLogin() {
        return lastLogin;
    }
    
    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", userType=" + userType +
                ", isActive=" + isActive +
                '}';
    }
}
