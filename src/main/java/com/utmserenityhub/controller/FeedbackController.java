package com.utmserenityhub.controller;

import com.utmserenityhub.model.Feedback;
import com.utmserenityhub.service.FeedbackService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/student/feedback")
public class FeedbackController {

    private final FeedbackService feedbackService;

    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    // Show feedback form (User)
    @GetMapping("")
    public String showForm(Model model) {
        model.addAttribute("feedback", new Feedback());
        return "student/feedback_form"; // /WEB-INF/views/feedback_form.jsp
    }

    // Submit feedback
    @PostMapping("/save")
    public String saveFeedback(@ModelAttribute Feedback feedback, RedirectAttributes redirectAttributes) {
        try {
            // Delegate to service - all business logic happens there
            feedbackService.saveFeedback(feedback);
            redirectAttributes.addFlashAttribute("success", "Feedback submitted successfully!");
        } catch (IllegalArgumentException e) {
            // Handle validation errors from service
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            // Handle unexpected errors
            redirectAttributes.addFlashAttribute("error", "Failed to submit feedback. Please try again.");
        }
        
        return "redirect:/student/feedback";
    }

    
}