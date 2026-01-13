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

@Controller
@RequestMapping("/counselor")
public class CounselorController {

    @Autowired
    private UserService userService;

    @Autowired
    private CounselorService counselorService;

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private AssessmentService assessmentService;

    /* counselor dashboard */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        Counselor counselor = counselorService.getCounselorByUserId(userId);
        model.addAttribute("counselor", counselor);

        List<Appointment> pendingAppointments = appointmentService.getPendingAppointments(counselorId);
        model.addAttribute("pendingAppointments", pendingAppointments);

        List<Appointment> allAppointments = appointmentService.getCounselorAppointments(counselorId);
        model.addAttribute("appointments", allAppointments);

        int totalAppointments = allAppointments.size();
        int pendingCount = pendingAppointments.size();
        int approvedCount = (int) allAppointments.stream()
                .filter(a -> a.getStatus() == Appointment.Status.APPROVED)
                .count();
        int completedCount = (int) allAppointments.stream()
                .filter(a -> a.getStatus() == Appointment.Status.COMPLETED)
                .count();

        model.addAttribute("totalAppointments", totalAppointments);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("approvedCount", approvedCount);
        model.addAttribute("completedCount", completedCount);

        return "counselor/dashboard";
    }

    /* appointment management */
    @GetMapping("/appointments")
    public String appointments(HttpSession session, Model model) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        List<Appointment> appointments = appointmentService.getCounselorAppointments(counselorId);
        model.addAttribute("appointments", appointments);

        return "counselor/appointments";
    }

    /* view appointment details */
    @GetMapping("/appointment/{appointmentId}")
    public String viewAppointment(@PathVariable int appointmentId,
            HttpSession session, Model model) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        // verify this appointment belongs to this counselor
        if (appointment == null || appointment.getCounselorId() != counselorId) {
            return "redirect:/counselor/appointments";
        }

        model.addAttribute("appointment", appointment);

        return "counselor/appointment-details";
    }

    /* approve appointment */
    @PostMapping("/appointment/{appointmentId}/approve")
    public String approveAppointment(@PathVariable int appointmentId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        if (appointment != null && appointment.getCounselorId() == counselorId) {
            boolean success = appointmentService.approveAppointment(appointmentId);

            if (success) {
                userService.logActivity(userId, "APPOINTMENT_APPROVED",
                        "Approved appointment #" + appointmentId);
                redirectAttributes.addFlashAttribute("success", "Appointment approved successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to approve appointment");
            }
        }

        return "redirect:/counselor/appointments";
    }

    /* decline appointment */
    @PostMapping("/appointment/{appointmentId}/decline")
    public String declineAppointment(@PathVariable int appointmentId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        if (appointment != null && appointment.getCounselorId() == counselorId) {
            boolean success = appointmentService.declineAppointment(appointmentId);

            if (success) {
                userService.logActivity(userId, "APPOINTMENT_DECLINED",
                        "Declined appointment #" + appointmentId);
                redirectAttributes.addFlashAttribute("success", "Appointment declined");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to decline appointment");
            }
        }

        return "redirect:/counselor/appointments";
    }

    /* complete appointment */
    @PostMapping("/appointment/{appointmentId}/complete")
    public String completeAppointment(@PathVariable int appointmentId,
            @RequestParam String counselorNotes,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");
        Integer userId = (Integer) session.getAttribute("userId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        if (appointment != null && appointment.getCounselorId() == counselorId) {
            boolean success = appointmentService.completeAppointment(appointmentId, counselorNotes);

            if (success) {
                userService.logActivity(userId, "APPOINTMENT_COMPLETED",
                        "Completed appointment #" + appointmentId);
                redirectAttributes.addFlashAttribute("success", "Appointment marked as completed");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to complete appointment");
            }
        }

        return "redirect:/counselor/appointments";
    }

    /* View Assessment Management Page */
    @GetMapping("/assessments")
    public String viewAssessments(Model model) {
        // Get all assessment results for counselor to review
        List<AssessmentResult> results = assessmentService.getAllResults();
        model.addAttribute("results", results);

        List<AssessmentType> assessmentTypes = assessmentService.getAllAssessmentTypes();
        model.addAttribute("assessmentTypes", assessmentTypes);

        return "counselor/assessments";
    }

    /* view student assessment result */
    @GetMapping("/assessment/{resultId}")
    public String viewAssessmentResult(@PathVariable int resultId, Model model) {
        AssessmentResult result = assessmentService.getResultById(resultId);

        if (result == null) {
            return "redirect:/counselor/assessments";
        }

        model.addAttribute("result", result);

        return "counselor/assessment-detail";
    }

    /* counselor profile */
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        User user = userService.findById(userId);
        Counselor counselor = counselorService.getCounselorByUserId(userId);

        model.addAttribute("user", user);
        model.addAttribute("counselor", counselor);

        return "counselor/profile";
    }

    /* update counselor profile */
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute User user,
            @ModelAttribute Counselor counselor,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        user.setUserId(userId);
        boolean userUpdated = userService.updateUser(user);

        counselor.setUserId(userId);
        boolean counselorUpdated = counselorService.updateCounselor(counselor);

        if (userUpdated && counselorUpdated) {
            session.setAttribute("fullName", user.getFullName());
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile");
        }

        return "redirect:/counselor/profile";
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
            return "redirect:/counselor/profile";
        }

        boolean success = counselorService.changePassword(userId, currentPassword, newPassword);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "Password changed successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Current password is incorrect");
        }
        return "redirect:/counselor/profile";
    }

    /* counselor availability */
    @GetMapping("/availability")
    public String manageAvailability(HttpSession session, Model model) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        // Get counselor availability
        // This would require CounselorService

        return "counselor/availability";
    }

    /* update availability */
    @PostMapping("/availability/update")
    public String updateAvailability(@RequestParam String availableDays,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer counselorId = (Integer) session.getAttribute("counselorId");

        if (counselorId == null) {
            return "redirect:/login";
        }

        // Update counselor availability
        // This would require CounselorService

        redirectAttributes.addFlashAttribute("success", "Availability updated successfully");
        return "redirect:/counselor/availability";
    }

    /* view assessment questions by type */
    @GetMapping("/assessment/{typeId}/questions")
    public String viewQuestions(@PathVariable int typeId, Model model) {
        AssessmentType assessmentType = assessmentService.getAssessmentTypeById(typeId);

        if (assessmentType == null) {
            return "redirect:/counselor/assessments";
        }

        List<AssessmentQuestion> questions = assessmentService.getAssessmentQuestions(typeId);

        model.addAttribute("assessmentType", assessmentType);
        model.addAttribute("questions", questions);

        return "counselor/assessment-questions";
    }

    /**
     * Create new assessment type
     */
    @PostMapping("/assessment/type/create")
    public String createAssessmentType(@RequestParam String name,
            @RequestParam String description,
            @RequestParam String scoringMethod,
            @RequestParam(defaultValue = "true") boolean isActive,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        try {
            AssessmentType assessmentType = new AssessmentType();
            assessmentType.setName(name);
            assessmentType.setDescription(description);
            assessmentType.setScoringMethod(scoringMethod);
            assessmentType.setActive(isActive);
            assessmentType.setTotalQuestions(0); // Start with 0 questions

            int typeId = assessmentService.createAssessmentType(assessmentType);

            if (typeId > 0) {
                userService.logActivity(userId, "ASSESSMENT_TYPE_CREATED",
                        "Created assessment type: " + name);
                redirectAttributes.addFlashAttribute("success",
                        "Assessment type '" + name + "' created successfully! You can now add questions to it.");
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "Failed to create assessment type. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }

        return "redirect:/counselor/assessments";
    }

    /**
     * Toggle assessment type active status
     */
    @PostMapping("/assessment/type/{typeId}/toggle")
    public String toggleAssessmentType(@PathVariable int typeId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        try {
            boolean success = assessmentService.toggleAssessmentTypeStatus(typeId);

            if (success) {
                userService.logActivity(userId, "ASSESSMENT_TYPE_TOGGLED",
                        "Toggled status for assessment type ID: " + typeId);
                redirectAttributes.addFlashAttribute("success",
                        "Assessment type status updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error",
                        "Failed to update assessment type status.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "Error: " + e.getMessage());
        }

        return "redirect:/counselor/assessments";
    }

    /* create assessment question */
    @PostMapping("/assessment/question/create")
    public String createQuestion(@RequestParam int assessmentTypeId,
            @RequestParam String questionText,
            @RequestParam String category,
            @RequestParam int displayOrder,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        AssessmentQuestion question = new AssessmentQuestion();
        question.setAssessmentTypeId(assessmentTypeId);
        question.setQuestionText(questionText);
        question.setCategory(category);
        question.setDisplayOrder(displayOrder);

        try {
            int questionId = assessmentService.createQuestion(question);

            if (questionId > 0) {
                userService.logActivity(userId, "QUESTION_CREATED",
                        "Created assessment question #" + questionId);
                redirectAttributes.addFlashAttribute("success", "Question created successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to create question");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }

        return "redirect:/counselor/assessment/" + assessmentTypeId + "/questions";
    }

    /* edit assessment question */
    @PostMapping("/assessment/question/{questionId}/edit")
    public String editQuestion(@PathVariable int questionId,
            @RequestParam int assessmentTypeId,
            @RequestParam String questionText,
            @RequestParam String category,
            @RequestParam int displayOrder,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        AssessmentQuestion question = new AssessmentQuestion();
        question.setAssessmentQuestionId(questionId);
        question.setAssessmentTypeId(assessmentTypeId);
        question.setQuestionText(questionText);
        question.setCategory(category);
        question.setDisplayOrder(displayOrder);

        try {
            boolean success = assessmentService.updateQuestion(question);

            if (success) {
                userService.logActivity(userId, "QUESTION_UPDATED",
                        "Updated assessment question #" + questionId);
                redirectAttributes.addFlashAttribute("success", "Question updated successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to update question");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }

        return "redirect:/counselor/assessment/" + assessmentTypeId + "/questions";
    }

    /* delete assessment question */
    @PostMapping("/assessment/question/{questionId}/delete")
    public String deleteQuestion(@PathVariable int questionId,
            @RequestParam int assessmentTypeId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            return "redirect:/login";
        }

        try {
            boolean success = assessmentService.deleteQuestion(questionId);

            if (success) {
                userService.logActivity(userId, "QUESTION_DELETED",
                        "Deleted assessment question #" + questionId);
                redirectAttributes.addFlashAttribute("success", "Question deleted successfully");
            } else {
                redirectAttributes.addFlashAttribute("error", "Failed to delete question");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: " + e.getMessage());
        }

        return "redirect:/counselor/assessment/" + assessmentTypeId + "/questions";
    }
}
