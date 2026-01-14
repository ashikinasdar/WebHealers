<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Appointments - SerenityHub</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <style>
          body {
            background: #f5f7fa;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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

          .appointment-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 15px;
            border-left: 4px solid #667eea;
            transition: all 0.3s;
          }

          .appointment-card:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
          }

          .counselor-avatar {
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

          .badge-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
          }

          .badge-pending {
            background: #fef3c7;
            color: #92400e;
          }

          .badge-approved {
            background: #d1fae5;
            color: #065f46;
          }

          .badge-declined {
            background: #fee2e2;
            color: #991b1b;
          }

          .badge-completed {
            background: #dbeafe;
            color: #1e40af;
          }

          .badge-cancelled {
            background: #f3f4f6;
            color: #6b7280;
          }

          .modal-content {
            border-radius: 15px;
            border: none;
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/dashboard">
              <i class="fas fa-home"></i> Dashboard
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/learning">
              <i class="fas fa-book"></i> Learning
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/assessments">
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

        <!-- Main Content -->
        <div class="main-content">
          <!-- Top Navbar -->
          <nav class="navbar navbar-expand-lg navbar-light rounded">
            <div class="container-fluid">
              <h4 class="mb-0">
                <i class="fas fa-calendar me-2"></i>My Appointments
              </h4>
              <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#bookModal">
                <i class="fas fa-plus me-2"></i>Book Appointment
              </button>
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

          <!-- Appointments List -->
          <c:choose>
            <c:when test="${empty appointments}">
              <div class="text-center py-5">
                <i class="fas fa-calendar-alt fa-4x text-muted mb-3"></i>
                <h5 class="text-muted">No appointments yet</h5>
                <p class="text-muted">
                  Book your first appointment with a counselor
                </p>
                <button class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#bookModal">
                  <i class="fas fa-plus me-2"></i>Book Appointment
                </button>
              </div>
            </c:when>
            <c:otherwise>
              <c:forEach items="${appointments}" var="appointment">
                <div class="appointment-card">
                  <div class="d-flex">
                    <div class="counselor-avatar">
                      ${appointment.counselorName.substring(0,1).toUpperCase()}
                    </div>
                    <div class="ms-3 flex-grow-1">
                      <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                          <h5 class="mb-1">${appointment.counselorName}</h5>
                          <small class="text-muted">${appointment.counselorSpecialization}</small>
                        </div>
                        <span class="badge-status badge-${appointment.status.toString().toLowerCase()}">
                          ${appointment.status}
                        </span>
                      </div>
                      <div class="mb-2">
                        <p class="mb-1">
                          <i class="fas fa-calendar me-2 text-muted"></i>
                          <fmt:formatDate value="${appointment.appointmentDate}" pattern="EEEE, MMMM dd, yyyy" />
                        </p>
                        <p class="mb-1">
                          <i class="fas fa-clock me-2 text-muted"></i>
                          <fmt:formatDate value="${appointment.appointmentTime}" pattern="hh:mm a" />
                        </p>
                        <p class="mb-0">
                          <i class="fas fa-laptop me-2 text-muted"></i>
                          ${appointment.sessionType}
                        </p>
                        <c:if test="${not empty appointment.meetingLink && appointment.status == 'APPROVED'}">
                          <p class="mb-0">
                            <i class="fas fa-video me-2 text-primary"></i>
                            <a href="${appointment.meetingLink}" target="_blank" class="btn btn-sm btn-success">
                              <i class="fas fa-video me-1"></i>Join Meeting
                            </a>
                          </p>
                        </c:if>
                      </div>
                      <c:if test="${not empty appointment.reason}">
                        <p class="mb-0 text-muted small">
                          <strong>Reason:</strong> ${appointment.reason}
                        </p>
                      </c:if>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
          <!-- Counselor Directory -->
          <div style="margin-top: 40px">
            <h4 class="mb-3">
              <i class="fas fa-user-md me-2"></i>Counselors Directory
            </h4>

            <c:if test="${empty counselors}">
              <p class="text-muted">No counselors available at the moment.</p>
            </c:if>

            <c:forEach items="${counselors}" var="counselor">
              <div class="appointment-card" style="border-left-color: #764ba2">
                <div class="d-flex align-items-center">
                  <div class="counselor-avatar">
                    ${counselor.fullName.substring(0,1).toUpperCase()}
                  </div>
                  <div class="ms-3 flex-grow-1">
                    <div class="d-flex justify-content-between align-items-start">
                      <div>
                        <h5 class="mb-1">${counselor.fullName}</h5>
                        <small class="text-muted">${counselor.specialization}</small>
                      </div>
                      <c:choose>
                        <c:when test="${counselor.available}">
                          <span class="badge bg-success">Available Now</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">Unavailable</span>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <p class="mb-1">
                      <i class="fas fa-envelope me-2"></i>${counselor.email}
                    </p>
                    <p class="mb-1">
                      <i class="fas fa-phone me-2"></i>${counselor.phone}
                    </p>
                    <p class="mb-2">
                      <i class="fas fa-calendar-alt me-2"></i>Available:
                      ${counselor.availableDays}
                    </p>
                    <c:if test="${counselor.available && not empty counselor.shiftMeetingLink}">
                      <a href="${counselor.shiftMeetingLink}" target="_blank" class="btn btn-sm btn-success">
                        <i class="fas fa-video me-1"></i>Join Shift Meeting
                      </a>
                    </c:if>
                    <c:if test="${!counselor.available}">
                      <button class="btn btn-sm btn-secondary" disabled>
                        <i class="fas fa-video me-1"></i>Meeting Unavailable
                      </button>
                    </c:if>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>

        <!-- Book Appointment Modal -->
        <div class="modal fade" id="bookModal" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">
                  <i class="fas fa-calendar-plus me-2"></i>Book Appointment
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
              </div>
              <form action="${pageContext.request.contextPath}/student/appointment/book" method="post">
                <div class="modal-body">
                  <div class="mb-3">
                    <label class="form-label">Select Counselor <span class="text-danger">*</span></label>
                    <select class="form-select" name="counselorId" required>
                      <option value="">Choose a counselor</option>
                      <c:forEach items="${counselors}" var="counselor">
                        <option value="${counselor.counselorId}">
                          ${counselor.fullName} - ${counselor.specialization}
                        </option>
                      </c:forEach>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label class="form-label">Appointment Date <span class="text-danger">*</span></label>
                    <input type="date" class="form-control" name="appointmentDate"
                      min="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" required />
                  </div>

                  <div class="mb-3">
                    <label class="form-label">Appointment Time <span class="text-danger">*</span></label>
                    <select class="form-select" name="appointmentTime" required>
                      <option value="">Select time</option>
                      <option value="09:00:00">09:00 AM</option>
                      <option value="10:00:00">10:00 AM</option>
                      <option value="11:00:00">11:00 AM</option>
                      <option value="14:00:00">02:00 PM</option>
                      <option value="15:00:00">03:00 PM</option>
                      <option value="16:00:00">04:00 PM</option>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label class="form-label">Session Type <span class="text-danger">*</span></label>
                    <select class="form-select" name="sessionType" required>
                      <option value="IN_PERSON">In-Person</option>
                      <option value="ONLINE">Online (Video Call)</option>
                      <option value="PHONE">Phone Call</option>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label class="form-label">Reason for Appointment</label>
                    <textarea class="form-control" name="reason" rows="3"
                      placeholder="Brief description of what you'd like to discuss"></textarea>
                  </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    Cancel
                  </button>
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check me-2"></i>Book Appointment
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
          // Set minimum date to today
          const today = new Date().toISOString().split("T")[0];
          document.querySelector('input[name="appointmentDate"]').min = today;
        </script>
      </body>

      </html>