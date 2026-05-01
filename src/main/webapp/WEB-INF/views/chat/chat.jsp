<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<style>
    .chat-container { height: calc(100vh - 200px); display: flex; flex-direction: column; }
    .chat-messages { flex-grow: 1; overflow-y: auto; padding: 20px; background-color: #f8f9fa; }
    .message { max-width: 75%; margin-bottom: 15px; padding: 12px 18px; border-radius: 20px; position: relative; clear: both; }
    .message.sent { background-color: #0d6efd; color: white; float: right; border-bottom-right-radius: 4px; }
    .message.received { background-color: #e9ecef; color: #212529; float: left; border-bottom-left-radius: 4px; }
    .message-time { font-size: 0.7rem; margin-top: 5px; opacity: 0.8; text-align: right; }
    .chat-input-area { background: white; padding: 15px; border-top: 1px solid #dee2e6; }
</style>

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-4">
        <div class="card border-0 shadow-sm chat-container">
            <!-- Chat Header -->
            <div class="card-header bg-primary text-white p-3 d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <a href="javascript:history.back()" class="text-white me-3 fs-5"><i class="bi bi-arrow-left"></i></a>
                    <div class="bg-white text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px; font-size: 1.2rem;">
                        <i class="bi bi-person-fill"></i>
                    </div>
                    <div>
                        <h5 class="mb-0 fw-bold">Live Mentorship Chat</h5>
                        <small class="text-white-50"><i class="bi bi-circle-fill text-success small me-1"></i>Connected</small>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/chat/clear" method="POST" class="m-0" onsubmit="return confirm('Are you sure you want to permanently delete this entire chat history? This action cannot be undone.');">
                    <input type="hidden" name="withUserId" value="${withUserId}">
                    <button type="submit" class="btn btn-sm btn-outline-light"><i class="bi bi-trash-fill me-1"></i>Delete Chat</button>
                </form>
            </div>

            <!-- Messages Area -->
            <div class="chat-messages" id="chatBox">
                <!-- Messages will be populated via AJAX -->
                <div class="text-center text-muted mt-5" id="loadingMsg">
                    <div class="spinner-border spinner-border-sm me-2" role="status"></div> Loading messages...
                </div>
            </div>

            <!-- Input Area -->
            <div class="chat-input-area">
                <form id="chatForm" class="d-flex gap-2" onsubmit="sendMessage(event)">
                    <input type="hidden" id="withUserId" value="${withUserId}">
                    <input type="text" id="messageInput" class="form-control rounded-pill px-4" placeholder="Type your message..." required autocomplete="off">
                    <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">
                        <i class="bi bi-send-fill me-1"></i>Send
                    </button>
                </form>
            </div>
        </div>
    </div>
</main>

<script>
    const currentUserId = ${sessionScope.user.id};
    const withUserId = document.getElementById('withUserId').value;
    const chatBox = document.getElementById('chatBox');
    const chatForm = document.getElementById('chatForm');
    const messageInput = document.getElementById('messageInput');

    // Function to render a single message bubble
    function renderMessage(msg) {
        const isSent = (msg.senderId === currentUserId);
        const div = document.createElement('div');
        div.className = 'message ' + (isSent ? 'sent' : 'received');
        
        const content = document.createElement('div');
        content.textContent = msg.content;
        
        const time = document.createElement('div');
        time.className = 'message-time';
        time.textContent = msg.sentAt;
        
        div.appendChild(content);
        div.appendChild(time);
        
        // Clear floats after
        const clearer = document.createElement('div');
        clearer.style.clear = 'both';

        chatBox.appendChild(div);
        chatBox.appendChild(clearer);
    }

    // Function to fetch messages via AJAX
    function fetchMessages() {
        fetch(`${pageContext.request.contextPath}/chat/sync?with=` + withUserId)
            .then(response => response.json())
            .then(data => {
                // Determine if we are at the bottom of the chat before updating
                const isScrolledToBottom = chatBox.scrollHeight - chatBox.clientHeight <= chatBox.scrollTop + 50;
                
                chatBox.innerHTML = ''; // Clear old messages
                if (data.length === 0) {
                    chatBox.innerHTML = '<div class="text-center text-muted mt-5">No messages yet. Say hello!</div>';
                } else {
                    data.forEach(msg => renderMessage(msg));
                }

                // Auto-scroll to bottom if we were already there
                if (isScrolledToBottom || chatBox.scrollTop === 0) {
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            })
            .catch(error => console.error('Error fetching messages:', error));
    }

    // Send new message via POST
    function sendMessage(e) {
        e.preventDefault();
        const content = messageInput.value.trim();
        if (!content) return;

        const formData = new URLSearchParams();
        formData.append('receiverId', withUserId);
        formData.append('content', content);

        fetch(`${pageContext.request.contextPath}/chat/send`, {
            method: 'POST',
            body: formData,
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        }).then(response => {
            if (response.ok) {
                messageInput.value = ''; // Clear input
                fetchMessages(); // Immediately sync
            }
        });
    }

    // Start polling every 2.5 seconds
    setInterval(fetchMessages, 2500);
    
    // Initial fetch
    fetchMessages();
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
