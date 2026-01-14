package com.utmserenityhub.controller;

import com.utmserenityhub.model.*;
import com.utmserenityhub.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private LearningModuleService moduleService;

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private AssessmentService assessmentService;

    @Autowired
    private ForumService forumService;

    /* student dashboard */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (studentId == null || userId == null) {
            return "redirect:/login";
        }

        Student student = studentService.getStudentByUserId(userId);
        model.addAttribute("student", student);

        int completedModules = moduleService.getCompletedModulesCount(studentId);
        int totalModules = moduleService.getActiveModulesCount();
        int progressPercentage = totalModules > 0 ? (completedModules * 100 / totalModules) : 0;

        model.addAttribute("completedModules", completedModules);
        model.addAttribute("totalModules", totalModules);
        model.addAttribute("progressPercentage", progressPercentage);

        List<Map<String, Object>> recentActivities = userService.getUserActivities(userId, 5);
        model.addAttribute("recentActivities", recentActivities);

        List<Appointment> upcomingAppointments = appointmentService.getUpcomingAppointments(studentId, 3);
        model.addAttribute("upcomingAppointments", upcomingAppointments);

        List<AssessmentResult> recentAssessments = assessmentService.getRecentResults(studentId, 3);
        model.addAttribute("recentAssessments", recentAssessments);

        int totalAppointments = appointmentService.countStudentAppointments(studentId);
        int completedAssessments = assessmentService.countStudentAssessments(studentId);
        int forumPosts = forumService.countStudentPosts(studentId);

        model.addAttribute("totalAppointments", totalAppointments);
        model.addAttribute("completedAssessments", completedAssessments);
        model.addAttribute("forumPosts", forumPosts);

        return "student/dashboard";
    }

    /* learning module page */
    @GetMapping("/learning")
    public String learningModules(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            return "redirect:/login";
        }

        List<Map<String, Object>> modulesWithProgress = moduleService.getModulesWithProgress(studentId);
        model.addAttribute("modules", modulesWithProgress);

        return "student/learning";
    }

    /* view module content */
    @GetMapping("/module/{moduleId}")
    public String viewModule(@PathVariable int moduleId, HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (studentId == null) {
            return "redirect:/login";
        }

        LearningModule module = moduleService.getModuleById(moduleId);
        if (module == null || !module.isActive()) {
            return "redirect:/student/learning";
        }

        model.addAttribute("module", module);

        ModuleProgress progress = moduleService.getOrCreateProgress(studentId, moduleId);
        model.addAttribute("progress", progress);

        userService.logActivity(userId, "MODULE_VIEW", "Viewed module: " + module.getTitle());

        return "student/module-view";
    }

    /* update module progress */
    @PostMapping("/module/{moduleId}/progress")
    @ResponseBody
    public Map<String, Object> updateProgress(@PathVariable int moduleId,
            @RequestParam double progressPercentage,
            HttpSession session) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        boolean success = moduleService.updateProgress(studentId, moduleId, progressPercentage);

        return Map.of("success", success);
    }

    /* mark module as complete */
    @PostMapping("/module/{moduleId}/complete")
    public String completeModule(@PathVariable int moduleId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            return "redirect:/login";
        }

        boolean success = moduleService.updateProgress(studentId, moduleId, 100.0);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "Module completed! Great job!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update progress");
        }

        return "redirect:/student/module/" + moduleId;
    }

    /**
     * View available assessments
     */
    @GetMapping("/assessments")
    public String viewAssessments(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            return "redirect:/login";
        }

        // Get all active assessment types
        List<AssessmentType> assessmentTypes = assessmentService.getActiveAssessmentTypes();
        model.addAttribute("assessmentTypes", assessmentTypes);

        // Get student's assessment history
        List<AssessmentResult> assessmentHistory = assessmentService.getStudentAssessmentHistory(studentId);
        model.addAttribute("assessmentHistory", assessmentHistory);

        return "student/assessments";
    }

    /**
     * Take assessment - display questions
     * Changed from /assessment/{typeId} to /assessment/{typeId}/take for clarity
     */
    @GetMapping("/assessment/{typeId}")
    public String takeAssessment(@PathVariable int typeId,
            HttpSession session,
            Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            return "redirect:/login";
        }

        // Get assessment type
        AssessmentType assessmentType = assessmentService.getAssessmentTypeById(typeId);

        if (assessmentType == null || !assessmentType.isActive()) {
            return "redirect:/student/assessments";
        }

        // Get questions
        List<AssessmentQuestion> questions = assessmentService.getAssessmentQuestions(typeId);

        model.addAttribute("assessmentType", assessmentType);
        model.addAttribute("questions", questions);

        return "student/take-assessment";
    }

    /**
     * Submit assessment
     */
    @PostMapping("/assessment/{typeId}/submit")
    public String submitAssessment(@PathVariable int typeId,
            @RequestParam Map<String, String> answers,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (studentId == null) {
            return "redirect:/login";
        }

        try {
            // Process assessment
            AssessmentResult result = assessmentService.processAssessment(studentId, typeId, answers);

            if (result != null && result.getResultId() > 0) {
                // Log activity
                userService.logActivity(userId, "ASSESSMENT_COMPLETED",
                        "Completed assessment type ID: " + typeId);

                redirectAttributes.addFlashAttribute("success",
                        "Assessment completed successfully!");
                redirectAttributes.addFlashAttribute("newResultId", result.getResultId());

                // Redirect to view the result
                return "redirect:/student/assessment/result/" + result.getResultId();
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "Failed to save assessment results. Please try again.");
                return "redirect:/student/assessments";
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "An error occurred: " + e.getMessage());
            return "redirect:/student/assessments";
        }
    }

    /**
     * View specific assessment result
     */
    @GetMapping("/assessment/result/{resultId}")
    public String viewResult(@PathVariable int resultId,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            return "redirect:/login";
        }

        AssessmentResult result = assessmentService.getResultById(resultId);

        // Verify this result belongs to this student
        if (result == null || result.getStudentId() != studentId) {
            redirectAttributes.addFlashAttribute("error", "Assessment result not found.");
            return "redirect:/student/assessments";
        }

        model.addAttribute("result", result);

        return "student/assessment-result-detail";
    }

    /**
 * Chatbot Support Page - FIXED VERSION
 */
