package com.utmserenityhub.model;

import java.sql.Timestamp;

public class ModuleProgress {
    private int progressId;
    private int studentId;
    private int moduleId;
    private Status status;
    private double progressPercentage;
    private Timestamp startedAt;
    private Timestamp completedAt;
    private Timestamp lastAccessed;
    
    // For joined queries
    private String moduleTitle;
    private String moduleCategory;
    
    // Enum for progress status
    public enum Status {
        NOT_STARTED, IN_PROGRESS, COMPLETED
    }
    
    // Constructors
    public ModuleProgress() {
        this.status = Status.NOT_STARTED;
        this.progressPercentage = 0.0;
    }
    
    public ModuleProgress(int studentId, int moduleId) {
        this.studentId = studentId;
        this.moduleId = moduleId;
        this.status = Status.NOT_STARTED;
        this.progressPercentage = 0.0;
    }
    
    // Getters and Setters
    public int getProgressId() {
        return progressId;
    }
    
    public void setProgressId(int progressId) {
        this.progressId = progressId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getModuleId() {
        return moduleId;
    }
    
    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
    public double getProgressPercentage() {
        return progressPercentage;
    }
    
    public void setProgressPercentage(double progressPercentage) {
        this.progressPercentage = progressPercentage;
        
        // Auto-update status based on percentage
        if (progressPercentage == 0) {
            this.status = Status.NOT_STARTED;
        } else if (progressPercentage >= 100) {
            this.status = Status.COMPLETED;
        } else {
            this.status = Status.IN_PROGRESS;
        }
    }
    
    public Timestamp getStartedAt() {
        return startedAt;
    }
    
    public void setStartedAt(Timestamp startedAt) {
        this.startedAt = startedAt;
    }
    
    public Timestamp getCompletedAt() {
        return completedAt;
    }
    
    public void setCompletedAt(Timestamp completedAt) {
        this.completedAt = completedAt;
    }
    
    public Timestamp getLastAccessed() {
        return lastAccessed;
    }
    
    public void setLastAccessed(Timestamp lastAccessed) {
        this.lastAccessed = lastAccessed;
    }
    
    public String getModuleTitle() {
        return moduleTitle;
    }
    
    public void setModuleTitle(String moduleTitle) {
        this.moduleTitle = moduleTitle;
    }
    
    public String getModuleCategory() {
        return moduleCategory;
    }
    
    public void setModuleCategory(String moduleCategory) {
        this.moduleCategory = moduleCategory;
    }
    
    @Override
    public String toString() {
        return "ModuleProgress{" +
                "progressId=" + progressId +
                ", studentId=" + studentId +
                ", moduleId=" + moduleId +
                ", status=" + status +
                ", progressPercentage=" + progressPercentage +
                '}';
    }
}
