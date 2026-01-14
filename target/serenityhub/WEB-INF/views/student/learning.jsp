<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Learning - SerenityHub</title>
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

        /* Filter Tabs */
        .filter-tabs {
          display: flex;
          gap: 10px;
          flex-wrap: wrap;
          margin-bottom: 25px;
          padding: 20px;
          background: white;
          border-radius: 15px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .filter-btn {
          padding: 8px 20px;
          border-radius: 20px;
          font-size: 14px;
          font-weight: 500;
          transition: all 0.3s;
          text-decoration: none;
          border: 2px solid transparent;
        }

        .btn-primary.filter-btn {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          border: none;
          color: white;
        }

        .btn-outline-primary.filter-btn {
          color: #667eea;
          border-color: #667eea;
          background: white;
        }

        .btn-outline-primary.filter-btn:hover {
          background: #667eea;
          color: white;
        }

        /* Module Cards */
        .module-card {
          background: white;
          border-radius: 15px;
          padding: 25px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
          margin-bottom: 20px;
          transition: all 0.3s;
          border: 1px solid #e5e7eb;
          position: relative;
          overflow: hidden;
        }

        .module-card::before {
          content: "";
          position: absolute;
          top: 0;
          left: 0;
          width: 4px;
          height: 100%;
          background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
        }

        .module-card:hover {
          transform: translateY(-5px);
          box-shadow: 0 8px 25px rgba(102, 126, 234, 0.15);
          border-color: #667eea;
        }

        .module-icon {
          width: 60px;
          height: 60px;
          border-radius: 12px;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          display: flex;
          align-items: center;
          justify-content: center;
          color: white;
          font-size: 24px;
        }

        .badge-category {
          background: #f0f4ff;
          color: #667eea;
          padding: 5px 15px;
          border-radius: 20px;
          font-size: 12px;
          font-weight: 500;
        }

        .progress-ring {
          width: 60px;
          height: 60px;
          position: relative;
        }

        .progress-circle {
          width: 100%;
          height: 100%;
          border-radius: 50%;
          background: conic-gradient(#667eea 0deg,
              #667eea var(--progress),
              #e9ecef var(--progress),
              #e9ecef 360deg);
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .progress-inner {
          width: 46px;
          height: 46px;
          background: white;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 13px;
          font-weight: 700;
          color: #667eea;
        }

        .btn-start {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          border: none;
          color: white;
          padding: 10px 25px;
          border-radius: 10px;
          transition: all 0.3s;
        }

        .btn-start:hover {
          transform: scale(1.05);
          box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
          color: white;
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
      <!-- side navigation bar -->
      <div class="sidebar">
        <div class="brand-section">
          <div class="brand-logo">
            <i class="fas fa-heart"></i>
          </div>
          <p class="brand-text">SerenityHub</p>
        </div>
        <nav class="nav flex-column mt-4">
          <a class="nav-link " href="${pageContext.request.contextPath}/student/dashboard">
            <i class="fas fa-home"></i> Dashboard
          </a>
          <a class="nav-link active" href="${pageContext.request.contextPath}/student/learning">
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

      <!-- main content -->
      <div class="main-content">
        <!-- top navigation bar -->
        <nav class="navbar navbar-expand-lg navbar-light rounded">
          <div class="container-fluid">
            <h4 class="mb-0"><i class="fas fa-book me-2"></i>Learning Modules</h4>
          </div>
        </nav>

        <!-- Filter Tabs -->
        <div class="filter-tabs">
          <a href="${pageContext.request.contextPath}/student/learning"
            class="btn btn-sm ${empty selectedCategory or selectedCategory == 'all' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-th me-2"></i>All Modules
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Mental Health"
            class="btn btn-sm ${selectedCategory == 'Mental Health' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-brain me-2"></i>Mental Health
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Stress Management"
            class="btn btn-sm ${selectedCategory == 'Stress Management' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-spa me-2"></i>Stress Management
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Anxiety"
            class="btn btn-sm ${selectedCategory == 'Anxiety' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-wind me-2"></i>Anxiety
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Depression"
            class="btn btn-sm ${selectedCategory == 'Depression' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-cloud-rain me-2"></i>Depression
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Self-Care"
            class="btn btn-sm ${selectedCategory == 'Self-Care' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-heart me-2"></i>Self-Care
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Mindfulness"
            class="btn btn-sm ${selectedCategory == 'Mindfulness' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-leaf me-2"></i>Mindfulness
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Relationships"
            class="btn btn-sm ${selectedCategory == 'Relationships' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-users me-2"></i>Relationships
          </a>
          <a href="${pageContext.request.contextPath}/student/learning?category=Academic Wellness"
            class="btn btn-sm ${selectedCategory == 'Academic Wellness' ? 'btn-primary' : 'btn-outline-primary'} filter-btn">
            <i class="fas fa-graduation-cap me-2"></i>Academic Wellness
          </a>
        </div>

        <!-- learning modules -->
        <div class="row">
          <c:choose>
            <c:when test="${empty modules}">
              <div class="col-12">
                <div class="text-center py-5">
                  <i class="fas fa-book fa-4x text-muted mb-3"></i>
                  <h5 class="text-muted">No learning modules available in this category</h5>
                </div>
              </div>
            </c:when>
            <c:otherwise>
              <c:forEach items="${modules}" var="module">
                <div class="col-md-6">
                  <div class="module-card">
                    <div class="d-flex">
                      <div class="module-icon">
                        <i class="fas fa-book-open"></i>
                      </div>
                      <div class="ms-3 flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                          <div>
                            <h5 class="mb-1">${module.title}</h5>
                            <span class="badge-category">${module.category}</span>
                          </div>
                          <div class="text-center">
                            <div class="progress-ring" style="--progress: ${module.progress_percentage * 3.6}deg;">
                              <div class="progress-circle">
                                <div class="progress-inner">
                                  ${module.progress_percentage}%
                                </div>
                              </div>
                            </div>
                            <small class="text-muted d-block mt-1">Progress</small>
                          </div>
                        </div>
                        <p class="text-muted mb-3">${module.description}</p>
                        <div class="d-flex justify-content-between align-items-center">
                          <div>
                            <small class="text-muted">
                              <i class="fas fa-clock me-1"></i>
                              ${module.duration_minutes} minutes
                            </small>
                          </div>
                          <a href="${pageContext.request.contextPath}/student/module/${module.module_id}"
                            class="btn btn-start btn-sm">
                            <c:choose>
                              <c:when test="${module.progress_status == 'COMPLETED'}">
                                <i class="fas fa-check me-2"></i>Review
                              </c:when>
                              <c:when test="${module.progress_status == 'IN_PROGRESS'}">
                                <i class="fas fa-play me-2"></i>Continue
                              </c:when>
                              <c:otherwise>
                                <i class="fas fa-play me-2"></i>Start
                              </c:otherwise>
                            </c:choose>
                          </a>
                        </div>
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
    </body>

    </html>