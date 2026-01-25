<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum Management - SerenityHub</title>
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
        .thread-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 15px;
            border-left: 4px solid #1e40af;
        }
        .thread-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }
        .badge-anonymous {
            background: #fef3c7;
            color: #92400e;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
        }
        .thread-stats {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #718096;
        }
        .stat-item i {
            margin-right: 5px;
            color: #1e40af;
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
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand-section">
            <div class="brand-logo">
                <i class="fas fa-shield-alt"></i>
            </div>
            <p class="brand-text">Admin Panel</p>
        </div>
        <nav class="nav flex-column mt-4">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                <i class="fas fa-users"></i> User Management
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/modules">
                <i class="fas fa-book"></i> Learning Modules
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/forum">
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
                <h4 class="mb-0"><i class="fas fa-comments me-2"></i>Forum Management</h4>
            </div>
        </nav>

        <!-- Alerts -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Forum Threads -->
        <c:choose>
            <c:when test="${empty threads}">
                <div class="text-center py-5">
                    <i class="fas fa-comments fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No forum threads found</h5>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${threads}" var="thread">
                    <div class="thread-card">
                        <div class="d-flex">
                            <div class="thread-avatar">
                                <c:choose>
                                    <c:when test="${thread.is_anonymous}">
                                        <i class="fas fa-user-secret"></i>
                                    </c:when>
                                    <c:otherwise>
                                        ${thread.author_name.substring(0,1).toUpperCase()}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="ms-3 flex-grow-1">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <h5 class="mb-1">${thread.title}</h5>
                                        <div class="d-flex align-items-center gap-2">
                                            <small class="text-muted">
                                                Posted by: 
                                                <c:choose>
                                                    <c:when test="${thread.is_anonymous}">
                                                        Anonymous
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${thread.author_name}
                                                    </c:otherwise>
                                                </c:choose>
                                            </small>
                                            <c:if test="${thread.is_anonymous}">
                                                <span class="badge-anonymous">
                                                    <i class="fas fa-user-secret me-1"></i>Anonymous Post
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${thread.created_at}" pattern="MMM dd, yyyy HH:mm" />
                                    </small>
                                </div>
                                
                                <p class="text-muted mb-3">
                                    ${thread.content.length() > 200 ? thread.content.substring(0, 200) : thread.content}
                                    <c:if test="${thread.content.length() > 200}">...</c:if>
                                </p>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="thread-stats">
                                        <span class="stat-item">
                                            <i class="fas fa-heart"></i>
                                            ${thread.likes_count} likes
                                        </span>
                                        <span class="stat-item">
                                            <i class="fas fa-comment"></i>
                                            ${thread.replies_count} replies
                                        </span>
                                    </div>
                                    <div>
                                        <form action="${pageContext.request.contextPath}/admin/forum/thread/${thread.thread_id}/delete" 
                                              method="post" style="display: inline;">
                                            <button type="submit" class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Are you sure you want to delete this thread? This action cannot be undone.')">
                                                <i class="fas fa-trash me-1"></i>Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>
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