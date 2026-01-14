<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>My Profile - SerenityHub</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
      <style>
        body {
          background: #f5f7fa;
          font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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

        .profile-card {
          background: white;
          border-radius: 15px;
          padding: 30px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
          margin-bottom: 20px;
        }

        .profile-header {
          text-align: center;
          padding-bottom: 20px;
          border-bottom: 2px solid #e5e7eb;
          margin-bottom: 30px;
        }

        .profile-avatar {
          width: 120px;
          height: 120px;
          border-radius: 50%;
          background: linear-gradient(135deg, #059669 0%, #10b981 100%);
          display: flex;
          align-items: center;
          justify-content: center;
          color: white;
          font-size: 48px;
          font-weight: 600;
          margin: 0 auto 20px;
          box-shadow: 0 5px 15px rgba(5, 150, 105, 0.3);
        }

        .section-title {
          font-size: 18px;
          font-weight: 600;
          margin-bottom: 20px;
          color: #059669;
          padding-bottom: 10px;
          border-bottom: 2px solid #e5e7eb;
        }

        .form-control:focus,
        .form-select:focus {
          border-color: #10b981;
          box-shadow: 0 0 0 0.2rem rgba(16, 185, 129, 0.25);
        }

        .btn-primary {
          background: linear-gradient(135deg, #059669 0%, #10b981 100%);
          border: none;
          padding: 12px 30px;
        }

        .btn-primary:hover {
          background: linear-gradient(135deg, #047857 0%, #059669 100%);
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

        .badge-counselor {
          background: #d1fae5;
          color: #065f46;
          padding: 5px 15px;
          border-radius: 20px;
          font-size: 13px;
          font-weight: 500;
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
          <a class="nav-link" href="${pageContext.request.contextPath}/counselor/manage-shift">
            <i class="fas fa-clock"></i> Manage Shift
          </a>
          <a class="nav-link" href="${pageContext.request.contextPath}/counselor/assessments">
            <i class="fas fa-clipboard-list"></i> Students Assessments
          </a>
          <a class="nav-link active" href="${pageContext.request.contextPath}/counselor/profile">
            <i class="fas fa-user"></i> My Profile
          </a>
          <hr style="border-color: rgba(255, 255, 255, 0.1); margin: 20px 25px" />
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
            <h4 class="mb-0"><i class="fas fa-user me-2"></i>My Profile</h4>
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

        <div class="row">
          <!-- Profile Information -->
          <div class="col-md-8">
            <div class="profile-card">
              <div class="profile-header">
                <div class="profile-avatar">
                  ${user.fullName.substring(0,1).toUpperCase()}
                </div>
                <h4 class="mb-1">${user.fullName}</h4>
                <span class="badge-counselor">Counselor</span>
                <p class="text-muted mb-0 mt-2">${user.email}</p>
              </div>

              <!-- Edit Profile Form -->
              <form action="${pageContext.request.contextPath}/counselor/profile/update" method="post">
                <h5 class="section-title">Personal Information</h5>

                <div class="row mb-3">
                  <div class="col-md-6">
                    <label class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="fullName" value="${user.fullName}" required />
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Email Address</label>
                    <input type="email" class="form-control" name="email" value="${user.email}" required />
                  </div>
                </div>

                <div class="row mb-3">
                  <div class="col-md-6">
                    <label class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" name="phone" value="${user.phone}"
                      placeholder="e.g., 0123456789" />
                  </div>
                  <div class="col-md-6">
                    <label class="form-label">Specialization</label>
                    <input type="text" class="form-control" name="specialization" value="${counselor.specialization}"
                      placeholder="e.g., Clinical Psychology" />
                  </div>
                </div>

                <div class="mb-3">
                  <label class="form-label">Qualifications</label>
                  <textarea class="form-control" name="qualifications" rows="3"
                    placeholder="Your qualifications and certifications">
${counselor.qualifications}</textarea>
                </div>

                <div class="mb-3">
                  <label class="form-label">Bio</label>
                  <textarea class="form-control" name="bio" rows="4"
                    placeholder="Tell students about yourself and your approach to counseling">
${counselor.bio}</textarea>
                </div>

                <div class="mb-4">
                  <label class="form-label">Available Days</label>
                  <input type="text" class="form-control" name="availableDays" value="${counselor.availableDays}"
                    placeholder="e.g., Monday, Wednesday, Friday" />
                  <small class="text-muted">Comma-separated list of days</small>
                </div>

                <div class="text-end">
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-2"></i>Save Changes
                  </button>
                </div>
              </form>
            </div>
          </div>

          <!-- Change Password & Stats -->
          <div class="col-md-4">
            <!-- Change Password -->
            <div class="profile-card">
              <h5 class="section-title">Change Password</h5>
              <form action="${pageContext.request.contextPath}/counselor/profile/change-password" method="post">
                <div class="mb-3">
                  <label class="form-label">Current Password</label>
                  <input type="password" class="form-control" name="currentPassword" required />
                </div>
                <div class="mb-3">
                  <label class="form-label">New Password</label>
                  <input type="password" class="form-control" name="newPassword" id="newPassword" required
                    minlength="6" />
                </div>
                <div class="mb-3">
                  <label class="form-label">Confirm New Password</label>
                  <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" required
                    minlength="6" />
                </div>
                <button type="submit" class="btn btn-primary w-100">
                  <i class="fas fa-key me-2"></i>Update Password
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      <script>
        // Password validation
        document
          .querySelector('form[action*="change-password"]')
          .addEventListener("submit", function (e) {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword =
              document.getElementById("confirmPassword").value;

            if (newPassword !== confirmPassword) {
              e.preventDefault();
              alert("New passwords do not match!");
              return false;
            }
          });
      </script>
    </body>

    </html>