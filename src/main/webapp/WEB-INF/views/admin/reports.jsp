<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reports - SerenityHub</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: #f5f7fa;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .sidebar {
        min-height: 100vh;
        background: linear-gradient(180deg, #1e3a8a 0%, #1e40af 100%);
        padding: 0;
        position: fixed;
        width: 250px;
      }
      .sidebar .nav-link {
        color: rgba(255, 255, 255, 0.8);
        padding: 15px 25px;
        border-left: 3px solid transparent;
        transition: all 0.3s;
      }
      .sidebar .nav-link:hover,
      .sidebar .nav-link.active {
        color: white;
        background: rgba(255, 255, 255, 0.1);
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
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        border-radius: 10px;
      }
      .report-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
        transition: transform 0.3s;
      }
      .report-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
      }
      .report-icon {
        width: 60px;
        height: 60px;
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        color: white;
        margin-bottom: 15px;
      }
      .report-icon.blue {
        background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
      }
      .report-icon.green {
        background: linear-gradient(135deg, #15803d 0%, #22c55e 100%);
      }
      .report-icon.purple {
        background: linear-gradient(135deg, #7e22ce 0%, #a855f7 100%);
      }
      .report-icon.orange {
        background: linear-gradient(135deg, #ea580c 0%, #fb923c 100%);
      }
      .btn-export {
        background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
        border: none;
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        transition: all 0.3s;
      }
      .btn-export:hover {
        background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
        color: white;
        transform: scale(1.05);
      }
      .stats-section {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
      }
      .section-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        color: #2d3748;
      }
      .brand-section {
        padding: 30px 25px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
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
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="brand-section">
        <div class="brand-logo">
          <i class="fas fa-shield-alt"></i>
        </div>
        <p class="brand-text">Admin Panel</p>
      </div>
      <nav class="nav flex-column mt-4">
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/dashboard"
        >
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/users"
        >
          <i class="fas fa-users"></i> User Management
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/modules"
        >
          <i class="fas fa-book"></i> Learning Modules
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/forum"
        >
          <i class="fas fa-comments"></i> Forum Management
        </a>
        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/reports">
          <i class="fas fa-chart-bar"></i> Reports
        </a>
        <a class="nav-link " href="${pageContext.request.contextPath}/admin/feedback/list">
          <i class="fas fa-comment-dots"></i> Feedback List
        </a>
        <hr style="border-color: rgba(255, 255, 255, 0.1); margin: 20px 25px" />
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
            <i class="fas fa-chart-bar me-2"></i>Reports & Analytics
          </h4>
        </div>
      </nav>

      <!-- Report Cards -->
      <div class="row">
        <div class="col-md-6 col-lg-3">
          <div class="report-card text-center">
            <div class="report-icon blue mx-auto">
              <i class="fas fa-users"></i>
            </div>
            <h5>User Report</h5>
            <p class="text-muted small mb-3">
              Complete user data with registration details
            </p>
            <a
              href="${pageContext.request.contextPath}/admin/reports/users/export"
              class="btn btn-export btn-sm"
            >
              <i class="fas fa-file-pdf me-2"></i>Export PDF
            </a>
          </div>
        </div>

        <div class="col-md-6 col-lg-3">
          <div class="report-card text-center">
            <div class="report-icon green mx-auto">
              <i class="fas fa-calendar-check"></i>
            </div>
            <h5>Appointments Report</h5>
            <p class="text-muted small mb-3">
              All appointment records and statistics
            </p>
            <a
              href="${pageContext.request.contextPath}/admin/reports/appointments/export"
              class="btn btn-export btn-sm"
            >
              <i class="fas fa-file-pdf me-2"></i>Export PDF
            </a>
          </div>
        </div>

        <div class="col-md-6 col-lg-3">
          <div class="report-card text-center">
            <div class="report-icon purple mx-auto">
              <i class="fas fa-clipboard-list"></i>
            </div>
            <h5>Assessment Report</h5>
            <p class="text-muted small mb-3">
              Assessment results and severity analysis
            </p>
            <a
              href="${pageContext.request.contextPath}/admin/reports/assessments/export"
              class="btn btn-export btn-sm"
            >
              <i class="fas fa-file-pdf me-2"></i>Export PDF
            </a>
          </div>
        </div>
      </div>

      <!-- Statistics Overview -->
      <div class="row">
        <!-- User Statistics -->
        <div class="col-md-6">
          <div class="stats-section">
            <h5 class="section-title">User Statistics</h5>
            <div class="row text-center">
              <div class="col-6 mb-3">
                <h3 class="text-primary">${userStats.totalUsers}</h3>
                <small class="text-muted">Total Users</small>
              </div>
              <div class="col-6 mb-3">
                <h3 class="text-success">${userStats.activeUsers}</h3>
                <small class="text-muted">Active Users</small>
              </div>
              <div class="col-4">
                <h4 class="text-info">${userStats.students}</h4>
                <small class="text-muted">Students</small>
              </div>
              <div class="col-4">
                <h4 class="text-warning">${userStats.counselors}</h4>
                <small class="text-muted">Counselors</small>
              </div>
              <div class="col-4">
                <h4 class="text-danger">${userStats.admins}</h4>
                <small class="text-muted">Admins</small>
              </div>
            </div>
          </div>
        </div>

        <!-- Appointment Statistics -->
        <div class="col-md-6">
          <div class="stats-section">
            <h5 class="section-title">Appointment Statistics</h5>
            <div class="row text-center">
              <div class="col-6 mb-3">
                <h3 class="text-primary">
                  ${appointmentStats.totalAppointments}
                </h3>
                <small class="text-muted">Total Appointments</small>
              </div>
              <div class="col-6 mb-3">
                <h3 class="text-success">${appointmentStats.completedCount}</h3>
                <small class="text-muted">Completed</small>
              </div>
              <div class="col-4">
                <h4 class="text-warning">${appointmentStats.pendingCount}</h4>
                <small class="text-muted">Pending</small>
              </div>
              <div class="col-4">
                <h4 class="text-info">${appointmentStats.approvedCount}</h4>
                <small class="text-muted">Approved</small>
              </div>
              <div class="col-4">
                <h4 class="text-danger">${appointmentStats.declinedCount}</h4>
                <small class="text-muted">Declined</small>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Assessment Statistics -->
      <div class="row">
        <div class="col-md-12">
          <div class="stats-section">
            <h5 class="section-title">Assessment Severity Distribution</h5>
            <div class="row text-center">
              <div class="col">
                <h3 class="text-success">${assessmentStats.normalCount}</h3>
                <small class="text-muted">Normal</small>
              </div>
              <div class="col">
                <h3 class="text-info">${assessmentStats.mildCount}</h3>
                <small class="text-muted">Mild</small>
              </div>
              <div class="col">
                <h3 class="text-warning">${assessmentStats.moderateCount}</h3>
                <small class="text-muted">Moderate</small>
              </div>
              <div class="col">
                <h3 class="text-danger">${assessmentStats.severeCount}</h3>
                <small class="text-muted">Severe</small>
              </div>
              <div class="col">
                <h3 class="text-dark">
                  ${assessmentStats.extremelySevereCount}
                </h3>
                <small class="text-muted">Extremely Severe</small>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
