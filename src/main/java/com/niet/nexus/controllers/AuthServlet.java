package com.niet.nexus.controllers;

import com.niet.nexus.dao.UserDAO;
import com.niet.nexus.models.User;
import com.niet.nexus.utils.BcryptUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@SuppressWarnings("unused")
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        switch (pathInfo) {
            case "/login":
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                break;
            case "/logout":
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect(request.getContextPath() + "/auth/login");
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo.equals("/login")) {
            loginUser(request, response);
        } else if (pathInfo.equals("/register")) {
            registerUser(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.getUserByEmail(email);

        if (user != null && BcryptUtil.checkPassword(password, user.getPasswordHash())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/dashboard/home");
        } else {
            response.sendRedirect(request.getContextPath() + "/auth/login?error=Invalid credentials");
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleStr = request.getParameter("role");

        if (userDAO.getUserByEmail(email) != null) {
            response.sendRedirect(request.getContextPath() + "/auth/register?error=Email already exists");
            return;
        }

        User newUser = new User();
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setEmail(email);
        newUser.setPasswordHash(BcryptUtil.hashPassword(password));

        try {
            User.Role role = User.Role.valueOf(roleStr);
            newUser.setRole(role);
            if (role == User.Role.ALUMNI) {
                newUser.setStatus(User.Status.PENDING);
            } else {
                newUser.setStatus(User.Status.APPROVED);
            }
        } catch (IllegalArgumentException e) {
            newUser.setRole(User.Role.STUDENT);
            newUser.setStatus(User.Status.APPROVED);
        }

        userDAO.saveUser(newUser);

        response.sendRedirect(request.getContextPath() + "/auth/login?msg=Registration successful. Please login.");
    }
}
