<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Assessments - SerenityHub</title>
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

                    .assessment-card {
                        background: white;
                        border-radius: 15px;
                        padding: 25px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                        margin-bottom: 20px;
                        transition: all 0.3s;
                        border-left: 4px solid #667eea;
                    }

                    .assessment-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                    }

                    .assessment-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 12px;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-size: 24px;
                    }

                    .history-card {
                        background: white;
                        border-radius: 15px;
                        padding: 20px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                        margin-bottom: 15px;
                        border-left: 3px solid #667eea;
                    }

                    .badge-severity {
                        padding: 6px 15px;
                        border-radius: 20px;
                        font-size: 12px;
                        font-weight: 500;
                    }

                    .badge-normal {
                        background: #d1fae5;
                        color: #065f46;
                    }

                    .badge-mild {
                        background: #dbeafe;
                        color: #1e40af;
                    }

                    .badge-moderate {
                        background: #fef3c7;
                        color: #92400e;
                    }

                    .badge-severe {
                        background: #fed7aa;
                        color: #9a3412;
                    }

                    .badge-extremely_severe {
                        background: #fee2e2;
                        color: #991b1b;
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

                    .info-box {
                        background: #f0f9ff;
                        border: 1px solid #bfdbfe;
                        border-radius: 10px;
                        padding: 15px;
                        margin-bottom: 20px;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/student/assessments">
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
                            <h4 class="mb-0"><i class="fas fa-clipboard-check me-2"></i>Self-Assessment Tools</h4>
                        </div>
                    </nav>

                    <!-- info box -->
                    <div class="info-box">
                        <div class="d-flex align-items-start">
                            <i class="fas fa-info-circle fa-2x text-primary me-3"></i>
                            <div>
                                <h6 class="mb-1">About Self-Assessment</h6>
                                <p class="mb-0 small">
                                    These assessments can help you understand your mental health better.
                                    They are screening tools and not diagnostic tests. If you're concerned about
                                    your results, please book an appointment with our counselors.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- available assessments -->
                    <h5 class="mb-3">Available Assessments</h5>
                    <div class="row">
                        <c:choose>
                            <c:when test="${empty assessmentTypes}">
                                <div class="col-12">
                                    <p class="text-muted text-center">No assessments available at the moment</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${assessmentTypes}" var="type">
                                    <div class="col-md-6">
                                        <div class="assessment-card">
                                            <div class="d-flex">
                                                <div class="assessment-icon">
                                                    <i class="fas fa-heartbeat"></i>
                                                </div>
                                                <div class="ms-3 flex-grow-1">
                                                    <h5 class="mb-2">${type.name}</h5>
                                                    <p class="text-muted mb-3">${type.description}</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="text-muted">
                                                            <i class="fas fa-question-circle me-1"></i>
                                                            ${type.totalQuestions} questions
                                                        </small>
                                                        <a href="${pageContext.request.contextPath}/student/assessment/${type.assessmentTypeId}"
                                                            class="btn btn-primary btn-sm">
                                                            <i class="fas fa-play me-2"></i>Take Assessment
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- assessment history -->
                    <h5 class="mb-3 mt-4">Your Assessment History</h5>
                    <c:choose>
                        <c:when test="${empty assessmentHistory}">
                            <div class="text-center py-4">
                                <i class="fas fa-clipboard-list fa-3x text-muted mb-3"></i>
                                <p class="text-muted">You haven't taken any assessments yet</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${assessmentHistory}" var="result">
                                <div class="history-card">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div class="flex-grow-1">
                                            <h6 class="mb-2">${result.assessmentName}</h6>
                                            <div class="row mb-2">
                                                <div class="col-md-4">
                                                    <small class="text-muted">Depression:</small>
                                                    <strong class="ms-2">${result.depressionScore}</strong>
                                                </div>
                                                <div class="col-md-4">
                                                    <small class="text-muted">Anxiety:</small>
                                                    <strong class="ms-2">${result.anxietyScore}</strong>
                                                </div>
                                                <div class="col-md-4">
                                                    <small class="text-muted">Stress:</small>
                                                    <strong class="ms-2">${result.stressScore}</strong>
                                                </div>
                                            </div>
                                            <small class="text-muted">
                                                <i class="fas fa-calendar me-1"></i>
                                                <fmt:formatDate value="${result.attemptedAt}"
                                                    pattern="MMMM dd, yyyy 'at' hh:mm a" />
                                            </small>
                                        </div>
                                        <div class="text-end">
                                            <span
                                                class="badge-severity badge-${result.overallSeverity.toString().toLowerCase()}">
                                                ${result.overallSeverity.toString().replace('_', ' ')}
                                            </span>
                                            <br>
                                            <a href="${pageContext.request.contextPath}/student/assessment/result/${result.resultId}"
                                                class="btn btn-sm btn-outline-primary mt-2">
                                                <i class="fas fa-eye me-1"></i>View Details
                                            </a>
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