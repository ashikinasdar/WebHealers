<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chatbot - SerenityHub</title>

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

      .navbar {
        background: white;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
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

      .chat-header {
    padding: 15px;
    border-bottom: 1px solid #e5e7eb;
    background: #f8f9ff;
    gap: 12px;
}

.chat-avatar {
    width: 42px;
    height: 42px;
    background: #667eea;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}

.status-dot {
    display: inline-block;
    width: 8px;
    height: 8px;
    background: #22c55e;
    border-radius: 50%;
    margin-right: 5px;
}

.message-user {
    background: #667eea;
    color: white;
    padding: 10px 15px;
    border-radius: 18px 18px 4px 18px;
    margin-bottom: 10px;
    align-self: flex-end;
    max-width: 75%;
}

.message-bot {
    background: white;
    border: 1px solid #e5e7eb;
    padding: 10px 15px;
    border-radius: 18px 18px 18px 4px;
    margin-bottom: 10px;
    max-width: 75%;
}

.quick-responses span {
    display: inline-block;
    background: #eef2ff;
    color: #4338ca;
    padding: 6px 12px;
    border-radius: 20px;
    margin: 5px 5px 0 0;
    cursor: pointer;
    font-size: 13_packet;
}

.quick-responses span:hover {
    background: #e0e7ff;
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
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/dashboard"
        >
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/learning"
        >
          <i class="fas fa-book"></i> Learning
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/assessments"
        >
          <i class="fas fa-clipboard-check"></i> Assessments
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/appointments"
        >
          <i class="fas fa-calendar"></i> Counseling
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/forum"
        >
          <i class="fas fa-comments"></i> Forum
        </a>
        <a class="nav-link " href="${pageContext.request.contextPath}/student/feedback">
                            <i class="fas fa-comment-dots"></i> Feedback
                        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/mood/checkin"
        >
          <i class="fas fa-smile"></i> Mood Tracker
        </a>
        <a
          class="nav-link active"
          href="${pageContext.request.contextPath}/student/chatbot"
        >
          <i class="fas fa-robot"></i> Chatbot
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/student/profile"
        >
          <i class="fas fa-user"></i> Profile
        </a>
        <hr style="border-color: rgba(255, 255, 255, 0.1); margin: 20px 25px" />
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <nav class="navbar navbar-expand-lg navbar-light rounded">
        <div class="container-fluid">
          <h4><i class="fas fa-robot me-2"></i> Mental Health Chatbot</h4>
          <p class="text-muted">Talk to Serenity AI for support</p>
        </div>
      </nav>

      <div class="chat-window mt-3">
        <!-- Chat Header -->
        <div class="chat-header d-flex align-items-center">
          <div class="chat-avatar">
            <i class="fas fa-robot"></i>
          </div>
          <div>
            <h6 class="mb-0">Serenity AI Assistant</h6>
            <small class="text-success">
              <span class="status-dot"></span> Online • Ready to help
            </small>
          </div>
        </div>

        <!-- Messages -->
        <div class="chat-messages" id="chatMessages">
          <div class="message-bot">
            Hello! I'm here to support your mental wellbeing 🌱 How are you
            feeling today?
          </div>
        </div>

        <!-- Quick Responses -->
        <div class="quick-responses px-3 py-2">
          <span onclick="quickResponse('I feel anxious')"
            >😟 Feeling anxious</span
          >
          <span onclick="quickResponse('I feel stressed')">😣 Stressed</span>
          <span onclick="quickResponse('Need coping tips')"
            >🧠 Coping tips</span
          >
          <span onclick="quickResponse('Trouble sleeping')"
            >🌙 Sleep issues</span
          >
        </div>

        <!-- Input -->
        <div class="chat-input">
          <textarea
            id="userInput"
            class="form-control"
            rows="1"
            placeholder="Type your message..."
          ></textarea>
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

        showTyping();

        setTimeout(() => {
            removeTyping();
            addMessage("bot", getBotResponse(text));
        }, 1000);
    }

    function quickResponse(text) {
        document.getElementById("userInput").value = text;
        sendMessage();
    }

    function addMessage(type, text) {
        const chat = document.getElementById("chatMessages");
        const div = document.createElement("div");
        div.className = type === "user" ? "message-user" : "message-bot";
        div.textContent = text;
        chat.appendChild(div);
        chat.scrollTop = chat.scrollHeight;
    }

    function showTyping() {
        const chat = document.getElementById("chatMessages");
        const div = document.createElement("div");
        div.id = "typing";
        div.className = "message-bot";
        div.textContent = "Serenity AI is typing...";
        chat.appendChild(div);
        chat.scrollTop = chat.scrollHeight;
    }

    function removeTyping() {
        const typing = document.getElementById("typing");
        if (typing) typing.remove();
    }

    function getBotResponse(msg) {
        msg = msg.toLowerCase();
        if (msg.includes("anxious")) return "I'm sorry you're feeling anxious. Try slow breathing — inhale 4s, exhale 6s 🌬️";
        if (msg.includes("stress")) return "Stress can be heavy. Want some simple grounding techniques?";
        if (msg.includes("sleep")) return "Sleep trouble is common. Avoid screens 1 hour before bed 🌙";
        return "I'm here with you. Tell me more 💙";
    }
</script>

  </body>
</html>