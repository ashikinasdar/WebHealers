package com.utmserenityhub.controller;

import com.utmserenityhub.service.MoodService;
import com.utmserenityhub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student/mood")
public class MoodController {
    
    @Autowired
    private MoodService moodService;
    
    @Autowired
    private UserService userService;
    
    /**
     * Show mood check-in page
     */
    @GetMapping("/checkin")
    public String moodCheckinPage(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        // Check if already checked in today
        boolean hasCheckedIn = moodService.hasCheckedInToday(studentId);
        model.addAttribute("hasCheckedIn", hasCheckedIn);
        
        if (hasCheckedIn) {
            Map<String, Object> todayCheckin = moodService.getTodayCheckin(studentId);
            model.addAttribute("todayCheckin", todayCheckin);
        }
        
        // Get streak
        int streak = moodService.getCheckinStreak(studentId);
        model.addAttribute("streak", streak);
        
        return "student/mood/checkin";
    }
    
    /**
     * Submit mood check-in
     */
    @PostMapping("/checkin")
    public String submitMoodCheckin(@RequestParam int moodRating,
                                   @RequestParam(required = false) String notes,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        // Check if already checked in today
        if (moodService.hasCheckedInToday(studentId)) {
            redirectAttributes.addFlashAttribute("error", "You have already checked in today!");
            return "redirect:/student/mood/checkin";
        }
        
        try {
            moodService.createMoodCheckin(studentId, moodRating, notes);
            
            // Log activity
            userService.logActivity(userId, "MOOD_CHECKIN", "Checked in mood: " + moodRating);
            
            redirectAttributes.addFlashAttribute("success", "Mood checked in successfully!");
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to check in mood. Please try again.");
        }
        
        return "redirect:/student/mood/checkin";
    }
    
    /**
     * Update today's mood check-in
     */
    @PostMapping("/checkin/update")
    public String updateMoodCheckin(@RequestParam int checkinId,
                                   @RequestParam int moodRating,
                                   @RequestParam(required = false) String notes,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        try {
            boolean success = moodService.updateMoodCheckin(checkinId, moodRating, notes);
            
            if (success) {
                redirectAttributes.addFlashAttribute("success", "Mood check-in updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to update mood check-in.");
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update mood check-in. Please try again.");
        }
        
        return "redirect:/student/mood/checkin";
    }
    
    /**
     * Show mood history page
     */
    @GetMapping("/history")
    public String moodHistory(@RequestParam(defaultValue = "30") int days,
                             HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }

        // Get mood history
        List<Map<String, Object>> moodHistory = moodService.getMoodHistory(studentId, days);
        model.addAttribute("moodHistory", moodHistory);
        model.addAttribute("days", days);

        // Get statistics
        int totalCheckins = moodService.getTotalCheckinCount(studentId);
        Double averageMood = moodService.getAverageMood(studentId);
        Double weeklyAverage = moodService.getAverageMoodForPeriod(studentId, 7);
        Double monthlyAverage = moodService.getAverageMoodForPeriod(studentId, 30);
        Integer mostCommonMood = moodService.getMostCommonMood(studentId);
        int streak = moodService.getCheckinStreak(studentId);
        
        // Get mood distribution
        List<Map<String, Object>> moodDistribution = moodService.getMoodDistribution(studentId);
        List<Map<String, Object>> weeklyDistribution = moodService.getMoodDistributionForPeriod(studentId, 7);
        
        // Get mood trend
        Map<String, Object> moodTrend = moodService.getMoodTrend(studentId);
        
        // Get recent history for chart
        List<Map<String, Object>> recentHistory = moodService.getMoodHistory(studentId, 30);
        
        model.addAttribute("totalCheckins", totalCheckins);
        model.addAttribute("averageMood", averageMood != null ? String.format("%.1f", averageMood) : "N/A");
        model.addAttribute("weeklyAverage", weeklyAverage != null ? String.format("%.1f", weeklyAverage) : "N/A");
        model.addAttribute("monthlyAverage", monthlyAverage != null ? String.format("%.1f", monthlyAverage) : "N/A");
        model.addAttribute("mostCommonMood", mostCommonMood);
        model.addAttribute("streak", streak);
        model.addAttribute("moodDistribution", moodDistribution);
        model.addAttribute("weeklyDistribution", weeklyDistribution);
        model.addAttribute("moodTrend", moodTrend);
        model.addAttribute("recentHistory", recentHistory);
        
        return "student/mood/history";
    }

    
    /**
     * Delete mood check-in
     */
    @PostMapping("/checkin/{checkinId}/delete")
    public String deleteMoodCheckin(@PathVariable int checkinId,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        try {
            boolean success = moodService.deleteMoodCheckin(checkinId);
            
            if (success) {
                redirectAttributes.addFlashAttribute("success", "Mood check-in deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to delete mood check-in.");
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete mood check-in. Please try again.");
        }
        
        return "redirect:/student/mood/history";
    }
    
    /**
     * Get mood data as JSON (for charts)
     */
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getMoodData(@RequestParam(defaultValue = "30") int days,
                                          HttpSession session) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return Map.of("error", "Not authenticated");
        }
        
        List<Map<String, Object>> history = moodService.getMoodHistory(studentId, days);
        List<Map<String, Object>> distribution = moodService.getMoodDistributionForPeriod(studentId, days);
        
        return Map.of(
            "history", history,
            "distribution", distribution
        );
    }
}

