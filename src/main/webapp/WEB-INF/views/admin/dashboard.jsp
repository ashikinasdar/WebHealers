<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SerenityHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #1e3a8a 0%, #1e40af 100%);
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
            border-radius: 10px;
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
        .stat-icon.blue { background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%); }
        .stat-icon.green { background: linear-gradient(135deg, #15803d 0%, #22c55e 100%); }
        .stat-icon.purple { background: linear-gradient(135deg, #7e22ce 0%, #a855f7 100%); }
        .stat-icon.orange { background: linear-gradient(135deg, #ea580c 0%, #fb923c 100%); }
        .stat-icon.red { background: linear-gradient(135deg, #dc2626 0%, #ef4444 100%); }
        .stat-icon.teal { background: linear-gradient(135deg, #0d9488 0%, #14b8a6 100%); }
        .chart-container {
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
        .recent-user {
            background: #f8fafc;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .badge-role {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-student { background: #dbeafe; color: #1e40af; }
        .badge-counselor { background: #dcfce7; color: #15803d; }
        .badge-admin { background: #fef3c7; color: #92400e; }
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
        .admin-badge {
            background: #fef3c7;
            color: #92400e;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand-section">
            <div class="brand-logo">
                <i class="fas fa-shield-alt"></i>
            </div>
            <p class="brand-text">Admin Panel</p>
        </div>
        <nav class="nav flex-column mt-4">
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                <i class="fas fa-users"></i> User Management
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/modules">
                <i class="fas fa-book"></i> Learning Modules
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/forum">
                <i class="fas fa-comments"></i> Forum Management
            </a> 
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                <i class="fas fa-chart-bar"></i> Reports
            </a>
            <a class="nav-link " href="${pageContext.request.contextPath}/admin/feedback/list">
                <i class="fas fa-comment-dots"></i> Feedback List
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
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
                <h4 class="mb-0">
                    Admin Dashboard
                    <span class="admin-badge">ADMIN</span>
                </h4>
                <span class="text-muted">Welcome back, ${fullName}</span>
            </div>
        </nav>

        <!-- Statistics Cards Row 1 -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon blue">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${userStats.totalUsers}</h3>
                            <p class="text-muted mb-0 small">Total Users</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon green">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${userStats.students}</h3>
                            <p class="text-muted mb-0 small">Students</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon purple">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${userStats.counselors}</h3>
                            <p class="text-muted mb-0 small">Counselors</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon orange">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${userStats.activeUsers}</h3>
                            <p class="text-muted mb-0 small">Active Users</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistics Cards Row 2 -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon teal">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${totalAppointments}</h3>
                            <p class="text-muted mb-0 small">Total Appointments</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon blue">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${totalAssessments}</h3>
                            <p class="text-muted mb-0 small">Assessments Taken</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon purple">
                            <i class="fas fa-comments"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${totalPosts}</h3>
                            <p class="text-muted mb-0 small">Forum Posts</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon green">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${totalModules}</h3>
                            <p class="text-muted mb-0 small">Learning Modules</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts and Details -->
        <div class="row">
            <!-- Appointment Statistics -->
            <div class="col-md-6">
                <div class="chart-container">
                    <h5 class="section-title">Appointment Statistics</h5>
                    <div class="row text-center">
                        <div class="col-4">
                            <h4 class="text-warning">${appointmentStats.pendingCount}</h4>
                            <small class="text-muted">Pending</small>
                        </div>
                        <div class="col-4">
                            <h4 class="text-success">${appointmentStats.approvedCount}</h4>
                            <small class="text-muted">Approved</small>
                        </div>
                        <div class="col-4">
                            <h4 class="text-primary">${appointmentStats.completedCount}</h4>
                            <small class="text-muted">Completed</small>
                        </div>
                    </div>
                    <hr>
                    <div class="row text-center">
                        <div class="col-6">
                            <h4 class="text-danger">${appointmentStats.declinedCount}</h4>
                            <small class="text-muted">Declined</small>
                        </div>
                        <div class="col-6">
                            <h4 class="text-secondary">${appointmentStats.cancelledCount}</h4>
                            <small class="text-muted">Cancelled</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Assessment Statistics -->
            <div class="col-md-6">
                <div class="chart-container">
                    <h5 class="section-title">Assessment Severity Distribution</h5>
                    <div class="row text-center">
                        <div class="col-4">
                            <h4 class="text-success">${assessmentStats.normalCount}</h4>
                            <small class="text-muted">Normal</small>
                        </div>
                        <div class="col-4">
                            <h4 class="text-info">${assessmentStats.mildCount}</h4>
                            <small class="text-muted">Mild</small>
                        </div>
                        <div class="col-4">
                            <h4 class="text-warning">${assessmentStats.moderateCount}</h4>
                            <small class="text-muted">Moderate</small>
                        </div>
                    </div>
                    <hr>
                    <div class="row text-center">
                        <div class="col-6">
                            <h4 class="text-danger">${assessmentStats.severeCount}</h4>
                            <small class="text-muted">Severe</small>
                        </div>
                        <div class="col-6">
                            <h4 class="text-dark">${assessmentStats.extremelySevereCount}</h4>
                            <small class="text-muted">Extremely Severe</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Users -->
        <div class="row">
            <div class="col-md-12">
                <div class="chart-container">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="section-title mb-0">Recent Users</h5>
                        <a href="${pageContext.request.contextPath}/admin/users" 
                           class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                    <c:choose>
                        <c:when test="${empty recentUsers}">
                            <p class="text-muted text-center">No recent users</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${recentUsers}" var="user">
                                <div class="recent-user">
                                    <div class="d-flex align-items-center">
                                        <div style="width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; margin-right: 15px;">
                                            ${user.fullName.substring(0,1).toUpperCase()}
                                        </div>
                                        <div>
                                            <h6 class="mb-0">${user.fullName}</h6>
                                            <small class="text-muted">${user.email}</small>
                                        </div>
                                    </div>
                                    <div>
                                        <span class="badge-role badge-${user.userType.toString().toLowerCase()}">
                                            ${user.userType}
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