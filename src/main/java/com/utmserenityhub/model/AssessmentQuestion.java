package com.utmserenityhub.model;

public class AssessmentQuestion {
    private int assessmentQuestionId;
    private int assessmentTypeId;
    private String questionText;
    private String category;  // Depression, Anxiety, Stress
    private int displayOrder;
    
    // Constructors
    public AssessmentQuestion() {}
    
    // Getters and Setters
    public int getAssessmentQuestionId() {
        return assessmentQuestionId;
    }
    
    public void setAssessmentQuestionId(int assessmentQuestionId) {
        this.assessmentQuestionId = assessmentQuestionId;
    }
    
    public int getAssessmentTypeId() {
        return assessmentTypeId;
    }
    
    public void setAssessmentTypeId(int assessmentTypeId) {
        this.assessmentTypeId = assessmentTypeId;
    }
    
    public String getQuestionText() {
        return questionText;
    }
    
    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public int getDisplayOrder() {
        return displayOrder;
    }
    
    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }
    
    @Override
    public String toString() {
        return "AssessmentQuestion{" +
                "assessmentQuestionId=" + assessmentQuestionId +
                ", category='" + category + '\'' +
                ", questionText='" + questionText + '\'' +
                '}';
    }
}