@GetMapping("/chatbot")
public String chatbot(HttpSession session, Model model) {
    // DEBUG: Print what's in the session
    System.out.println("=== Chatbot Endpoint Called ===");
    System.out.println("Session ID: " + session.getId());
    
    // Get session attributes
    Integer studentId = (Integer) session.getAttribute("studentId");
    Integer userId = (Integer) session.getAttribute("userId");
    String fullName = (String) session.getAttribute("fullName");
    
    System.out.println("studentId from session: " + studentId);
    System.out.println("userId from session: " + userId);
    System.out.println("fullName from session: " + fullName);
    
    // Check authentication - match the pattern used in dashboard() method
    if (studentId == null || userId == null) {
        System.out.println("Missing session attributes - redirecting to login");
        return "redirect:/login";
    }
    
    try {
        // Get student info
        Student student = studentService.getStudentByUserId(userId);
        
        if (student == null) {
            System.out.println("Student not found for userId: " + userId);
            return "redirect:/login";
        }
        
        model.addAttribute("student", student);
        
        // Log activity
        userService.logActivity(userId, "CHATBOT_ACCESS", "Accessed chatbot support");
        
        System.out.println("Successfully loaded chatbot page for student: " + student.getFullName());
        System.out.println("Returning view: student/chatbot");
        
        return "student/chatbot";
        
    } catch (Exception e) {
        System.err.println("ERROR in chatbot method: " + e.getMessage());
        e.printStackTrace();
        return "redirect:/student/dashboard";
    }
}

    /* appointment page */
    @GetMapping("/appointments")
    public String appointments(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            return "redirect:/login";
        }

        List<Appointment> appointments = appointmentService.getStudentAppointments(studentId);
        model.addAttribute("appointments", appointments);

        List<Counselor> counselors = studentService.getAvailableCounselors();
        model.addAttribute("counselors", counselors);

        return "student/appointments";
    }

    /* book appointment */
    @PostMapping("/appointment/book")
    public String bookAppointment(@ModelAttribute Appointment appointment,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (studentId == null) {
            return "redirect:/login";
        }

        appointment.setStudentId(studentId);
        appointment.setStatus(Appointment.Status.PENDING);

        boolean success = appointmentService.createAppointment(appointment);

        if (success) {
            userService.logActivity(userId, "APPOINTMENT_BOOKED", "Booked new appointment");
            redirectAttributes.addFlashAttribute("success",
                    "Appointment booked successfully. Waiting for counselor approval.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to book appointment. Please try again.");
        }

        return "redirect:/student/appointments";
    }

    /* profile page */
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        User user = userService.findById(userId);
        Student student = studentService.getStudentByUserId(userId);

        model.addAttribute("user", user);
        model.addAttribute("student", student);

        return "student/profile";
    }

    /* update profile */
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute User user,
            @ModelAttribute Student student,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        user.setUserId(userId);
        boolean userUpdated = userService.updateUser(user);

        student.setUserId(userId);
        boolean studentUpdated = studentService.updateStudent(student);

        if (userUpdated && studentUpdated) {
            session.setAttribute("fullName", user.getFullName());
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile");
        }

        return "redirect:/student/profile";
    }

    /* change password */
    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam String currentPassword,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "New passwords do not match");
            return "redirect:/student/profile";
        }

        boolean success = studentService.changePassword(userId, currentPassword, newPassword);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "Password changed successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
        }

        return "redirect:/student/profile";
    }
}
