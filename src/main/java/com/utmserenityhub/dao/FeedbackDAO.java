package com.utmserenityhub.dao;

import com.utmserenityhub.model.Feedback;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class FeedbackDAO {

    private final JdbcTemplate jdbcTemplate;

    public FeedbackDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // CREATE
    public void saveFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (username, title, category, message, resolved) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, feedback.getUsername(), feedback.getTitle(), feedback.getCategory(),
                feedback.getMessage(), false);
    }

    // READ
    public List<Feedback> getAllFeedback() {
        String sql = "SELECT * FROM feedback ORDER BY id DESC";
        return jdbcTemplate.query(sql, getFeedbackRowMapper());
    }

    public List<Feedback> getFilteredFeedback(String category, Boolean resolved) {
        StringBuilder sql = new StringBuilder("SELECT * FROM feedback WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (category != null && !category.isEmpty() && !category.equals("all")) {
            sql.append(" AND category = ?");
            params.add(category);
        }

        if (resolved != null) {
            sql.append(" AND resolved = ?");
            params.add(resolved);
        }

        sql.append(" ORDER BY id DESC");

        return jdbcTemplate.query(sql.toString(), getFeedbackRowMapper(), params.toArray());
    }

    // DELETE
    public void deleteFeedback(Long id) {
        String sql = "DELETE FROM feedback WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    public void resolveFeedback(Long id, Integer adminUserId) {
        String sql = "UPDATE feedback SET resolved = TRUE, resolved_at = NOW(), resolved_by = ? WHERE id = ?";
        jdbcTemplate.update(sql, adminUserId, id);
    }

    private RowMapper<Feedback> getFeedbackRowMapper() {
        return new RowMapper<Feedback>() {
            @Override
            public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException {
                Feedback f = new Feedback();
                f.setId(rs.getLong("id"));
                f.setUsername(rs.getString("username"));
                f.setTitle(rs.getString("title"));
                f.setCategory(rs.getString("category"));
                f.setMessage(rs.getString("message"));
                f.setResolved(rs.getBoolean("resolved"));
                f.setCreatedAt(rs.getTimestamp("created_at")); 
                f.setResolvedAt(rs.getTimestamp("resolved_at")); 
                Integer resolvedBy = (Integer) rs.getObject("resolved_by");
                f.setResolvedBy(resolvedBy);
                return f;
            }
        };
    }

}