<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main>
    <c:if test="${missingProfile}">
        <div class="alert alert-warning text-center rounded-0 mb-0 shadow-sm border-0 border-bottom border-warning">
            <i class="bi bi-exclamation-triangle-fill me-2 text-warning"></i>
            <strong>Profile Incomplete!</strong> Please <a href="${pageContext.request.contextPath}/profile/setup" class="alert-link text-decoration-none">complete your profile details</a> to appear on the Alumni Wall.
        </div>
    </c:if>

    <div class="hero-banner text-center mb-5" style="background: linear-gradient(135deg, #198754, #146c43);">
        <div class="container">
            <h1 class="display-4 fw-bold mb-3">Welcome Back, ${sessionScope.user.firstName}</h1>
            <p class="lead">Give back to the NIET community, hire top talent, and connect with fellow alumni.</p>
        </div>
    </div>

    <div class="container">
        <!-- Gamification Banner -->
        <div class="alert alert-warning shadow-sm border-0 d-flex align-items-center justify-content-between mb-5" role="alert">
            <div>
                <i class="bi bi-star-fill text-warning me-2 fs-4"></i>
                <strong>Top Mentor Leaderboard:</strong> Earn mentorship points by referring students and uploading resources!
            </div>
            <a href="${pageContext.request.contextPath}/network/directory" class="btn btn-warning btn-sm text-dark">View Leaderboard</a>
        </div>

        <div class="row g-4">
            <!-- Hire Talent -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-4">
                        <div class="display-4 text-success mb-3"><i class="bi bi-person-lines-fill"></i></div>
                        <h4 class="card-title fw-bold">Hire Top Talent</h4>
                        <p class="card-text text-muted">Post job opportunities and get direct access to the best NIET graduates.</p>
                        <a href="${pageContext.request.contextPath}/jobs/create" class="btn btn-success mt-2">Post a Job</a>
                    </div>
                </div>
            </div>
            <!-- Mentorship Requests -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-4">
                        <div class="display-4 text-primary mb-3"><i class="bi bi-envelope-paper-fill"></i></div>
                        <h4 class="card-title fw-bold">Mentorship Requests</h4>
                        <p class="card-text text-muted">Manage virtual mentorship requests from students seeking your guidance.</p>
                        <a href="${pageContext.request.contextPath}/network/requests" class="btn btn-primary mt-2">View Requests</a>
                    </div>
                </div>
            </div>
            <!-- B2B Networking -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-4">
                        <div class="display-4 text-purple mb-3" style="color: #6f42c1;"><i class="bi bi-buildings-fill"></i></div>
                        <h4 class="card-title fw-bold">B2B Lounge</h4>
                        <p class="card-text text-muted">Find co-founders, investors, or clients within the trusted alumni network.</p>
                        <a href="${pageContext.request.contextPath}/network/b2b" class="btn text-white mt-2" style="background-color: #6f42c1;">Enter Lounge</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
