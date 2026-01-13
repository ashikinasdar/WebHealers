package com.utmserenityhub.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Appointment {
    private int appointmentId;
    private int studentId;
    private int counselorId;
    private Date appointmentDate;
    private Time appointmentTime;
    private SessionType sessionType;
    private Status status;
    private String reason;
    private String notes;
    private String counselorNotes;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // For joined queries
    private String studentName;
    private String studentEmail;
    private String counselorName;
    private String counselorSpecialization;
    
    // Enums
    public enum SessionType {
        IN_PERSON, ONLINE, PHONE
    }
    
    public enum Status {
        PENDING, APPROVED, DECLINED, COMPLETED, CANCELLED
    }
    
    // Constructors
    public Appointment() {
        this.status = Status.PENDING;
    }
    
    // Getters and Setters
    public int getAppointmentId() {
        return appointmentId;
    }
    
    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getCounselorId() {
        return counselorId;
    }
    
    public void setCounselorId(int counselorId) {
        this.counselorId = counselorId;
    }
    
    public Date getAppointmentDate() {
        return appointmentDate;
    }
    
    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }
    
    public Time getAppointmentTime() {
        return appointmentTime;
    }
    
    public void setAppointmentTime(Time appointmentTime) {
        this.appointmentTime = appointmentTime;
    }
    
    public SessionType getSessionType() {
        return sessionType;
    }
    
    public void setSessionType(SessionType sessionType) {
        this.sessionType = sessionType;
    }
    
    public Status getStatus() {
        return status;
    }
    
    public void setStatus(Status status) {
        this.status = status;
    }
    
    public String getReason() {
        return reason;
    }
    
    public void setReason(String reason) {
        this.reason = reason;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public String getCounselorNotes() {
        return counselorNotes;
    }
    
    public void setCounselorNotes(String counselorNotes) {
        this.counselorNotes = counselorNotes;
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
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getStudentEmail() {
        return studentEmail;
    }
    
    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }
    
    public String getCounselorName() {
        return counselorName;
    }
    
    public void setCounselorName(String counselorName) {
        this.counselorName = counselorName;
    }
    
    public String getCounselorSpecialization() {
        return counselorSpecialization;
    }
    
    public void setCounselorSpecialization(String counselorSpecialization) {
        this.counselorSpecialization = counselorSpecialization;
    }
    
    @Override
    public String toString() {
        return "Appointment{" +
                "appointmentId=" + appointmentId +
                ", studentId=" + studentId +
                ", counselorId=" + counselorId +
                ", appointmentDate=" + appointmentDate +
                ", appointmentTime=" + appointmentTime +
                ", status=" + status +
                '}';
    }
}
