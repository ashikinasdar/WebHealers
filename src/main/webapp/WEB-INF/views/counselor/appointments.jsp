<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointments Management - SerenityHub</title>
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
        .appointment-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s;
        }
        .appointment-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .badge-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-pending { background: #fef3c7; color: #92400e; }
        .badge-approved { background: #d1fae5; color: #065f46; }
        .badge-completed { background: #dbeafe; color: #1e40af; }
        .badge-declined { background: #fee2e2; color: #991b1b; }
        .badge-cancelled { background: #f3f4f6; color: #4b5563; }
        .filter-tabs {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .filter-tabs .btn {
            margin-right: 10px;
            margin-bottom: 10px;
            border-radius: 20px;
        }
        .modal-content {
            border-radius: 15px;
        }
        .session-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        .session-online { background: #dbeafe; color: #0284c7; }
        .session-inperson { background: #d1fae5; color: #059669; }
        .session-phone { background: #fef3c7; color: #d97706; }
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/counselor/appointments">
                <i class="fas fa-calendar"></i> Appointments
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
                    <i class="fas fa-calendar me-2"></i>Appointment Management
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

        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <button class="btn btn-sm btn-primary filter-btn" data-filter="all">
                All Appointments
            </button>
            <button class="btn btn-sm btn-outline-warning filter-btn" data-filter="PENDING">
                Pending
            </button>
            <button class="btn btn-sm btn-outline-success filter-btn" data-filter="APPROVED">
                Approved
            </button>
            <button class="btn btn-sm btn-outline-info filter-btn" data-filter="COMPLETED">
                Completed
            </button>
            <button class="btn btn-sm btn-outline-danger filter-btn" data-filter="DECLINED">
                Declined
            </button>
        </div>

        <!-- Appointments List -->
        <div class="row">
            <c:choose>
                <c:when test="${empty appointments}">
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
                            <h5 class="text-muted">No appointments found</h5>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${appointments}" var="appt">
                        <div class="col-md-6 appointment-item" data-status="${appt.status}">
                            <div class="appointment-card">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="d-flex align-items-center">
                                        <div class="session-icon session-${appt.sessionType.toString().toLowerCase()} me-3">
                                            <c:choose>
                                                <c:when test="${appt.sessionType == 'ONLINE'}">
                                                    <i class="fas fa-video"></i>
                                                </c:when>
                                                <c:when test="${appt.sessionType == 'IN_PERSON'}">
                                                    <i class="fas fa-user"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-phone"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <h6 class="mb-0">${appt.studentName}</h6>
                                            <small class="text-muted">${appt.studentEmail}</small>
                                        </div>
                                    </div>
                                    <span class="badge-status badge-${appt.status.toString().toLowerCase()}">
                                        ${appt.status}
                                    </span>
                                </div>

                                <div class="mb-3">
                                    <div class="row">
                                        <div class="col-6">
                                            <small class="text-muted d-block">
                                                <i class="fas fa-calendar me-2"></i>Date
                                            </small>
                                            <strong>
                                                <fmt:formatDate value="${appt.appointmentDate}" pattern="MMM dd, yyyy" />
                                            </strong>
                                        </div>
                                        <div class="col-6">
                                            <small class="text-muted d-block">
                                                <i class="fas fa-clock me-2"></i>Time
                                            </small>
                                            <strong>
                                                <fmt:formatDate value="${appt.appointmentTime}" pattern="hh:mm a" />
                                            </strong>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${not empty appt.reason}">
                                    <div class="mb-3">
                                        <small class="text-muted d-block mb-1">
                                            <i class="fas fa-comment-dots me-2"></i>Reason
                                        </small>
                                        <p class="mb-0 small">${appt.reason}</p>
                                    </div>
                                </c:if>

                                <div class="d-flex gap-2">
                                    <c:choose>
                                        <c:when test="${appt.status == 'PENDING'}">
                                            <form action="${pageContext.request.contextPath}/counselor/appointment/${appt.appointmentId}/approve" 
                                                  method="post" style="flex: 1;">
                                                <button type="submit" class="btn btn-success btn-sm w-100">
                                                    <i class="fas fa-check me-1"></i>Approve
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/counselor/appointment/${appt.appointmentId}/decline" 
                                                  method="post" style="flex: 1;">
                                                <button type="submit" class="btn btn-danger btn-sm w-100">
                                                    <i class="fas fa-times me-1"></i>Decline
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:when test="${appt.status == 'APPROVED'}">
                                            <button type="button" class="btn btn-info btn-sm flex-fill" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#completeModal${appt.appointmentId}">
                                                <i class="fas fa-check-double me-1"></i>Complete Session
                                            </button>
                                        </c:when>
                                    </c:choose>
                                    <button type="button" class="btn btn-outline-primary btn-sm" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#detailsModal${appt.appointmentId}">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Complete Appointment Modal -->
                        <div class="modal fade" id="completeModal${appt.appointmentId}" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Complete Appointment</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/counselor/appointment/${appt.appointmentId}/complete" 
                                          method="post">
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label class="form-label">Session Notes</label>
                                                <textarea class="form-control" name="counselorNotes" rows="5" 
                                                          placeholder="Enter your notes about this counseling session..." required></textarea>
                                                <small class="text-muted">
                                                    These notes will be saved for your reference only.
                                                </small>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-check-double me-1"></i>Complete Session
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Details Modal -->
                        <div class="modal fade" id="detailsModal${appt.appointmentId}" tabindex="-1">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Appointment Details</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <strong>Student Name:</strong><br>
                                                ${appt.studentName}
                                            </div>
                                            <div class="col-md-6">
                                                <strong>Email:</strong><br>
                                                ${appt.studentEmail}
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-md-4">
                                                <strong>Date:</strong><br>
                                                <fmt:formatDate value="${appt.appointmentDate}" pattern="MMMM dd, yyyy" />
                                            </div>
                                            <div class="col-md-4">
                                                <strong>Time:</strong><br>
                                                <fmt:formatDate value="${appt.appointmentTime}" pattern="hh:mm a" />
                                            </div>
                                            <div class="col-md-4">
                                                <strong>Session Type:</strong><br>
                                                ${appt.sessionType}
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <strong>Status:</strong><br>
                                            <span class="badge-status badge-${appt.status.toString().toLowerCase()}">
                                                ${appt.status}
                                            </span>
                                        </div>
                                        <c:if test="${not empty appt.reason}">
                                            <div class="mb-3">
                                                <strong>Reason for Appointment:</strong><br>
                                                ${appt.reason}
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty appt.notes}">
                                            <div class="mb-3">
                                                <strong>Student Notes:</strong><br>
                                                ${appt.notes}
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty appt.counselorNotes}">
                                            <div class="mb-3">
                                                <strong>Counselor Notes:</strong><br>
                                                <div class="alert alert-info">
                                                    ${appt.counselorNotes}
                                                </div>
                                            </div>
                                        </c:if>
                                        <div class="mb-3">
                                            <small class="text-muted">
                                                <strong>Created:</strong> 
                                                <fmt:formatDate value="${appt.createdAt}" pattern="MMM dd, yyyy hh:mm a" />
                                            </small>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filter functionality
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                // Update active button
                document.querySelectorAll('.filter-btn').forEach(b => {
                    b.classList.remove('btn-primary');
                    b.classList.add('btn-outline-primary');
                });
                this.classList.remove('btn-outline-primary', 'btn-outline-warning', 'btn-outline-success', 
                                      'btn-outline-info', 'btn-outline-danger');
                this.classList.add('btn-primary');

                // Filter appointments
                const filter = this.getAttribute('data-filter');
                document.querySelectorAll('.appointment-item').forEach(item => {
                    if (filter === 'all' || item.getAttribute('data-status') === filter) {
                        item.style.display = 'block';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        });

        // Auto-dismiss alerts
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>