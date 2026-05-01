package com.niet.nexus.controllers;

import com.niet.nexus.dao.ResourceDAO;
import com.niet.nexus.models.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ResourceServlet extends HttpServlet {

    private ResourceDAO resourceDAO;

    public void init() {
        resourceDAO = new ResourceDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            List<Resource> resources = resourceDAO.getAllResources();
            request.setAttribute("resources", resources);
            request.getRequestDispatcher("/WEB-INF/views/resources/library.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
