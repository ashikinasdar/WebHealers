package com.utmserenityhub.service;

import com.utmserenityhub.dao.CounselorDAO;
import com.utmserenityhub.dao.UserDAO;
import com.utmserenityhub.model.Counselor;
import com.utmserenityhub.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CounselorService {

    @Autowired
    private CounselorDAO counselorDAO;

    @Autowired
    private UserDAO userDAO;

    /* create counselor profile */
    public int createCounselor(Counselor counselor) {
        return counselorDAO.create(counselor);
    }

    /* get counselor by ID */
    public Counselor getCounselorById(int counselorId) {
        return counselorDAO.findById(counselorId);
    }

    /* get counselor by user ID */
    public Counselor getCounselorByUserId(int userId) {
        return counselorDAO.findByUserId(userId);
    }

    /* get all counselors */
    public List<Counselor> getAllCounselors() {
        return counselorDAO.findAll();
    }

    /* get counselors by specialization */
    public List<Counselor> getCounselorsBySpecialization(String specialization) {
        return counselorDAO.findBySpecialization(specialization);
    }

    /* get available counselors */
    public List<Counselor> getAvailableCounselors() {
        return counselorDAO.findAvailable();
    }

    /* update counselor profile (by user ID) */
    public boolean updateCounselor(Counselor counselor) {
        return counselorDAO.updateByUserId(counselor);
    }

    /* update profile picture */
    public boolean updateProfilePicture(int counselorId, String picturePath) {
        Counselor counselor = counselorDAO.findById(counselorId);
        if (counselor == null) {
            return false;
        }

        counselor.setProfilePicture(picturePath);
        return counselorDAO.update(counselor);
    }

    /* update availability */
    public boolean updateAvailability(int counselorId, String availableDays) {
        Counselor counselor = counselorDAO.findById(counselorId);
        if (counselor == null) {
            return false;
        }

        counselor.setAvailableDays(availableDays);
        return counselorDAO.update(counselor);
    }

    public boolean updateAvailability(int counselorId, boolean isAvailable, String shiftMeetingLink) {
        return counselorDAO.updateAvailability(counselorId, isAvailable, shiftMeetingLink);
    }

    /* delete counselor */
    public boolean deleteCounselor(int counselorId) {
        return counselorDAO.delete(counselorId);
    }

    /* search counselors */
    public List<Counselor> searchCounselors(String keyword) {
        return counselorDAO.search(keyword);
    }

    /* get total counselor count */
    public int getTotalCounselorCount() {
        return counselorDAO.countAll();
    }

    /* change password */
    public boolean changePassword(int userId, String currentPassword, String newPassword) {
        User user = userDAO.findById(userId);

        if (user == null) {
            return false;
        }

        // verify current password
        if (!BCrypt.checkpw(currentPassword, user.getPasswordHash())) {
            return false;
        }

        // hash new password
        String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt(10));

        return userDAO.updatePassword(userId, newPasswordHash);
    }

    /* validate counselor data */
    public boolean validateCounselorData(Counselor counselor) {
        if (counselor == null) {
            return false;
        }

        if (counselor.getSpecialization() == null || counselor.getSpecialization().isEmpty()) {
            return false;
        }

        if (counselor.getQualifications() == null || counselor.getQualifications().isEmpty()) {
            return false;
        }

        return true;
    }
}