package com.niet.nexus.controllers;

import com.niet.nexus.dao.ProfileDAO;
import com.niet.nexus.models.Profile;
import com.niet.nexus.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {

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

        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/setup") || pathInfo.equals("/edit")) {
            Profile profile = profileDAO.getProfileByUserId(user.getId());
            request.setAttribute("profile", profile);
            request.getRequestDispatcher("/WEB-INF/views/profile/profile_setup.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.equals("/save")) {
            Profile profile = new Profile();
            profile.setUserId(user.getId());
            profile.setUser(user);
            
            profile.setDepartment(request.getParameter("department"));
            
            String gradYearStr = request.getParameter("graduationYear");
            if (gradYearStr != null && !gradYearStr.isEmpty()) {
                profile.setGraduationYear(Integer.parseInt(gradYearStr));
            }
            
            profile.setCurrentIndustry(request.getParameter("currentIndustry"));
            profile.setCompany(request.getParameter("company"));
            profile.setJobTitle(request.getParameter("jobTitle"));
            profile.setSkills(request.getParameter("skills"));
            
            String willing = request.getParameter("willingnessToRefer");
            profile.setWillingnessToRefer(willing != null && willing.equals("on"));
            
            // Retain old points if profile exists
            Profile existing = profileDAO.getProfileByUserId(user.getId());
            if (existing != null) {
                profile.setMentorshipPoints(existing.getMentorshipPoints());
            }

            profileDAO.saveOrUpdateProfile(profile);

            response.sendRedirect(request.getContextPath() + "/dashboard/home?msg=Profile+updated+successfully");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
