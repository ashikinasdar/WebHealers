package com.utmserenityhub.controller;

import com.utmserenityhub.service.ForumService;
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
@RequestMapping("/student/forum")
public class ForumController {
    
    @Autowired
    private ForumService forumService;
    
    @Autowired
    private UserService userService;
    
    /*home-list all forum threads*/
    @GetMapping("")
    public String forumHome(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        List<Map<String, Object>> threads = forumService.getAllThreads();
        model.addAttribute("threads", threads);
        model.addAttribute("currentStudentId", studentId);
        
        return "student/forum/index";
    }
    
    /*search forum*/
    @GetMapping("/search")
    public String searchForum(@RequestParam String keyword, 
                             HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        List<Map<String, Object>> threads = forumService.searchThreads(keyword);
        model.addAttribute("threads", threads);
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentStudentId", studentId);
        
        return "student/forum/search";
    }
    
    /*view thread replies*/
    @GetMapping("/thread/{threadId}")
    public String viewThread(@PathVariable int threadId, 
                            HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        Map<String, Object> thread = forumService.getThreadById(threadId);
        
        if (thread == null) {
            return "redirect:/student/forum";
        }
        
        List<Map<String, Object>> replies = forumService.getRepliesByThreadId(threadId);
        
        model.addAttribute("thread", thread);
        model.addAttribute("replies", replies);
        model.addAttribute("currentStudentId", studentId);
        model.addAttribute("hasLiked", forumService.hasLikedThread(studentId, threadId));
        
        return "student/forum/thread";
    }
    
    /*create thread form*/
    @GetMapping("/create")
    public String createThreadForm() {
        return "student/forum/create";
    }
    
    /*create thread*/
    @PostMapping("/create")
    public String createThread(@RequestParam String title,
                              @RequestParam String content,
                              @RequestParam(defaultValue = "false") boolean isAnonymous,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        try {
            int threadId = forumService.createThread(studentId, title, content, isAnonymous);
            
            userService.logActivity(userId, "FORUM_POST_CREATED", "Created new forum thread");
            
            redirectAttributes.addFlashAttribute("success", "Thread created successfully");
            return "redirect:/student/forum/thread/" + threadId;
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create thread");
            return "redirect:/student/forum/create";
        }
    }
    
    /*edit thread form*/
    @GetMapping("/thread/{threadId}/edit")
    public String editThreadForm(@PathVariable int threadId, 
                                HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        Map<String, Object> thread = forumService.getThreadById(threadId);
        
        if (thread == null) {
            return "redirect:/student/forum";
        }
        
        // check if user is the thread author
        int threadStudentId = (Integer) thread.get("student_id");
        if (threadStudentId != studentId) {
            return "redirect:/student/forum/thread/" + threadId;
        }
        
        model.addAttribute("thread", thread);
        
        return "student/forum/edit";
    }
    
    /*update thread*/
    @PostMapping("/thread/{threadId}/update")
    public String updateThread(@PathVariable int threadId,
                              @RequestParam String title,
                              @RequestParam String content,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        Map<String, Object> thread = forumService.getThreadById(threadId);
        
        if (thread != null) {
            int threadStudentId = (Integer) thread.get("student_id");
            
            if (threadStudentId == studentId) {
                boolean success = forumService.updateThread(threadId, title, content);
                
                if (success) {
                    redirectAttributes.addFlashAttribute("success", "Thread updated successfully");
                } else {
                    redirectAttributes.addFlashAttribute("error", "Failed to update thread");
                }
            }
        }
        
        return "redirect:/student/forum/thread/" + threadId;
    }
    
    /*delete thread*/
    @PostMapping("/thread/{threadId}/delete")
    public String deleteThread(@PathVariable int threadId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        Map<String, Object> thread = forumService.getThreadById(threadId);
        
        if (thread != null) {
            int threadStudentId = (Integer) thread.get("student_id");
            
            if (threadStudentId == studentId) {
                boolean success = forumService.deleteThread(threadId);
                
                if (success) {
                    userService.logActivity(userId, "FORUM_POST_DELETED", "Deleted forum thread");
                    redirectAttributes.addFlashAttribute("success", "Thread deleted successfully");
                } else {
                    redirectAttributes.addFlashAttribute("error", "Failed to delete thread");
                }
            }
        }
        
        return "redirect:/student/forum";
    }

    /*like/unlike thread*/
    @PostMapping("/thread/{threadId}/like")
    @ResponseBody
    public Map<String, Object> likeThread(@PathVariable int threadId, HttpSession session) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return Map.of("success", false, "message", "Not authenticated");
        }
        
        boolean liked = forumService.likeThread(studentId, threadId);
        
        return Map.of(
            "success", true,
            "liked", liked,
            "message", liked ? "Thread liked" : "Thread unliked"
        );
    }
    
    /*create reply*/
    @PostMapping("/thread/{threadId}/reply")
    public String createReply(@PathVariable int threadId,
                             @RequestParam String content,
                             @RequestParam(defaultValue = "false") boolean isAnonymous,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        try {
            forumService.createReply(threadId, studentId, content, isAnonymous);
            
            userService.logActivity(userId, "FORUM_REPLY_CREATED", "Replied to forum thread");
            
            redirectAttributes.addFlashAttribute("success", "Reply posted successfully");
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to post reply");
        }
        
        return "redirect:/student/forum/thread/" + threadId;
    }
    
    /*update reply*/
    @PostMapping("/reply/{replyId}/update")
    public String updateReply(@PathVariable int replyId,
                             @RequestParam String content,
                             @RequestParam int threadId,
                             RedirectAttributes redirectAttributes) {
        boolean success = forumService.updateReply(replyId, content);
        
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Reply updated successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update reply");
        }
        
        return "redirect:/student/forum/thread/" + threadId;
    }
    
    /*delete reply*/
    @PostMapping("/reply/{replyId}/delete")
    public String deleteReply(@PathVariable int replyId,
                             @RequestParam int threadId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        boolean success = forumService.deleteReply(replyId, threadId);
        
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Reply deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete reply");
        }
        
        return "redirect:/student/forum/thread/" + threadId;
    }
    
    /*like/unlike reply*/
    @PostMapping("/reply/{replyId}/like")
    @ResponseBody
    public Map<String, Object> likeReply(@PathVariable int replyId, HttpSession session) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return Map.of("success", false, "message", "Not authenticated");
        }
        
        boolean liked = forumService.likeReply(studentId, replyId);
        
        return Map.of(
            "success", true,
            "liked", liked,
            "message", liked ? "Reply liked" : "Reply unliked"
        );
    }
    
    /*my posts*/
    @GetMapping("/my-posts")
    public String myPosts(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        List<Map<String, Object>> threads = forumService.getThreadsByStudentId(studentId);
        model.addAttribute("threads", threads);
        model.addAttribute("currentStudentId", studentId);
        
        return "student/forum/my-posts";
    }
    
    /*popular threads*/
    @GetMapping("/popular")
    public String popularThreads(HttpSession session, Model model) {
        Integer studentId = (Integer) session.getAttribute("studentId");
        
        if (studentId == null) {
            return "redirect:/login";
        }
        
        List<Map<String, Object>> threads = forumService.getPopularThreads(20);
        model.addAttribute("threads", threads);
        model.addAttribute("currentStudentId", studentId);
        
        return "student/forum/popular";
    }
}
