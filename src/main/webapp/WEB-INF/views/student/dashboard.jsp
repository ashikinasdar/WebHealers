<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - SerenityHub</title>
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
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            transition: transform 0.3s;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
        }
        .stat-icon.purple { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .stat-icon.green { background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%); }
        .stat-icon.orange { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .stat-icon.blue { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        .progress-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #2d3748;
        }
        .appointment-card {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 4px solid #667eea;
        }
        .badge-status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/dashboard">
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
            <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
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

    <!-- main content -->
    <div class="main-content">
        <!-- top navigation bar -->
        <nav class="navbar navbar-expand-lg navbar-light rounded">
            <div class="container-fluid">
                <h4 class="mb-0">Welcome, ${fullName}!</h4>
            </div>
        </nav>

        <!-- statisitic card -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon purple">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${completedModules}/${totalModules}</h3>
                            <p class="text-muted mb-0 small">Modules Completed</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon green">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${totalAppointments}</h3>
                            <p class="text-muted mb-0 small">Appointments</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon orange">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${completedAssessments}</h3>
                            <p class="text-muted mb-0 small">Assessments</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon blue">
                            <i class="fas fa-comments"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${forumPosts}</h3>
                            <p class="text-muted mb-0 small">Forum Posts</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- progress section -->
        <div class="row">
            <div class="col-md-8">
                <div class="progress-section">
                    <h5 class="section-title">Learning Progress</h5>
                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Overall Progress</span>
                            <span class="fw-bold">${progressPercentage}%</span>
                        </div>
                        <div class="progress" style="height: 20px; border-radius: 10px;">
                            <div class="progress-bar" role="progressbar"  
                                 aria-valuenow="${progressPercentage}" aria-valuemin="0" aria-valuemax="100">
                            </div>
                            <!-- Progress bar for the second bar
                            <div class="progress-bar" role="progressbar" 
                                 style="width: ${progressPercentage}; background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);" 
                                 aria-valuenow="${progressPercentage}" aria-valuemin="0" aria-valuemax="100">
                            </div> -->
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/student/learning" 
                           class="btn btn-primary">
                            <i class="fas fa-book me-2"></i>Continue Learning
                        </a>
                    </div>
                </div>

                <!-- upcoming appointments -->
                <div class="progress-section">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="section-title mb-0">Upcoming Appointments</h5>
                        <a href="${pageContext.request.contextPath}/student/appointments" 
                           class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty upcomingAppointments}">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-calendar-alt fa-3x mb-3"></i>
                                <p>No upcoming appointments</p>
                                <a href="${pageContext.request.contextPath}/student/appointments" 
                                   class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>Book Appointment
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${upcomingAppointments}" var="appointment">
                                <div class="appointment-card">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <h6 class="mb-1">${appointment.counselorName}</h6>
                                            <p class="text-muted mb-1 small">
                                                <i class="fas fa-calendar me-2"></i>
                                                <fmt:formatDate value="${appointment.appointmentDate}" pattern="MMM dd, yyyy" />
                                                at 
                                                <fmt:formatDate value="${appointment.appointmentTime}" pattern="HH:mm" />
                                            </p>
                                            <p class="text-muted mb-0 small">
                                                <i class="fas fa-laptop me-2"></i>${appointment.sessionType}
                                            </p>
                                        </div>
                                        <span class="badge-status bg-warning text-dark">
                                            ${appointment.status}
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>