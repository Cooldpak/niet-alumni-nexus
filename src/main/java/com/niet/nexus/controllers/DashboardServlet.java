package com.niet.nexus.controllers;

import com.niet.nexus.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@SuppressWarnings("unused")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        com.niet.nexus.dao.ProfileDAO profileDAO = new com.niet.nexus.dao.ProfileDAO();
        com.niet.nexus.models.Profile profile = profileDAO.getProfileByUserId(user.getId());
        request.setAttribute("missingProfile", profile == null);

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/home")) {
            if (user.getRole() == User.Role.ALUMNI) {
                request.getRequestDispatcher("/WEB-INF/views/dashboard/alumni_home.jsp").forward(request, response);
            } else if (user.getRole() == User.Role.STUDENT) {
                request.getRequestDispatcher("/WEB-INF/views/dashboard/student_home.jsp").forward(request, response);
            } else {
                // Admin dashboard placeholder
                response.getWriter().println("Admin Dashboard under construction");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
