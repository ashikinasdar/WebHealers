<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counselor Dashboard - SerenityHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #059669 0%, #10b981 100%);
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
        .stat-icon.green { background: linear-gradient(135deg, #059669 0%, #10b981 100%); }
        .stat-icon.orange { background: linear-gradient(135deg, #ea580c 0%, #fb923c 100%); }
        .stat-icon.blue { background: linear-gradient(135deg, #0284c7 0%, #0ea5e9 100%); }
        .stat-icon.purple { background: linear-gradient(135deg, #7e22ce 0%, #a855f7 100%); }
        .appointment-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 15px;
            border-left: 4px solid #10b981;
        }
        .badge-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-pending { background: #fef3c7; color: #92400e; }
        .badge-approved { background: #d1fae5; color: #065f46; }
        .badge-completed { background: #dbeafe; color: #1e40af; }
        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #2d3748;
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
        .counselor-badge {
            background: #d1fae5;
            color: #065f46;
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
                <i class="fas fa-user-md"></i>
            </div>
            <p class="brand-text">Counselor Portal</p>
        </div>
        <nav class="nav flex-column mt-4">
            <a class="nav-link active" href="${pageContext.request.contextPath}/counselor/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/counselor/appointments">
                <i class="fas fa-calendar"></i> Appointments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/counselor/assessments">
                <i class="fas fa-clipboard-list"></i> Students Assessments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/counselor/profile">
                <i class="fas fa-user"></i> My Profile
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
                    Counselor Dashboard
                    <span class="counselor-badge">COUNSELOR</span>
                </h4>
                <span class="text-muted">Welcome back, ${fullName}</span>
            </div>
        </nav>

        <!-- Statistics Cards -->
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon green">
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
                        <div class="stat-icon orange">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${pendingCount}</h3>
                            <p class="text-muted mb-0 small">Pending Requests</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon blue">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${approvedCount}</h3>
                            <p class="text-muted mb-0 small">Approved</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center">
                        <div class="stat-icon purple">
                            <i class="fas fa-check-double"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">${completedCount}</h3>
                            <p class="text-muted mb-0 small">Completed</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Pending Appointments -->
            <div class="col-md-7">
                <div style="background: white; border-radius: 15px; padding: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="section-title mb-0">Pending Appointment Requests</h5>
                        <a href="${pageContext.request.contextPath}/counselor/appointments" 
                           class="btn btn-sm btn-outline-success">View All</a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty pendingAppointments}">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-calendar-check fa-3x mb-3"></i>
                                <p>No pending appointment requests</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${pendingAppointments}" var="appointment">
                                <div class="appointment-card">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1">${appointment.studentName}</h6>
                                            <p class="text-muted mb-2 small">
                                                <i class="fas fa-calendar me-2"></i>
                                                <fmt:formatDate value="${appointment.appointmentDate}" pattern="MMM dd, yyyy" />
                                                at 
                                                <fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a" />
                                            </p>
                                            <p class="text-muted mb-2 small">
                                                <i class="fas fa-laptop me-2"></i>${appointment.sessionType}
                                            </p>
                                            <c:if test="${not empty appointment.reason}">
                                                <p class="mb-0 small">
                                                    <strong>Reason:</strong> ${appointment.reason}
                                                </p>
                                            </c:if>
                                        </div>
                                        <div class="text-end">
                                            <form action="${pageContext.request.contextPath}/counselor/appointment/${appointment.appointmentId}/approve" 
                                                  method="post" style="display: inline;">
                                                <button type="submit" class="btn btn-sm btn-success mb-2">
                                                    <i class="fas fa-check me-1"></i>Approve
                                                </button>
                                            </form>
                                            <br>
                                            <form action="${pageContext.request.contextPath}/counselor/appointment/${appointment.appointmentId}/decline" 
                                                  method="post" style="display: inline;">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="fas fa-times me-1"></i>Decline
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Upcoming Appointments -->
            <div class="col-md-5">
                <div style="background: white; border-radius: 15px; padding: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 20px;">
                    <h5 class="section-title">Upcoming Appointments</h5>
                    
                    <c:choose>
                        <c:when test="${empty appointments || appointments.size() == 0}">
                            <p class="text-muted text-center">No upcoming appointments</p>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${appointments}" var="appt" begin="0" end="4">
                                <c:if test="${appt.status == 'APPROVED'}">
                                    <div style="background: #f9fafb; border-radius: 10px; padding: 15px; margin-bottom: 10px; border-left: 3px solid #10b981;">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h6 class="mb-1">${appt.studentName}</h6>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar me-1"></i>
                                                    <fmt:formatDate value="${appt.appointmentDate}" pattern="MMM dd" />
                                                    at 
                                                    <fmt:formatDate value="${appt.appointmentTime}" pattern="hh:mm a" />
                                                </small>
                                            </div>
                                            <span class="badge-status badge-approved">
                                                ${appt.sessionType}
                                            </span>
                                        </div>
                                    </div>
                                </c:if>
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