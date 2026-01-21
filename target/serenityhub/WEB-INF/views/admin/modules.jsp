<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module Management - SerenityHub</title>
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
        .module-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            border-left: 4px solid #1e40af;
            transition: all 0.3s;
        }
        .module-card:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .module-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }
        .badge-category {
            background: #dbeafe;
            color: #1e40af;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-active {
            background: #d1fae5;
            color: #065f46;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-inactive {
            background: #fee2e2;
            color: #991b1b;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .btn-action {
            padding: 5px 15px;
            margin: 0 3px;
            border-radius: 8px;
            font-size: 13px;
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/modules">
                <i class="fas fa-book"></i> Learning Modules
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/forum">
                <i class="fas fa-comments"></i> Forum Management
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                <i class="fas fa-chart-bar"></i> Reports
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
                <h4 class="mb-0"><i class="fas fa-book me-2"></i>Learning Modules</h4>
                <a href="${pageContext.request.contextPath}/admin/module/create" 
                   class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add Module
                </a>
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

        <!-- Modules List -->
        <c:choose>
            <c:when test="${empty modules}">
                <div class="text-center py-5">
                    <i class="fas fa-book fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No learning modules yet</h5>
                    <p class="text-muted">Create your first module to get started</p>
                    <a href="${pageContext.request.contextPath}/admin/module/create" 
                       class="btn btn-primary mt-3">
                        <i class="fas fa-plus me-2"></i>Create Module
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach items="${modules}" var="module">
                        <div class="col-md-12">
                            <div class="module-card">
                                <div class="d-flex">
                                    <div class="module-icon">
                                        <i class="fas fa-book-open"></i>
                                    </div>
                                    <div class="ms-3 flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div>
                                                <h5 class="mb-1">${module.title}</h5>
                                                <div class="d-flex gap-2 align-items-center">
                                                    <span class="badge-category">${module.category}</span>
                                                    <c:choose>
                                                        <c:when test="${module.active}">
                                                            <span class="badge-active">
                                                                <i class="fas fa-check-circle me-1"></i>Active
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge-inactive">
                                                                <i class="fas fa-times-circle me-1"></i>Inactive
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <small class="text-muted">
                                                Order: ${module.displayOrder}
                                            </small>
                                        </div>
                                        
                                        <p class="text-muted mb-2">
                                            ${module.description.length() > 150 ? module.description.substring(0, 150) : module.description}
                                            <c:if test="${module.description.length() > 150}">...</c:if>
                                        </p>
                                        
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <small class="text-muted me-3">
                                                    <i class="fas fa-clock me-1"></i>
                                                    ${module.durationMinutes} minutes
                                                </small>
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar me-1"></i>
                                                    <fmt:formatDate value="${module.createdAt}" pattern="MMM dd, yyyy" />
                                                </small>
                                            </div>
                                            <div>
                                                <a href="${pageContext.request.contextPath}/admin/module/${module.moduleId}/edit" 
                                                   class="btn btn-sm btn-warning btn-action">
                                                    <i class="fas fa-edit me-1"></i>Edit
                                                </a>
                                                <c:choose>
                                                    <c:when test="${module.active}">
                                                        <form action="${pageContext.request.contextPath}/admin/module/${module.moduleId}/toggle" 
                                                              method="post" style="display: inline;">
                                                            <input type="hidden" name="active" value="false">
                                                            <button type="submit" class="btn btn-sm btn-secondary btn-action"
                                                                    onclick="return confirm('Deactivate this module?')">
                                                                <i class="fas fa-ban me-1"></i>Deactivate
                                                            </button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <form action="${pageContext.request.contextPath}/admin/module/${module.moduleId}/toggle" 
                                                              method="post" style="display: inline;">
                                                            <input type="hidden" name="active" value="true">
                                                            <button type="submit" class="btn btn-sm btn-success btn-action"
                                                                    onclick="return confirm('Activate this module?')">
                                                                <i class="fas fa-check me-1"></i>Activate
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                                <form action="${pageContext.request.contextPath}/admin/module/${module.moduleId}/delete" 
                                                      method="post" style="display: inline;">
                                                    <button type="submit" class="btn btn-sm btn-danger btn-action"
                                                            onclick="return confirm('Are you sure you want to delete this module? This action cannot be undone.')">
                                                        <i class="fas fa-trash me-1"></i>Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>