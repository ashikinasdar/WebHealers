<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
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
      .stat-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        text-align: center;
        height: 100%;
      }
      .stat-icon {
        font-size: 2.5rem;
        margin-bottom: 15px;
      }
      .stat-value {
        font-size: 2rem;
        font-weight: 700;
        color: #2d3748;
        margin-bottom: 5px;
      }
      .stat-label {
        color: #718096;
        font-size: 0.9rem;
      }
      .checkin-card {
        background: white;
        border-radius: 25px;
        padding: 40px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        margin-bottom: 20px;
      }
      .mood-selector {
        display: flex;
        justify-content: space-around;
        margin: 30px 0;
        gap: 15px;
      }
      .mood-option {
        text-align: center;
        cursor: pointer;
        transition: all 0.3s;
        flex: 1;
        padding: 20px;
        border-radius: 15px;
        border: 3px solid transparent;
      }
      .mood-option:hover {
        transform: translateY(-5px);
        background: #f8f9fa;
      }
      .mood-option.selected {
        border-color: #667eea;
        background: #f0f4ff;
      }
      .mood-option input[type="radio"] {
        display: none;
      }
      .mood-icon {
        font-size: 3rem;
        margin-bottom: 10px;
        transition: all 0.3s;
      }
      .mood-option:hover .mood-icon {
        transform: scale(1.1);
      }
      .mood-label {
        font-weight: 600;
        color: #2d3748;
        font-size: 0.9rem;
      }
      .notes-section {
        margin: 30px 0;
      }
      .btn-checkin {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        color: white;
        padding: 15px 50px;
        border-radius: 50px;
        font-size: 1.1rem;
        font-weight: 600;
        transition: all 0.3s;
        width: 100%;
      }
      .btn-checkin:hover {
        transform: scale(1.02);
        box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
      }
      .already-checked-in {
        background: #e6f3ff;
        border-left: 5px solid #667eea;
        padding: 25px;
        border-radius: 15px;
        margin-bottom: 20px;
      }
      .mood-display {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-top: 15px;
      }
      .mood-display-icon {
        font-size: 3rem;
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
            <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
                <i class="fas fa-comments"></i> Forum
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/mood/checkin">
                <i class="fas fa-smile"></i> Mood Tracker
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/chatbot">
                <i class="fas fa-robot"></i> Chatbot
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
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
          <h4 class="mb-0">
            <i class="fas fa-history me-2"></i>Mood History
          </h4>
          <div>
            <a
              href="${pageContext.request.contextPath}/student/mood/checkin"
              class="btn btn-primary"
            >
              <i class="fas fa-plus me-2"></i>Check In
            </a>
          </div>
        </div>
      </nav>

      <!-- Stats Grid -->
      <div class="row g-3 mb-4">
        <div class="col-md-3">
          <div class="stat-card">
            <div class="stat-icon">📊</div>
            <div class="stat-value">${totalCheckins}</div>
            <div class="stat-label">Total Check-ins</div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stat-card">
            <div class="stat-icon">⭐</div>
            <div class="stat-value">${averageMood}</div>
            <div class="stat-label">Average Mood</div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stat-card">
            <div class="stat-icon">🔥</div>
            <div class="stat-value">${streak}</div>
            <div class="stat-label">Day Streak</div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stat-card">
            <div class="stat-icon">
              <c:choose>
                <c:when test="${mostCommonMood == 5}">😄</c:when>
                <c:when test="${mostCommonMood == 4}">😊</c:when>
                <c:when test="${mostCommonMood == 3}">😐</c:when>
                <c:when test="${mostCommonMood == 2}">😟</c:when>
                <c:when test="${mostCommonMood == 1}">😢</c:when>
                <c:otherwise>😊</c:otherwise>
              </c:choose>
            </div>
            <div class="stat-value">
              <c:choose>
                <c:when test="${mostCommonMood == 5}">Excellent</c:when>
                <c:when test="${mostCommonMood == 4}">Good</c:when>
                <c:when test="${mostCommonMood == 3}">Okay</c:when>
                <c:when test="${mostCommonMood == 2}">Not Great</c:when>
                <c:when test="${mostCommonMood == 1}">Struggling</c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </div>
            <div class="stat-label">Most Common Mood</div>
          </div>
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
