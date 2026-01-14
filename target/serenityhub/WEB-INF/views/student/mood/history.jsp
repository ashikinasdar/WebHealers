<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Mood History - SerenityHub</title>
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
        background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
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
        border-radius: 15px;
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
      .checkin-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 15px;
        transition: all 0.3s;
      }
      .checkin-card:hover {
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
      }
      .mood-icon-large {
        font-size: 3rem;
      }
      .mood-badge {
        padding: 8px 20px;
        border-radius: 20px;
        font-weight: 600;
        display: inline-block;
      }
      .mood-5 {
        background: #d4edda;
        color: #155724;
      }
      .mood-4 {
        background: #d1ecf1;
        color: #0c5460;
      }
      .mood-3 {
        background: #fff3cd;
        color: #856404;
      }
      .mood-2 {
        background: #f8d7da;
        color: #721c24;
      }
      .mood-1 {
        background: #f5c6cb;
        color: #721c24;
      }
      .filter-section {
        background: white;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
      }
    </style>
  </head>
  <body>
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="brand-section">
        <div class="brand-logo">
          <i class="fas fa-heart"></i>
        </div>
        <p class="brand-text">SerenityHub</p>
      </div>
      <nav class="nav flex-column mt-4">
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/dashboard"
        >
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/learning"
        >
          <i class="fas fa-book"></i> Learning
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/assessments"
        >
          <i class="fas fa-clipboard-check"></i> Assessments
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/appointments"
        >
          <i class="fas fa-calendar"></i> Appointments
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/forum"
        >
          <i class="fas fa-comments"></i> Forum
        </a>
        <a
          class="nav-link active"
          href="${pageContext.request.contextPath}/student/mood/checkin"
        >
          <i class="fas fa-smile"></i> Mood Tracker
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/profile"
        >
          <i class="fas fa-user"></i> Profile
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
          <h4 class="mb-0"><i class="fas fa-history me-2"></i>Mood History</h4>
          <a
            href="${pageContext.request.contextPath}/student/mood/checkin"
            class="btn btn-primary"
          >
            <i class="fas fa-plus me-2"></i>New Check-in
          </a>
        </div>
      </nav>

      <!-- Filter Section -->
      <div class="filter-section">
        <div class="d-flex gap-2 align-items-center">
          <span><strong>Show:</strong></span>
          <a
            href="?days=7"
            class="btn btn-sm ${days == 7 ? 'btn-primary' : 'btn-outline-primary'}"
            >Last 7 Days</a
          >
          <a
            href="?days=30"
            class="btn btn-sm ${days == 30 ? 'btn-primary' : 'btn-outline-primary'}"
            >Last 30 Days</a
          >
          <a
            href="?days=90"
            class="btn btn-sm ${days == 90 ? 'btn-primary' : 'btn-outline-primary'}"
            >Last 3 Months</a
          >
        </div>
      </div>

      <!-- Success/Error Messages -->
      <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show">
          <i class="fas fa-check-circle me-2"></i>${success}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
          ></button>
        </div>
      </c:if>

      <!-- Mood History -->
      <c:choose>
        <c:when test="${empty moodHistory}">
          <div class="text-center py-5">
            <i class="fas fa-calendar-alt fa-4x text-muted mb-3"></i>
            <h5 class="text-muted">No mood check-ins yet</h5>
            <p class="text-muted">Start tracking your mood today!</p>
            <a
              href="${pageContext.request.contextPath}/student/mood/checkin"
              class="btn btn-primary mt-3"
            >
              <i class="fas fa-plus me-2"></i>Check In Now
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach items="${moodHistory}" var="checkin">
            <div class="checkin-card">
              <div class="d-flex align-items-start">
                <div class="mood-icon-large me-3">
                  <c:choose>
                    <c:when test="${checkin.mood_rating == 5}">😄</c:when>
                    <c:when test="${checkin.mood_rating == 4}">😊</c:when>
                    <c:when test="${checkin.mood_rating == 3}">😐</c:when>
                    <c:when test="${checkin.mood_rating == 2}">😟</c:when>
                    <c:otherwise>😢</c:otherwise>
                  </c:choose>
                </div>
                <div class="flex-grow-1">
                  <div
                    class="d-flex justify-content-between align-items-start mb-2"
                  >
                    <div>
                      <span class="mood-badge mood-${checkin.mood_rating}">
                        <c:choose>
                          <c:when test="${checkin.mood_rating == 5}"
                            >Excellent</c:when
                          >
                          <c:when test="${checkin.mood_rating == 4}"
                            >Good</c:when
                          >
                          <c:when test="${checkin.mood_rating == 3}"
                            >Okay</c:when
                          >
                          <c:when test="${checkin.mood_rating == 2}"
                            >Not Great</c:when
                          >
                          <c:otherwise>Struggling</c:otherwise>
                        </c:choose>
                      </span>
                    </div>
                    <div class="text-end">
                      <div class="text-muted">
                        <fmt:formatDate
                          value="${checkin.checkin_date}"
                          pattern="EEEE, MMM dd, yyyy"
                        />
                      </div>
                      <small class="text-muted">
                        <fmt:formatDate
                          value="${checkin.checkin_time}"
                          pattern="hh:mm a"
                        />
                      </small>
                    </div>
                  </div>
                  <c:if test="${not empty checkin.notes}">
                    <div class="mt-2 p-3 bg-light rounded">
                      <i class="fas fa-sticky-note me-2 text-muted"></i>
                      <c:out value="${checkin.notes}" />
                    </div>
                  </c:if>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
