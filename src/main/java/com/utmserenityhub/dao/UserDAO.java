package com.utmserenityhub.dao;

import com.utmserenityhub.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper for User object
    private final RowMapper<User> userRowMapper = (rs, rowNum) -> {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setUserType(User.UserType.valueOf(rs.getString("user_type")));
        user.setPhone(rs.getString("phone"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        user.setActive(rs.getBoolean("is_active"));
        user.setLastLogin(rs.getTimestamp("last_login"));
        return user;
    };

    /*create a new user and return the generated ID*/
    public int create(User user) {
        String sql = "INSERT INTO users (email, password_hash, full_name, user_type, phone, is_active) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getUserType().toString());
            ps.setString(5, user.getPhone());
            ps.setBoolean(6, user.isActive());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    /*find user by email*/
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, email);
        } catch (Exception e) {
            return null;
        }
    }

    /*find user by ID*/
    public User findById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, userRowMapper, userId);
        } catch (Exception e) {
            return null;
        }
    }

    /*update user information*/
    public boolean update(User user) {
        String sql = "UPDATE users SET email = ?, full_name = ?, phone = ?, updated_at = CURRENT_TIMESTAMP " +
                    "WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, user.getEmail(), user.getFullName(), 
                                      user.getPhone(), user.getUserId());
        return rows > 0;
    }

    /*update user password*/
    public boolean updatePassword(int userId, String newPasswordHash) {
        String sql = "UPDATE users SET password_hash = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, newPasswordHash, userId);
        return rows > 0;
    }

    /*update last login timestamp*/
    public boolean updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, userId);
        return rows > 0;
    }

    /*deactivate user*/
    public boolean deactivateUser(int userId) {
        String sql = "UPDATE users SET is_active = FALSE, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, userId);
        return rows > 0;
    }

    /*activate user*/
    public boolean activateUser(int userId) {
        String sql = "UPDATE users SET is_active = TRUE, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, userId);
        return rows > 0;
    }

    /*delete user permanently*/
    public boolean delete(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql, userId);
        return rows > 0;
    }

    /*find all users*/
    public List<User> findAll() {
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, userRowMapper);
    }

    /*find users by type*/
    public List<User> findByType(User.UserType userType) {
        String sql = "SELECT * FROM users WHERE user_type = ? ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, userRowMapper, userType.toString());
    }

    /*count users by type*/
    public int countByType(User.UserType userType) {
        String sql = "SELECT COUNT(*) FROM users WHERE user_type = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, userType.toString());
    }

    /*count all users*/
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM users";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*count active users*/
    public int countActiveUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE is_active = TRUE";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*get user statistics*/
    public Map<String, Integer> getUserStatistics() {
        Map<String, Integer> stats = new HashMap<>();
        
        stats.put("totalUsers", countAll());
        stats.put("students", countByType(User.UserType.STUDENT));
        stats.put("counselors", countByType(User.UserType.COUNSELOR));
        stats.put("admins", countByType(User.UserType.ADMIN));
        stats.put("activeUsers", countActiveUsers());
        
        return stats;
    }

    /*search users by name or email*/
    public List<User> search(String keyword) {
        String sql = "SELECT * FROM users WHERE full_name LIKE ? OR email LIKE ? ORDER BY full_name";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, userRowMapper, searchPattern, searchPattern);
    }

    /*log user activity*/
    public void logActivity(int userId, String activityType, String description) {
        String sql = "INSERT INTO activity_logs (user_id, activity_type, description) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, userId, activityType, description);
    }

    /*get user's recent activities*/
    public List<Map<String, Object>> getUserActivities(int userId, int limit) {
        String sql = "SELECT * FROM activity_logs WHERE user_id = ? ORDER BY created_at DESC LIMIT ?";
        return jdbcTemplate.queryForList(sql, userId, limit);
    }

    /*get recently registered users*/
    public List<User> findRecentUsers(int limit) {
        String sql = "SELECT * FROM users ORDER BY created_at DESC LIMIT ?";
        return jdbcTemplate.query(sql, userRowMapper, limit);
    }
}
