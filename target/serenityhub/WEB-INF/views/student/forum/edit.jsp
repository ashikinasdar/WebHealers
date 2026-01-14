<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Thread - SerenityHub Forum</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
            padding: 0;
            position: fixed;
            width: 250px;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 15px 25px;
            border-left: 3px solid transparent;
            transition: all 0.3s;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            color: white;
            background: rgba(255,255,255,0.1);
            border-left-color: white;
        }
        .sidebar .nav-link i {
            margin-right: 10px;
            width: 20px;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .navbar {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 900px;
            margin: 0 auto;
        }
        .brand-section {
            padding: 30px 25px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .brand-logo {
            font-size: 32px;
            color: white;
            margin-bottom: 5px;
        }
        .brand-text {
            color: white;
            font-size: 18px;
            font-weight: 600;
            margin: 0;
        }
        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #e2e8f0;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 40px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        .btn-submit:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        .info-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        .char-count {
            font-size: 12px;
            color: #718096;
            text-align: right;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <!-- side navigation bar -->
    <div class="sidebar">
        <div class="brand-section">
            <div class="brand-logo">
                <i class="fas fa-heart"></i>
            </div>
            <p class="brand-text">SerenityHub</p>
        </div>
        <nav class="nav flex-column mt-4">
            <a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/learning">
                <i class="fas fa-book"></i> Learning
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/assessments">
                <i class="fas fa-clipboard-check"></i> Assessments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/appointments">
                <i class="fas fa-calendar"></i> Counseling
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/forum">
                <i class="fas fa-comments"></i> Forum
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/mood/checkin">
                <i class="fas fa-smile"></i> Mood Tracker
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/chatbot">
                <i class="fas fa-user"></i> Chatbot
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/profile">
                <i class="fas fa-user"></i> Profile
            </a>
            <hr style="border-color: rgba(255,255,255,0.1); margin: 20px 25px;">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light rounded">
            <div class="container-fluid">
                <a href="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}" 
                   class="text-decoration-none text-dark">
                    <i class="fas fa-arrow-left me-2"></i>Back to Thread
                </a>
            </div>
        </nav>

        <!-- Form Container -->
        <div class="form-container">
            <h3 class="mb-4">
                <i class="fas fa-edit me-2" style="color: #667eea;"></i>
                Edit Discussion
            </h3>

            <div class="info-box">
                <i class="fas fa-info-circle me-2"></i>
                <strong>Note:</strong> You can edit the title and content of your thread. 
                The anonymous status cannot be changed after posting.
            </div>

            <form action="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}/update" 
                  method="post" id="editThreadForm">
                
                <!-- Thread Title -->
                <div class="mb-4">
                    <label for="title" class="form-label">
                        <i class="fas fa-heading me-2"></i>Thread Title
                    </label>
                    <input type="text" 
                           class="form-control" 
                           id="title" 
                           name="title" 
                           value="${thread.title}"
                           required 
                           maxlength="200"
                           oninput="updateCharCount('title', 'titleCount', 200)">
                    <div class="char-count">
                        <span id="titleCount">${thread.title.length()}</span>/200 characters
                    </div>
                </div>

                <!-- Thread Content -->
                <div class="mb-4">
                    <label for="content" class="form-label">
                        <i class="fas fa-align-left me-2"></i>Content
                    </label>
                    <textarea class="form-control" 
                              id="content" 
                              name="content" 
                              rows="10" 
                              required
                              oninput="updateCharCount('content', 'contentCount', 5000)">${thread.content}</textarea>
                    <div class="char-count">
                        <span id="contentCount">${thread.content.length()}</span>/5000 characters
                    </div>
                </div>

                <!-- Anonymous Status (Read-only) -->
                <div class="mb-4">
                    <div class="alert alert-info">
                        <i class="fas fa-lock me-2"></i>
                        <strong>Posting Status:</strong> 
                        <c:choose>
                            <c:when test="${thread.is_anonymous}">
                                This thread is posted <strong>anonymously</strong>
                            </c:when>
                            <c:otherwise>
                                This thread is posted with <strong>your name</strong>
                            </c:otherwise>
                        </c:choose>
                        (cannot be changed)
                    </div>
                </div>

                <!-- Submit Buttons -->
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}" 
                       class="btn btn-outline-secondary">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                    <button type="submit" class="btn btn-submit">
                        <i class="fas fa-save me-2"></i>Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateCharCount(inputId, countId, maxLength) {
            const input = document.getElementById(inputId);
            const count = document.getElementById(countId);
            const currentLength = input.value.length;
            count.textContent = currentLength;
            
            if (currentLength > maxLength * 0.9) {
                count.style.color = '#e53e3e';
            } else {
                count.style.color = '#718096';
            }
        }

        // Initialize character counts
        window.addEventListener('DOMContentLoaded', function() {
            updateCharCount('title', 'titleCount', 200);
            updateCharCount('content', 'contentCount', 5000);
        });

        // Form validation
        document.getElementById('editThreadForm').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (title.length < 5) {
                e.preventDefault();
                alert('Thread title must be at least 5 characters long.');
                return false;
            }
            
            if (content.length < 10) {
                e.preventDefault();
                alert('Content must be at least 10 characters long.');
                return false;
            }
        });
    </script>
</body>
</html>