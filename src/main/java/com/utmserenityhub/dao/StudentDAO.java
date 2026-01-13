package com.utmserenityhub.dao;

import com.utmserenityhub.model.Student;
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
public class StudentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // RowMapper for Student object
    private final RowMapper<Student> studentRowMapper = (rs, rowNum) -> {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setUserId(rs.getInt("user_id"));
        student.setStudentNumber(rs.getString("student_number"));
        student.setFaculty(rs.getString("faculty"));
        student.setYearOfStudy(rs.getInt("year_of_study"));
        student.setProfilePicture(rs.getString("profile_picture"));
        student.setBio(rs.getString("bio"));
        return student;
    };

    // RowMapper for Student with User info (joined query)
    private final RowMapper<Student> studentWithUserRowMapper = (rs, rowNum) -> {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setUserId(rs.getInt("user_id"));
        student.setStudentNumber(rs.getString("student_number"));
        student.setFaculty(rs.getString("faculty"));
        student.setYearOfStudy(rs.getInt("year_of_study"));
        student.setProfilePicture(rs.getString("profile_picture"));
        student.setBio(rs.getString("bio"));

        // user information
        try {
            student.setFullName(rs.getString("full_name"));
            student.setEmail(rs.getString("email"));
        } catch (Exception e) {
            // columns may not exist in all queries
        }

        return student;
    };

    /*create a new student profile*/
    public int create(Student student) {
        String sql = "INSERT INTO students (user_id, student_number, faculty, year_of_study, bio) " +
                "VALUES (?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, student.getUserId());
            ps.setString(2, student.getStudentNumber());
            ps.setString(3, student.getFaculty());
            ps.setInt(4, student.getYearOfStudy());
            ps.setString(5, student.getBio());
            return ps;
        }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    /*find student by ID*/
    public Student findById(int studentId) {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE s.student_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, studentWithUserRowMapper, studentId);
        } catch (Exception e) {
            return null;
        }
    }

    /*find student by user ID*/
    public Student findByUserId(int userId) {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE s.user_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, studentWithUserRowMapper, userId);
        } catch (Exception e) {
            return null;
        }
    }

    /*find student by student number*/
    public Student findByStudentNumber(String studentNumber) {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE s.student_number = ?";
        try {
            return jdbcTemplate.queryForObject(sql, studentWithUserRowMapper, studentNumber);
        } catch (Exception e) {
            return null;
        }
    }

    /*update student profile*/
    public boolean update(Student student) {
        String sql = "UPDATE students SET student_number = ?, faculty = ?, " +
                "year_of_study = ?, bio = ?, profile_picture = ? " +
                "WHERE student_id = ?";
        int rows = jdbcTemplate.update(sql,
                student.getStudentNumber(),
                student.getFaculty(),
                student.getYearOfStudy(),
                student.getBio(),
                student.getProfilePicture(),
                student.getStudentId());
        return rows > 0;
    }

    /*update student by user ID*/
    public boolean updateByUserId(Student student) {
        String sql = "UPDATE students SET student_number = ?, faculty = ?, " +
                "year_of_study = ?, bio = ? " +
                "WHERE user_id = ?";
        int rows = jdbcTemplate.update(sql,
                student.getStudentNumber(),
                student.getFaculty(),
                student.getYearOfStudy(),
                student.getBio(),
                student.getUserId());
        return rows > 0;
    }

    /*update profile picture*/
    public boolean updateProfilePicture(int studentId, String picturePath) {
        String sql = "UPDATE students SET profile_picture = ? WHERE student_id = ?";
        int rows = jdbcTemplate.update(sql, picturePath, studentId);
        return rows > 0;
    }

    /*delete student profile*/
    public boolean delete(int studentId) {
        String sql = "DELETE FROM students WHERE student_id = ?";
        int rows = jdbcTemplate.update(sql, studentId);
        return rows > 0;
    }

    /*get all students*/
    public List<Student> findAll() {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "ORDER BY u.full_name";
        return jdbcTemplate.query(sql, studentWithUserRowMapper);
    }

    /*get students by faculty*/
    public List<Student> findByFaculty(String faculty) {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE s.faculty = ? ORDER BY u.full_name";
        return jdbcTemplate.query(sql, studentWithUserRowMapper, faculty);
    }

    /*get students by year of study*/
    public List<Student> findByYear(int year) {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE s.year_of_study = ? ORDER BY u.full_name";
        return jdbcTemplate.query(sql, studentWithUserRowMapper, year);
    }

    /*count all students*/
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM students";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    /*search students by name or student number*/
    public List<Student> search(String keyword) {
        String sql = "SELECT s.*, u.full_name, u.email FROM students s " +
                "INNER JOIN users u ON s.user_id = u.user_id " +
                "WHERE u.full_name LIKE ? OR s.student_number LIKE ? " +
                "ORDER BY u.full_name";
        String searchPattern = "%" + keyword + "%";
        return jdbcTemplate.query(sql, studentWithUserRowMapper, searchPattern, searchPattern);
    }

    /*check if student number exists*/
    public boolean studentNumberExists(String studentNumber) {
        String sql = "SELECT COUNT(*) FROM students WHERE student_number = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, studentNumber);
        return count != null && count > 0;
    }
}
