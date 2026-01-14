<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Assessment Results - SerenityHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            padding-top: 40px;
            padding-bottom: 40px;
        }
        .page-header {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .result-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        .result-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        .severity-badge {
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .severity-normal { 
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }
        .severity-mild { 
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
            color: white;
        }
        .severity-moderate { 
            background: linear-gradient(135deg, #fb923c 0%, #ea580c 100%);
            color: white;
        }
        .severity-severe { 
            background: linear-gradient(135deg, #f87171 0%, #ef4444 100%);
            color: white;
        }
        .severity-extremely_severe { 
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
            color: white;
        }
        .score-circle {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            color: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .score-circle.depression {
            background: linear-gradient(135deg, #3b82f6 0%, #1e40af 100%);
        }
        .score-circle.anxiety {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        }
        .score-circle.stress {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        }
        .score-label {
            font-size: 12px;
            font-weight: 600;
            margin-top: 5px;
        }
        .back-btn {
            background: white;
            color: #667eea;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .back-btn:hover {
            background: #f0f0f0;
            transform: translateX(-5px);
        }
        .recommendations-box {
            background: #f0f9ff;
            border-left: 4px solid #0284c7;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .chart-container {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .timeline-item {
            position: relative;
            padding-left: 30px;
            margin-bottom: 20px;
        }
        .timeline-item::before {
            content: '';
            position: absolute;
            left: 8px;
            top: 30px;
            bottom: -20px;
            width: 2px;
            background: #e5e7eb;
        }
        .timeline-item:last-child::before {
            display: none;
        }
        .timeline-dot {
            position: absolute;
            left: 0;
            top: 12px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 0 0 4px white, 0 0 0 6px #e5e7eb;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .empty-icon {
            font-size: 80px;
            color: #d1d5db;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Back Button -->
        <button onclick="window.location.href='${pageContext.request.contextPath}/student/assessments'" 
                class="back-btn mb-3">
            <i class="fas fa-arrow-left me-2"></i>Back to Assessments
        </button>

        <!-- Page Header -->
        <div class="page-header">
            <h2 class="mb-2">
                <i class="fas fa-chart-line text-primary me-2"></i>
                My Assessment Results
            </h2>
            <p class="text-muted mb-0">
                Track your mental health journey over time. Review past assessments and monitor your progress.
            </p>
        </div>

        <c:choose>
            <c:when test="${empty results}">
                <!-- Empty State -->
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <h4>No Assessment Results Yet</h4>
                    <p class="text-muted">
                        You haven't completed any assessments. Take your first assessment to begin tracking your mental health.
                    </p>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/student/assessments'" 
                            class="btn btn-primary mt-3">
                        <i class="fas fa-play me-2"></i>Take an Assessment
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Results Timeline -->
                <div class="row">
                    <div class="col-md-8">
                        <h5 class="mb-4 text-white">
                            <i class="fas fa-history me-2"></i>Assessment History
                        </h5>
                        
                        <c:forEach items="${results}" var="result">
                            <div class="timeline-item">
                                <div class="timeline-dot"></div>
                                <div class="result-card">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h5 class="mb-1">${result.assessmentName}</h5>
                                            <small class="text-muted">
                                                <i class="fas fa-calendar me-1"></i>
                                                <fmt:formatDate value="${result.attemptedAt}" pattern="MMMM dd, yyyy 'at' hh:mm a" />
                                            </small>
                                        </div>
                                        <span class="severity-badge severity-${result.overallSeverity.toString().toLowerCase()}">
                                            ${result.overallSeverity.toString().replace('_', ' ')}
                                        </span>
                                    </div>

                                    <!-- Scores -->
                                    <div class="row text-center mb-4">
                                        <div class="col-4">
                                            <div class="score-circle depression mx-auto">
                                                <div>${result.depressionScore}</div>
                                            </div>
                                            <div class="score-label text-muted mt-2">Depression</div>
                                        </div>
                                        <div class="col-4">
                                            <div class="score-circle anxiety mx-auto">
                                                <div>${result.anxietyScore}</div>
                                            </div>
                                            <div class="score-label text-muted mt-2">Anxiety</div>
                                        </div>
                                        <div class="col-4">
                                            <div class="score-circle stress mx-auto">
                                                <div>${result.stressScore}</div>
                                            </div>
                                            <div class="score-label text-muted mt-2">Stress</div>
                                        </div>
                                    </div>

                                    <!-- Recommendations -->
                                    <c:if test="${not empty result.recommendations}">
                                        <div class="recommendations-box">
                                            <h6 class="mb-3">
                                                <i class="fas fa-lightbulb me-2"></i>Recommendations
                                            </h6>
                                            <pre style="white-space: pre-wrap; font-family: inherit; margin: 0;">${result.recommendations}</pre>
                                        </div>
                                    </c:if>

                                    <!-- Actions -->
                                    <div class="mt-3">
                                        <button type="button" class="btn btn-sm btn-outline-primary" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#detailModal${result.resultId}">
                                            <i class="fas fa-eye me-1"></i>View Full Details
                                        </button>
                                        <c:if test="${result.overallSeverity == 'SEVERE' || result.overallSeverity == 'EXTREMELY_SEVERE'}">
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/student/appointments/book'" 
                                                    class="btn btn-sm btn-danger">
                                                <i class="fas fa-calendar-plus me-1"></i>Book Counseling
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <!-- Detail Modal -->
                            <div class="modal fade" id="detailModal${result.resultId}" tabindex="-1">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Assessment Details</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <h6 class="mb-3">${result.assessmentName}</h6>
                                            
                                            <div class="row mb-4">
                                                <div class="col-6">
                                                    <strong>Date Completed:</strong><br>
                                                    <fmt:formatDate value="${result.attemptedAt}" pattern="MMMM dd, yyyy" />
                                                </div>
                                                <div class="col-6">
                                                    <strong>Overall Severity:</strong><br>
                                                    <span class="severity-badge severity-${result.overallSeverity.toString().toLowerCase()}">
                                                        ${result.overallSeverity.toString().replace('_', ' ')}
                                                    </span>
                                                </div>
                                            </div>

                                            <h6 class="mb-3">Score Breakdown</h6>
                                            <div class="row mb-4">
                                                <div class="col-4 text-center">
                                                    <div class="score-circle depression mx-auto mb-2">
                                                        ${result.depressionScore}
                                                    </div>
                                                    <strong>Depression</strong>
                                                    <p class="text-muted small mb-0">
                                                        <c:choose>
                                                            <c:when test="${result.depressionScore <= 9}">Normal</c:when>
                                                            <c:when test="${result.depressionScore <= 13}">Mild</c:when>
                                                            <c:when test="${result.depressionScore <= 20}">Moderate</c:when>
                                                            <c:when test="${result.depressionScore <= 27}">Severe</c:when>
                                                            <c:otherwise>Extremely Severe</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div class="col-4 text-center">
                                                    <div class="score-circle anxiety mx-auto mb-2">
                                                        ${result.anxietyScore}
                                                    </div>
                                                    <strong>Anxiety</strong>
                                                    <p class="text-muted small mb-0">
                                                        <c:choose>
                                                            <c:when test="${result.anxietyScore <= 7}">Normal</c:when>
                                                            <c:when test="${result.anxietyScore <= 9}">Mild</c:when>
                                                            <c:when test="${result.anxietyScore <= 14}">Moderate</c:when>
                                                            <c:when test="${result.anxietyScore <= 19}">Severe</c:when>
                                                            <c:otherwise>Extremely Severe</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                                <div class="col-4 text-center">
                                                    <div class="score-circle stress mx-auto mb-2">
                                                        ${result.stressScore}
                                                    </div>
                                                    <strong>Stress</strong>
                                                    <p class="text-muted small mb-0">
                                                        <c:choose>
                                                            <c:when test="${result.stressScore <= 14}">Normal</c:when>
                                                            <c:when test="${result.stressScore <= 18}">Mild</c:when>
                                                            <c:when test="${result.stressScore <= 25}">Moderate</c:when>
                                                            <c:when test="${result.stressScore <= 33}">Severe</c:when>
                                                            <c:otherwise>Extremely Severe</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>

                                            <h6 class="mb-3">Understanding Your Scores</h6>
                                            <div class="alert alert-info">
                                                <strong>DASS-21 Scoring Guide:</strong>
                                                <ul class="mb-0 mt-2">
                                                    <li><strong>Normal:</strong> Scores indicate typical emotional states</li>
                                                    <li><strong>Mild:</strong> Slightly elevated symptoms, worth monitoring</li>
                                                    <li><strong>Moderate:</strong> Notable symptoms, consider support</li>
                                                    <li><strong>Severe:</strong> Significant symptoms, professional help recommended</li>
                                                    <li><strong>Extremely Severe:</strong> Very high symptoms, urgent support needed</li>
                                                </ul>
                                            </div>

                                            <c:if test="${not empty result.recommendations}">
                                                <h6 class="mb-3">Personalized Recommendations</h6>
                                                <div class="recommendations-box">
                                                    <pre style="white-space: pre-wrap; font-family: inherit; margin: 0;">${result.recommendations}</pre>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/student/appointments/book'" 
                                                    class="btn btn-primary">
                                                <i class="fas fa-calendar-plus me-1"></i>Book Appointment
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Sidebar -->
                    <div class="col-md-4">
                        <!-- Latest Result -->
                        <div class="chart-container">
                            <h6 class="mb-3">
                                <i class="fas fa-star text-warning me-2"></i>Latest Assessment
                            </h6>
                            <c:if test="${not empty results && results.size() > 0}">
                                <c:set var="latest" value="${results[0]}" />
                                <div class="text-center mb-3">
                                    <h5>${latest.assessmentName}</h5>
                                    <span class="severity-badge severity-${latest.overallSeverity.toString().toLowerCase()}">
                                        ${latest.overallSeverity.toString().replace('_', ' ')}
                                    </span>
                                </div>
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h3 class="text-primary mb-0">${latest.depressionScore}</h3>
                                        <small class="text-muted">Depression</small>
                                    </div>
                                    <div class="col-4">
                                        <h3 class="text-warning mb-0">${latest.anxietyScore}</h3>
                                        <small class="text-muted">Anxiety</small>
                                    </div>
                                    <div class="col-4">
                                        <h3 class="text-danger mb-0">${latest.stressScore}</h3>
                                        <small class="text-muted">Stress</small>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <!-- Quick Actions -->
                        <div class="chart-container">
                            <h6 class="mb-3">
                                <i class="fas fa-tasks me-2"></i>Quick Actions
                            </h6>
                            <div class="d-grid gap-2">
                                <button onclick="window.location.href='${pageContext.request.contextPath}/student/assessments'" 
                                        class="btn btn-outline-primary">
                                    <i class="fas fa-plus-circle me-2"></i>Take New Assessment
                                </button>
                                <button onclick="window.location.href='${pageContext.request.contextPath}/student/appointments/book'" 
                                        class="btn btn-outline-success">
                                    <i class="fas fa-calendar-plus me-2"></i>Book Counseling
                                </button>
                                <button onclick="window.location.href='${pageContext.request.contextPath}/student/resources'" 
                                        class="btn btn-outline-info">
                                    <i class="fas fa-book me-2"></i>View Resources
                                </button>
                            </div>
                        </div>

                        <!-- Help Box -->
                        <div class="chart-container" style="background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);">
                            <h6 class="mb-3">
                                <i class="fas fa-question-circle me-2"></i>Need Help?
                            </h6>
                            <p class="small mb-3">
                                If you're experiencing significant distress or your scores indicate severe symptoms, 
                                please reach out for professional support.
                            </p>
                            <div class="d-grid">
                                <button onclick="window.location.href='${pageContext.request.contextPath}/student/appointments/book'" 
                                        class="btn btn-warning">
                                    <i class="fas fa-phone me-2"></i>Contact Counselor
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>