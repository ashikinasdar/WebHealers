package com.utmserenityhub.dao;

import com.utmserenityhub.model.LearningModule;
import com.utmserenityhub.model.ModuleProgress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

@Repository
public class LearningModuleDAO {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    // RowMapper for LearningModule
    private final RowMapper<LearningModule> moduleRowMapper = (rs, rowNum) -> {
        LearningModule module = new LearningModule();
        module.setModuleId(rs.getInt("module_id"));
        module.setTitle(rs.getString("title"));
        module.setCategory(rs.getString("category"));
        module.setDescription(rs.getString("description"));
        module.setContent(rs.getString("content"));
        module.setDurationMinutes(rs.getInt("duration_minutes"));
        module.setDisplayOrder(rs.getInt("display_order"));
        module.setObjectives(rs.getString("objectives"));
        module.setActive(rs.getBoolean("is_active"));
        module.setCreatedBy(rs.getInt("created_by"));
        module.setCreatedAt(rs.getTimestamp("created_at"));
        module.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        try {
            module.setCreatorName(rs.getString("creator_name"));
        } catch (Exception e) {
            // column may not exist
        }
        
        return module;
    };
    
    // RowMapper for ModuleProgress
    private final RowMapper<ModuleProgress> progressRowMapper = (rs, rowNum) -> {
        ModuleProgress progress = new ModuleProgress();
        progress.setProgressId(rs.getInt("progress_id"));
        progress.setStudentId(rs.getInt("student_id"));
        progress.setModuleId(rs.getInt("module_id"));
        progress.setStatus(ModuleProgress.Status.valueOf(rs.getString("status")));
        progress.setProgressPercentage(rs.getDouble("progress_percentage"));
        progress.setStartedAt(rs.getTimestamp("started_at"));
        progress.setCompletedAt(rs.getTimestamp("completed_at"));
        progress.setLastAccessed(rs.getTimestamp("last_accessed"));
        
        try {
            progress.setModuleTitle(rs.getString("module_title"));
            progress.setModuleCategory(rs.getString("module_category"));
        } catch (Exception e) {
            // columns may not exist
        }
        
        return progress;
    };
    
