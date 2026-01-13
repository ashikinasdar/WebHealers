<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create Module - SerenityHub</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: #f5f7fa;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .sidebar {
        min-height: 100vh;
        background: linear-gradient(180deg, #1e3a8a 0%, #1e40af 100%);
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
      .form-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        max-width: 900px;
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
      .form-control:focus,
      .form-select:focus {
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
          <i class="fas fa-shield-alt"></i>
        </div>
        <p class="brand-text">Admin Panel</p>
      </div>
      <nav class="nav flex-column mt-4">
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/dashboard"
        >
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/users"
        >
          <i class="fas fa-users"></i> User Management
        </a>
        <a
          class="nav-link active"
          href="${pageContext.request.contextPath}/admin/modules"
        >
          <i class="fas fa-book"></i> Learning Modules
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/forum"
        >
          <i class="fas fa-comments"></i> Forum Management
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/reports"
        >
          <i class="fas fa-chart-bar"></i> Reports
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
          <h4 class="mb-0">
            <i class="fas fa-plus-circle me-2"></i>Create Learning Module
          </h4>
          <a
            href="${pageContext.request.contextPath}/admin/modules"
            class="btn btn-outline-secondary"
          >
            <i class="fas fa-arrow-left me-2"></i>Back to Modules
          </a>
        </div>
      </nav>

      <!-- Alerts -->
      <c:if test="${not empty error}">
        <div
          class="alert alert-danger alert-dismissible fade show"
          role="alert"
        >
          <i class="fas fa-exclamation-circle me-2"></i>${error}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
          ></button>
        </div>
      </c:if>

      <!-- Form Card -->
      <div class="form-card">
        <form
          action="${pageContext.request.contextPath}/admin/module/create"
          method="post"
        >
          <!-- Basic Information -->
          <div class="form-section">
            <h5 class="form-section-title">
              <i class="fas fa-info-circle me-2"></i>Basic Information
            </h5>

            <div class="mb-3">
              <label class="form-label"
                >Module Title <span class="text-danger">*</span></label
              >
              <input
                type="text"
                class="form-control"
                name="title"
                required
              />
            </div>

            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label"
                  >Category <span class="text-danger">*</span></label
                >
                <select class="form-select" name="category" required>
                  <option value="">Select Category</option>
                  <option value="Mental Health">Mental Health</option>
                  <option value="Stress Management">Stress Management</option>
                  <option value="Anxiety">Anxiety</option>
                  <option value="Depression">Depression</option>
                  <option value="Self-Care">Self-Care</option>
                  <option value="Mindfulness">Mindfulness</option>
                  <option value="Relationships">Relationships</option>
                  <option value="Academic Wellness">Academic Wellness</option>
                  <option value="Other">Other</option>
                </select>
              </div>

              <div class="col-md-6 mb-3">
                <label class="form-label"
                  >Duration (minutes) <span class="text-danger">*</span></label
                >
                <input
                  type="number"
                  class="form-control"
                  name="durationMinutes"
                  min="1"
                  max="300"
                  required
                />
              </div>
            </div>

            <div class="mb-3">
              <label class="form-label">Display Order</label>
              <input
                type="number"
                class="form-control"
                name="displayOrder"
                min="1"
                value="1"
                placeholder="1"
              />
            </div>

            <div class="mb-3">
              <label class="form-label"
                >Short Description <span class="text-danger">*</span></label
              >
              <textarea
                class="form-control"
                name="description"
                rows="3"
                required
              ></textarea>
            </div>
          </div>

          <!-- Module Content -->
          <div class="form-section">
            <h5 class="form-section-title">
              <i class="fas fa-file-alt me-2"></i>Module Content
            </h5>

            <div class="mb-3">
              <label class="form-label"
                >Learning Content <span class="text-danger">*</span></label
              >
              <textarea
                class="form-control"
                name="content"
                rows="12"
                required
              ></textarea>
            </div>

            <div class="mb-3">
              <label class="form-label">Learning Objectives</label>
              <textarea
                class="form-control"
                name="objectives"
                rows="4"
              ></textarea>
            </div>
          </div>

          <!-- Module Settings -->
          <div class="form-section">
            <h5 class="form-section-title">
              <i class="fas fa-cog me-2"></i>Module Settings
            </h5>

            <div class="form-check form-switch mb-3">
              <input
                class="form-check-input"
                type="checkbox"
                role="switch"
                name="isActive"
                id="isActive"
                checked
              />
              <label class="form-check-label" for="isActive">
                <strong>Module is active</strong>
                <br />
                <small class="text-muted"
                  >Active modules are visible to students</small
                >
              </label>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="d-flex justify-content-between">
            <a
              href="${pageContext.request.contextPath}/admin/modules"
              class="btn btn-outline-secondary"
            >
              <i class="fas fa-times me-2"></i>Cancel
            </a>
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-save me-2"></i>Create Module
            </button>
          </div>
        </form>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
