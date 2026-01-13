package com.utmserenityhub.dao;

import com.utmserenityhub.model.Counselor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class CounselorDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper for Counselor with User info
    private final RowMapper<Counselor> counselorRowMapper = (rs, rowNum) -> {
        Counselor counselor = new Counselor();
        counselor.setCounselorId(rs.getInt("counselor_id"));
        counselor.setUserId(rs.getInt("user_id"));
        counselor.setSpecialization(rs.getString("specialization"));
        counselor.setQualifications(rs.getString("qualifications"));
        counselor.setBio(rs.getString("bio"));
        counselor.setAvailableDays(rs.getString("available_days"));
        counselor.setProfilePicture(rs.getString("profile_picture"));
        
        // user information (if joined)
        try {
            counselor.setFullName(rs.getString("full_name"));
            counselor.setEmail(rs.getString("email"));
            counselor.setPhone(rs.getString("phone"));
        } catch (Exception e) {
            // columns may not exist
        }
        
        return counselor;
    };
    
    /*create new counselor profile*/
    public int create(Counselor counselor) {
        String sql = "INSERT INTO counselors (user_id, specialization, qualifications, bio, available_days) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, counselor.getUserId());
            ps.setString(2, counselor.getSpecialization());
            ps.setString(3, counselor.getQualifications());
            ps.setString(4, counselor.getBio());
            ps.setString(5, counselor.getAvailableDays());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    /*find counselor by ID*/
    public Counselor findById(int counselorId) {
        String sql = "SELECT c.*, u.full_name, u.email, u.phone FROM counselors c " +
                    "INNER JOIN users u ON c.user_id = u.user_id " +
                    "WHERE c.counselor_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, counselorRowMapper, counselorId);
        } catch (Exception e) {
            return null;
        }
    }

    /*find counselor by user ID*/
    public Counselor findByUserId(int userId) {
        String sql = "SELECT c.*, u.full_name, u.email, u.phone FROM counselors c " +
                    "INNER JOIN users u ON c.user_id = u.user_id " +
                    "WHERE c.user_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, counselorRowMapper, userId);
        } catch (Exception e) {
            return null;
        }
    }

    /*update counselor profile*/
    public boolean update(Counselor counselor) {
        String sql = "UPDATE counselors SET specialization = ?, qualifications = ?, " +
                    "bio = ?, available_days = ?, profile_picture = ? " +
                    "WHERE counselor_id = ?";
        int rows = jdbcTemplate.update(sql, 
            counselor.getSpecialization(),
            counselor.getQualifications(),
            counselor.getBio(),
            counselor.getAvailableDays(),
            counselor.getProfilePicture(),
            counselor.getCounselorId()
        );
        return rows > 0;
    }

    /*update counselor by user ID*/
    public boolean updateByUserId(Counselor counselor) {
        String sql = "UPDATE counselors SET specialization = ?, qualifications = ?, " +
                    "bio = ?, available_days = ? " +
                    "WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, 
            counselor.getSpecialization(),
            counselor.getQualifications(),
            counselor.getBio(),
            counselor.getAvailableDays(),
            counselor.getUserId()
        );
        return rows > 0;
    }

    /*delete counselor profile*/
    public boolean delete(int counselorId) {
        String sql = "DELETE FROM counselors WHERE counselor_id = ?";
        int rows = jdbcTemplate.update(sql, counselorId);
        return rows > 0;
    }

    /*get all counselors*/
    public List<Counselor> findAll() {
        String sql = "SELECT c.*, u.full_name, u.email, u.phone FROM counselors c " +
                    "INNER JOIN users u ON c.user_id = u.user_id " +
                    "WHERE u.is_active = TRUE " +
                    "ORDER BY u.full_name";
        return jdbcTemplate.query(sql, counselorRowMapper);
    }

    /*get counselors by specialization*/
    public List<Counselor> findBySpecialization(String specialization) {
        String sql = "SELECT c.*, u.full_name, u.email, u.phone FROM counselors c " +
                    "INNER JOIN users u ON c.user_id = u.user_id " +
                    "WHERE c.specialization = ? AND u.is_active = TRUE " +
                    "ORDER BY u.full_name";
        return jdbcTemplate.query(sql, counselorRowMapper, specialization);
    }

    /*count all counselors*/
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM counselors";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*get available counselors (active users)*/
    public List<Counselor> findAvailable() {
        String sql = "SELECT c.*, u.full_name, u.email, u.phone FROM counselors c " +
                    "INNER JOIN users u ON c.user_id = u.user_id " +
                    "WHERE u.is_active = TRUE " +
                    "ORDER BY u.full_name";
        return jdbcTemplate.query(sql, counselorRowMapper);
    }

    /*search counselors*/
    public List<Counselor> search(String keyword) {
        String sql = "SELECT c.*, u.full_name, u.email, u.phone FROM counselors c " +
                    "INNER JOIN users u ON c.user_id = u.user_id " +
                    "WHERE (u.full_name LIKE ? OR c.specialization LIKE ?) " +
                    "AND u.is_active = TRUE " +
                    "ORDER BY u.full_name";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, counselorRowMapper, searchPattern, searchPattern);
    }
}