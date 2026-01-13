package com.utmserenityhub.model;

public class Counselor {
    private int counselorId;
    private int userId;
    private String specialization;
    private String qualifications;
    private String bio;
    private String availableDays;
    private String profilePicture;
    
    // For joined queries
    private String fullName;
    private String email;
    private String phone;
    
    // Constructors
    public Counselor() {}
    
    public Counselor(int userId, String specialization) {
        this.userId = userId;
        this.specialization = specialization;
    }
    
    // Getters and Setters
    public int getCounselorId() {
        return counselorId;
    }
    
    public void setCounselorId(int counselorId) {
        this.counselorId = counselorId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getSpecialization() {
        return specialization;
    }
    
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    
    public String getQualifications() {
        return qualifications;
    }
    
    public void setQualifications(String qualifications) {
        this.qualifications = qualifications;
    }
    
    public String getBio() {
        return bio;
    }
    
    public void setBio(String bio) {
        this.bio = bio;
    }
    
    public String getAvailableDays() {
        return availableDays;
    }
    
    public void setAvailableDays(String availableDays) {
        this.availableDays = availableDays;
    }
    
    public String getProfilePicture() {
        return profilePicture;
    }
    
    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
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
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    @Override
    public String toString() {
        return "Counselor{" +
                "counselorId=" + counselorId +
                ", userId=" + userId +
                ", specialization='" + specialization + '\'' +
                ", fullName='" + fullName + '\'' +
                '}';
    }
}
