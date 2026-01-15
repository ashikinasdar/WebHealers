package com.utmserenityhub.dao;

import com.utmserenityhub.model.ForumThread;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ForumDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // Just move ONE method from your Service to test
    public List<ForumThread> getAllThreads() {
        String sql = "SELECT t.*, u.full_name as author_name " +
                    "FROM forum_threads t " +
                    "INNER JOIN students s ON t.student_id = s.student_id " +
                    "INNER JOIN users u ON s.user_id = u.user_id " +
                    "WHERE t.is_active = TRUE " +
                    "ORDER BY t.created_at DESC";
        
        return jdbcTemplate.query(sql, new ThreadRowMapper());
    }
    
    private static class ThreadRowMapper implements RowMapper<ForumThread> {
        @Override
        public ForumThread mapRow(ResultSet rs, int rowNum) throws SQLException {
            ForumThread thread = new ForumThread();
            thread.setThread_id(rs.getInt("thread_id"));
            thread.setTitle(rs.getString("title"));
            thread.setContent(rs.getString("content"));
            thread.setStudent_id(rs.getInt("student_id"));
            thread.setIs_anonymous(rs.getBoolean("is_anonymous"));
            thread.setIs_active(rs.getBoolean("is_active"));
            thread.setLikes_count(rs.getInt("likes_count"));
            thread.setReplies_count(rs.getInt("replies_count"));
            thread.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
            thread.setAuthor_name(rs.getString("author_name"));
            return thread;
        }
    }
}