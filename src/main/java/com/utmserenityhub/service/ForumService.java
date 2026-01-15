package com.utmserenityhub.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.utmserenityhub.dao.ForumDAO;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ForumService {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    private ForumDAO forumDAO; 
    
    /*Create a new forum thread*/
    public int createThread(int studentId, String title, String content, boolean isAnonymous) {
        String sql = "INSERT INTO forum_threads (student_id, title, content, is_anonymous) " +
                    "VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, studentId, title, content, isAnonymous);
        
        // Get the last inserted ID
        return jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
    }

    /*Get thread by ID*/
    public Map<String, Object> getThreadById(int threadId) {
        String sql = "SELECT t.*, u.full_name as author_name " +
                    "FROM forum_threads t " +
                    "INNER JOIN students s ON t.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE t.thread_id = ? AND t.is_active = TRUE";
        try {
            return jdbcTemplate.queryForMap(sql, threadId);
        } catch (Exception e) {
            return null;
        }
    }

    /*Get all active threads*/
    public List<Map<String, Object>> getAllThreads() {
        String sql = "SELECT t.*, u.full_name as author_name " +
                    "FROM forum_threads t " +
                    "INNER JOIN students s ON t.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE t.is_active = TRUE " +
                    "ORDER BY t.created_at DESC";
        return jdbcTemplate.queryForList(sql);
    }

    /*Get threads by student ID*/
    public List<Map<String, Object>> getThreadsByStudentId(int studentId) {
        String sql = "SELECT t.*, u.full_name as author_name " +
                    "FROM forum_threads t " +
                    "INNER JOIN students s ON t.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE t.student_id = ? AND t.is_active = TRUE " +
                    "ORDER BY t.created_at DESC";
        return jdbcTemplate.queryForList(sql, studentId);
    }

    /*Update thread*/
    public boolean updateThread(int threadId, String title, String content) {
        String sql = "UPDATE forum_threads SET title = ?, content = ? WHERE thread_id = ?";
        int rows = jdbcTemplate.update(sql, title, content, threadId);
        return rows > 0;
    }

    /*Delete thread (soft delete)*/
    public boolean deleteThread(int threadId) {
        String sql = "UPDATE forum_threads SET is_active = FALSE WHERE thread_id = ?";
        int rows = jdbcTemplate.update(sql, threadId);
        return rows > 0;
    }

    /*Like a thread*/
    public boolean likeThread(int studentId, int threadId) {
        //check if already liked
        String checkSql = "SELECT COUNT(*) FROM forum_likes WHERE student_id = ? AND thread_id = ?";
        Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, studentId, threadId);
        
        if (count > 0) {
            //unlike
            String deleteSql = "DELETE FROM forum_likes WHERE student_id = ? AND thread_id = ?";
            jdbcTemplate.update(deleteSql, studentId, threadId);
            
            //decrease like count
            String updateSql = "UPDATE forum_threads SET likes_count = likes_count - 1 WHERE thread_id = ?";
            jdbcTemplate.update(updateSql, threadId);
            return false;
        } else {
            //like
            String insertSql = "INSERT INTO forum_likes (student_id, thread_id) VALUES (?, ?)";
            jdbcTemplate.update(insertSql, studentId, threadId);
            
            //increase like count
            String updateSql = "UPDATE forum_threads SET likes_count = likes_count + 1 WHERE thread_id = ?";
            jdbcTemplate.update(updateSql, threadId);
            return true;
        }
    }

    /*Check if student liked a thread*/
    public boolean hasLikedThread(int studentId, int threadId) {
        String sql = "SELECT COUNT(*) FROM forum_likes WHERE student_id = ? AND thread_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, studentId, threadId);
        return count > 0;
    }

    /*Create a reply*/
    public int createReply(int threadId, int studentId, String content, boolean isAnonymous) {
        String sql = "INSERT INTO forum_replies (thread_id, student_id, content, is_anonymous) " +
                    "VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, threadId, studentId, content, isAnonymous);
        
        //update thread reply count
        String updateSql = "UPDATE forum_threads SET replies_count = replies_count + 1 WHERE thread_id = ?";
        jdbcTemplate.update(updateSql, threadId);
        
        return jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
    }

    /*Get replies for a thread*/
    public List<Map<String, Object>> getRepliesByThreadId(int threadId) {
        String sql = "SELECT r.*, u.full_name as author_name " +
                    "FROM forum_replies r " +
                    "INNER JOIN students s ON r.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE r.thread_id = ? " +
                    "ORDER BY r.created_at ASC";
        return jdbcTemplate.queryForList(sql, threadId);
    }

    /*Update reply*/
    public boolean updateReply(int replyId, String content) {
        String sql = "UPDATE forum_replies SET content = ? WHERE reply_id = ?";
        int rows = jdbcTemplate.update(sql, content, replyId);
        return rows > 0;
    }

    /*Delete reply*/
    public boolean deleteReply(int replyId, int threadId) {
        String sql = "DELETE FROM forum_replies WHERE reply_id = ?";
        int rows = jdbcTemplate.update(sql, replyId);
        
        if (rows > 0) {
            //update thread reply count
            String updateSql = "UPDATE forum_threads SET replies_count = replies_count - 1 WHERE thread_id = ?";
            jdbcTemplate.update(updateSql, threadId);
            return true;
        }
        return false;
    }

    /*Like a reply*/
    public boolean likeReply(int studentId, int replyId) {
        //check if already liked
        String checkSql = "SELECT COUNT(*) FROM forum_likes WHERE student_id = ? AND reply_id = ?";
        Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, studentId, replyId);
        
        if (count > 0) {
            //unlike
            String deleteSql = "DELETE FROM forum_likes WHERE student_id = ? AND reply_id = ?";
            jdbcTemplate.update(deleteSql, studentId, replyId);
            
            //decrease like count
            String updateSql = "UPDATE forum_replies SET likes_count = likes_count - 1 WHERE reply_id = ?";
            jdbcTemplate.update(updateSql, replyId);
            return false;
        } else {
            //like
            String insertSql = "INSERT INTO forum_likes (student_id, reply_id) VALUES (?, ?)";
            jdbcTemplate.update(insertSql, studentId, replyId);
            
            //increase like count
            String updateSql = "UPDATE forum_replies SET likes_count = likes_count + 1 WHERE reply_id = ?";
            jdbcTemplate.update(updateSql, replyId);
            return true;
        }
    }

    /*Count student's forum posts*/
    public int countStudentPosts(int studentId) {
        String sql = "SELECT COUNT(*) FROM forum_threads WHERE student_id = ? AND is_active = TRUE";
        return jdbcTemplate.queryForObject(sql, Integer.class, studentId);
    }

    /*Count all active threads*/
    public int countAllThreads() {
        String sql = "SELECT COUNT(*) FROM forum_threads WHERE is_active = TRUE";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*Search threads*/
    public List<Map<String, Object>> searchThreads(String keyword) {
        String sql = "SELECT t.*, u.full_name as author_name " +
                    "FROM forum_threads t " +
                    "INNER JOIN students s ON t.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE (t.title LIKE ? OR t.content LIKE ?) AND t.is_active = TRUE " +
                    "ORDER BY t.created_at DESC";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.queryForList(sql, searchPattern, searchPattern);
    }

    /*Get popular threads (most liked/replied)*/
    public List<Map<String, Object>> getPopularThreads(int limit) {
        String sql = "SELECT t.*, u.full_name as author_name " +
                    "FROM forum_threads t " +
                    "INNER JOIN students s ON t.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE t.is_active = TRUE " +
                    "ORDER BY (t.likes_count + t.replies_count) DESC " +
                    "LIMIT ?";
        return jdbcTemplate.queryForList(sql, limit);
    }
}
