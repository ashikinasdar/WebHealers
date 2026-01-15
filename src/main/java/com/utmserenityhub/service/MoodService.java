package com.utmserenityhub.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class MoodService {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    /**
     * Create a new mood check-in
     */
    public int createMoodCheckin(int studentId, int moodRating, String notes) {
        String sql = "INSERT INTO mood_checkins (student_id, mood_rating, notes, checkin_date, checkin_time) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();
        
        jdbcTemplate.update(sql, studentId, moodRating, notes, today, now);
        
        return jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
    }
    
    /**
     * Check if student has already checked in today
     */
    public boolean hasCheckedInToday(int studentId) {
        String sql = "SELECT COUNT(*) FROM mood_checkins " +
                    "WHERE student_id = ? AND checkin_date = CURDATE()";
        
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, studentId);
        return count > 0;
    }
    
    /**
     * Get today's mood check-in for a student
     */
    public Map<String, Object> getTodayCheckin(int studentId) {
        String sql = "SELECT * FROM mood_checkins " +
                    "WHERE student_id = ? AND checkin_date = CURDATE()";
        try {
            return jdbcTemplate.queryForMap(sql, studentId);
        } catch (Exception e) {
            return null;
        }
    }
    
    /**
     * Get mood history for a student (last N days)
     */
    public List<Map<String, Object>> getMoodHistory(int studentId, int days) {
        String sql = "SELECT * FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "AND checkin_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                    "ORDER BY checkin_date DESC, checkin_time DESC";
        
        return jdbcTemplate.queryForList(sql, studentId, days);
    }
    
    /**
     * Get all mood check-ins for a student
     */
    public List<Map<String, Object>> getAllMoodCheckins(int studentId) {
        String sql = "SELECT * FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "ORDER BY checkin_date DESC, checkin_time DESC";
        
        return jdbcTemplate.queryForList(sql, studentId);
    }
    
    /**
     * Get mood check-ins by date range
     */
    public List<Map<String, Object>> getMoodCheckinsByDateRange(int studentId, String startDate, String endDate) {
        String sql = "SELECT * FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "AND checkin_date BETWEEN ? AND ? " +
                    "ORDER BY checkin_date DESC, checkin_time DESC";
        
        return jdbcTemplate.queryForList(sql, studentId, startDate, endDate);
    }
    
    /**
     * Get average mood rating for a student
     */
    public Double getAverageMood(int studentId) {
        String sql = "SELECT AVG(mood_rating) FROM mood_checkins WHERE student_id = ?";
        return jdbcTemplate.queryForObject(sql, Double.class, studentId);
    }
    
    /**
     * Get average mood for last N days
     */
    public Double getAverageMoodForPeriod(int studentId, int days) {
        String sql = "SELECT AVG(mood_rating) FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "AND checkin_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY)";
        
        return jdbcTemplate.queryForObject(sql, Double.class, studentId, days);
    }
    
    /**
     * Get mood distribution (count of each rating)
     */
    public List<Map<String, Object>> getMoodDistribution(int studentId) {
        String sql = "SELECT mood_rating, COUNT(*) as count " +
                    "FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "GROUP BY mood_rating " +
                    "ORDER BY mood_rating";
        
        return jdbcTemplate.queryForList(sql, studentId);
    }
    
    /**
     * Get mood distribution for last N days
     */
    public List<Map<String, Object>> getMoodDistributionForPeriod(int studentId, int days) {
        String sql = "SELECT mood_rating, COUNT(*) as count " +
                    "FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "AND checkin_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                    "GROUP BY mood_rating " +
                    "ORDER BY mood_rating";
        
        return jdbcTemplate.queryForList(sql, studentId, days);
    }
    
    /**
     * Get total check-in count for a student
     */
    public int getTotalCheckinCount(int studentId) {
        String sql = "SELECT COUNT(*) FROM mood_checkins WHERE student_id = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, studentId);
    }
    
    /**
     * Get check-in streak (consecutive days)
     */
    public int getCheckinStreak(int studentId) {
        String sql = "SELECT checkin_date FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "GROUP BY checkin_date " +
                    "ORDER BY checkin_date DESC";
        
        List<Map<String, Object>> checkins = jdbcTemplate.queryForList(sql, studentId);
        
        if (checkins.isEmpty()) {
            return 0;
        }
        
        int streak = 0;
        LocalDate expectedDate = LocalDate.now();
        
        for (Map<String, Object> checkin : checkins) {
            java.sql.Date sqlDate = (java.sql.Date) checkin.get("checkin_date");
            LocalDate checkinDate = sqlDate.toLocalDate();
            
            if (checkinDate.equals(expectedDate)) {
                streak++;
                expectedDate = expectedDate.minusDays(1);
            } else {
                break;
            }
        }
        
        return streak;
    }
    
    /**
     * Update a mood check-in
     */
    public boolean updateMoodCheckin(int checkinId, int moodRating, String notes) {
        String sql = "UPDATE mood_checkins SET mood_rating = ?, notes = ? WHERE checkin_id = ?";
        int rows = jdbcTemplate.update(sql, moodRating, notes, checkinId);
        return rows > 0;
    }
    
    /**
     * Delete a mood check-in
     */
    public boolean deleteMoodCheckin(int checkinId) {
        String sql = "DELETE FROM mood_checkins WHERE checkin_id = ?";
        int rows = jdbcTemplate.update(sql, checkinId);
        return rows > 0;
    }
    
    /**
     * Get most common mood
     */
    public Integer getMostCommonMood(int studentId) {
        String sql = "SELECT mood_rating FROM mood_checkins " +
                    "WHERE student_id = ? " +
                    "GROUP BY mood_rating " +
                    "ORDER BY COUNT(*) DESC " +
                    "LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, Integer.class, studentId);
        } catch (Exception e) {
            return null;
        }
    }
    
    /**
     * Get mood trend (last 7 days vs previous 7 days)
     */
    public Map<String, Object> getMoodTrend(int studentId) {
        String sql1 = "SELECT AVG(mood_rating) FROM mood_checkins " +
                     "WHERE student_id = ? " +
                     "AND checkin_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
        
        String sql2 = "SELECT AVG(mood_rating) FROM mood_checkins " +
                     "WHERE student_id = ? " +
                     "AND checkin_date >= DATE_SUB(CURDATE(), INTERVAL 14 DAY) " +
                     "AND checkin_date < DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
        
        Double lastWeek = jdbcTemplate.queryForObject(sql1, Double.class, studentId);
        Double previousWeek = jdbcTemplate.queryForObject(sql2, Double.class, studentId);
        
        String trend = "stable";
        if (lastWeek != null && previousWeek != null) {
            double diff = lastWeek - previousWeek;
            if (diff > 0.5) trend = "improving";
            else if (diff < -0.5) trend = "declining";
        }
        
        return Map.of(
            "lastWeekAverage", lastWeek != null ? lastWeek : 0.0,
            "previousWeekAverage", previousWeek != null ? previousWeek : 0.0,
            "trend", trend
        );
    }
}

