<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Details - SerenityHub</title>
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
      .detail-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
      }
      .profile-header {
        display: flex;
        align-items: center;
        padding-bottom: 20px;
        border-bottom: 2px solid #e5e7eb;
        margin-bottom: 20px;
      }
      .profile-avatar {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 36px;
        font-weight: 600;
        margin-right: 25px;
      }
      .info-row {
        padding: 15px 0;
        border-bottom: 1px solid #f3f4f6;
      }
      .info-label {
        font-weight: 600;
        color: #6b7280;
        margin-bottom: 5px;
      }
      .info-value {
        color: #1f2937;
        font-size: 16px;
      }
      .badge-role {
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 500;
      }
      .badge-student {
        background: #dbeafe;
        color: #1e40af;
      }
      .badge-counselor {
        background: #dcfce7;
        color: #15803d;
      }
      .badge-admin {
        background: #fef3c7;
        color: #92400e;
      }
      .badge-active {
        background: #d1fae5;
        color: #065f46;
      }
      .badge-inactive {
        background: #fee2e2;
        color: #991b1b;
      }
      .section-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        color: #1e40af;
        padding-bottom: 10px;
        border-bottom: 2px solid #e5e7eb;
      }
      .activity-item {
        padding: 12px;
        background: #f9fafb;
        border-radius: 8px;
        margin-bottom: 10px;
        border-left: 3px solid #1e40af;
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
          class="nav-link active"
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
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/reports"
        >
          <i class="fas fa-chart-bar"></i> Reports
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
          <h4 class="mb-0"><i class="fas fa-user me-2"></i>User Details</h4>
          <a
            href="${pageContext.request.contextPath}/admin/users"
            class="btn btn-outline-secondary"
          >
            <i class="fas fa-arrow-left me-2"></i>Back to Users
          </a>
        </div>
      </nav>

      <!-- User Profile Card -->
      <div class="detail-card">
        <div class="profile-header">
          <div class="profile-avatar">
            ${user.fullName.substring(0,1).toUpperCase()}
          </div>
          <div class="flex-grow-1">
            <h3 class="mb-2">${user.fullName}</h3>
            <div class="d-flex gap-2 align-items-center">
              <span
                class="badge-role badge-${user.userType.toString().toLowerCase()}"
              >
                <i class="fas fa-user-tag me-1"></i>${user.userType}
              </span>
              <c:choose>
                <c:when test="${user.active}">
                  <span class="badge-role badge-active">
                    <i class="fas fa-check-circle me-1"></i>Active
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="badge-role badge-inactive">
                    <i class="fas fa-times-circle me-1"></i>Inactive
                  </span>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          <div>
            <a
              href="${pageContext.request.contextPath}/admin/user/${user.userId}/edit"
              class="btn btn-primary me-2"
            >
              <i class="fas fa-edit me-2"></i>Edit User
            </a>
            <c:choose>
              <c:when test="${user.active}">
                <form
                  action="${pageContext.request.contextPath}/admin/user/${user.userId}/deactivate"
                  method="post"
                  style="display: inline"
                >
                  <button
                    type="submit"
                    class="btn btn-warning"
                    onclick="return confirm('Deactivate this user?')"
                  >
                    <i class="fas fa-ban me-2"></i>Deactivate
                  </button>
                </form>
              </c:when>
              <c:otherwise>
                <form
                  action="${pageContext.request.contextPath}/admin/user/${user.userId}/activate"
                  method="post"
                  style="display: inline"
                >
                  <button
                    type="submit"
                    class="btn btn-success"
                    onclick="return confirm('Activate this user?')"
                  >
                    <i class="fas fa-check me-2"></i>Activate
                  </button>
                </form>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Basic Information -->
        <h5 class="section-title mt-4">Basic Information</h5>
        <div class="row">
          <div class="col-md-6">
            <div class="info-row">
              <div class="info-label">Email Address</div>
              <div class="info-value">
                <i class="fas fa-envelope me-2 text-muted"></i>${user.email}
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="info-row">
              <div class="info-label">Phone Number</div>
              <div class="info-value">
                <i class="fas fa-phone me-2 text-muted"></i>
                <c:choose>
                  <c:when test="${not empty user.phone}">${user.phone}</c:when>
                  <c:otherwise
                    ><span class="text-muted">Not provided</span></c:otherwise
                  >
                </c:choose>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6">
            <div class="info-row">
              <div class="info-label">Registration Date</div>
              <div class="info-value">
                <i class="fas fa-calendar me-2 text-muted"></i>
                <fmt:formatDate
                  value="${user.createdAt}"
                  pattern="MMMM dd, yyyy 'at' HH:mm"
                />
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="info-row">
              <div class="info-label">Last Login</div>
              <div class="info-value">
                <i class="fas fa-clock me-2 text-muted"></i>
                <c:choose>
                  <c:when test="${not empty user.lastLogin}">
                    <fmt:formatDate
                      value="${user.lastLogin}"
                      pattern="MMMM dd, yyyy 'at' HH:mm"
                    />
                  </c:when>
                  <c:otherwise
                    ><span class="text-muted"
                      >Never logged in</span
                    ></c:otherwise
                  >
                </c:choose>
              </div>
            </div>
          </div>
        </div>

        <!-- Student-Specific Information -->
        <c:if test="${user.userType == 'STUDENT' && not empty student}">
          <h5 class="section-title mt-4">Student Information</h5>
          <div class="row">
            <div class="col-md-6">
              <div class="info-row">
                <div class="info-label">Student Number</div>
                <div class="info-value">
                  <i class="fas fa-id-card me-2 text-muted"></i>
                  <c:choose>
                    <c:when test="${not empty student.studentNumber}"
                      >${student.studentNumber}</c:when
                    >
                    <c:otherwise
                      ><span class="text-muted">Not provided</span></c:otherwise
                    >
                  </c:choose>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="info-row">
                <div class="info-label">Faculty</div>
                <div class="info-value">
                  <i class="fas fa-university me-2 text-muted"></i>
                  <c:choose>
                    <c:when test="${not empty student.faculty}"
                      >${student.faculty}</c:when
                    >
                    <c:otherwise
                      ><span class="text-muted">Not provided</span></c:otherwise
                    >
                  </c:choose>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6">
              <div class="info-row">
                <div class="info-label">Year of Study</div>
                <div class="info-value">
                  <i class="fas fa-graduation-cap me-2 text-muted"></i>
                  <c:choose>
                    <c:when test="${student.yearOfStudy > 0}"
                      >Year ${student.yearOfStudy}</c:when
                    >
                    <c:otherwise
                      ><span class="text-muted">Not provided</span></c:otherwise
                    >
                  </c:choose>
                </div>
              </div>
            </div>
          </div>
        </c:if>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
