package com.utmserenityhub.service;

import com.utmserenityhub.dao.StudentDAO;
import com.utmserenityhub.dao.CounselorDAO;
import com.utmserenityhub.dao.UserDAO;
import com.utmserenityhub.model.Student;
import com.utmserenityhub.model.Counselor;
import com.utmserenityhub.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StudentService {

    @Autowired
    private StudentDAO studentDAO;

    @Autowired
    private CounselorDAO counselorDAO;

    @Autowired
    private UserDAO userDAO;

    /*Create a new student profile*/
    public int createStudent(Student student) {
        return studentDAO.create(student);
    }

    /*Get student by ID*/
    public Student getStudentById(int studentId) {
        return studentDAO.findById(studentId);
    }

    /*Get student by user ID*/
    public Student getStudentByUserId(int userId) {
        return studentDAO.findByUserId(userId);
    }

    /*Get student by student number*/
    public Student getStudentByStudentNumber(String studentNumber) {
        return studentDAO.findByStudentNumber(studentNumber);
    }

    /*Update student profile*/
    public boolean updateStudent(Student student) {
        return studentDAO.updateByUserId(student);
    }

    /*Update profile picture*/
    public boolean updateProfilePicture(int studentId, String picturePath) {
        return studentDAO.updateProfilePicture(studentId, picturePath);
    }

    /*Delete student*/
    public boolean deleteStudent(int studentId) {
        return studentDAO.delete(studentId);
    }

    /*Get all students*/
    public List<Student> getAllStudents() {
        return studentDAO.findAll();
    }

    /*Get students by faculty*/
    public List<Student> getStudentsByFaculty(String faculty) {
        return studentDAO.findByFaculty(faculty);
    }

    /*Get students by year*/
    public List<Student> getStudentsByYear(int year) {
        return studentDAO.findByYear(year);
    }

    /*Get total student count*/
    public int getTotalStudentCount() {
        return studentDAO.countAll();
    }

    /*Search students*/
    public List<Student> searchStudents(String keyword) {
        return studentDAO.search(keyword);
    }

    /*Check if student number exists*/
    public boolean isStudentNumberExists(String studentNumber) {
        return studentDAO.studentNumberExists(studentNumber);
    }

    /*get available counselors*/
    public List<Counselor> getAvailableCounselors() {
        return counselorDAO.findAvailable();
    }

    /*change password*/
    public boolean changePassword(int userId, String currentPassword, String newPassword) {
        User user = userDAO.findById(userId);

        if (user == null) {
            return false;
        }

        //verify current password
        if (!BCrypt.checkpw(currentPassword, user.getPasswordHash())) {
            return false;
        }

        //hash new password
        String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt(10));

        //update password
        return userDAO.updatePassword(userId, newPasswordHash);
    }

    /**/
    public boolean validateStudentData(Student student) {
        if (student == null) {
            return false;
        }

        // Validate year of study
        if (student.getYearOfStudy() < 1 || student.getYearOfStudy() > 5) {
            return false;
        }

        return true;
    }

    /*Get active student count*/
    public int getActiveStudentCount() {
        List<Student> students = studentDAO.findAll();
        return (int) students.stream()
                .filter(s -> {
                    User user = userDAO.findById(s.getUserId());
                    return user != null && user.isActive();
                })
                .count();
    }
}
