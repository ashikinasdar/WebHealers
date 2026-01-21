<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Questions - ${assessmentType.name}</title>
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

                .question-card {
                    background: white;
                    border-radius: 15px;
                    padding: 20px;
                    margin-bottom: 15px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    transition: all 0.3s;
                }

                .question-card:hover {
                    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                    transform: translateY(-2px);
                }

                .category-badge {
                    padding: 4px 12px;
                    border-radius: 15px;
                    font-size: 11px;
                    font-weight: 600;
                }

                .category-depression {
                    background: #dbeafe;
                    color: #1e40af;
                }

                .category-anxiety {
                    background: #fef3c7;
                    color: #92400e;
                }

                .category-stress {
                    background: #fee2e2;
                    color: #991b1b;
                }

                .order-badge {
                    background: #e0e7ff;
                    color: #3730a3;
                    padding: 4px 10px;
                    border-radius: 10px;
                    font-size: 12px;
                    font-weight: 600;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/counselor/assessments">
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
                        <div>
                            <a href="${pageContext.request.contextPath}/counselor/assessments"
                                class="btn btn-sm btn-outline-secondary me-3">
                                <i class="fas fa-arrow-left me-1"></i>Back
                            </a>
                            <h4 class="d-inline mb-0">
                                <i class="fas fa-list me-2"></i>${assessmentType.name} - Questions
                            </h4>
                        </div>
                        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal"
                            data-bs-target="#addQuestionModal">
                            <i class="fas fa-plus me-1"></i>Add Question
                        </button>
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

                <!-- Questions List -->
                <div class="row">
                    <c:choose>
                        <c:when test="${empty questions}">
                            <div class="col-12">
                                <div class="text-center py-5">
                                    <i class="fas fa-question-circle fa-4x text-muted mb-3"></i>
                                    <h5 class="text-muted">No questions found</h5>
                                    <p class="text-muted">Click "Add Question" to create your first question</p>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${questions}" var="question">
                                <div class="col-12">
                                    <div class="question-card">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div class="flex-grow-1">
                                                <div class="mb-2">
                                                    <span class="order-badge me-2">#${question.displayOrder}</span>
                                                    <span
                                                        class="category-badge category-${question.category.toLowerCase()}">
                                                        ${question.category}
                                                    </span>
                                                </div>
                                                <p class="mb-0">${question.questionText}</p>
                                            </div>
                                            <div class="btn-group ms-3">
                                                <button type="button" class="btn btn-sm btn-outline-primary"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editModal${question.assessmentQuestionId}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                    
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        onclick="confirmDelete(${question.assessmentQuestionId})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Edit Modal -->
                                <div class="modal fade" id="editModal${question.assessmentQuestionId}" tabindex="-1">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit Question</h5>
                                                <button type="button" class="btn-close"
                                                    data-bs-dismiss="modal"></button>
                                            </div>
                                            <form
                                                action="${pageContext.request.contextPath}/counselor/assessment/question/${question.assessmentQuestionId}/edit"
                                                method="post">
                                                <input type="hidden" name="assessmentTypeId"
                                                    value="${assessmentType.assessmentTypeId}">
                                                <div class="modal-body">
                                                    <div class="mb-3">
                                                        <label class="form-label">Question Text</label>
                                                        <textarea class="form-control" name="questionText" rows="3"
                                                            required>${question.questionText}</textarea>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Category</label>
                                                        <select class="form-select" name="category" required>
                                                            <option value="DEPRESSION" ${question.category=='DEPRESSION'
                                                                ? 'selected' : '' }>Depression</option>
                                                            <option value="ANXIETY" ${question.category=='ANXIETY'
                                                                ? 'selected' : '' }>Anxiety</option>
                                                            <option value="STRESS" ${question.category=='STRESS'
                                                                ? 'selected' : '' }>Stress</option>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Display Order</label>
                                                        <input type="number" class="form-control" name="displayOrder"
                                                            value="${question.displayOrder}" min="1" required>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                        data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fas fa-save me-1"></i>Save Changes
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden Delete Form -->
                                <form id="deleteForm${question.assessmentQuestionId}"
                                    action="${pageContext.request.contextPath}/counselor/assessment/question/${question.assessmentQuestionId}/delete"
                                    method="post" style="display: none;">
                                    <input type="hidden" name="assessmentTypeId"
                                        value="${assessmentType.assessmentTypeId}">
                                </form>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Add Question Modal -->
            <div class="modal fade" id="addQuestionModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Question</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/counselor/assessment/question/create"
                            method="post">
                            <input type="hidden" name="assessmentTypeId" value="${assessmentType.assessmentTypeId}">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Question Text</label>
                                    <textarea class="form-control" name="questionText" rows="3"
                                        placeholder="Enter the question text..." required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Category</label>
                                    <select class="form-select" name="category" required>
                                        <option value="">Select Category</option>
                                        <option value="DEPRESSION">Depression</option>
                                        <option value="ANXIETY">Anxiety</option>
                                        <option value="STRESS">Stress</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Display Order</label>
                                    <input type="number" class="form-control" name="displayOrder" placeholder="1"
                                        min="1" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-plus me-1"></i>Add Question
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function confirmDelete(questionId) {
                    if (confirm('Are you sure you want to delete this question? This action cannot be undone.')) {
                        document.getElementById('deleteForm' + questionId).submit();
                    }
                }

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