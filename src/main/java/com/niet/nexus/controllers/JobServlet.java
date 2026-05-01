package com.niet.nexus.controllers;

import com.niet.nexus.dao.JobDAO;
import com.niet.nexus.models.JobPost;
import com.niet.nexus.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class JobServlet extends HttpServlet {

    private JobDAO jobDAO;

    public void init() {
        jobDAO = new JobDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/portal")) {
            List<JobPost> jobs = jobDAO.getAllJobs();
            request.setAttribute("jobs", jobs);
            request.getRequestDispatcher("/WEB-INF/views/jobs/job_portal.jsp").forward(request, response);
        } else if (pathInfo.equals("/create")) {
            User user = (User) session.getAttribute("user");
            if (user.getRole() != User.Role.ALUMNI) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only alumni can post jobs.");
                return;
            }
            request.getRequestDispatcher("/WEB-INF/views/jobs/post_job.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getRole() != User.Role.ALUMNI) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo != null && pathInfo.equals("/post")) {
            JobPost job = new JobPost();
            job.setAlumni(user);
            job.setTitle(request.getParameter("title"));
            job.setCompany(request.getParameter("company"));
            job.setLocation(request.getParameter("location"));
            job.setDescription(request.getParameter("description"));
            
            String referral = request.getParameter("isReferralAvailable");
            job.setIsReferralAvailable(referral != null && referral.equals("on"));

            jobDAO.saveJob(job);
            response.sendRedirect(request.getContextPath() + "/jobs/portal?msg=Job+posted+successfully");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
