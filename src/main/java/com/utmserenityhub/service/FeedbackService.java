package com.utmserenityhub.service;

import com.utmserenityhub.dao.FeedbackDAO;
import com.utmserenityhub.model.Feedback;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FeedbackService {

    private final FeedbackDAO feedbackDAO;

    public FeedbackService(FeedbackDAO feedbackDAO) {
        this.feedbackDAO = feedbackDAO;
    }

    /**
     * Save feedback with validation and sanitization
     */
    public void saveFeedback(Feedback feedback) {
        // Business logic: Validate input
        validateFeedback(feedback);

        // Business logic: Sanitize input to prevent XSS
        feedback.setTitle(sanitizeInput(feedback.getTitle()));
        feedback.setMessage(sanitizeInput(feedback.getMessage()));
        feedback.setUsername(sanitizeInput(feedback.getUsername()));

        // Business logic: Set default values
        if (feedback.getCategory() == null || feedback.getCategory().trim().isEmpty()) {
            feedback.setCategory("Other");
        }
        feedback.setResolved(false); // New feedback is always unresolved

        // Delegate to DAO for database operation
        feedbackDAO.saveFeedback(feedback);
    }

    public List<Feedback> getAllFeedback() {
        return feedbackDAO.getAllFeedback();
    }

    public List<Feedback> getFilteredFeedback(String category, Boolean resolved) {
        // Business logic: Validate category parameter
        if (category != null && !category.isEmpty() && !category.equals("all")) {
            if (!isValidCategory(category)) {
                throw new IllegalArgumentException("Invalid category: " + category);
            }
        }

        return feedbackDAO.getFilteredFeedback(category, resolved);
    }

    public void deleteFeedback(Long id) {
        // Business logic: Validate ID
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid feedback ID");
        }

        feedbackDAO.deleteFeedback(id);
    }

    public void resolveFeedback(Long id, Integer adminUserId) {
        // Business logic: Validate ID
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid feedback ID");
        }

        // Business logic: Validate admin user ID
        if (adminUserId == null || adminUserId <= 0) {
            throw new IllegalArgumentException("Invalid admin user ID");
        }

        feedbackDAO.resolveFeedback(id, adminUserId);
    }

    private void validateFeedback(Feedback feedback) {
        if (feedback == null) {
            throw new IllegalArgumentException("Feedback cannot be null");
        }

        // Validate username
        if (feedback.getUsername() == null || feedback.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username cannot be empty");
        }
        if (feedback.getUsername().length() > 100) {
            throw new IllegalArgumentException("Username too long (max 100 characters)");
        }

        // Validate title
        if (feedback.getTitle() == null || feedback.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be empty");
        }
        if (feedback.getTitle().length() > 200) {
            throw new IllegalArgumentException("Title too long (max 200 characters)");
        }

        // Validate message
        if (feedback.getMessage() == null || feedback.getMessage().trim().isEmpty()) {
            throw new IllegalArgumentException("Message cannot be empty");
        }
        if (feedback.getMessage().length() > 2000) {
            throw new IllegalArgumentException("Message too long (max 2000 characters)");
        }
    }

    /**
     * Sanitize input to prevent XSS attacks
     */
    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }

        // Trim whitespace
        String sanitized = input.trim();

        // Remove potentially dangerous HTML/script tags
        sanitized = sanitized.replaceAll("<script>", "")
                .replaceAll("</script>", "")
                .replaceAll("<iframe>", "")
                .replaceAll("</iframe>", "");

        return sanitized;
    }

    /**
     * Check if category is valid
     */
    private boolean isValidCategory(String category) {
        return "Usability".equals(category) ||
                "Content".equals(category) ||
                "Bug".equals(category) ||
                "Other".equals(category);
    }
}