<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Assessment Management - SerenityHub</title>
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
        background: linear-gradient(180deg, #059669 0%, #10b981 100%);
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
      }
      .brand-text {
        color: white;
        font-size: 18px;
        font-weight: 600;
      }
      .tab-content {
        padding-top: 20px;
      }
      .assessment-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        margin-bottom: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        transition: all 0.3s;
      }
      .assessment-card:hover {
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        transform: translateY(-2px);
      }
      .result-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 15px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      }
      .severity-badge {
        padding: 6px 15px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
      }
      .severity-normal {
        background: #d1fae5;
        color: #065f46;
      }
      .severity-mild {
        background: #fef3c7;
        color: #92400e;
      }
      .severity-moderate {
        background: #fed7aa;
        color: #9a3412;
      }
      .severity-severe {
        background: #fecaca;
        color: #991b1b;
      }
      .severity-extremely_severe {
        background: #fca5a5;
        color: #7f1d1d;
      }
      .score-display {
        font-size: 28px;
        font-weight: bold;
        color: #059669;
      }
      .filter-buttons {
        background: white;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      }
      .filter-buttons .btn {
        margin-right: 10px;
        margin-bottom: 5px;
      }
      .stats-card {
        background: white;
        border-radius: 15px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        text-align: center;
      }
      .stats-number {
        font-size: 36px;
        font-weight: bold;
        color: #059669;
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
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/counselor/dashboard"
        >
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/counselor/appointments"
        >
          <i class="fas fa-calendar"></i> Appointments
        </a>
        <a
          class="nav-link active"
          href="${pageContext.request.contextPath}/counselor/assessments"
        >
          <i class="fas fa-clipboard-list"></i> Student Assessments
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/counselor/profile"
        >
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
          <h4 class="mb-0">
            <i class="fas fa-clipboard-list me-2"></i>Assessment Management
          </h4>
          <button
            type="button"
            class="btn btn-success"
            data-bs-toggle="modal"
            data-bs-target="#createTypeModal"
          >
            <i class="fas fa-plus-circle me-2"></i>Create New Assessment Type
          </button>
        </div>
      </nav>

      <!-- Success/Error Messages -->
      <c:if test="${not empty success}">
        <div
          class="alert alert-success alert-dismissible fade show"
          role="alert"
        >
          <i class="fas fa-check-circle me-2"></i>${success}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
          ></button>
        </div>
      </c:if>
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

      <!-- Tabs -->
      <ul class="nav nav-tabs mb-3" id="assessmentTabs" role="tablist">
        <li class="nav-item" role="presentation">
          <button
            class="nav-link active"
            id="results-tab"
            data-bs-toggle="tab"
            data-bs-target="#results"
            type="button"
            role="tab"
          >
            <i class="fas fa-chart-bar me-2"></i>Student Results
          </button>
        </li>
        <li class="nav-item" role="presentation">
          <button
            class="nav-link"
            id="manage-tab"
            data-bs-toggle="tab"
            data-bs-target="#manage"
            type="button"
            role="tab"
          >
            <i class="fas fa-cog me-2"></i>Manage Questions
          </button>
        </li>
      </ul>

      <!-- Tab Content -->
      <div class="tab-content" id="assessmentTabContent">
        <!-- Student Results Tab -->
        <div class="tab-pane fade show active" id="results" role="tabpanel">
          <!-- Filter Buttons -->
          <div class="filter-buttons">
            <button class="btn btn-sm btn-primary filter-btn" data-filter="all">
              All Results
            </button>
            <button
              class="btn btn-sm btn-outline-success filter-btn"
              data-filter="NORMAL"
            >
              Normal
            </button>
            <button
              class="btn btn-sm btn-outline-warning filter-btn"
              data-filter="MILD"
            >
              Mild
            </button>
            <button
              class="btn btn-sm btn-outline-orange filter-btn"
              data-filter="MODERATE"
            >
              Moderate
            </button>
            <button
              class="btn btn-sm btn-outline-danger filter-btn"
              data-filter="SEVERE"
            >
              Severe
            </button>
            <button
              class="btn btn-sm btn-outline-dark filter-btn"
              data-filter="EXTREMELY_SEVERE"
            >
              Extremely Severe
            </button>
          </div>

          <div class="row">
            <c:choose>
              <c:when test="${empty results}">
                <div class="col-12">
                  <div class="text-center py-5">
                    <i class="fas fa-clipboard fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No assessment results found</h5>
                    <p class="text-muted">
                      Students haven't completed any assessments yet
                    </p>
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <c:forEach items="${results}" var="result">
                  <div
                    class="col-md-6 result-item"
                    data-severity="${result.overallSeverity}"
                  >
                    <div class="result-card">
                      <div
                        class="d-flex justify-content-between align-items-start mb-3"
                      >
                        <div>
                          <h6 class="mb-1">${result.studentName}</h6>
                          <small class="text-muted"
                            >${result.assessmentName}</small
                          >
                        </div>
                        <span
                          class="severity-badge severity-${result.overallSeverity.toString().toLowerCase()}"
                        >
                          ${result.overallSeverity.toString().replace('_', ' ')}
                        </span>
                      </div>

                      <div class="row text-center mb-3">
                        <div class="col-4">
                          <div class="score-display text-primary">
                            ${result.depressionScore}
                          </div>
                          <small class="text-muted">Depression</small>
                        </div>
                        <div class="col-4">
                          <div class="score-display text-warning">
                            ${result.anxietyScore}
                          </div>
                          <small class="text-muted">Anxiety</small>
                        </div>
                        <div class="col-4">
                          <div class="score-display text-danger">
                            ${result.stressScore}
                          </div>
                          <small class="text-muted">Stress</small>
                        </div>
                      </div>

                      <div
                        class="d-flex justify-content-between align-items-center"
                      >
                        <small class="text-muted">
                          <i class="fas fa-calendar me-1"></i>
                          <fmt:formatDate
                            value="${result.attemptedAt}"
                            pattern="MMM dd, yyyy"
                          />
                        </small>
                        <button
                          type="button"
                          class="btn btn-sm btn-outline-primary"
                          data-bs-toggle="modal"
                          data-bs-target="#resultModal${result.resultId}"
                        >
                          <i class="fas fa-eye me-1"></i>View Details
                        </button>
                      </div>
                    </div>
                  </div>

                  <!-- Result Details Modal -->
                  <div
                    class="modal fade"
                    id="resultModal${result.resultId}"
                    tabindex="-1"
                  >
                    <div class="modal-dialog modal-lg">
                      <div class="modal-content">
                        <div class="modal-header">
                          <h5 class="modal-title">Assessment Result Details</h5>
                          <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                          ></button>
                        </div>
                        <div class="modal-body">
                          <div class="row mb-4">
                            <div class="col-md-6">
                              <strong>Student:</strong> ${result.studentName}
                            </div>
                            <div class="col-md-6">
                              <strong>Assessment:</strong>
                              ${result.assessmentName}
                            </div>
                          </div>

                          <div class="row mb-4">
                            <div class="col-md-4 text-center">
                              <div class="score-display text-primary">
                                ${result.depressionScore}
                              </div>
                              <strong>Depression Score</strong>
                              <p class="text-muted small mb-0">
                                <c:choose>
                                  <c:when test="${result.depressionScore <= 9}"
                                    >Normal</c:when
                                  >
                                  <c:when test="${result.depressionScore <= 13}"
                                    >Mild</c:when
                                  >
                                  <c:when test="${result.depressionScore <= 20}"
                                    >Moderate</c:when
                                  >
                                  <c:when test="${result.depressionScore <= 27}"
                                    >Severe</c:when
                                  >
                                  <c:otherwise>Extremely Severe</c:otherwise>
                                </c:choose>
                              </p>
                            </div>
                            <div class="col-md-4 text-center">
                              <div class="score-display text-warning">
                                ${result.anxietyScore}
                              </div>
                              <strong>Anxiety Score</strong>
                              <p class="text-muted small mb-0">
                                <c:choose>
                                  <c:when test="${result.anxietyScore <= 7}"
                                    >Normal</c:when
                                  >
                                  <c:when test="${result.anxietyScore <= 9}"
                                    >Mild</c:when
                                  >
                                  <c:when test="${result.anxietyScore <= 14}"
                                    >Moderate</c:when
                                  >
                                  <c:when test="${result.anxietyScore <= 19}"
                                    >Severe</c:when
                                  >
                                  <c:otherwise>Extremely Severe</c:otherwise>
                                </c:choose>
                              </p>
                            </div>
                            <div class="col-md-4 text-center">
                              <div class="score-display text-danger">
                                ${result.stressScore}
                              </div>
                              <strong>Stress Score</strong>
                              <p class="text-muted small mb-0">
                                <c:choose>
                                  <c:when test="${result.stressScore <= 14}"
                                    >Normal</c:when
                                  >
                                  <c:when test="${result.stressScore <= 18}"
                                    >Mild</c:when
                                  >
                                  <c:when test="${result.stressScore <= 25}"
                                    >Moderate</c:when
                                  >
                                  <c:when test="${result.stressScore <= 33}"
                                    >Severe</c:when
                                  >
                                  <c:otherwise>Extremely Severe</c:otherwise>
                                </c:choose>
                              </p>
                            </div>
                          </div>

                          <div class="mb-4">
                            <strong>Overall Severity:</strong>
                            <span
                              class="severity-badge severity-${result.overallSeverity.toString().toLowerCase()} ms-2"
                            >
                              ${result.overallSeverity.toString().replace('_', '
                              ')}
                            </span>
                          </div>

                          <div>
                            <small class="text-muted">
                              <strong>Date Completed:</strong>
                              <fmt:formatDate
                                value="${result.attemptedAt}"
                                pattern="MMMM dd, yyyy 'at' hh:mm a"
                              />
                            </small>
                          </div>

                          <c:if
                            test="${result.overallSeverity == 'SEVERE' || result.overallSeverity == 'EXTREMELY_SEVERE'}"
                          >
                            <div class="alert alert-danger mt-3">
                              <i class="fas fa-exclamation-triangle me-2"></i>
                              <strong>Action Required:</strong> This student
                              shows
                              ${result.overallSeverity.toString().toLowerCase().replace('_',
                              ' ')} symptoms. Consider reaching out to provide
                              support or schedule a follow-up appointment.
                            </div>
                          </c:if>
                        </div>
                        <div class="modal-footer">
                          <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal"
                          >
                            Close
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- Manage Assessments Tab -->
        <div class="tab-pane fade" id="manage" role="tabpanel">
          <div class="row mb-3">
            <div class="col-12">
              <div class="stats-card">
                <h6 class="text-muted mb-2">Total Assessment Types</h6>
                <div class="stats-number">${assessmentTypes.size()}</div>
              </div>
            </div>
          </div>

          <div class="row">
            <c:choose>
              <c:when test="${empty assessmentTypes}">
                <div class="col-12">
                  <div class="text-center py-5">
                    <i class="fas fa-clipboard-list fa-4x text-muted mb-3"></i>
                    <h5 class="text-muted">No assessment types found</h5>
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <c:forEach items="${assessmentTypes}" var="type">
                  <div class="col-md-6">
                    <div class="assessment-card">
                      <div
                        class="d-flex justify-content-between align-items-start mb-3"
                      >
                        <div>
                          <h5 class="mb-1">${type.name}</h5>
                          <p class="text-muted mb-0">${type.description}</p>
                        </div>
                        <span
                          class="badge ${type.active ? 'bg-success' : 'bg-secondary'}"
                        >
                          ${type.active ? 'Active' : 'Inactive'}
                        </span>
                      </div>

                      <div class="row mb-3">
                        <div class="col-md-6">
                          <small class="text-muted"
                            ><i class="fas fa-question-circle me-1"></i>Total
                            Questions:</small
                          >
                          <strong class="ms-2">${type.totalQuestions}</strong>
                        </div>
                        <div class="col-md-6">
                          <small class="text-muted"
                            ><i class="fas fa-calculator me-1"></i
                            >Scoring:</small
                          >
                          <strong class="ms-2">${type.scoringMethod}</strong>
                        </div>
                      </div>

                      <button
                        type="button"
                        class="btn btn-primary btn-sm"
                        onclick="window.location.href='${pageContext.request.contextPath}/counselor/assessment/${type.assessmentTypeId}/questions'"
                      >
                        <i class="fas fa-list me-1"></i>Manage Questions
                        (${type.totalQuestions})
                      </button>
                      <form
                        action="${pageContext.request.contextPath}/counselor/assessment/type/${type.assessmentTypeId}/toggle"
                        method="post"
                        style="display: inline"
                      >
                        <button
                          type="submit"
                          class="btn btn-sm ${type.active ? 'btn-outline-warning' : 'btn-outline-success'}"
                        >
                          <i
                            class="fas ${type.active ? 'fa-eye-slash' : 'fa-eye'} me-1"
                          ></i>
                          ${type.active ? 'Deactivate' : 'Activate'}
                        </button>
                      </form>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>

    <!-- Create Assessment Type Modal -->
    <div class="modal fade" id="createTypeModal" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">
              <i class="fas fa-plus-circle me-2"></i>Create New Assessment Type
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
            ></button>
          </div>
          <form
            action="${pageContext.request.contextPath}/counselor/assessment/type/create"
            method="post"
          >
            <div class="modal-body">
              <div class="mb-3">
                <label class="form-label"
                  >Assessment Name <span class="text-danger">*</span></label
                >
                <input
                  type="text"
                  class="form-control"
                  name="name"
                  placeholder="e.g., PHQ-9, GAD-7, DASS-21"
                  required
                />
                <small class="text-muted"
                  >Choose a clear, recognizable name for this assessment</small
                >
              </div>

              <div class="mb-3">
                <label class="form-label"
                  >Description <span class="text-danger">*</span></label
                >
                <textarea
                  class="form-control"
                  name="description"
                  rows="3"
                  placeholder="Describe what this assessment measures..."
                  required
                ></textarea>
                <small class="text-muted"
                  >This will be shown to students when they select an
                  assessment</small
                >
              </div>

              <div class="mb-3">
                <label class="form-label"
                  >Scoring Method <span class="text-danger">*</span></label
                >
                <input
                  type="text"
                  class="form-control"
                  name="scoringMethod"
                  placeholder="e.g., Sum scores, Sum and multiply by 2"
                  required
                />
                <small class="text-muted"
                  >Explain how the assessment is scored</small
                >
              </div>

              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  name="isActive"
                  value="true"
                  id="isActiveCheck"
                  checked
                />
                <label class="form-check-label" for="isActiveCheck">
                  Make this assessment active (students can take it immediately)
                </label>
              </div>

              <div class="alert alert-info mt-3 mb-0">
                <i class="fas fa-info-circle me-2"></i>
                <strong>Next Steps:</strong> After creating this assessment
                type, you'll need to add questions to it before students can
                take it.
              </div>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-secondary"
                data-bs-dismiss="modal"
              >
                Cancel
              </button>
              <button type="submit" class="btn btn-success">
                <i class="fas fa-plus-circle me-1"></i>Create Assessment Type
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Filter functionality
      document.querySelectorAll(".filter-btn").forEach(function (btn) {
        btn.addEventListener("click", function () {
          // Update active button
          document.querySelectorAll(".filter-btn").forEach(function (b) {
            b.classList.remove("btn-primary");
            b.classList.add(
              "btn-outline-primary",
              "btn-outline-success",
              "btn-outline-warning",
              "btn-outline-orange",
              "btn-outline-danger",
              "btn-outline-dark"
            );
          });
          this.classList.remove(
            "btn-outline-primary",
            "btn-outline-success",
            "btn-outline-warning",
            "btn-outline-orange",
            "btn-outline-danger",
            "btn-outline-dark"
          );
          this.classList.add("btn-primary");

          // Filter results
          var filter = this.getAttribute("data-filter");
          document.querySelectorAll(".result-item").forEach(function (item) {
            if (
              filter === "all" ||
              item.getAttribute("data-severity") === filter
            ) {
              item.style.display = "block";
            } else {
              item.style.display = "none";
            }
          });
        });
      });

      // Auto-dismiss alerts
      setTimeout(function () {
        document.querySelectorAll(".alert").forEach(function (alert) {
          alert.style.transition = "opacity 0.5s";
          alert.style.opacity = "0";
          setTimeout(function () {
            alert.remove();
          }, 500);
        });
      }, 5000);
    </script>
  </body>
</html>
