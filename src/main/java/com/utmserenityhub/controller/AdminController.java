package com.utmserenityhub.controller;

import com.utmserenityhub.model.*;
import com.utmserenityhub.service.*;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private LearningModuleService moduleService;

    @Autowired
    private AssessmentService assessmentService;

    @Autowired
    private ForumService forumService;

    /*admin dashboard*/
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Map<String, Integer> userStats = userService.getUserStatistics();
        model.addAttribute("userStats", userStats);

        int totalAppointments = appointmentService.countAllAppointments();
        int totalAssessments = assessmentService.countAllResults();
        int totalPosts = forumService.countAllThreads();
        int totalModules = moduleService.getActiveModulesCount();

        model.addAttribute("totalAppointments", totalAppointments);
        model.addAttribute("totalAssessments", totalAssessments);
        model.addAttribute("totalPosts", totalPosts);
        model.addAttribute("totalModules", totalModules);

        AppointmentService.AppointmentStatistics appointmentStats = appointmentService.getStatistics();
        model.addAttribute("appointmentStats", appointmentStats);

        AssessmentService.AssessmentStatistics assessmentStats = assessmentService.getStatistics();
        model.addAttribute("assessmentStats", assessmentStats);

        List<User> recentUsers = userService.getRecentUsers(10);
        model.addAttribute("recentUsers", recentUsers);

        return "admin/dashboard";
    }

    /*view all users*/
    @GetMapping("/users")
    public String manageUsers(@RequestParam(required = false) String type, Model model) {
        List<User> users;

        if (type != null && !type.isEmpty()) {
            users = userService.getUsersByType(User.UserType.valueOf(type.toUpperCase()));
        } else {
            users = userService.getAllUsers();
        }

        model.addAttribute("users", users);
        model.addAttribute("filterType", type);

        return "admin/users";
    }

    /*view user details*/
    @GetMapping("/user/{userId}")
    public String viewUser(@PathVariable int userId, Model model) {
        User user = userService.findById(userId);

        if (user == null) {
            return "redirect:/admin/users";
        }

        model.addAttribute("user", user);

        if (user.getUserType() == User.UserType.STUDENT) {
            Student student = studentService.getStudentByUserId(userId);
            model.addAttribute("student", student);

            List<Map<String, Object>> activities = userService.getUserActivities(userId, 10);
            model.addAttribute("activities", activities);
        }

        return "admin/user-details";
    }

    /*create user form*/
    @GetMapping("/user/create")
    public String createUserForm(Model model) {
        model.addAttribute("user", new User());
        return "admin/user-create";
    }

    /*create user*/
    @PostMapping("/user/create")
    public String createUser(@ModelAttribute User user,
            @RequestParam String password,
            @RequestParam(required = false) String studentNumber,
            RedirectAttributes redirectAttributes) {
        try {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(10));
            user.setPasswordHash(hashedPassword);

            int userId = userService.createUser(user);

            if (user.getUserType() == User.UserType.STUDENT) {
                Student student = new Student();
                student.setUserId(userId);
                student.setStudentNumber(studentNumber);
                studentService.createStudent(student);
            }

            redirectAttributes.addFlashAttribute("success", "User created successfully");
            return "redirect:/admin/users";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create user: " + e.getMessage());
            return "redirect:/admin/user/create";
        }
    }

    /*edit user form*/
    @GetMapping("/user/{userId}/edit")
    public String editUserForm(@PathVariable int userId, Model model) {
        User user = userService.findById(userId);

        if (user == null) {
            return "redirect:/admin/users";
        }

        model.addAttribute("user", user);

        if (user.getUserType() == User.UserType.STUDENT) {
            Student student = studentService.getStudentByUserId(userId);
            model.addAttribute("student", student);
        }

        return "admin/user-edit";
    }

    /*update user*/
    @PostMapping("/user/{userId}/update")
    public String updateUser(@PathVariable int userId,
            @ModelAttribute User user,
            RedirectAttributes redirectAttributes) {
        user.setUserId(userId);
        boolean success = userService.updateUser(user);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "User updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update user");
        }

        return "redirect:/admin/user/" + userId;
    }

    /*deactivate user*/
    @PostMapping("/user/{userId}/deactivate")
    public String deactivateUser(@PathVariable int userId, RedirectAttributes redirectAttributes) {
        boolean success = userService.deactivateUser(userId);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "User deactivated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to deactivate user");
        }

        return "redirect:/admin/users";
    }

    /*activate user*/
    @PostMapping("/user/{userId}/activate")
    public String activateUser(@PathVariable int userId, RedirectAttributes redirectAttributes) {
        boolean success = userService.activateUser(userId);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "User activated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to activate user");
        }

        return "redirect:/admin/users";
    }

    /*delete user*/
    @PostMapping("/user/{userId}/delete")
    public String deleteUser(@PathVariable int userId, RedirectAttributes redirectAttributes) {
        boolean success = userService.deleteUser(userId);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "User deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete user");
        }

        return "redirect:/admin/users";
    }

    /*manage learning modules*/
    @GetMapping("/modules")
    public String manageModules(Model model) {
        List<LearningModule> modules = moduleService.getAllModules();
        model.addAttribute("modules", modules);
        return "admin/modules";
    }

    /*create module form*/
    @GetMapping("/module/create")
    public String createModuleForm(Model model) {
        model.addAttribute("module", new LearningModule());
        return "admin/module-create";
    }

    /*create module*/
    @PostMapping("/module/create")
    public String createModule(@ModelAttribute LearningModule module,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Integer userId = (Integer) session.getAttribute("userId");
        module.setCreatedBy(userId);

        if (moduleService.validateModule(module)) {
            int moduleId = moduleService.createModule(module);
            redirectAttributes.addFlashAttribute("success", "Module created successfully");
            return "redirect:/admin/modules";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid module data");
            return "redirect:/admin/module/create";
        }
    }

    /*edit module form*/
    @GetMapping("/module/{moduleId}/edit")
    public String editModuleForm(@PathVariable int moduleId, Model model) {
        LearningModule module = moduleService.getModuleById(moduleId);

        if (module == null) {
            return "redirect:/admin/modules";
        }

        model.addAttribute("module", module);
        return "admin/module-edit";
    }

    /*update module*/
    @PostMapping("/module/{moduleId}/update")
    public String updateModule(@PathVariable int moduleId,
            @ModelAttribute LearningModule module,
            RedirectAttributes redirectAttributes) {
        module.setModuleId(moduleId);

        if (moduleService.updateModule(module)) {
            redirectAttributes.addFlashAttribute("success", "Module updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update module");
        }

        return "redirect:/admin/modules";
    }

    /*module status*/
    @PostMapping("/module/{moduleId}/toggle")
    public String toggleModuleStatus(@PathVariable int moduleId,
            @RequestParam boolean active,
            RedirectAttributes redirectAttributes) {
        boolean success = moduleService.updateModule(moduleService.getModuleById(moduleId));

        if (success) {
            redirectAttributes.addFlashAttribute("success", "Module status updated");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update module status");
        }

        return "redirect:/admin/modules";
    }

    /*delete module*/
    @PostMapping("/module/{moduleId}/delete")
    public String deleteModule(@PathVariable int moduleId, RedirectAttributes redirectAttributes) {
        boolean success = moduleService.deleteModule(moduleId);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "Module deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete module");
        }

        return "redirect:/admin/modules";
    }

    /*manage forum*/
    @GetMapping("/forum")
    public String manageForum(Model model) {
        List<Map<String, Object>> threads = forumService.getAllThreads();
        model.addAttribute("threads", threads);
        return "admin/forum";
    }

    /*delete forum thread*/
    @PostMapping("/forum/thread/{threadId}/delete")
    public String deleteThread(@PathVariable int threadId, RedirectAttributes redirectAttributes) {
        boolean success = forumService.deleteThread(threadId);

        if (success) {
            redirectAttributes.addFlashAttribute("success", "Thread deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete thread");
        }

        return "redirect:/admin/forum";
    }

    /*report page*/
    @GetMapping("/reports")
    public String reports(Model model) {
        model.addAttribute("userStats", userService.getUserStatistics());
        model.addAttribute("appointmentStats", appointmentService.getStatistics());
        model.addAttribute("assessmentStats", assessmentService.getStatistics());

        return "admin/reports";
    }

    /*export report*/
    @GetMapping("/reports/users/export")
    public String exportUserReport() {
        // patutnya generate a PDF report, tapi tak berfungsi lagi
        // implementation kena guna iText library
        return "redirect:/admin/reports";
    }
}
