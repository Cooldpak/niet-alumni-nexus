<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/dashboard/home">
            <i class="bi bi-mortarboard-fill me-2"></i>NIET Nexus
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/home">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/network/directory">Alumni Wall</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/network/my-requests">My Requests</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/network/connections">My Network</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/jobs/portal">Opportunities</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.user}">
                    <span class="text-light me-3">Hello, ${sessionScope.user.firstName}!</span>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-light btn-sm">Logout</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>
