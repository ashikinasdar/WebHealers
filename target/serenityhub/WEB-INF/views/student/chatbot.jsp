<<<<<<< HEAD
<html>
<body>
<h2>Hello World!</h2>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Chatbot - SerenityHub</title>
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
        .navbar {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            border-radius: 10px;
        }
        .chat-container {
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 20px;
            height: calc(100vh - 180px);
        }
        .chat-window {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        .chat-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 15px 15px 0 0;
        }
        .chat-header-content {
            display: flex;
            align-items: center;
        }
        .chat-avatar {
            width: 50px;
            height: 50px;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: 15px;
        }
        .chat-status {
            display: flex;
            align-items: center;
            font-size: 14px;
            margin-top: 5px;
        }
        .status-indicator {
            width: 8px;
            height: 8px;
            background: #10b981;
            border-radius: 50%;
            margin-right: 8px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        .chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            background: #f9fafb;
        }
        .message {
            margin-bottom: 15px;
            padding: 12px 16px;
            border-radius: 15px;
            max-width: 70%;
            position: relative;
            animation: slideIn 0.3s ease;
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .message-bot {
            background: white;
            border: 1px solid #e5e7eb;
            margin-right: auto;
        }
        .message-user {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            margin-left: auto;
        }
        .message-time {
            font-size: 11px;
            opacity: 0.7;
            margin-top: 5px;
        }
        .typing-indicator {
            display: flex;
            gap: 5px;
            padding: 12px 16px;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 15px;
            width: fit-content;
            margin-bottom: 15px;
        }
        .typing-dot {
            width: 8px;
            height: 8px;
            background: #667eea;
            border-radius: 50%;
            animation: typing 1.4s infinite;
        }
        .typing-dot:nth-child(2) { animation-delay: 0.2s; }
        .typing-dot:nth-child(3) { animation-delay: 0.4s; }
        @keyframes typing {
            0%, 60%, 100% { transform: translateY(0); }
            30% { transform: translateY(-10px); }
        }
        .chat-input-area {
            border-top: 1px solid #e5e7eb;
            padding: 15px 20px;
            background: white;
        }
        .chat-input-wrapper {
            display: flex;
            gap: 10px;
            align-items: flex-end;
        }
        .chat-input {
            flex: 1;
            border: 2px solid #e5e7eb;
            border-radius: 25px;
            padding: 12px 20px;
            resize: none;
            max-height: 120px;
            font-family: inherit;
        }
        .chat-input:focus {
            outline: none;
            border-color: #667eea;
        }
        .chat-send-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        .chat-send-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .quick-responses {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-top: 10px;
        }
        .quick-response-btn {
            background: #f3f4f6;
            border: 1px solid #e5e7eb;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .quick-response-btn:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        .chat-sidebar {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .sidebar-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .sidebar-card h4 {
            font-size: 16px;
            margin-bottom: 15px;
            color: #1f2937;
        }
        .sidebar-card h4 i {
            margin-right: 8px;
            color: #667eea;
        }
        .help-topic {
            display: flex;
            align-items: center;
            padding: 12px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 10px;
        }
        .help-topic:hover {
            background: #f3f4f6;
        }
        .topic-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
        }
        .topic-info h5 {
            font-size: 14px;
            margin: 0;
            color: #1f2937;
        }
        .topic-info p {
            font-size: 12px;
            color: #6b7280;
            margin: 0;
        }
        .resource-item, .emergency-contact {
            display: flex;
            align-items: center;
            padding: 12px;
            border-radius: 10px;
            background: #f9fafb;
            margin-bottom: 10px;
        }
        .resource-icon, .contact-icon {
            width: 35px;
            height: 35px;
            background: #667eea;
            color: white;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
        }
        .resource-text, .contact-info {
            flex: 1;
        }
        .resource-text strong, .contact-info strong {
            display: block;
            font-size: 13px;
            color: #1f2937;
        }
        .resource-text span, .contact-info span {
            font-size: 12px;
            color: #6b7280;
        }
        .emergency-resources {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e5e7eb;
        }
        .emergency-resources h5 {
            font-size: 14px;
            color: #dc2626;
            margin-bottom: 12px;
        }
        .emergency-resources h5 i {
            margin-right: 8px;
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
                <i class="fas fa-calendar"></i> Appointments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
                <i class="fas fa-comments"></i> Forum
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/chatbot">
                <i class="fas fa-robot"></i> AI Chatbot
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
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
                <h4 class="mb-0">
                    <i class="fas fa-robot me-2"></i>Mental Health AI Assistant
                </h4>
                <span class="text-muted">Get instant support and guidance</span>
            </div>
        </nav>

        <!-- Chat Container -->
        <div class="chat-container">
            <!-- Chat Window -->
            <div class="chat-window">
                <div class="chat-header">
                    <div class="chat-header-content">
                        <div class="chat-avatar">
                            <i class="fas fa-robot"></i>
                        </div>
                        <div>
                            <h5 class="mb-0">Serenity AI Assistant</h5>
                            <div class="chat-status">
                                <span class="status-indicator"></span>
                                <span>Online • Ready to help</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="chat-messages" id="chatMessages">
                    <div class="message message-bot">
                        Hello! I'm Serenity AI, your mental health companion. I'm here to support your wellbeing. How are you feeling today?
                        <div class="message-time">Just now</div>
                    </div>
                </div>

                <div class="chat-input-area">
                    <div class="chat-input-wrapper">
                        <textarea class="chat-input" id="userInput"
                                  placeholder="Type your message here..."
                                  rows="1"></textarea>
                        <button class="chat-send-btn" id="sendButton" onclick="sendMessage()">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </div>

                    <div class="quick-responses">
                        <span class="quick-response-btn" onclick="quickResponse('I feel anxious today')">
                            I feel anxious
                        </span>
                        <span class="quick-response-btn" onclick="quickResponse('Feeling depressed')">
                            Feeling down
                        </span>
                        <span class="quick-response-btn" onclick="quickResponse('Need coping strategies')">
                            Coping strategies
                        </span>
                        <span class="quick-response-btn" onclick="quickResponse('Stress management tips')">
                            Stress help
                        </span>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="chat-sidebar">
                <div class="sidebar-card">
                    <h4><i class="fas fa-lightbulb"></i> Quick Help Topics</h4>
                    <div class="help-topics">
                        <div class="help-topic" onclick="quickResponse('How to manage anxiety attacks?')">
                            <div class="topic-icon">
                                <i class="fas fa-wind"></i>
                            </div>
                            <div class="topic-info">
                                <h5>Anxiety Management</h5>
                                <p>Learn coping techniques</p>
                            </div>
                        </div>
                        <div class="help-topic" onclick="quickResponse('Tips for better sleep?')">
                            <div class="topic-icon">
                                <i class="fas fa-moon"></i>
                            </div>
                            <div class="topic-info">
                                <h5>Sleep Better</h5>
                                <p>Improve sleep quality</p>
                            </div>
                        </div>
                        <div class="help-topic" onclick="quickResponse('Mindfulness exercises?')">
                            <div class="topic-icon">
                                <i class="fas fa-spa"></i>
                            </div>
                            <div class="topic-info">
                                <h5>Mindfulness</h5>
                                <p>Stay present and calm</p>
                            </div>
                        </div>
                        <div class="help-topic" onclick="quickResponse('Professional help options?')">
                            <div class="topic-icon">
                                <i class="fas fa-hand-holding-heart"></i>
                            </div>
                            <div class="topic-info">
                                <h5>Find Help</h5>
                                <p>Connect with professionals</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="sidebar-card">
                    <h4><i class="fas fa-book-medical"></i> Resources</h4>
                    <div class="resources-list">
                        <div class="resource-item">
                            <div class="resource-icon">
                                <i class="fas fa-phone-alt"></i>
                            </div>
                            <div class="resource-text">
                                <strong>Crisis Text Line</strong>
                                <span>Text HOME to 741741</span>
                            </div>
                        </div>
                        <div class="resource-item">
                            <div class="resource-icon">
                                <i class="fas fa-headset"></i>
                            </div>
                            <div class="resource-text">
                                <strong>Befrienders Malaysia</strong>
                                <span>Call 03-7956 8145</span>
                            </div>
                        </div>
                        <div class="resource-item">
                            <div class="resource-icon">
                                <i class="fas fa-file-alt"></i>
                            </div>
                            <div class="resource-text">
                                <strong>Self-Help Guides</strong>
                                <span>Downloadable resources</span>
                            </div>
                        </div>
                    </div>

                    <div class="emergency-resources">
                        <h5><i class="fas fa-exclamation-triangle"></i> Emergency Contacts</h5>
                        <div class="emergency-contact">
                            <div class="contact-icon">
                                <i class="fas fa-phone"></i>
                            </div>
                            <div class="contact-info">
                                <strong>UTM Counselling</strong>
                                <span>07-553 1234</span>
                            </div>
                        </div>
                        <div class="emergency-contact">
                            <div class="contact-icon">
                                <i class="fas fa-ambulance"></i>
                            </div>
                            <div class="contact-info">
                                <strong>Emergency Services</strong>
                                <span>999 / 112</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function sendMessage() {
            const input = document.getElementById('userInput');
            const message = input.value.trim();
            if (!message) return;

            addMessage('user', message);
            input.value = '';
            input.style.height = 'auto';

            showTyping();

            setTimeout(() => {
                removeTyping();
                const response = getBotResponse(message);
                addMessage('bot', response);
            }, 1000 + Math.random() * 1000);
        }

        function quickResponse(text) {
            document.getElementById('userInput').value = text;
            sendMessage();
        }

        function addMessage(type, text) {
            const chat = document.getElementById('chatMessages');
            const messageDiv = document.createElement('div');
            messageDiv.className = `message message-${type}`;
            messageDiv.innerHTML = `
                ${text}
                <div class="message-time">${new Date().toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'})}</div>
            `;
            chat.appendChild(messageDiv);
            chat.scrollTop = chat.scrollHeight;
        }

        function showTyping() {
            const chat = document.getElementById('chatMessages');
            const typingDiv = document.createElement('div');
            typingDiv.className = 'typing-indicator';
            typingDiv.id = 'typingIndicator';
            typingDiv.innerHTML = `
                <div class="typing-dot"></div>
                <div class="typing-dot"></div>
                <div class="typing-dot"></div>
            `;
            chat.appendChild(typingDiv);
            chat.scrollTop = chat.scrollHeight;
        }

        function removeTyping() {
            const typing = document.getElementById('typingIndicator');
            if (typing) typing.remove();
        }

        function getBotResponse(userMessage) {
            userMessage = userMessage.toLowerCase();

            if (userMessage.includes('anxious') || userMessage.includes('anxiety')) {
                return "I understand anxiety can be overwhelming. Try the 4-7-8 breathing technique: Inhale for 4 seconds, hold for 7, exhale for 8. This activates your parasympathetic nervous system and helps calm you down. Would you like more anxiety management tips?";
            } else if (userMessage.includes('depress') || userMessage.includes('sad') || userMessage.includes('down')) {
                return "I'm sorry you're feeling this way. Remember, it's okay to not be okay. Depression is treatable, and seeking help is a sign of strength. Have you considered talking to a counselor? UTM offers free counseling services at 07-553 1234.";
            } else if (userMessage.includes('stress')) {
                return "Stress affects many students. Here are some quick tips: 1) Break tasks into smaller steps, 2) Take regular 5-minute breaks, 3) Try physical activity - even a short walk helps, 4) Practice deep breathing. Would you like to learn more stress management techniques?";
            } else if (userMessage.includes('sleep')) {
                return "For better sleep hygiene: 1) Establish a consistent sleep schedule, 2) Avoid screens 1 hour before bed, 3) Create a calm, dark environment, 4) Try chamomile tea or reading. Sleep is crucial for mental health!";
            } else if (userMessage.includes('mindfulness') || userMessage.includes('meditation')) {
                return "Mindfulness is powerful! Try this 5-minute exercise: Focus on your breathing, notice 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, 1 you can taste. This grounds you in the present moment.";
            } else if (userMessage.includes('help') || userMessage.includes('support') || userMessage.includes('professional')) {
                return "Here are resources available to you:<br><br>📞 UTM Counselling: 07-553 1234<br>📱 Befrienders Malaysia: 03-7956 8145<br>💬 Crisis Text Line: Text HOME to 741741<br>🚨 Emergency: 999<br><br>You can also book an appointment through our system!";
            } else if (userMessage.includes('hello') || userMessage.includes('hi') || userMessage.includes('hey')) {
                return "Hello! I'm Serenity AI, here to support your mental wellbeing. You can talk to me about anxiety, depression, stress, sleep issues, coping strategies, or just how you're feeling today. How can I help you?";
            } else if (userMessage.includes('thank')) {
                return "You're very welcome! Remember, taking care of your mental health is important. I'm here whenever you need support. Is there anything else I can help you with?";
            } else if (userMessage.includes('suicide') || userMessage.includes('kill myself') || userMessage.includes('end it')) {
                return "I'm very concerned about what you're sharing. Please reach out for immediate help:<br><br>🚨 Emergency: 999<br>📞 Befrienders: 03-7956 8145 (24/7)<br>📞 UTM Counselling: 07-553 1234<br><br>Your life matters. Please talk to someone right now. Would you like me to guide you on how to contact these services?";
            } else {
                return "I'm here to support your mental wellbeing. You can ask me about:<br>• Anxiety & stress management<br>• Depression & low mood<br>• Sleep problems<br>• Coping strategies<br>• Mindfulness techniques<br>• Getting professional help<br><br>How can I help you today?";
            }
        }

        // Auto-resize textarea
        document.getElementById('userInput').addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });

        // Enter key to send
        document.getElementById('userInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        });
    </script>
>>>>>>> 9dc905e85bd64f8ecef71dcf6ef32caa78e596a7
</body>
</html>