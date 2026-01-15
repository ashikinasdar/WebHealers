package com.utmserenityhub.model;

import java.time.LocalDateTime;

public class ForumThread {
    private int threadId;
    private String title;
    private String content;
    private int studentId;
    private boolean isAnonymous;
    private boolean isActive = true;
    private int likesCount = 0;
    private int repliesCount = 0;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String authorName;
    
    // Getters that match your JSP ${thread.xxx}
    public int getThread_id() { return threadId; }
    public void setThread_id(int threadId) { this.threadId = threadId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public int getStudent_id() { return studentId; }
    public void setStudent_id(int studentId) { this.studentId = studentId; }
    
    public boolean getIs_anonymous() { return isAnonymous; }
    public void setIs_anonymous(boolean isAnonymous) { this.isAnonymous = isAnonymous; }
    
    public boolean getIs_active() { return isActive; }
    public void setIs_active(boolean isActive) { this.isActive = isActive; }
    
    public int getLikes_count() { return likesCount; }
    public void setLikes_count(int likesCount) { this.likesCount = likesCount; }
    
    public int getReplies_count() { return repliesCount; }
    public void setReplies_count(int repliesCount) { this.repliesCount = repliesCount; }
    
    public LocalDateTime getCreated_at() { return createdAt; }
    public void setCreated_at(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdated_at() { return updatedAt; }
    public void setUpdated_at(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public String getAuthor_name() { return authorName; }
    public void setAuthor_name(String authorName) { this.authorName = authorName; }
}