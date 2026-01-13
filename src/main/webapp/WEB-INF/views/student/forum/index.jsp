<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forum - SerenityHub</title>
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
        }
        .thread-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 15px;
            transition: all 0.3s;
            border-left: 4px solid #667eea;
        }
        .thread-card:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .thread-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }
        .thread-stats {
            display: flex;
            gap: 20px;
            font-size: 14px;
            color: #718096;
        }
        .stat-item i {
            margin-right: 5px;
            color: #667eea;
        }
        .btn-create {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        .btn-create:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            color: white;
        }
        .badge-anonymous {
            background: #fef3c7;
            color: #92400e;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
        }
        .search-box {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
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
                <i class="fas fa-calendar"></i> Appointments
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/forum">
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

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light rounded">
            <div class="container-fluid">
                <h4 class="mb-0"><i class="fas fa-comments me-2"></i>Peer Support Forum</h4>
                <a href="${pageContext.request.contextPath}/student/forum/create" class="btn btn-create">
                    <i class="fas fa-plus me-2"></i>New Thread
                </a>
            </div>
        </nav>

        <!-- Search Box -->
        <div class="search-box">
            <form action="${pageContext.request.contextPath}/student/forum/search" method="get">
                <div class="input-group">
                    <span class="input-group-text bg-transparent border-end-0">
                        <i class="fas fa-search text-muted"></i>
                    </span>
                    <input type="text" class="form-control border-start-0" 
                           name="keyword" placeholder="Search discussions..." 
                           style="box-shadow: none;">
                    <button class="btn btn-outline-primary" type="submit">Search</button>
                </div>
            </form>
        </div>

        <!-- Forum Threads -->
        <c:choose>
            <c:when test="${empty threads}">
                <div class="text-center py-5">
                    <i class="fas fa-comments fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No discussions yet</h5>
                    <p class="text-muted">Be the first to start a conversation!</p>
                    <a href="${pageContext.request.contextPath}/student/forum/create" 
                       class="btn btn-create mt-3">
                        <i class="fas fa-plus me-2"></i>Create Thread
                    </a>
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
                                        <h5 class="mb-1">
                                            <a href="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}" 
                                               class="text-decoration-none text-dark">
                                                ${thread.title}
                                            </a>
                                        </h5>
                                        <div class="d-flex align-items-center gap-2">
                                            <small class="text-muted">
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
                                                    <i class="fas fa-user-secret me-1"></i>Anonymous
                                                </span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${thread.created_at}" pattern="MMM dd, yyyy" />
                                    </small>
                                </div>
                                <p class="text-muted mb-3">
                                    ${thread.content.length() > 200 ? thread.content.substring(0, 200) : thread.content}
                                    <c:if test="${thread.content.length() > 200}">...</c:if>
                                </p>
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