package com.utmserenityhub.service;

import com.utmserenityhub.dao.UserDAO;
import com.utmserenityhub.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserService {
    
    @Autowired
    private UserDAO userDAO;
    
    /*create a new user*/
    public int createUser(User user) {
        return userDAO.create(user);
    }

    /*find user by email*/
    public User findByEmail(String email) {
        return userDAO.findByEmail(email);
    }

    /*find user by ID*/
    public User findById(int userId) {
        return userDAO.findById(userId);
    }

    /*update user information*/
    public boolean updateUser(User user) {
        return userDAO.update(user);
    }

    /*update user password*/
    public boolean updatePassword(int userId, String newPasswordHash) {
        return userDAO.updatePassword(userId, newPasswordHash);
    }

    /*update last login timestamp*/
    public boolean updateLastLogin(int userId) {
        return userDAO.updateLastLogin(userId);
    }

    /*deactivate user account*/
    public boolean deactivateUser(int userId) {
        return userDAO.deactivateUser(userId);
    }

    /*activate user account*/
    public boolean activateUser(int userId) {
        return userDAO.activateUser(userId);
    }

    /*delete user permanently*/
    public boolean deleteUser(int userId) {
        return userDAO.delete(userId);
    }

    /*get all users*/
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }

    /*get users by type*/
    public List<User> getUsersByType(User.UserType userType) {
        return userDAO.findByType(userType);
    }

    /*get user count by type*/
    public int getUserCountByType(User.UserType userType) {
        return userDAO.countByType(userType);
    }

    /*get total user count*/
    public int getTotalUserCount() {
        return userDAO.countAll();
    }

    /*get user statistics*/
    public Map<String, Integer> getUserStatistics() {
        return userDAO.getUserStatistics();
    }
    
    /*search users*/
    public List<User> searchUsers(String keyword) {
        return userDAO.search(keyword);
    }
    
    /*log activity*/
    public void logActivity(int userId, String activityType, String description) {
        userDAO.logActivity(userId, activityType, description);
    }
    
    /*get user's recent activites*/
    public List<Map<String, Object>> getUserActivities(int userId, int limit) {
        return userDAO.getUserActivities(userId, limit);
    }
    
    /*validate email format*/
    public boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email != null && email.matches(emailRegex);
    }
    
    /*check if email already exist*/
    public boolean isEmailExists(String email) {
        return userDAO.findByEmail(email) != null;
    }
    
    /*get active user count*/
    public int getActiveUserCount() {
        return userDAO.countActiveUsers();
    }
    
    /*get recently registered users*/
    public List<User> getRecentUsers(int limit) {
        return userDAO.findRecentUsers(limit);
    }
}