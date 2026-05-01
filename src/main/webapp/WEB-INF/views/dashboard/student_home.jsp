<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main>
    <c:if test="${missingProfile}">
        <div class="alert alert-warning text-center rounded-0 mb-0 shadow-sm border-0 border-bottom border-warning">
            <i class="bi bi-exclamation-triangle-fill me-2 text-warning"></i>
            <strong>Profile Incomplete!</strong> Please <a href="${pageContext.request.contextPath}/profile/setup" class="alert-link text-decoration-none">complete your profile details</a> to unlock all networking features.
        </div>
    </c:if>

    <div class="hero-banner text-center mb-5">
        <div class="container">
            <h1 class="display-4 fw-bold mb-3">Welcome to your Future</h1>
            <p class="lead">Connect with NIET alumni, find mentors, and discover career opportunities.</p>
        </div>
    </div>

    <div class="container">
        <div class="row g-4">
            <!-- Mentorship Hub -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-4">
                        <div class="display-4 text-primary mb-3"><i class="bi bi-people-fill"></i></div>
                        <h4 class="card-title fw-bold">Smart Networking</h4>
                        <p class="card-text text-muted">Find alumni working in your dream companies and request a virtual mentorship session.</p>
                        <a href="${pageContext.request.contextPath}/network/directory" class="btn btn-primary mt-2">Find a Mentor</a>
                    </div>
                </div>
            </div>
            <!-- Opportunity Portal -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-4">
                        <div class="display-4 text-success mb-3"><i class="bi bi-briefcase-fill"></i></div>
                        <h4 class="card-title fw-bold">Opportunity Portal</h4>
                        <p class="card-text text-muted">Browse jobs posted by verified alumni and request direct referrals.</p>
                        <a href="${pageContext.request.contextPath}/jobs/portal" class="btn btn-success mt-2">View Jobs</a>
                    </div>
                </div>
            </div>
            <!-- Resource Library -->
            <div class="col-md-4">
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body text-center p-4">
                        <div class="display-4 text-info mb-3"><i class="bi bi-journal-bookmark-fill"></i></div>
                        <h4 class="card-title fw-bold">Resource Library</h4>
                        <p class="card-text text-muted">Access interview experiences, roadmaps, and exclusive perks.</p>
                        <a href="${pageContext.request.contextPath}/resources" class="btn btn-info text-white mt-2">Explore Resources</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
