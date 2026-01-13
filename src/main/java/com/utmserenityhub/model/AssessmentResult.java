package com.utmserenityhub.model;

import java.sql.Timestamp;

public class AssessmentResult {
    private int resultId;
    private int studentId;
    private int assessmentTypeId;
    private int depressionScore;
    private int anxietyScore;
    private int stressScore;
    private Severity overallSeverity;
    private String recommendations;
    private Timestamp attemptedAt;
    
    // For joined queries
    private String assessmentName;
    private String studentName;
    
    public enum Severity {
        NORMAL, MILD, MODERATE, SEVERE, EXTREMELY_SEVERE
    }
    
    // Constructors
    public AssessmentResult() {}
    
    // Getters and Setters
    public int getResultId() {
        return resultId;
    }
    
    public void setResultId(int resultId) {
        this.resultId = resultId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getAssessmentTypeId() {
        return assessmentTypeId;
    }
    
    public void setAssessmentTypeId(int assessmentTypeId) {
        this.assessmentTypeId = assessmentTypeId;
    }
    
    public int getDepressionScore() {
        return depressionScore;
    }
    
    public void setDepressionScore(int depressionScore) {
        this.depressionScore = depressionScore;
    }
    
    public int getAnxietyScore() {
        return anxietyScore;
    }
    
    public void setAnxietyScore(int anxietyScore) {
        this.anxietyScore = anxietyScore;
    }
    
    public int getStressScore() {
        return stressScore;
    }
    
    public void setStressScore(int stressScore) {
        this.stressScore = stressScore;
    }
    
    public Severity getOverallSeverity() {
        return overallSeverity;
    }
    
    public void setOverallSeverity(Severity overallSeverity) {
        this.overallSeverity = overallSeverity;
    }
    
    public String getRecommendations() {
        return recommendations;
    }
    
    public void setRecommendations(String recommendations) {
        this.recommendations = recommendations;
    }
    
    public Timestamp getAttemptedAt() {
        return attemptedAt;
    }
    
    public void setAttemptedAt(Timestamp attemptedAt) {
        this.attemptedAt = attemptedAt;
    }
    
    public String getAssessmentName() {
        return assessmentName;
    }
    
    public void setAssessmentName(String assessmentName) {
        this.assessmentName = assessmentName;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    @Override
    public String toString() {
        return "AssessmentResult{" +
                "resultId=" + resultId +
                ", studentId=" + studentId +
                ", depressionScore=" + depressionScore +
                ", anxietyScore=" + anxietyScore +
                ", stressScore=" + stressScore +
                ", overallSeverity=" + overallSeverity +
                '}';
    }
}
