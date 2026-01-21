<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Submit Feedback - SerenityHub</title>
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

                    .card {
                        border-radius: 15px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                        padding: 25px;
                    }
                </style>
            </head>

            <body>
                <!-- Sidebar -->
                <div class="sidebar">
                    <div class="brand-section text-center py-4">
                        <div class="brand-logo"><i class="fas fa-heart"></i></div>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
                            <i class="fas fa-comments"></i> Forum
                        </a>

                        <a class="nav-link active" href="${pageContext.request.contextPath}/student/feedback">
                            <i class="fas fa-comment-dots"></i> Feedback
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
                    <nav class="navbar navbar-expand-lg navbar-light rounded mb-4">
                        <div class="container-fluid">
                            <h4 class="mb-0"><i class="fas fa-comment-dots me-2"></i>Submit Feedback</h4>
                        </div>
                    </nav>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card">
                        <form:form method="POST" action="${pageContext.request.contextPath}/student/feedback/save"
                            modelAttribute="feedback">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <form:input path="username" cssClass="form-control"  />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Title</label>
                                <form:input path="title" cssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Category</label>
                                <form:select path="category" cssClass="form-select">
                                    <form:option value="Usability" label="Usability" />
                                    <form:option value="Content" label="Content" />
                                    <form:option value="Bug" label="Bug" />
                                    <form:option value="Other" label="Other" />
                                </form:select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Message</label>
                                <form:textarea path="message" rows="4" cssClass="form-control" />
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane me-2"></i>Submit
                                Feedback</button>
                        </form:form>


                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>