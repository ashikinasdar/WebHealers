package com.utmserenityhub.interceptor;

import com.utmserenityhub.model.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*interceptor to check authentication and authorization for protected routes*/
public class AuthenticationInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, 
                            HttpServletResponse response, 
                            Object handler) throws Exception {
        
        HttpSession session = request.getSession(false);
        String requestURI = request.getRequestURI();
        
        //check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        User user = (User) session.getAttribute("user");
        User.UserType userType = user.getUserType();
        
        //check role-based access
        if (requestURI.contains("/student/") && userType != User.UserType.STUDENT) {
            response.sendRedirect(request.getContextPath() + "/unauthorized");
            return false;
        }
        
        if (requestURI.contains("/counselor/") && userType != User.UserType.COUNSELOR) {
            response.sendRedirect(request.getContextPath() + "/unauthorized");
            return false;
        }
        
        if (requestURI.contains("/admin/") && userType != User.UserType.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/unauthorized");
            return false;
        }

        //user is authenticated and authorized
        return true;
    }
}
