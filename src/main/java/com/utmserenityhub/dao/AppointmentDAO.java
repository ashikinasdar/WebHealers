package com.utmserenityhub.dao;

import com.utmserenityhub.model.Appointment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class AppointmentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Appointment> appointmentRowMapper = (rs, rowNum) -> {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointment_id"));
        appointment.setStudentId(rs.getInt("student_id"));
        appointment.setCounselorId(rs.getInt("counselor_id"));
        appointment.setAppointmentDate(rs.getDate("appointment_date"));
        appointment.setAppointmentTime(rs.getTime("appointment_time"));
        appointment.setSessionType(Appointment.SessionType.valueOf(rs.getString("session_type")));
        appointment.setStatus(Appointment.Status.valueOf(rs.getString("status")));
        appointment.setReason(rs.getString("reason"));
        appointment.setNotes(rs.getString("notes"));
        appointment.setCounselorNotes(rs.getString("counselor_notes"));
        appointment.setCreatedAt(rs.getTimestamp("created_at"));
        appointment.setUpdatedAt(rs.getTimestamp("updated_at"));

        try {
            appointment.setStudentName(rs.getString("student_name"));
            appointment.setStudentEmail(rs.getString("student_email"));
            appointment.setCounselorName(rs.getString("counselor_name"));
            appointment.setCounselorSpecialization(rs.getString("counselor_specialization"));
        } catch (Exception e) {
            // columns may not exist
        }

        return appointment;
    };

    /*create new appointment*/
    public int create(Appointment appointment) {
        String sql = "INSERT INTO appointments (student_id, counselor_id, appointment_date, " +
                "appointment_time, session_type, status, reason, notes) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, appointment.getStudentId());
            ps.setInt(2, appointment.getCounselorId());
            ps.setDate(3, appointment.getAppointmentDate());
            ps.setTime(4, appointment.getAppointmentTime());
            ps.setString(5, appointment.getSessionType().toString());
            ps.setString(6, appointment.getStatus().toString());
            ps.setString(7, appointment.getReason());
            ps.setString(8, appointment.getNotes());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    /*find appointment by id*/
    public Appointment findById(int appointmentId) {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "WHERE a.appointment_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, appointmentRowMapper, appointmentId);
        } catch (Exception e) {
            return null;
        }
    }

    /*update appointment*/
    public boolean update(Appointment appointment) {
        String sql = "UPDATE appointments SET counselor_id = ?, appointment_date = ?, " +
                "appointment_time = ?, session_type = ?, reason = ?, notes = ? " +
                "WHERE appointment_id = ?";
        int rows = jdbcTemplate.update(sql,
                appointment.getCounselorId(),
                appointment.getAppointmentDate(),
                appointment.getAppointmentTime(),
                appointment.getSessionType().toString(),
                appointment.getReason(),
                appointment.getNotes(),
                appointment.getAppointmentId());
        return rows > 0;
    }

    /*update appointment status*/
    public boolean updateStatus(int appointmentId, Appointment.Status status) {
        String sql = "UPDATE appointments SET status = ?, updated_at = CURRENT_TIMESTAMP " +
                "WHERE appointment_id = ?";
        int rows = jdbcTemplate.update(sql, status.toString(), appointmentId);
        return rows > 0;
    }

    /*update counselor notes*/
    public boolean updateCounselorNotes(int appointmentId, String notes) {
        String sql = "UPDATE appointments SET counselor_notes = ?, updated_at = CURRENT_TIMESTAMP " +
                "WHERE appointment_id = ?";
        int rows = jdbcTemplate.update(sql, notes, appointmentId);
        return rows > 0;
    }

    /*delete appointments*/
    public boolean delete(int appointmentId) {
        String sql = "DELETE FROM appointments WHERE appointment_id = ?";
        int rows = jdbcTemplate.update(sql, appointmentId);
        return rows > 0;
    }

    /*get student's appointments*/
    public List<Appointment> findByStudentId(int studentId) {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "WHERE a.student_id = ? " +
                "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        return jdbcTemplate.query(sql, appointmentRowMapper, studentId);
    }

    /*get counselor's appointments*/
    public List<Appointment> findByCounselorId(int counselorId) {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "WHERE a.counselor_id = ? " +
                "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        return jdbcTemplate.query(sql, appointmentRowMapper, counselorId);
    }

    /*get appointments by status*/
    public List<Appointment> findByStatus(Appointment.Status status) {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "WHERE a.status = ? " +
                "ORDER BY a.appointment_date, a.appointment_time";
        return jdbcTemplate.query(sql, appointmentRowMapper, status.toString());
    }

    /*get pending appointments for counselor*/
    public List<Appointment> findPendingByCounselorId(int counselorId) {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "WHERE a.counselor_id = ? AND a.status = 'PENDING' " +
                "ORDER BY a.created_at DESC";
        return jdbcTemplate.query(sql, appointmentRowMapper, counselorId);
    }

    /*get upcoming appointments for student*/
    public List<Appointment> findUpcomingByStudentId(int studentId, int limit) {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "WHERE a.student_id = ? " +
                "AND a.appointment_date >= CURDATE() " +
                "AND a.status IN ('PENDING', 'APPROVED') " +
                "ORDER BY a.appointment_date, a.appointment_time " +
                "LIMIT ?";
        return jdbcTemplate.query(sql, appointmentRowMapper, studentId, limit);
    }

    /*get all appointments*/
    public List<Appointment> findAll() {
        String sql = "SELECT a.*, " +
                "u1.full_name as student_name, u1.email as student_email, " +
                "u2.full_name as counselor_name, c.specialization as counselor_specialization " +
                "FROM appointments a " +
                "INNER JOIN students s ON a.student_id = s.student_id " +
                "INNER JOIN users u1 ON s.user_id = u1.user_id " +
                "INNER JOIN counselors c ON a.counselor_id = c.counselor_id " +
                "INNER JOIN users u2 ON c.user_id = u2.user_id " +
                "ORDER BY a.created_at DESC";
        return jdbcTemplate.query(sql, appointmentRowMapper);
    }

    /*count appointments by student*/
    public int countByStudentId(int studentId) {
        String sql = "SELECT COUNT(*) FROM appointments WHERE student_id = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, studentId);
    }

    /*count all appointments*/
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM appointments";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*count appointments by status*/
    public int countByStatus(Appointment.Status status) {
        String sql = "SELECT COUNT(*) FROM appointments WHERE status = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, status.toString());
    }

    /*check if time slot is available for counselor*/
    public boolean isTimeSlotAvailable(int counselorId, Date date, java.sql.Time time) {
        String sql = "SELECT COUNT(*) FROM appointments " +
                "WHERE counselor_id = ? AND appointment_date = ? AND appointment_time = ? " +
                "AND status NOT IN ('DECLINED', 'CANCELLED')";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, counselorId, date, time);
        return count == 0;
    }
}
