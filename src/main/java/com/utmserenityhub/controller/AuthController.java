package com.utmserenityhub.controller;

import com.utmserenityhub.model.User;
import com.utmserenityhub.model.Counselor;
import com.utmserenityhub.model.Student;
import com.utmserenityhub.service.UserService;
import com.utmserenityhub.service.StudentService;
import com.utmserenityhub.service.CounselorService;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    @Autowired
    private CounselorService counselorService;

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;

    // login page
    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLoginPage(Model model, HttpSession session) {
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return redirectToDashboard(user.getUserType());
        }
        return "auth/login";
    }

    // handle login
    @PostMapping("/login")
    public String login(@RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        try {
            User user = userService.findByEmail(email);

            if (user == null) {
                redirectAttributes.addFlashAttribute("error", "Invalid email or password");
                return "redirect:/login";
            }

            if (!BCrypt.checkpw(password, user.getPasswordHash())) {
                redirectAttributes.addFlashAttribute("error", "Invalid email or password");
                return "redirect:/login";
            }

            // check if account is active, if not active cannot login
            if (!user.isActive()) {
                redirectAttributes.addFlashAttribute("error",
                        "Your account has been deactivated. Please contact admin.");
                return "redirect:/login";
            }

            // update last login
            userService.updateLastLogin(user.getUserId());

            // set common session attributes
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userType", user.getUserType().toString());
            session.setAttribute("fullName", user.getFullName());

            // if the user is a student
            if (user.getUserType() == User.UserType.STUDENT) {
                Student student = studentService.getStudentByUserId(user.getUserId());
                if (student != null) {
                    session.setAttribute("studentId", student.getStudentId());
                }
            }

            // if the user is a counselor
            if (user.getUserType() == User.UserType.COUNSELOR) {
                Counselor counselor = counselorService.getCounselorByUserId(user.getUserId());
                if (counselor != null) {
                    session.setAttribute("counselorId", counselor.getCounselorId());
                }
            }

            // log activity
            userService.logActivity(user.getUserId(), "LOGIN", "User logged in successfully");

            // redirect to appropriate dashboard
            return "redirect:" + redirectToDashboard(user.getUserType());

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "An error occurred during login. Please try again.");
            return "redirect:/login";
        }
    }

    // registration page
    @GetMapping("/register")
    public String showRegistrationPage() {
        return "auth/register";
    }

    // handle registration
    @PostMapping("/register")
    public String register(@RequestParam String email,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String fullName,
            @RequestParam(required = false) String studentNumber,
            @RequestParam(required = false) String phone,
            RedirectAttributes redirectAttributes) {

        try {
            if (!password.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Passwords do not match");
                return "redirect:/register";
            }

            if (password.length() < 6) {
                redirectAttributes.addFlashAttribute("error", "Password must be at least 6 characters");
                return "redirect:/register";
            }

            // check if email already exists
            if (userService.findByEmail(email) != null) {
                redirectAttributes.addFlashAttribute("error", "Email already registered");
                return "redirect:/register";
            }

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(10));

            // create user
            User user = new User(email, hashedPassword, fullName, User.UserType.STUDENT);
            user.setPhone(phone);

            int userId = userService.createUser(user);

            // create student profile
            Student student = new Student();
            student.setUserId(userId);
            student.setStudentNumber(studentNumber);
            studentService.createStudent(student);

            // log activity
            userService.logActivity(userId, "REGISTRATION", "New user registered");

            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
            return "redirect:/login";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Registration failed. Please try again.");
            return "redirect:/register";
        }
    }

    // handle logout
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            userService.logActivity(user.getUserId(), "LOGOUT", "User logged out");
        }
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "You have been logged out successfully");
        return "redirect:/login";
    }

    // helper method to redirect to appropriate dashboard
    private String redirectToDashboard(User.UserType userType) {
        switch (userType) {
            case STUDENT:
                return "/student/dashboard";
            case COUNSELOR:
                return "/counselor/dashboard";
            case ADMIN:
                return "/admin/dashboard";
            default:
                return "/login";
        }
    }
}
