<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${thread.title}"/> - SerenityHub Forum</title>
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
        }
        .thread-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .thread-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        .thread-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 24px;
        }
        .thread-content {
            font-size: 16px;
            line-height: 1.8;
            color: #2d3748;
            margin: 20px 0;
            white-space: pre-wrap;
        }
        .thread-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }
        .action-btn {
            background: none;
            border: 1px solid #e2e8f0;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s;
            color: #4a5568;
        }
        .action-btn:hover {
            background: #f7fafc;
            border-color: #667eea;
            color: #667eea;
        }
        .action-btn.liked {
            background: #fee;
            border-color: #fc8181;
            color: #c53030;
        }
        .action-btn i {
            margin-right: 5px;
        }
        .reply-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 3px solid #667eea;
        }
        .reply-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }
        .reply-form {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .badge-anonymous {
            background: #fef3c7;
            color: #92400e;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
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
        .btn-edit, .btn-delete {
            padding: 5px 15px;
            font-size: 13px;
            border-radius: 6px;
        }
        .edit-form {
            display: none;
            margin-top: 15px;
        }
        .reply-content-text {
            white-space: pre-wrap;
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
            <a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard">
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/forum">
                <i class="fas fa-comments"></i> Forum
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/mood/checkin">
                <i class="fas fa-smile"></i> Mood Tracker
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/chatbot">
                <i class="fas fa-robot"></i> Chatbot
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
                <a href="${pageContext.request.contextPath}/student/forum" class="text-decoration-none text-dark">
                    <i class="fas fa-arrow-left me-2"></i>Back to Forum
                </a>
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

        <!-- Thread -->
        <div class="thread-container">
            <div class="thread-header">
                <div class="d-flex">
                    <div class="thread-avatar">
                        <c:choose>
                            <c:when test="${thread.is_anonymous}">
                                <i class="fas fa-user-secret"></i>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${fn:substring(thread.author_name, 0, 1)}" />
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="ms-3 flex-grow-1">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <h3 class="mb-2"><c:out value="${thread.title}"/></h3>
                                <div class="d-flex align-items-center gap-2">
                                    <small class="text-muted">
                                        Posted by 
                                        <c:choose>
                                            <c:when test="${thread.is_anonymous}">
                                                <strong>Anonymous</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <strong><c:out value="${thread.author_name}"/></strong>
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                    <c:if test="${thread.is_anonymous}">
                                        <span class="badge-anonymous">
                                            <i class="fas fa-user-secret me-1"></i>Anonymous
                                        </span>
                                    </c:if>
                                    <small class="text-muted">•</small>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${thread.created_at}" pattern="MMM dd, yyyy 'at' hh:mm a" />
                                    </small>
                                </div>
                            </div>
                            <c:if test="${thread.student_id == currentStudentId}">
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        <i class="fas fa-ellipsis-v"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}/edit">
                                                <i class="fas fa-edit me-2"></i>Edit
                                            </a>
                                        </li>
                                        <li>
                                            <form action="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}/delete" 
                                                  method="post" style="display: inline;" 
                                                  onsubmit="return confirm('Are you sure you want to delete this thread?');">
                                                <button type="submit" class="dropdown-item text-danger">
                                                    <i class="fas fa-trash me-2"></i>Delete
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="thread-content">
                <c:out value="${thread.content}"/>
            </div>

            <div class="thread-actions">
                <c:set var="likedClass" value="${hasLiked ? 'liked' : ''}" />
                <c:set var="threadIdValue" value="${thread.thread_id}" />
                <button class="action-btn ${likedClass}" id="likeBtn" var="threadIdValue"onclick="likeThread(${threadIdValue})">
                    <i class="fas fa-heart"></i>
                    <span id="likeCount">${thread.likes_count}</span>
                </button>
                <button class="action-btn">
                    <i class="fas fa-comment"></i>
                    <span>${thread.replies_count} Replies</span>
                </button>
            </div>
        </div>

        <!-- Reply Form -->
        <div class="reply-form">
            <h5 class="mb-3"><i class="fas fa-reply me-2"></i>Post a Reply</h5>
            <form action="${pageContext.request.contextPath}/student/forum/thread/${thread.thread_id}/reply" method="post">
                <div class="mb-3">
                    <textarea class="form-control" name="content" rows="4" 
                              placeholder="Share your thoughts..." required></textarea>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="isAnonymous" id="anonymousReply">
                        <label class="form-check-label" for="anonymousReply">
                            <i class="fas fa-user-secret me-1"></i>Post Anonymously
                        </label>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane me-2"></i>Post Reply
                    </button>
                </div>
            </form>
        </div>

        <!-- Replies -->
        <div class="mb-4">
            <h5 class="mb-3">
                <i class="fas fa-comments me-2"></i>Replies (<c:out value="${fn:length(replies)}"/>)
            </h5>
            
            <c:choose>
                <c:when test="${empty replies}">
                    <div class="text-center py-5">
                        <i class="fas fa-comment-slash fa-3x text-muted mb-3"></i>
                        <p class="text-muted">No replies yet. Be the first to respond!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${replies}" var="reply">
                        <c:set var="replyIdValue" value="${reply.reply_id}" />
                        <div class="reply-card" id="reply-${replyIdValue}">
                            <div class="d-flex">
                                <div class="reply-avatar">
                                    <c:choose>
                                        <c:when test="${reply.is_anonymous}">
                                            <i class="fas fa-user-secret"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <c:out value="${fn:substring(reply.author_name, 0, 1)}" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="ms-3 flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${reply.is_anonymous}">
                                                        Anonymous
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${reply.author_name}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </strong>
                                            <c:if test="${reply.is_anonymous}">
                                                <span class="badge-anonymous ms-2">
                                                    <i class="fas fa-user-secret me-1"></i>Anonymous
                                                </span>
                                            </c:if>
                                            <br>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${reply.created_at}" pattern="MMM dd, yyyy 'at' hh:mm a" />
                                            </small>
                                        </div>
                                        <c:if test="${reply.student_id == currentStudentId}">
                                            <div class="dropdown">
                                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                    <i class="fas fa-ellipsis-v"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <a class="dropdown-item" href="javascript:void(0);" var="replyIdValue"onclick="showEditForm(${replyIdValue})">
                                                            <i class="fas fa-edit me-2"></i>Edit
                                                        </a>
                                                    </li>
                                                    <li>
                                                        <form action="${pageContext.request.contextPath}/student/forum/reply/${replyIdValue}/delete" 
                                                              method="post" style="display: inline;" 
                                                              onsubmit="return confirm('Are you sure you want to delete this reply?');">
                                                            <input type="hidden" name="threadId" value="${thread.thread_id}">
                                                            <button type="submit" class="dropdown-item text-danger">
                                                                <i class="fas fa-trash me-2"></i>Delete
                                                            </button>
                                                        </form>
                                                    </li>
                                                </ul>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <p class="mb-2 reply-content-text reply-content-${replyIdValue}"><c:out value="${reply.content}"/></p>
                                    
                                    <!-- Edit Form (Hidden) -->
                                    <div class="edit-form" id="edit-form-${replyIdValue}">
                                        <form action="${pageContext.request.contextPath}/student/forum/reply/${replyIdValue}/update" method="post">
                                            <input type="hidden" name="threadId" value="${thread.thread_id}">
                                            <div class="mb-2">
                                                <textarea class="form-control" name="content" rows="3" required><c:out value="${reply.content}"/></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-sm btn-primary me-2">Save</button>
                                            <button type="button" class="btn btn-sm btn-secondary" var="replyIdValue"onclick="hideEditForm(${replyIdValue})">Cancel</button>
                                        </form>
                                    </div>
                                    
                                    <div class="d-flex gap-3 mt-2">
                                        <button class="btn btn-sm action-btn" var="replyIdValue"onclick="likeReply(${replyIdValue})">
                                            <i class="fas fa-heart"></i>
                                            <span id="replyLikeCount-${replyIdValue}">${reply.likes_count}</span>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript">
    //<![CDATA[
        var contextPath = '${pageContext.request.contextPath}';
        
        function likeThread(threadId) {
            var url = contextPath + '/student/forum/thread/' + threadId + '/like';
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(function(response) { 
                return response.json(); 
            })
            .then(function(data) {
                if (data.success) {
                    var likeBtn = document.getElementById('likeBtn');
                    var likeCount = document.getElementById('likeCount');
                    
                    if (data.liked) {
                        likeBtn.classList.add('liked');
                        likeCount.textContent = parseInt(likeCount.textContent) + 1;
                    } else {
                        likeBtn.classList.remove('liked');
                        likeCount.textContent = parseInt(likeCount.textContent) - 1;
                    }
                }
            })
            .catch(function(error) { 
                console.error('Error:', error); 
            });
        }

        function likeReply(replyId) {
            var url = contextPath + '/student/forum/reply/' + replyId + '/like';
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(function(response) { 
                return response.json(); 
            })
            .then(function(data) {
                if (data.success) {
                    var likeCount = document.getElementById('replyLikeCount-' + replyId);
                    if (data.liked) {
                        likeCount.textContent = parseInt(likeCount.textContent) + 1;
                    } else {
                        likeCount.textContent = parseInt(likeCount.textContent) - 1;
                    }
                }
            })
            .catch(function(error) { 
                console.error('Error:', error); 
            });
        }

        function showEditForm(replyId) {
            var contentElement = document.querySelector('.reply-content-' + replyId);
            var editFormElement = document.getElementById('edit-form-' + replyId);
            contentElement.style.display = 'none';
            editFormElement.style.display = 'block';
        }

        function hideEditForm(replyId) {
            var contentElement = document.querySelector('.reply-content-' + replyId);
            var editFormElement = document.getElementById('edit-form-' + replyId);
            contentElement.style.display = 'block';
            editFormElement.style.display = 'none';
        }
    //]]>
    </script>
</body>
</html>