<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100">
    <!-- Header Section -->
    <div class="bg-info text-white py-5 mb-5 shadow-sm">
        <div class="container text-center">
            <h1 class="display-4 fw-bold mb-3"><i class="bi bi-journal-bookmark-fill me-3"></i>Resource Library</h1>
            <p class="lead mb-0">Access interview experiences, roadmaps, and exclusive perks shared by our alumni network.</p>
        </div>
    </div>

    <div class="container">
        <!-- Resource Filters -->
        <div class="d-flex justify-content-center mb-5 gap-3">
            <button class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">All Resources</button>
            <button class="btn btn-outline-secondary bg-white rounded-pill px-4">Interview Experiences</button>
            <button class="btn btn-outline-secondary bg-white rounded-pill px-4">Roadmaps</button>
            <button class="btn btn-outline-secondary bg-white rounded-pill px-4">Alumni Perks</button>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty resources}">
                    <c:forEach var="res" items="${resources}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 border-0 shadow-sm resource-card">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div class="resource-icon bg-info text-white rounded d-flex align-items-center justify-content-center" style="width: 45px; height: 45px; font-size: 1.5rem;">
                                            <i class="bi 
                                                ${res.type == 'INTERVIEW_EXP' ? 'bi-chat-left-quote-fill' : 
                                                  res.type == 'ROADMAP' ? 'bi-signpost-split-fill' : 'bi-gift-fill'}">
                                            </i>
                                        </div>
                                        <span class="badge bg-light text-dark border">${res.type}</span>
                                    </div>
                                    <h4 class="card-title fw-bold mb-2">${res.title}</h4>
                                    <p class="card-text text-muted mb-4">${res.description}</p>
                                    
                                    <a href="${res.fileUrl}" class="btn btn-outline-info w-100 fw-bold" target="_blank">
                                        <i class="bi bi-box-arrow-up-right me-2"></i>Access Resource
                                    </a>
                                </div>
                                <div class="card-footer bg-white border-top-0 p-4 pt-0">
                                    <small class="text-muted d-block border-top pt-3"><i class="bi bi-clock me-1"></i> Added: ${res.createdAt}</small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <div class="display-1 text-muted mb-3"><i class="bi bi-folder2-open"></i></div>
                        <h3 class="fw-bold">No Resources Yet</h3>
                        <p class="text-muted">Alumni haven't shared any resources yet. Check back soon!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<style>
    .resource-card { transition: transform 0.2s ease, box-shadow 0.2s ease; }
    .resource-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; }
</style>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
