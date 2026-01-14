<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SerenityHub | Mental Health Assistant</title>
    <link rel="stylesheet" href="assets/css/styles.css" />
    <link rel="stylesheet" href="assets/css/chatbot.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
                <i class="fas fa-calendar"></i> Appointments
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/forum">
                <i class="fas fa-comments"></i> Forum
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
    <main class="content">
        <div class="container">
            <div class="chatbot-wrapper">
                <div class="page-header">
                    <h3>Mental Health Assistant</h3>
                    <p>Talk to Serenity AI for instant support and guidance</p>
                </div>
               
                <div class="chatbot-layout">
                    <!-- Chat Window -->
                    <div class="chat-window">
                        <div class="chat-header">
                            <div class="chat-header-content">
                                <div class="chat-avatar">
                                    <i class="fas fa-robot"></i>
                                </div>
                                <div class="chat-info">
                                    <h3>Serenity AI Assistant</h3>
                                    <div class="chat-status">
                                        <span class="status-indicator"></span>
                                        <span>Online • Ready to help</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                       
                        <div class="chat-messages" id="chatMessages">
                            <div class="message message-bot">
                                Hello! I'm here to support your mental wellbeing. How are you feeling today?
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
                                <span class="quick-response-btn" onclick="quickResponse('I feel anxious today')">I feel anxious today</span>
                                <span class="quick-response-btn" onclick="quickResponse('Feeling depressed')">Feeling depressed</span>
                                <span class="quick-response-btn" onclick="quickResponse('Need coping strategies')">Need coping strategies</span>
                                <span class="quick-response-btn" onclick="quickResponse('Stress management tips')">Stress management tips</span>
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
                                        <p>Improve your sleep quality</p>
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
                                        <strong>National Helpline</strong>
                                        <span>Call 911 for support</span>
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
        </div>
    </main>


    <script>
        // Chatbot functionality
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
           
            // Simple rule-based responses
            if (userMessage.includes('anxious') || userMessage.includes('anxiety')) {
                return "I understand anxiety can be overwhelming. Try the 4-7-8 breathing technique: Inhale for 4 seconds, hold for 7, exhale for 8. Would you like more anxiety management tips?";
            } else if (userMessage.includes('depress') || userMessage.includes('sad')) {
                return "I'm sorry you're feeling this way. Remember, it's okay to not be okay. Have you considered talking to a counselor? UTM offers free counseling services.";
            } else if (userMessage.includes('stress')) {
                return "Stress affects many students. Try breaking tasks into smaller steps and take regular breaks. Physical activity can also help reduce stress.";
            } else if (userMessage.includes('sleep')) {
                return "For better sleep: establish a routine, avoid screens 1 hour before bed, and create a calm environment. Chamomile tea can also help.";
            } else if (userMessage.includes('help') || userMessage.includes('support')) {
                return "Here are resources: UTM Counselling (07-553 1234), Befrienders (03-7956 8145), Crisis Text Line (Text HOME to 741741).";
            } else if (userMessage.includes('hello') || userMessage.includes('hi')) {
                return "Hello! I'm Serenity AI, here to support your mental wellbeing. How can I help you today?";
            } else {
                return "I'm here to support your mental wellbeing. You can ask me about anxiety, depression, stress, sleep, or coping strategies. How can I help you today?";
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
</body>
</html>
