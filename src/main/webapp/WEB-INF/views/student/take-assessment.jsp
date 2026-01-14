<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${assessmentType.name} - SerenityHub</title>
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

                .instructions-card {
                    background: white;
                    border-radius: 15px;
                    padding: 25px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    margin-bottom: 20px;
                    border-left: 4px solid #667eea;
                }

                .info-box {
                    background: #fef3c7;
                    border: 1px solid #fbbf24;
                    border-radius: 10px;
                    padding: 15px;
                    margin-top: 15px;
                }

                .progress-card {
                    background: white;
                    border-radius: 15px;
                    padding: 20px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    margin-bottom: 20px;
                }

                .progress {
                    height: 12px;
                    border-radius: 10px;
                    background: #e5e7eb;
                }

                .progress-bar {
                    background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
                    border-radius: 10px;
                    transition: width 0.5s ease;
                }

                .question-card {
                    background: white;
                    border-radius: 15px;
                    padding: 25px;
                    margin-bottom: 20px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    transition: all 0.3s;
                    border-left: 4px solid #e5e7eb;
                }

                .question-card.answered {
                    border-left-color: #10b981;
                    background: #f0fdf4;
                }

                .question-number {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                    font-size: 16px;
                    flex-shrink: 0;
                }

                .question-text {
                    font-size: 16px;
                    font-weight: 500;
                    color: #1f2937;
                    margin-bottom: 15px;
                }

                .category-badge {
                    padding: 4px 12px;
                    border-radius: 15px;
                    font-size: 11px;
                    font-weight: 600;
                    display: inline-block;
                }

                .badge-depression {
                    background: #dbeafe;
                    color: #1e40af;
                }

                .badge-anxiety {
                    background: #fef3c7;
                    color: #92400e;
                }

                .badge-stress {
                    background: #fee2e2;
                    color: #991b1b;
                }

                .option-container {
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                }

                .option-label {
                    background: #f9fafb;
                    border: 2px solid #e5e7eb;
                    border-radius: 10px;
                    padding: 12px 15px;
                    cursor: pointer;
                    transition: all 0.3s;
                    display: flex;
                    align-items: center;
                }

                .option-label:hover {
                    background: #f3f4f6;
                    border-color: #667eea;
                }

                .option-label input[type="radio"] {
                    margin-right: 12px;
                    width: 18px;
                    height: 18px;
                    cursor: pointer;
                }

                .option-label:has(input:checked) {
                    background: #ede9fe;
                    border-color: #667eea;
                    box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
                }

                .option-label input[type="radio"]:checked+span {
                    color: #667eea;
                    font-weight: 600;
                }

                .submit-card {
                    background: white;
                    border-radius: 15px;
                    padding: 25px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                    margin-top: 30px;
                    text-align: center;
                }

                .btn-submit {
                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                    border: none;
                    color: white;
                    padding: 12px 35px;
                    border-radius: 8px;
                    font-weight: 600;
                    font-size: 16px;
                    transition: all 0.3s;
                }

                .btn-submit:hover:not(:disabled) {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3);
                    color: white;
                }

                .btn-submit:disabled {
                    background: #9ca3af;
                    cursor: not-allowed;
                    transform: none;
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
                    <a class="nav-link " href="${pageContext.request.contextPath}/student/dashboard">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/student/learning">
                        <i class="fas fa-book"></i> Learning
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/student/assessments">
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
                        <button onclick="confirmExit()" class="btn btn-outline-secondary btn-sm me-3">
                            <i class="fas fa-arrow-left me-1"></i>Exit Assessment
                        </button>
                        <h4 class="mb-0">
                            <i class="fas fa-clipboard-list me-2"></i>${assessmentType.name}
                        </h4>
                    </div>
                </nav>

                <!-- Instructions Card -->
                <div class="instructions-card">
                    <h5 class="mb-3">
                        <i class="fas fa-info-circle text-primary me-2"></i>Instructions
                    </h5>
                    <p class="mb-2">
                        Please read each statement and select the response that best describes how you have been feeling
                        over the <strong>past week</strong>. There are no right or wrong answers. Be honest with
                        yourself.
                    </p>
                    <div class="info-box">
                        <strong><i class="fas fa-star me-2"></i>Rating Scale:</strong>
                        <ul class="mb-0 mt-2 small">
                            <li><strong>0</strong> = Did not apply to me at all</li>
                            <li><strong>1</strong> = Applied to me to some degree, or some of the time</li>
                            <li><strong>2</strong> = Applied to me to a considerable degree, or a good part of time</li>
                            <li><strong>3</strong> = Applied to me very much, or most of the time</li>
                        </ul>
                    </div>
                </div>

                <!-- Progress Card -->
                <div class="progress-card">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="fw-bold"><i class="fas fa-tasks me-2"></i>Progress</span>
                        <span id="progressText">0 of ${questions.size()} questions answered</span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" id="progressBar" role="progressbar" style="width: 0%"></div>
                    </div>
                </div>

                <!-- Assessment Form -->
                <form
                    action="${pageContext.request.contextPath}/student/assessment/${assessmentType.assessmentTypeId}/submit"
                    method="post" id="assessmentForm">

                    <c:forEach items="${questions}" var="question" varStatus="status">
                        <div class="question-card" data-question-id="${question.assessmentQuestionId}">
                            <div class="d-flex align-items-start mb-3">
                                <div class="question-number me-3">${status.index + 1}</div>
                                <div class="flex-grow-1">
                                    <div class="question-text">${question.questionText}</div>
                                    <span class="category-badge badge-${question.category.toLowerCase()}">
                                        ${question.category}
                                    </span>
                                </div>
                            </div>

                            <div class="option-container">
                                <label class="option-label">
                                    <input type="radio" name="q_${question.assessmentQuestionId}" value="0"
                                        onchange="updateProgress()" required>
                                    <span>0 - Did not apply to me at all</span>
                                </label>
                                <label class="option-label">
                                    <input type="radio" name="q_${question.assessmentQuestionId}" value="1"
                                        onchange="updateProgress()">
                                    <span>1 - Applied to some degree or sometimes</span>
                                </label>
                                <label class="option-label">
                                    <input type="radio" name="q_${question.assessmentQuestionId}" value="2"
                                        onchange="updateProgress()">
                                    <span>2 - Applied to considerable degree or often</span>
                                </label>
                                <label class="option-label">
                                    <input type="radio" name="q_${question.assessmentQuestionId}" value="3"
                                        onchange="updateProgress()">
                                    <span>3 - Applied very much or most of the time</span>
                                </label>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Submit Card -->
                    <div class="submit-card">
                        <h5 class="mb-3">Ready to Submit?</h5>
                        <p class="text-muted mb-3">
                            Please review your answers before submitting. Once submitted, you cannot change your
                            responses.
                        </p>
                        <button type="submit" class="btn btn-submit" id="submitBtn" disabled>
                            <i class="fas fa-hourglass-half me-2"></i>
                            Answer All Questions First
                        </button>
                        <p class="text-muted mt-3 mb-0 small">
                            <i class="fas fa-lock me-1"></i>
                            Your responses are confidential and secure
                        </p>
                    </div>
                </form>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                var totalQuestions = document.querySelectorAll('.question-card').length;

                function updateProgress() {
                    var form = document.getElementById('assessmentForm');
                    var radioGroups = {};

                    form.querySelectorAll('input[type="radio"]').forEach(function (radio) {
                        radioGroups[radio.name] = true;
                    });

                    var answeredCount = 0;
                    Object.keys(radioGroups).forEach(function (groupName) {
                        if (form.querySelector('input[name="' + groupName + '"]:checked')) {
                            answeredCount++;
                            var questionCard = form.querySelector('input[name="' + groupName + '"]').closest('.question-card');
                            if (questionCard) {
                                questionCard.classList.add('answered');
                            }
                        }
                    });

                    var percentage = (answeredCount / totalQuestions) * 100;
                    document.getElementById('progressBar').style.width = percentage + '%';
                    document.getElementById('progressText').textContent =
                        answeredCount + ' of ' + totalQuestions + ' questions answered';

                    var submitBtn = document.getElementById('submitBtn');
                    if (answeredCount === totalQuestions) {
                        submitBtn.disabled = false;
                        submitBtn.innerHTML = '<i class="fas fa-check-circle me-2"></i>Complete Assessment';
                    } else {
                        submitBtn.disabled = true;
                        submitBtn.innerHTML = '<i class="fas fa-hourglass-half me-2"></i>Answer All Questions (' + (totalQuestions - answeredCount) + ' remaining)';
                    }
                }

                function confirmExit() {
                    var form = document.getElementById('assessmentForm');
                    var radioGroups = {};
                    form.querySelectorAll('input[type="radio"]').forEach(function (radio) {
                        radioGroups[radio.name] = true;
                    });

                    var answeredCount = 0;
                    Object.keys(radioGroups).forEach(function (groupName) {
                        if (form.querySelector('input[name="' + groupName + '"]:checked')) {
                            answeredCount++;
                        }
                    });

                    if (answeredCount > 0) {
                        if (confirm('Are you sure you want to exit? Your progress will not be saved.')) {
                            window.location.href = '${pageContext.request.contextPath}/student/assessments';
                        }
                    } else {
                        window.location.href = '${pageContext.request.contextPath}/student/assessments';
                    }
                }

                window.addEventListener('beforeunload', function (e) {
                    var form = document.getElementById('assessmentForm');
                    var radioGroups = {};
                    form.querySelectorAll('input[type="radio"]').forEach(function (radio) {
                        radioGroups[radio.name] = true;
                    });

                    var answeredCount = 0;
                    Object.keys(radioGroups).forEach(function (groupName) {
                        if (form.querySelector('input[name="' + groupName + '"]:checked')) {
                            answeredCount++;
                        }
                    });

                    if (answeredCount > 0 && answeredCount < totalQuestions) {
                        e.preventDefault();
                        e.returnValue = '';
                    }
                });

                document.querySelectorAll('input[type="radio"]').forEach(function (radio) {
                    radio.addEventListener('change', function () {
                        var currentCard = this.closest('.question-card');
                        var nextCard = currentCard.nextElementSibling;

                        if (nextCard && nextCard.classList.contains('question-card')) {
                            setTimeout(function () {
                                nextCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                            }, 300);
                        }
                    });
                });

                updateProgress();
            </script>
        </body>

        </html>