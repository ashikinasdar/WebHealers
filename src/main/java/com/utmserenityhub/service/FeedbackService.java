package com.utmserenityhub.service;

import com.utmserenityhub.dao.FeedbackDAO;
import com.utmserenityhub.model.Feedback;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FeedbackService {

    private final FeedbackDAO feedbackDAO;

    public FeedbackService(FeedbackDAO feedbackDAO) {
        this.feedbackDAO = feedbackDAO;
    }

    public void saveFeedback(Feedback feedback) {
        feedbackDAO.saveFeedback(feedback);
    }

    public List<Feedback> getAllFeedback() {
        return feedbackDAO.getAllFeedback();
    }

    public void deleteFeedback(Long id) {
        feedbackDAO.deleteFeedback(id);
    }

    public void resolveFeedback(Long id) {
        feedbackDAO.resolveFeedback(id);
    }
}