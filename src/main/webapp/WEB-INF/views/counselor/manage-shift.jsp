<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Counselling Shift - SerenityHub</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
            <style>
                body {
                    background: #f5f7fa;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                .sidebar {
                    min-height: 100vh;
                    background: linear-gradient(180deg, #059669 0%, #10b981 100%);
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

                .shift-card {
                    background: white;
                    border-radius: 15px;
                    padding: 30px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                }

                .status-indicator {
                    width: 20px;
                    height: 20px;
                    border-radius: 50%;
                    display: inline-block;
                    margin-right: 10px;
                }

                .status-available {
                    background: #10b981;
                }

                .status-unavailable {
                    background: #ef4444;
                }

                .switch {
                    position: relative;
                    display: inline-block;
                    width: 60px;
                    height: 34px;
                }

                .switch input {
                    opacity: 0;
                    width: 0;
                    height: 0;
                }

                .slider {
                    position: absolute;
                    cursor: pointer;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background-color: #ccc;
                    transition: .4s;
                    border-radius: 34px;
                }

                .slider:before {
                    position: absolute;
                    content: "";
                    height: 26px;
                    width: 26px;
                    left: 4px;
                    bottom: 4px;
                    background-color: white;
                    transition: .4s;
                    border-radius: 50%;
                }

                input:checked+.slider {
                    background-color: #10b981;
                }

                input:checked+.slider:before {
                    transform: translateX(26px);
                }
            </style>
        </head>

        <body>
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="brand-section">
                    <div class="brand-logo">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <p class="brand-text">Counselor Portal</p>
                </div>
                <nav class="nav flex-column mt-4">
                    <a class="nav-link" href="${pageContext.request.contextPath}/counselor/dashboard">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/counselor/appointments">
                        <i class="fas fa-calendar"></i> Appointments
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/counselor/manage-shift">
                        <i class="fas fa-clock"></i> Manage Shift
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/counselor/assessments">
                        <i class="fas fa-clipboard-list"></i> Students Assessments
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/counselor/profile">
                        <i class="fas fa-user"></i> My Profile
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
                            <i class="fas fa-clock me-2"></i>Manage Counselling Shift
                        </h4>
                    </div>
                </nav>

                <!-- Success/Error Messages -->
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

                <div class="row">
                    <div class="col-md-8 mx-auto">
                        <div class="shift-card">
                            <h5 class="mb-4">
                                <i class="fas fa-video me-2"></i>Shift Availability & Meeting Link
                            </h5>

                            <!-- Current Status Display -->
                            <div class="alert alert-${counselor.available ? 'success' : 'secondary'} mb-4">
                                <h6 class="mb-2">
                                    <span
                                        class="status-indicator status-${counselor.available ? 'available' : 'unavailable'}"></span>
                                    Current Status: <strong>${counselor.available ? 'AVAILABLE' :
                                        'UNAVAILABLE'}</strong>
                                </h6>
                                <c:if test="${counselor.available && not empty counselor.shiftMeetingLink}">
                                    <p class="mb-0">
                                        <small>Active Meeting Link: <a href="${counselor.shiftMeetingLink}"
                                                target="_blank">${counselor.shiftMeetingLink}</a></small>
                                    </p>
                                </c:if>
                            </div>

                            <form action="${pageContext.request.contextPath}/counselor/shift/update" method="post">
                                <div class="mb-4">
                                    <label class="form-label d-block">
                                        <h6>Availability Status</h6>
                                    </label>
                                    <div class="d-flex align-items-center">
                                        <span class="me-3">Unavailable</span>
                                        <label class="switch">
                                            <input type="checkbox" name="isAvailable" value="true" ${counselor.available
                                                ? 'checked' : '' } onchange="toggleLinkField(this.checked)">
                                            <span class="slider"></span>
                                        </label>
                                        <span class="ms-3">Available</span>
                                    </div>
                                    <small class="text-muted">
                                        Toggle this switch when you start or end your counselling shift
                                    </small>
                                </div>

                                <div class="mb-4" id="linkField"
                                    style="display: ${counselor.available ? 'block' : 'none'};">

                                    <label class="form-label">
                                        <h6>Google Meet Link</h6>
                                    </label>
                                    <input type="url" class="form-control" name="shiftMeetingLink"
                                        value="${counselor.shiftMeetingLink}"
                                        placeholder="https://meet.google.com/xxx-xxxx-xxx" id="meetingLinkInput">
                                    <small class="text-muted">
                                        Students can use this link to join counselling sessions during your shift
                                    </small>
                                </div>

                                <div class="alert alert-warning">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <strong>Note:</strong> When you set your status to "Available", students will be
                                    able to see and access your meeting link in the counselor directory.
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="fas fa-save me-2"></i>Update Shift Status
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function toggleLinkField(isChecked) {
                    const linkField = document.getElementById('linkField');
                    const linkInput = document.getElementById('meetingLinkInput');

                    if (isChecked) {
                        linkField.style.display = 'block';
                        linkInput.required = true;
                    } else {
                        linkField.style.display = 'none';
                        linkInput.required = false;
                        linkInput.value = '';
                    }
                }

                // Auto-dismiss alerts
                setTimeout(() => {
                    document.querySelectorAll('.alert-dismissible').forEach(alert => {
                        alert.style.transition = 'opacity 0.5s';
                        alert.style.opacity = '0';
                        setTimeout(() => alert.remove(), 500);
                    });
                }, 5000);
            </script>
        </body>

        </html>