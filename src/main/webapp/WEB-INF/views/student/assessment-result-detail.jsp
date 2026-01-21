<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Assessment Result - SerenityHub</title>
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
                    }

                    .result-card {
                        background: white;
                        border-radius: 15px;
                        padding: 30px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                        margin-bottom: 20px;
                    }

                    .score-box {
                        text-align: center;
                        padding: 20px;
                        border-radius: 10px;
                        margin-bottom: 20px;
                    }

                    .score-box.depression {
                        background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
                        border: 2px solid #3b82f6;
                    }

                    .score-box.anxiety {
                        background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                        border: 2px solid #f59e0b;
                    }

                    .score-box.stress {
                        background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                        border: 2px solid #ef4444;
                    }

                    .score-number {
                        font-size: 48px;
                        font-weight: bold;
                        margin-bottom: 5px;
                    }

                    .score-label {
                        font-size: 14px;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                    }

                    .severity-badge {
                        padding: 10px 25px;
                        border-radius: 25px;
                        font-size: 16px;
                        font-weight: 700;
                        text-transform: uppercase;
                        display: inline-block;
                    }

                    .severity-normal {
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        color: white;
                    }

                    .severity-mild {
                        background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
                        color: white;
                    }

                    .severity-moderate {
                        background: linear-gradient(135deg, #fb923c 0%, #ea580c 100%);
                        color: white;
                    }

                    .severity-severe {
                        background: linear-gradient(135deg, #f87171 0%, #ef4444 100%);
                        color: white;
                    }

                    .severity-extremely_severe {
                        background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
                        color: white;
                    }

                    .recommendations-box {
                        background: #f0f9ff;
                        border-left: 4px solid #0284c7;
                        padding: 20px;
                        border-radius: 10px;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/student/assessments">
                            <i class="fas fa-clipboard-check"></i> Assessments
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/appointments">
                            <i class="fas fa-calendar"></i> Counseling
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
                            <i class="fas fa-comments"></i> Forum
                        </a>
                        <a class="nav-link " href="${pageContext.request.contextPath}/student/feedback">
                            <i class="fas fa-comment-dots"></i> Feedback
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/mood/checkin">
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
                    <nav class="navbar navbar-expand-lg navbar-light rounded">
                        <div class="container-fluid">
                            <a href="${pageContext.request.contextPath}/student/assessments"
                                class="btn btn-outline-primary btn-sm me-3">
                                <i class="fas fa-arrow-left me-1"></i>Back
                            </a>
                            <h4 class="mb-0">
                                <i class="fas fa-chart-line me-2"></i>Assessment Result
                            </h4>
                        </div>
                    </nav>

                    <!-- Success Message -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Result Card -->
                    <div class="result-card">
                        <div class="text-center mb-4">
                            <h3 class="mb-3">${result.assessmentName}</h3>
                            <p class="text-muted mb-3">
                                <i class="fas fa-calendar me-2"></i>
                                Completed on
                                <fmt:formatDate value="${result.attemptedAt}" pattern="MMMM dd, yyyy 'at' hh:mm a" />
                            </p>
                            <span class="severity-badge severity-${result.overallSeverity.toString().toLowerCase()}">
                                ${result.overallSeverity.toString().replace('_', ' ')}
                            </span>
                        </div>

                        <!-- Scores -->
                        <h5 class="mb-3">Your Scores</h5>
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="score-box depression">
                                    <div class="score-number text-primary">${result.depressionScore}</div>
                                    <div class="score-label text-primary">Depression</div>
                                    <small class="text-muted">
                                        <c:choose>
                                            <c:when test="${result.depressionScore <= 9}">Normal</c:when>
                                            <c:when test="${result.depressionScore <= 13}">Mild</c:when>
                                            <c:when test="${result.depressionScore <= 20}">Moderate</c:when>
                                            <c:when test="${result.depressionScore <= 27}">Severe</c:when>
                                            <c:otherwise>Extremely Severe</c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="score-box anxiety">
                                    <div class="score-number text-warning">${result.anxietyScore}</div>
                                    <div class="score-label text-warning">Anxiety</div>
                                    <small class="text-muted">
                                        <c:choose>
                                            <c:when test="${result.anxietyScore <= 7}">Normal</c:when>
                                            <c:when test="${result.anxietyScore <= 9}">Mild</c:when>
                                            <c:when test="${result.anxietyScore <= 14}">Moderate</c:when>
                                            <c:when test="${result.anxietyScore <= 19}">Severe</c:when>
                                            <c:otherwise>Extremely Severe</c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="score-box stress">
                                    <div class="score-number text-danger">${result.stressScore}</div>
                                    <div class="score-label text-danger">Stress</div>
                                    <small class="text-muted">
                                        <c:choose>
                                            <c:when test="${result.stressScore <= 14}">Normal</c:when>
                                            <c:when test="${result.stressScore <= 18}">Mild</c:when>
                                            <c:when test="${result.stressScore <= 25}">Moderate</c:when>
                                            <c:when test="${result.stressScore <= 33}">Severe</c:when>
                                            <c:otherwise>Extremely Severe</c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Recommendations -->
                        <c:if test="${not empty result.recommendations}">
                            <h5 class="mb-3">Recommendations</h5>
                            <div class="recommendations-box">
                                <pre
                                    style="white-space: pre-wrap; font-family: inherit; margin: 0;">${result.recommendations}</pre>
                            </div>
                        </c:if>

                        <!-- Actions -->
                        <div class="mt-4 text-center">
                            <a href="${pageContext.request.contextPath}/student/assessments"
                                class="btn btn-primary me-2">
                                <i class="fas fa-clipboard-check me-2"></i>Take Another Assessment
                            </a>
                            <c:if
                                test="${result.overallSeverity == 'SEVERE' || result.overallSeverity == 'EXTREMELY_SEVERE'}">
                                <a href="${pageContext.request.contextPath}/student/appointments"
                                    class="btn btn-danger">
                                    <i class="fas fa-calendar-plus me-2"></i>Book Counseling Appointment
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    setTimeout(function () {
                        var alerts = document.querySelectorAll('.alert');
                        alerts.forEach(function (alert) {
                            alert.style.transition = 'opacity 0.5s';
                            alert.style.opacity = '0';
                            setTimeout(function () { alert.remove(); }, 500);
                        });
                    }, 5000);
                </script>
            </body>

            </html>