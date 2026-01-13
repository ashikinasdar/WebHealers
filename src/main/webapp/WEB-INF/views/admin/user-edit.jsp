<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - SerenityHub</title>
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
        .form-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 800px;
            margin: 0 auto;
        }
        .form-section {
            margin-bottom: 30px;
        }
        .form-section-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e40af;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e5e7eb;
        }
        .form-control:focus, .form-select:focus {
            border-color: #1e40af;
            box-shadow: 0 0 0 0.2rem rgba(30, 64, 175, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
            border: none;
            padding: 12px 30px;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
                <i class="fas fa-users"></i> User Management
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/modules">
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
                <h4 class="mb-0"><i class="fas fa-edit me-2"></i>Edit User</h4>
                <a href="${pageContext.request.contextPath}/admin/user/${user.userId}" 
                   class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back
                </a>
            </div>
        </nav>

        <!-- Alerts -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Form Card -->
        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/user/${user.userId}/update" method="post">
                <!-- Basic Information -->
                <div class="form-section">
                    <h5 class="form-section-title">
                        <i class="fas fa-user me-2"></i>Basic Information
                    </h5>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="fullName" 
                                   value="${user.fullName}" required>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Email Address <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" 
                                   value="${user.email}" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" name="phone" 
                                   value="${user.phone}" placeholder="e.g., 0123456789">
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label">User Role</label>
                            <input type="text" class="form-control" value="${user.userType}" readonly disabled>
                            <small class="text-muted">User role cannot be changed</small>
                        </div>
                    </div>
                </div>

                <!-- Student-Specific Fields (if student) -->
                <c:if test="${user.userType == 'STUDENT'}">
                    <div class="form-section">
                        <h5 class="form-section-title">
                            <i class="fas fa-user-graduate me-2"></i>Student Information
                        </h5>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Student Number</label>
                                <input type="text" class="form-control" name="studentNumber" 
                                       value="${student.studentNumber}" placeholder="e.g., A20EC0001">
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Faculty</label>
                                <select class="form-select" name="faculty">
                                    <option value="">Select Faculty</option>
                                    <option value="Computing" ${student.faculty == 'Computing' ? 'selected' : ''}>Faculty of Computing</option>
                                    <option value="Engineering" ${student.faculty == 'Engineering' ? 'selected' : ''}>Faculty of Engineering</option>
                                    <option value="Science" ${student.faculty == 'Science' ? 'selected' : ''}>Faculty of Science</option>
                                    <option value="Management" ${student.faculty == 'Management' ? 'selected' : ''}>Faculty of Management</option>
                                    <option value="Education" ${student.faculty == 'Education' ? 'selected' : ''}>Faculty of Education</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Year of Study</label>
                                <select class="form-select" name="yearOfStudy">
                                    <option value="">Select Year</option>
                                    <option value="1" ${student.yearOfStudy == 1 ? 'selected' : ''}>Year 1</option>
                                    <option value="2" ${student.yearOfStudy == 2 ? 'selected' : ''}>Year 2</option>
                                    <option value="3" ${student.yearOfStudy == 3 ? 'selected' : ''}>Year 3</option>
                                    <option value="4" ${student.yearOfStudy == 4 ? 'selected' : ''}>Year 4</option>
                                    <option value="5" ${student.yearOfStudy == 5 ? 'selected' : ''}>Year 5</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Bio</label>
                                <textarea class="form-control" name="bio" rows="3" 
                                          placeholder="Brief description">${student.bio}</textarea>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Account Status -->
                <div class="form-section">
                    <h5 class="form-section-title">
                        <i class="fas fa-toggle-on me-2"></i>Account Status
                    </h5>
                    
                    <div class="form-check form-switch mb-3">
                        <input class="form-check-input" type="checkbox" role="switch" 
                               name="isActive" id="isActive" ${user.active ? 'checked' : ''}>
                        <label class="form-check-label" for="isActive">
                            <strong>Account is active</strong>
                            <br>
                            <small class="text-muted">Inactive users cannot log in to the system</small>
                        </label>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/admin/user/${user.userId}" 
                       class="btn btn-outline-secondary">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                    <div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Save Changes
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>