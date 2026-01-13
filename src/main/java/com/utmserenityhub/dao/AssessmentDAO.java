package com.utmserenityhub.dao;

import com.utmserenityhub.model.AssessmentQuestion;

import com.utmserenityhub.model.AssessmentResult;

import com.utmserenityhub.model.AssessmentType;

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
public class AssessmentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // RowMapper for AssessmentType
    private final RowMapper<AssessmentType> typeRowMapper = (rs, rowNum) -> {
        AssessmentType type = new AssessmentType();
        type.setAssessmentTypeId(rs.getInt("assessment_type_id"));
        type.setName(rs.getString("name"));
        type.setDescription(rs.getString("description"));
        type.setTotalQuestions(rs.getInt("total_questions"));
        type.setScoringMethod(rs.getString("scoring_method"));
        type.setActive(rs.getBoolean("is_active"));
        return type;
    };

    // RowMapper for AssessmentQuestion
    private final RowMapper<AssessmentQuestion> questionRowMapper = (rs, rowNum) -> {
        AssessmentQuestion question = new AssessmentQuestion();
        question.setAssessmentQuestionId(rs.getInt("assessment_question_id"));
        question.setAssessmentTypeId(rs.getInt("assessment_type_id"));
        question.setQuestionText(rs.getString("question_text"));
        question.setCategory(rs.getString("category"));
        question.setDisplayOrder(rs.getInt("display_order"));
        return question;
    };

    // RowMapper for AssessmentResult
    private final RowMapper<AssessmentResult> resultRowMapper = (rs, rowNum) -> {
        AssessmentResult result = new AssessmentResult();
        result.setResultId(rs.getInt("result_id"));
        result.setStudentId(rs.getInt("student_id"));
        result.setAssessmentTypeId(rs.getInt("assessment_type_id"));
        result.setDepressionScore(rs.getInt("depression_score"));
        result.setAnxietyScore(rs.getInt("anxiety_score"));
        result.setStressScore(rs.getInt("stress_score"));
        result.setOverallSeverity(AssessmentResult.Severity.valueOf(rs.getString("overall_severity")));
        result.setRecommendations(rs.getString("recommendations"));
        result.setAttemptedAt(rs.getTimestamp("attempted_at"));

        try {
            result.setAssessmentName(rs.getString("assessment_name"));
            result.setStudentName(rs.getString("student_name"));
        } catch (Exception e) {
            // columns may not exist
        }

        return result;
    };

    /* get all assessment types */
    public List<AssessmentType> findAllTypes() {
        String sql = "SELECT * FROM assessment_types ORDER BY name";
        return jdbcTemplate.query(sql, typeRowMapper);
    }

    /* get active assessment types */
    public List<AssessmentType> findActiveTypes() {
        String sql = "SELECT * FROM assessment_types WHERE is_active = TRUE ORDER BY name";
        return jdbcTemplate.query(sql, typeRowMapper);
    }

    /* get assessment type by ID */
    public AssessmentType findTypeById(int typeId) {
        String sql = "SELECT * FROM assessment_types WHERE assessment_type_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, typeRowMapper, typeId);
        } catch (Exception e) {
            return null;
        }
    }

    /* get questions for an assessment type */
    public List<AssessmentQuestion> findQuestionsByTypeId(int typeId) {
        String sql = "SELECT * FROM assessment_questions " +
                "WHERE assessment_type_id = ? " +
                "ORDER BY display_order";
        return jdbcTemplate.query(sql, questionRowMapper, typeId);
    }

    /* get questions by category */
    public List<AssessmentQuestion> findQuestionsByCategory(int typeId, String category) {
        String sql = "SELECT * FROM assessment_questions " +
                "WHERE assessment_type_id = ? AND category = ? " +
                "ORDER BY display_order";
        return jdbcTemplate.query(sql, questionRowMapper, typeId, category);
    }

    /* get question by ID */
    public AssessmentQuestion findQuestionById(int questionId) {
        String sql = "SELECT * FROM assessment_questions WHERE assessment_question_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, questionRowMapper, questionId);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Create new assessment type
     */
    public int createAssessmentType(AssessmentType assessmentType) {
        String sql = "INSERT INTO assessment_types (name, description, total_questions, scoring_method, is_active) " +
                "VALUES (?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, assessmentType.getName());
            ps.setString(2, assessmentType.getDescription());
            ps.setInt(3, assessmentType.getTotalQuestions());
            ps.setString(4, assessmentType.getScoringMethod());
            ps.setBoolean(5, assessmentType.isActive());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    /**
     * Update assessment type
     */
    public boolean updateAssessmentType(AssessmentType assessmentType) {
        String sql = "UPDATE assessment_types SET name = ?, description = ?, " +
                "scoring_method = ?, is_active = ? WHERE assessment_type_id = ?";
        int rows = jdbcTemplate.update(sql,
                assessmentType.getName(),
                assessmentType.getDescription(),
                assessmentType.getScoringMethod(),
                assessmentType.isActive(),
                assessmentType.getAssessmentTypeId());
        return rows > 0;
    }

    /**
     * Toggle assessment type status
     */
    public boolean toggleAssessmentTypeStatus(int typeId) {
        String sql = "UPDATE assessment_types SET is_active = NOT is_active WHERE assessment_type_id = ?";
        int rows = jdbcTemplate.update(sql, typeId);
        return rows > 0;
    }

    /* create assessment question */
    public int createQuestion(AssessmentQuestion question) {
        String sql = "INSERT INTO assessment_questions (assessment_type_id, question_text, " +
                "category, display_order) VALUES (?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, question.getAssessmentTypeId());
            ps.setString(2, question.getQuestionText());
            ps.setString(3, question.getCategory());
            ps.setInt(4, question.getDisplayOrder());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    /* update assessment question */
    public boolean updateQuestion(AssessmentQuestion question) {
        String sql = "UPDATE assessment_questions SET question_text = ?, category = ?, " +
                "display_order = ? WHERE assessment_question_id = ?";
        int rows = jdbcTemplate.update(sql,
                question.getQuestionText(),
                question.getCategory(),
                question.getDisplayOrder(),
                question.getAssessmentQuestionId());
        return rows > 0;
    }

    /* delete assessment question */
    public boolean deleteQuestion(int questionId) {
        String sql = "DELETE FROM assessment_questions WHERE assessment_question_id = ?";
        int rows = jdbcTemplate.update(sql, questionId);
        return rows > 0;
    }

    /* create assessment result */
    public int createResult(AssessmentResult result) {
        String sql = "INSERT INTO assessment_results (student_id, assessment_type_id, " +
                "depression_score, anxiety_score, stress_score, overall_severity, recommendations) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, result.getStudentId());
            ps.setInt(2, result.getAssessmentTypeId());
            ps.setInt(3, result.getDepressionScore());
            ps.setInt(4, result.getAnxietyScore());
            ps.setInt(5, result.getStressScore());
            ps.setString(6, result.getOverallSeverity().toString());
            ps.setString(7, result.getRecommendations());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    /* find result by ID */
    public AssessmentResult findResultById(int resultId) {
        String sql = "SELECT ar.*, at.name as assessment_name, u.full_name as student_name " +
                "FROM assessment_results ar " +
                "INNER JOIN assessment_types at ON ar.assessment_type_id = at.assessment_type_id " +
                "INNER JOIN students s ON ar.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE ar.result_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, resultRowMapper, resultId);
        } catch (Exception e) {
            return null;
        }
    }

    /* find results by student ID */
    public List<AssessmentResult> findResultsByStudentId(int studentId) {
        String sql = "SELECT ar.*, at.name as assessment_name, u.full_name as student_name " +
                "FROM assessment_results ar " +
                "INNER JOIN assessment_types at ON ar.assessment_type_id = at.assessment_type_id " +
                "INNER JOIN students s ON ar.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE ar.student_id = ? " +
                "ORDER BY ar.attempted_at DESC";
        return jdbcTemplate.query(sql, resultRowMapper, studentId);
    }

    /* find recent results by student ID */
    public List<AssessmentResult> findRecentResultsByStudentId(int studentId, int limit) {
        String sql = "SELECT ar.*, at.name as assessment_name, u.full_name as student_name " +
                "FROM assessment_results ar " +
                "INNER JOIN assessment_types at ON ar.assessment_type_id = at.assessment_type_id " +
                "INNER JOIN students s ON ar.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE ar.student_id = ? " +
                "ORDER BY ar.attempted_at DESC " +
                "LIMIT ?";
        return jdbcTemplate.query(sql, resultRowMapper, studentId, limit);
    }

    /* find all results */
    public List<AssessmentResult> findAllResults() {
        String sql = "SELECT ar.*, at.name as assessment_name, u.full_name as student_name " +
                "FROM assessment_results ar " +
                "INNER JOIN assessment_types at ON ar.assessment_type_id = at.assessment_type_id " +
                "INNER JOIN students s ON ar.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "ORDER BY ar.attempted_at DESC";
        return jdbcTemplate.query(sql, resultRowMapper);
    }

    /* find results by severity */
    public List<AssessmentResult> findResultsBySeverity(AssessmentResult.Severity severity) {
        String sql = "SELECT ar.*, at.name as assessment_name, u.full_name as student_name " +
                "FROM assessment_results ar " +
                "INNER JOIN assessment_types at ON ar.assessment_type_id = at.assessment_type_id " +
                "INNER JOIN students s ON ar.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE ar.overall_severity = ? " +
                "ORDER BY ar.attempted_at DESC";
        return jdbcTemplate.query(sql, resultRowMapper, severity.toString());
    }

    /* count by student ID */
    public int countByStudentId(int studentId) {
        String sql = "SELECT COUNT(*) FROM assessment_results WHERE student_id = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, studentId);
    }

    /* count all results */
    public int countAllResults() {
        String sql = "SELECT COUNT(*) FROM assessment_results";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /* find latest result for student and assessment type */
    public AssessmentResult findLatestResult(int studentId, int assessmentTypeId) {
        String sql = "SELECT ar.*, at.name as assessment_name, u.full_name as student_name " +
                "FROM assessment_results ar " +
                "INNER JOIN assessment_types at ON ar.assessment_type_id = at.assessment_type_id " +
                "INNER JOIN students s ON ar.student_id = s.student_id " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE ar.student_id = ? AND ar.assessment_type_id = ? " +
                "ORDER BY ar.attempted_at DESC " +
                "LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, resultRowMapper, studentId, assessmentTypeId);
        } catch (Exception e) {
            return null;
        }
    }
}