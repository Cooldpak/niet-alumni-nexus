package com.niet.nexus.controllers;

import com.niet.nexus.dao.ProfileDAO;
import com.niet.nexus.models.Profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@SuppressWarnings("unused")
public class AlumniServlet extends HttpServlet {

    private ProfileDAO profileDAO;

    public void init() {
        profileDAO = new ProfileDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        com.niet.nexus.models.User user = (com.niet.nexus.models.User) session.getAttribute("user");

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/directory")) {
            String department = request.getParameter("department");
            String industry = request.getParameter("industry");

            List<Profile> alumniList;
            if ((department != null && !department.isEmpty()) || (industry != null && !industry.isEmpty())) {
                alumniList = profileDAO.searchAlumniProfiles(department, industry);
            } else {
                alumniList = profileDAO.getAllAlumniProfiles();
            }

            request.setAttribute("alumniList", alumniList);
            request.getRequestDispatcher("/WEB-INF/views/alumni_wall/directory.jsp").forward(request, response);
        } else if (pathInfo.equals("/requests")) {
            com.niet.nexus.dao.ConnectionDAO connectionDAO = new com.niet.nexus.dao.ConnectionDAO();
            List<com.niet.nexus.models.Connection> requests = connectionDAO.getPendingRequestsForUser(user.getId());
            request.setAttribute("pendingRequests", requests);
            request.getRequestDispatcher("/WEB-INF/views/alumni_wall/requests.jsp").forward(request, response);
        } else if (pathInfo.equals("/b2b")) {
            request.getRequestDispatcher("/WEB-INF/views/alumni_wall/b2b_lounge.jsp").forward(request, response);
        } else if (pathInfo.equals("/my-requests")) {
            com.niet.nexus.dao.ConnectionDAO connectionDAO = new com.niet.nexus.dao.ConnectionDAO();
            List<com.niet.nexus.models.Connection> myRequests = connectionDAO.getRequestsByRequester(user.getId());
            request.setAttribute("myRequests", myRequests);
            request.getRequestDispatcher("/WEB-INF/views/dashboard/my_requests.jsp").forward(request, response);
        } else if (pathInfo.equals("/connections")) {
            com.niet.nexus.dao.ConnectionDAO connectionDAO = new com.niet.nexus.dao.ConnectionDAO();
            List<com.niet.nexus.models.Connection> connections = connectionDAO.getAcceptedConnectionsForUser(user.getId());
            request.setAttribute("connections", connections);
            request.getRequestDispatcher("/WEB-INF/views/dashboard/connections.jsp").forward(request, response);
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
        com.niet.nexus.models.User user = (com.niet.nexus.models.User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();
        
        if (pathInfo != null && pathInfo.equals("/request")) {
            Long receiverId = Long.parseLong(request.getParameter("receiverId"));
            String connectionTypeStr = request.getParameter("connectionType");
            String message = request.getParameter("message");
            
            com.niet.nexus.models.Connection connection = new com.niet.nexus.models.Connection();
            connection.setRequester(user);
            com.niet.nexus.models.User receiver = new com.niet.nexus.models.User();
            receiver.setId(receiverId);
            connection.setReceiver(receiver);
            connection.setConnectionType(com.niet.nexus.models.Connection.ConnectionType.valueOf(connectionTypeStr));
            connection.setMessage(message);
            connection.setStatus(com.niet.nexus.models.Connection.Status.REQUESTED);
            
            com.niet.nexus.dao.ConnectionDAO connectionDAO = new com.niet.nexus.dao.ConnectionDAO();
            connectionDAO.createConnectionRequest(connection);
            
            response.sendRedirect(request.getContextPath() + "/network/directory?msg=Request+sent+successfully");
        } else if (pathInfo != null && pathInfo.equals("/requests/update")) {
            Long connectionId = Long.parseLong(request.getParameter("connectionId"));
            String action = request.getParameter("action");
            
            com.niet.nexus.dao.ConnectionDAO connectionDAO = new com.niet.nexus.dao.ConnectionDAO();
            if (action.equals("ACCEPT")) {
                connectionDAO.updateConnectionStatus(connectionId, com.niet.nexus.models.Connection.Status.ACCEPTED);
            } else if (action.equals("REJECT")) {
                connectionDAO.updateConnectionStatus(connectionId, com.niet.nexus.models.Connection.Status.REJECTED);
            }
            response.sendRedirect(request.getContextPath() + "/network/requests?msg=Request+" + action + "+successfully");
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }
}