    /*create a new learning module*/
    public int create(LearningModule module) {
        String sql = "INSERT INTO learning_modules (title, category, description, content, " +
                    "duration_minutes, display_order, objectives, is_active, created_by) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, module.getTitle());
            ps.setString(2, module.getCategory());
            ps.setString(3, module.getDescription());
            ps.setString(4, module.getContent());
            ps.setInt(5, module.getDurationMinutes());
            ps.setInt(6, module.getDisplayOrder());
            ps.setString(7, module.getObjectives());
            ps.setBoolean(8, module.isActive());
            ps.setInt(9, module.getCreatedBy());
            return ps;
        }, keyHolder);
        
        return keyHolder.getKey().intValue();
    }

    /*find module by ID*/
    public LearningModule findById(int moduleId) {
        String sql = "SELECT m.*, u.full_name as creator_name FROM learning_modules m " +
                    "LEFT JOIN users u ON m.created_by = u.user_id " +
                    "WHERE m.module_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, moduleRowMapper, moduleId);
        } catch (Exception e) {
            return null;
        }
    }

    /*update module*/
    public boolean update(LearningModule module) {
        String sql = "UPDATE learning_modules SET title = ?, category = ?, description = ?, " +
                    "content = ?, duration_minutes = ?, display_order = ?, objectives = ?, " +
                    "is_active = ? WHERE module_id = ?";
        int rows = jdbcTemplate.update(sql,
            module.getTitle(),
            module.getCategory(),
            module.getDescription(),
            module.getContent(),
            module.getDurationMinutes(),
            module.getDisplayOrder(),
            module.getObjectives(),
            module.isActive(),
            module.getModuleId()
        );
        return rows > 0;
    }

    /*delete module*/
    public boolean delete(int moduleId) {
        String sql = "DELETE FROM learning_modules WHERE module_id = ?";
        int rows = jdbcTemplate.update(sql, moduleId);
        return rows > 0;
    }

    /*set active status of a module*/
    public boolean setActive(int moduleId, boolean active) {
        String sql = "UPDATE learning_modules SET is_active = ? WHERE module_id = ?";
        int rows = jdbcTemplate.update(sql, active, moduleId);
        return rows > 0;
    }

    /*get all modules*/
    public List<LearningModule> findAll() {
        String sql = "SELECT m.*, u.full_name as creator_name FROM learning_modules m " +
                    "LEFT JOIN users u ON m.created_by = u.user_id " +
                    "ORDER BY m.display_order, m.created_at DESC";
        return jdbcTemplate.query(sql, moduleRowMapper);
    }

    /*get active modules*/
    public List<LearningModule> findActive() {
        String sql = "SELECT m.*, u.full_name as creator_name FROM learning_modules m " +
                    "LEFT JOIN users u ON m.created_by = u.user_id " +
                    "WHERE m.is_active = TRUE " +
                    "ORDER BY m.display_order, m.created_at DESC";
        return jdbcTemplate.query(sql, moduleRowMapper);
    }

    /*find modules by category*/
    public List<LearningModule> findByCategory(String category) {
        String sql = "SELECT m.*, u.full_name as creator_name FROM learning_modules m " +
                    "LEFT JOIN users u ON m.created_by = u.user_id " +
                    "WHERE m.category = ? AND m.is_active = TRUE " +
                    "ORDER BY m.display_order";
        return jdbcTemplate.query(sql, moduleRowMapper, category);
    }

    /*count active modules*/
    public int countActive() {
        String sql = "SELECT COUNT(*) FROM learning_modules WHERE is_active = TRUE";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*search modules*/
    public List<LearningModule> search(String keyword) {
        String sql = "SELECT m.*, u.full_name as creator_name FROM learning_modules m " +
                    "LEFT JOIN users u ON m.created_by = u.user_id " +
                    "WHERE (m.title LIKE ? OR m.description LIKE ?) AND m.is_active = TRUE " +
                    "ORDER BY m.display_order";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, moduleRowMapper, searchPattern, searchPattern);
    }

    /*create or update progress*/
    public int createProgress(ModuleProgress progress) {
        String sql = "INSERT INTO module_progress (student_id, module_id, status, " +
                    "progress_percentage, started_at) " +
                    "VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP) " +
                    "ON DUPLICATE KEY UPDATE " +
                    "status = VALUES(status), progress_percentage = VALUES(progress_percentage), " +
                    "last_accessed = CURRENT_TIMESTAMP";
        
        return jdbcTemplate.update(sql,
            progress.getStudentId(),
            progress.getModuleId(),
            progress.getStatus().toString(),
            progress.getProgressPercentage()
        );
    }

    /*update progress*/
    public boolean updateProgress(int studentId, int moduleId, double progressPercentage) {
        String sql = "UPDATE module_progress SET progress_percentage = ?, " +
                    "status = CASE " +
                    "  WHEN ? >= 100 THEN 'COMPLETED' " +
                    "  WHEN ? > 0 THEN 'IN_PROGRESS' " +
                    "  ELSE 'NOT_STARTED' " +
                    "END, " +
                    "completed_at = CASE WHEN ? >= 100 THEN CURRENT_TIMESTAMP ELSE completed_at END, " +
                    "last_accessed = CURRENT_TIMESTAMP " +
                    "WHERE student_id = ? AND module_id = ?";
        int rows = jdbcTemplate.update(sql, progressPercentage, progressPercentage, 
                                      progressPercentage, progressPercentage, 
                                      studentId, moduleId);
        return rows > 0;
    }

    /*find progress for a student and module*/
    public ModuleProgress findProgress(int studentId, int moduleId) {
        String sql = "SELECT mp.*, m.title as module_title, m.category as module_category " +
                    "FROM module_progress mp " +
                    "INNER JOIN learning_modules m ON mp.module_id = m.module_id " +
                    "WHERE mp.student_id = ? AND mp.module_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, progressRowMapper, studentId, moduleId);
        } catch (Exception e) {
            return null;
        }
    }

    /*find progress for a student*/
    public List<ModuleProgress> findProgressByStudentId(int studentId) {
        String sql = "SELECT mp.*, m.title as module_title, m.category as module_category " +
                    "FROM module_progress mp " +
                    "INNER JOIN learning_modules m ON mp.module_id = m.module_id " +
                    "WHERE mp.student_id = ? " +
                    "ORDER BY mp.last_accessed DESC";
        return jdbcTemplate.query(sql, progressRowMapper, studentId);
    }

    /*find modules with progress for a student*/
    public List<Map<String, Object>> findModulesWithProgress(int studentId) {
        String sql = "SELECT m.*, " +
                    "COALESCE(mp.status, 'NOT_STARTED') as progress_status, " +
                    "COALESCE(mp.progress_percentage, 0) as progress_percentage, " +
                    "mp.last_accessed " +
                    "FROM learning_modules m " +
                    "LEFT JOIN module_progress mp ON m.module_id = mp.module_id AND mp.student_id = ? " +
                    "WHERE m.is_active = TRUE " +
                    "ORDER BY m.display_order";
        return jdbcTemplate.queryForList(sql, studentId);
    }

    /*get completed modules count for a student*/
    public int countCompletedByStudentId(int studentId) {
        String sql = "SELECT COUNT(*) FROM module_progress " +
                    "WHERE student_id = ? AND status = 'COMPLETED'";
        return jdbcTemplate.queryForObject(sql, Integer.class, studentId);
    }
}