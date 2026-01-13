<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${module.title} - SerenityHub</title>
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
            z-index: 1000;
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
        .module-header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 20px;
        }
        .breadcrumb-item a {
            color: #667eea;
            text-decoration: none;
        }
        .breadcrumb-item.active {
            color: #4a5568;
        }
        .module-title {
            font-size: 32px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 15px;
        }
        .module-meta {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }
        .meta-item {
            display: flex;
            align-items: center;
            color: #718096;
            font-size: 15px;
        }
        .meta-item i {
            margin-right: 8px;
            color: #667eea;
        }
        .category-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .progress-section {
            background: #f7fafc;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
        .progress-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .progress {
            height: 12px;
            border-radius: 10px;
            background: #e2e8f0;
        }
        .progress-bar {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            transition: width 0.5s ease;
        }
        .module-content-wrapper {
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }
        .objectives-section {
            background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
            border-left: 4px solid #667eea;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
        }
        .objectives-section h4 {
            color: #2d3748;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .objectives-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .objectives-list li {
            padding: 10px 0;
            color: #4a5568;
            font-size: 15px;
            display: flex;
            align-items: start;
        }
        .objectives-list li i {
            color: #667eea;
            margin-right: 12px;
            margin-top: 3px;
        }
        .content-section {
            line-height: 1.8;
            color: #2d3748;
            font-size: 16px;
        }
        .content-section h3 {
            color: #2d3748;
            font-size: 24px;
            font-weight: 600;
            margin-top: 30px;
            margin-bottom: 15px;
        }
        .content-section h4 {
            color: #4a5568;
            font-size: 20px;
            font-weight: 600;
            margin-top: 25px;
            margin-bottom: 12px;
        }
        .content-section p {
            margin-bottom: 15px;
        }
        .action-buttons {
            position: sticky;
            bottom: 0;
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }
        .btn-complete {
            background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
        }
        .btn-back {
            background: #e2e8f0;
            color: #4a5568;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
        }
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .status-completed {
            background: #d1fae5;
            color: #065f46;
        }
        .status-in-progress {
            background: #fef3c7;
            color: #92400e;
        }
        .status-not-started {
            background: #e2e8f0;
            color: #4a5568;
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/learning">
                <i class="fas fa-book"></i> Learning
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/assessments">
                <i class="fas fa-clipboard-check"></i> Assessments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/appointments">
                <i class="fas fa-calendar"></i> Appointments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
                <i class="fas fa-comments"></i> Forum
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
        <div class="module-header">
            <h1 class="module-title">${module.title}</h1>
            
            <div class="module-meta">
                <div class="meta-item">
                    <i class="fas fa-tag"></i>
                    <span class="category-badge">${module.category}</span>
                </div>
                <div class="meta-item">
                    <i class="fas fa-clock"></i>
                    <span>${module.durationMinutes} minutes</span>
                </div>
            </div>

            <!-- progress section -->
            <c:set var="progressValue" value="${empty progress.progressPercentage ? 0 : progress.progressPercentage}" />
            <div class="progress-section">
                <div class="progress-header">
                    <div>
                        <strong>Your Progress</strong>
                        <c:choose>
                            <c:when test="${progress.status eq 'COMPLETED'}">
                                <span class="status-badge status-completed ms-2">
                                    <i class="fas fa-check-circle"></i> Completed
                                </span>
                            </c:when>
                            <c:when test="${progress.status eq 'IN_PROGRESS'}">
                                <span class="status-badge status-in-progress ms-2">
                                    <i class="fas fa-spinner"></i> In Progress
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-not-started ms-2">
                                    <i class="fas fa-circle"></i> Not Started
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <span class="fw-bold text-primary" id="progressPercent">
                        <fmt:formatNumber value="${progressValue}" maxFractionDigits="0"/>%
                    </span>
                </div>
                <div class="progress">
                    <div class="progress-bar" role="progressbar" id="progressBar" >
                    </div>
                </div>
                </div>
            </div>

        <!-- module content -->
        <div class="module-content-wrapper">
            <!-- module description -->
            <div class="mb-4">
                <p class="lead">${module.description}</p>
            </div>

            <!-- learning objectives -->
            <c:if test="${not empty module.objectives}">
                <div class="objectives-section">
                    <h4><i class="fas fa-bullseye me-2"></i>Learning Objectives</h4>
                    <p class="text-muted mb-3">By the end of this module, you will be able to:</p>
                    <ul class="objectives-list">
                        <c:forEach items="${fn:split(module.objectives, ';')}" var="objective">
                            <c:if test="${not empty fn:trim(objective)}">
                                <li>
                                    <i class="fas fa-check-circle"></i>
                                    <span>${fn:trim(objective)}</span>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <!-- main content -->
            <div class="content-section" id="moduleContent">
                <c:choose>
                    <c:when test="${not empty module.content}">
                        ${module.content}
                    </c:when>
                    <c:otherwise>
                        <h3>Introduction</h3>
                        <p>Welcome to this learning module on ${module.title}. This course is designed to provide you with essential knowledge and practical skills in the area of ${module.category}.</p>

                        <h3>Key Concepts</h3>
                        <p>Throughout this module, we'll explore several important concepts that will help you develop a deeper understanding of the subject matter.</p>

                        <h3>Practical Applications</h3>
                        <p>Now that we've covered the theory, let's look at how you can apply these concepts in real-world situations.</p>

                        <h3>Summary</h3>
                        <p>Congratulations on completing this module! Remember that learning is a continuous process.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- action buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/student/learning" class="btn btn-back">
                <i class="fas fa-arrow-left me-2"></i>Back to Modules
            </a>
            <div>
                <form action="${pageContext.request.contextPath}/student/module/${module.moduleId}/complete" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-complete me-2">
                        <i class="fas fa-check me-2"></i>Mark as Complete
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>