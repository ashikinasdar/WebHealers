package com.utmserenityhub.service;

import com.utmserenityhub.dao.AppointmentDAO;
import com.utmserenityhub.model.Appointment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

@Service
@Transactional
public class AppointmentService {
    
    @Autowired
    private AppointmentDAO appointmentDAO;
    
    /*create a new appointment*/
    public boolean createAppointment(Appointment appointment) {
        //validate appointment date is not in the past
        Date today = new Date(System.currentTimeMillis());
        if (appointment.getAppointmentDate().before(today)) {
            return false;
        }
        
        // check if time slot is available
        if (!appointmentDAO.isTimeSlotAvailable(
                appointment.getCounselorId(), 
                appointment.getAppointmentDate(), 
                appointment.getAppointmentTime())) {
            return false;
        }
        
        int result = appointmentDAO.create(appointment);
        return result > 0;
    }
    
    /*get appointment by ID*/
    public Appointment getAppointmentById(int appointmentId) {
        return appointmentDAO.findById(appointmentId);
    }
    
    /*update appointment*/
    public boolean updateAppointment(Appointment appointment) {
        return appointmentDAO.update(appointment);
    }
    
    /*update appointment status*/
    public boolean updateAppointmentStatus(int appointmentId, Appointment.Status status) {
        return appointmentDAO.updateStatus(appointmentId, status);
    }
    
    /*approve appointment*/
    public boolean approveAppointment(int appointmentId) {
        return appointmentDAO.updateStatus(appointmentId, Appointment.Status.APPROVED);
    }
    
    /*decline appointment*/
    public boolean declineAppointment(int appointmentId) {
        return appointmentDAO.updateStatus(appointmentId, Appointment.Status.DECLINED);
    }
    
    /*complete appointment*/
    public boolean completeAppointment(int appointmentId, String counselorNotes) {
        boolean notesUpdated = appointmentDAO.updateCounselorNotes(appointmentId, counselorNotes);
        boolean statusUpdated = appointmentDAO.updateStatus(appointmentId, Appointment.Status.COMPLETED);
        return notesUpdated && statusUpdated;
    }
    
    /*cancel appointment*/
    public boolean cancelAppointment(int appointmentId) {
        return appointmentDAO.updateStatus(appointmentId, Appointment.Status.CANCELLED);
    }
    
    /*delete appointment*/
    public boolean deleteAppointment(int appointmentId) {
        return appointmentDAO.delete(appointmentId);
    }
    
    /*get student's appointments*/
    public List<Appointment> getStudentAppointments(int studentId) {
        return appointmentDAO.findByStudentId(studentId);
    }
    
    /*get counselor's appointments*/
    public List<Appointment> getCounselorAppointments(int counselorId) {
        return appointmentDAO.findByCounselorId(counselorId);
    }
    
    /*get pending appointments for counselor*/
    public List<Appointment> getPendingAppointments(int counselorId) {
        return appointmentDAO.findPendingByCounselorId(counselorId);
    }
    
    /*get upcoming appointments for student*/
    public List<Appointment> getUpcomingAppointments(int studentId, int limit) {
        return appointmentDAO.findUpcomingByStudentId(studentId, limit);
    }
    
    /*get appointments by status*/
    public List<Appointment> getAppointmentsByStatus(Appointment.Status status) {
        return appointmentDAO.findByStatus(status);
    }
    
    /*get all appointments*/
    public List<Appointment> getAllAppointments() {
        return appointmentDAO.findAll();
    }
    
    /*count student's appointments*/
    public int countStudentAppointments(int studentId) {
        return appointmentDAO.countByStudentId(studentId);
    }
    
    /*count all appointments*/
    public int countAllAppointments() {
        return appointmentDAO.countAll();
    }
    
    /*count appointments by status*/
    public int countAppointmentsByStatus(Appointment.Status status) {
        return appointmentDAO.countByStatus(status);
    }

    /*check if time slot is available*/
    public boolean isTimeSlotAvailable(int counselorId, Date date, Time time) {
        return appointmentDAO.isTimeSlotAvailable(counselorId, date, time);
    }

    /*validate appointment data*/
    public boolean validateAppointment(Appointment appointment) {
        if (appointment == null) {
            return false;
        }
        
        //check required fields
        if (appointment.getStudentId() <= 0 || appointment.getCounselorId() <= 0) {
            return false;
        }
        
        if (appointment.getAppointmentDate() == null || appointment.getAppointmentTime() == null) {
            return false;
        }
        
        // Check date is not in the past
        Date today = new Date(System.currentTimeMillis());
        if (appointment.getAppointmentDate().before(today)) {
            return false;
        }
        
        return true;
    }

    /*get appointment statistics*/
    public AppointmentStatistics getStatistics() {
        AppointmentStatistics stats = new AppointmentStatistics();
        stats.setTotalAppointments(appointmentDAO.countAll());
        stats.setPendingCount(appointmentDAO.countByStatus(Appointment.Status.PENDING));
        stats.setApprovedCount(appointmentDAO.countByStatus(Appointment.Status.APPROVED));
        stats.setCompletedCount(appointmentDAO.countByStatus(Appointment.Status.COMPLETED));
        stats.setDeclinedCount(appointmentDAO.countByStatus(Appointment.Status.DECLINED));
        stats.setCancelledCount(appointmentDAO.countByStatus(Appointment.Status.CANCELLED));
        return stats;
    }
    
    // Inner class for statistics
    public static class AppointmentStatistics {
        private int totalAppointments;
        private int pendingCount;
        private int approvedCount;
        private int completedCount;
        private int declinedCount;
        private int cancelledCount;
        
        // Getters and Setters
        public int getTotalAppointments() {
            return totalAppointments;
        }
        
        public void setTotalAppointments(int totalAppointments) {
            this.totalAppointments = totalAppointments;
        }
        
        public int getPendingCount() {
            return pendingCount;
        }
        
        public void setPendingCount(int pendingCount) {
            this.pendingCount = pendingCount;
        }
        
        public int getApprovedCount() {
            return approvedCount;
        }
        
        public void setApprovedCount(int approvedCount) {
            this.approvedCount = approvedCount;
        }
        
        public int getCompletedCount() {
            return completedCount;
        }
        
        public void setCompletedCount(int completedCount) {
            this.completedCount = completedCount;
        }
        
        public int getDeclinedCount() {
            return declinedCount;
        }
        
        public void setDeclinedCount(int declinedCount) {
            this.declinedCount = declinedCount;
        }
        
        public int getCancelledCount() {
            return cancelledCount;
        }
        
        public void setCancelledCount(int cancelledCount) {
            this.cancelledCount = cancelledCount;
        }
    }
}
