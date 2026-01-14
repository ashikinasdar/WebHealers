<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Chatbot - SerenityHub</title>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

            <style>
                body {
                    background: #f5f7fa;
                }

                .sidebar {
                    min-height: 100vh;
                    background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
                    position: fixed;
                    width: 250px;
                }

                .sidebar .nav-link {
                    color: rgba(255, 255, 255, 0.8);
                    padding: 15px 25px;
                }

                .sidebar .nav-link.active,
                .sidebar .nav-link:hover {
                    color: white;
                    background: rgba(255, 255, 255, 0.1);
                }

                .main-content {
                    margin-left: 250px;
                    padding: 20px;
                }

                .chat-window {
                    height: 550px;
                    background: white;
                    border-radius: 12px;
                    display: flex;
                    flex-direction: column;
                    border: 1px solid #e5e7eb;
                }

                .chat-messages {
                    flex: 1;
                    padding: 15px;
                    overflow-y: auto;
                    background: #f9fafb;
                }

                .message-user {
                    background: #667eea;
                    color: white;
                    padding: 10px 15px;
                    border-radius: 18px;
                    margin-bottom: 10px;
                    align-self: flex-end;
                    max-width: 70%;
                }

                .message-bot {
                    background: white;
                    border: 1px solid #e5e7eb;
                    padding: 10px 15px;
                    border-radius: 18px;
                    margin-bottom: 10px;
                    max-width: 70%;
                }

                .chat-input {
                    border-top: 1px solid #e5e7eb;
                    padding: 10px;
                    display: flex;
                    gap: 10px;
                }
            </style>
        </head>

        <body>

            <!-- Sidebar -->
            <div class="sidebar">
                <nav class="nav flex-column mt-4">
                    <a class="nav-link " href="${pageContext.request.contextPath}/student/dashboard">
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/student/chatbot">
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
                <h4><i class="fas fa-robot me-2"></i> Mental Health Chatbot</h4>
                <p class="text-muted">Talk to Serenity AI for support</p>

                <div class="chat-window mt-3">
                    <div class="chat-messages" id="chatMessages">
                        <div class="message-bot">
                            Hello! How are you feeling today?
                        </div>
                    </div>

                    <div class="chat-input">
                        <textarea id="userInput" class="form-control" rows="1"
                            placeholder="Type your message..."></textarea>
                        <button class="btn btn-primary" onclick="sendMessage()">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>

            <script>
                function sendMessage() {
                    const input = document.getElementById("userInput");
                    const text = input.value.trim();
                    if (!text) return;

                    addMessage("user", text);
                    input.value = "";

                    setTimeout(() => {
                        addMessage("bot", "I'm here to support you. Tell me more.");
                    }, 800);
                }

                function addMessage(type, text) {
                    const chat = document.getElementById("chatMessages");
                    const div = document.createElement("div");
                    div.className = type === "user" ? "message-user" : "message-bot";
                    div.textContent = text;
                    chat.appendChild(div);
                    chat.scrollTop = chat.scrollHeight;
                }
            </script>

        </body>

        </html>