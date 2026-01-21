package com.utmserenityhub.dao;

import com.utmserenityhub.model.Feedback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class FeedbackDAO {

    private final JdbcTemplate jdbcTemplate;

    public FeedbackDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // CREATE
    public void saveFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (username, title, category, message) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, feedback.getUsername(), feedback.getTitle(), feedback.getCategory(),
                feedback.getMessage());
    }

    // READ
    public List<Feedback> getAllFeedback() {
        String sql = "SELECT * FROM feedback ORDER BY id DESC";
        return jdbcTemplate.query(sql, new RowMapper<Feedback>() {
            @Override
            public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException {
                Feedback f = new Feedback();
                f.setId(rs.getLong("id"));
                f.setUsername(rs.getString("username"));
                f.setTitle(rs.getString("title"));
                f.setCategory(rs.getString("category"));
                f.setMessage(rs.getString("message"));
                f.setResolved(rs.getBoolean("resolved"));
                return f;
            }
        });
    }

    // DELETE
    public void deleteFeedback(Long id) {
        String sql = "DELETE FROM feedback WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public void resolveFeedback(Long id) {
        String sql = "UPDATE feedback SET resolved = TRUE WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

}