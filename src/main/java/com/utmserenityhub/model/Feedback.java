package com.utmserenityhub.model;

public class Feedback {
    private Long id;
    private String username;
    private String title;
    private String category;
    private String message;
    private boolean resolved;

    public Feedback() {}

    public Feedback(String username, String title, String category, String message) {
        this.username = username;
        this.title = title;
        this.category = category;
        this.message = message;
        this.resolved = false;
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public boolean isResolved() { return resolved; }
    public void setResolved(boolean resolved) { this.resolved = resolved; }
}