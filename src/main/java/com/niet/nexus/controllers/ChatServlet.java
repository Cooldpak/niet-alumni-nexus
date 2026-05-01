package com.niet.nexus.controllers;

import com.niet.nexus.dao.MessageDAO;
import com.niet.nexus.models.Message;
import com.niet.nexus.models.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class ChatServlet extends HttpServlet {

    private MessageDAO messageDAO;
    private Gson gson;

    public void init() {
        messageDAO = new MessageDAO();
        gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();
        String withParam = request.getParameter("with");

        if (withParam == null || withParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing 'with' parameter");
            return;
        }
        
        Long withUserId = Long.parseLong(withParam);

        if (pathInfo == null || pathInfo.equals("/")) {
            // Render the chat JSP
            request.setAttribute("withUserId", withUserId);
            // Optional: Fetch the other user's info to display name
            request.getRequestDispatcher("/WEB-INF/views/chat/chat.jsp").forward(request, response);
        } else if (pathInfo.equals("/sync")) {
            // API endpoint for AJAX polling
            List<Message> conversation = messageDAO.getConversation(user.getId(), withUserId);
            
            // Format for JSON
            List<Map<String, Object>> messagesList = new ArrayList<>();
            if (conversation != null) {
                for (Message m : conversation) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", m.getId());
                    map.put("content", m.getContent());
                    map.put("senderId", m.getSender().getId());
                    map.put("sentAt", m.getSentAt());
                    messagesList.add(map);
                }
            }
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(messagesList));
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.equals("/send")) {
            Long receiverId = Long.parseLong(request.getParameter("receiverId"));
            String content = request.getParameter("content");

            Message message = new Message();
            message.setSender(user);
            User receiver = new User();
            receiver.setId(receiverId);
            message.setReceiver(receiver);
            message.setContent(content);

            messageDAO.saveMessage(message);

            // Using AJAX POST, just return 200 OK
            response.setStatus(HttpServletResponse.SC_OK);
        } else if (pathInfo != null && pathInfo.equals("/clear")) {
            Long withUserId = Long.parseLong(request.getParameter("withUserId"));
            messageDAO.deleteConversation(user.getId(), withUserId);
            
            // Redirect back to dashboard based on role
            if (user.getRole() == User.Role.STUDENT) {
                response.sendRedirect(request.getContextPath() + "/network/my-requests?msg=Chat+history+deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/network/requests?msg=Chat+history+deleted");
            }
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
}
