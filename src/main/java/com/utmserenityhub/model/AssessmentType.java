package com.utmserenityhub.model;

public class AssessmentType {
    private int assessmentTypeId;
    private String name;
    private String description;
    private int totalQuestions;
    private String scoringMethod;
    private boolean isActive;
    
    public AssessmentType() {
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getAssessmentTypeId() {
        return assessmentTypeId;
    }
    
    public void setAssessmentTypeId(int assessmentTypeId) {
        this.assessmentTypeId = assessmentTypeId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getTotalQuestions() {
        return totalQuestions;
    }
    
    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }
    
    public String getScoringMethod() {
        return scoringMethod;
    }
    
    public void setScoringMethod(String scoringMethod) {
        this.scoringMethod = scoringMethod;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
}