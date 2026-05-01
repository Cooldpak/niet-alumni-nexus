<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <div>
                <h1 class="fw-bold text-success mb-2">Opportunity Portal</h1>
                <p class="text-muted mb-0">Discover career opportunities and referrals from our alumni network.</p>
            </div>
            <c:if test="${sessionScope.user.role == 'ALUMNI'}">
                <a href="${pageContext.request.contextPath}/jobs/create" class="btn btn-success btn-lg fw-bold shadow-sm">
                    <i class="bi bi-plus-circle me-2"></i>Post a Job
                </a>
            </c:if>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty jobs}">
                    <c:forEach var="job" items="${jobs}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 shadow-sm border-0 job-card position-relative">
                                <c:if test="${job.isReferralAvailable}">
                                    <span class="badge bg-success position-absolute top-0 end-0 m-3 shadow-sm">
                                        <i class="bi bi-star-fill me-1"></i>Referral Available
                                    </span>
                                </c:if>
                                <div class="card-body p-4">
                                    <h4 class="card-title fw-bold text-dark mb-1">${job.title}</h4>
                                    <h6 class="text-success fw-bold mb-3"><i class="bi bi-building me-2"></i>${job.company}</h6>
                                    
                                    <div class="mb-3 text-muted small">
                                        <i class="bi bi-geo-alt-fill me-1"></i>${job.location}
                                    </div>
                                    
                                    <p class="card-text text-muted small text-truncate" style="max-height: 4.5em; white-space: pre-wrap;">${job.description}</p>
                                    
                                    <hr>
                                    <button class="btn btn-outline-success w-100" data-bs-toggle="modal" data-bs-target="#jobModal${job.id}">
                                        View Details
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Job Details Modal -->
                        <div class="modal fade" id="jobModal${job.id}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content border-0 shadow-lg">
                                    <div class="modal-header bg-success text-white border-0">
                                        <h5 class="modal-title fw-bold">${job.title} at ${job.company}</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-5">
                                        <div class="d-flex justify-content-between align-items-start mb-4">
                                            <div>
                                                <h3 class="fw-bold mb-1">${job.title}</h3>
                                                <h5 class="text-success mb-2">${job.company}</h5>
                                                <p class="text-muted"><i class="bi bi-geo-alt-fill me-2"></i>${job.location}</p>
                                            </div>
                                            <c:if test="${job.isReferralAvailable}">
                                                <span class="badge bg-success fs-6 p-2"><i class="bi bi-check-circle-fill me-2"></i>Referral Available</span>
                                            </c:if>
                                        </div>
                                        
                                        <h5 class="fw-bold border-bottom pb-2 mb-3">Job Description</h5>
                                        <p style="white-space: pre-wrap;">${job.description}</p>
                                        
                                        <c:if test="${sessionScope.user.role == 'STUDENT' && job.isReferralAvailable}">
                                            <div class="mt-5 p-4 bg-light rounded text-center border border-success">
                                                <h5 class="text-success fw-bold">Want a referral?</h5>
                                                <p class="text-muted">Reach out to the alumni who posted this job via the Networking Directory.</p>
                                                <a href="${pageContext.request.contextPath}/network/directory" class="btn btn-success">Go to Alumni Wall</a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <div class="display-1 text-muted mb-3"><i class="bi bi-briefcase"></i></div>
                        <h3 class="fw-bold">No Jobs Posted Yet</h3>
                        <p class="text-muted">Check back later or post a new opportunity if you are an alumni!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<style>
    .job-card { transition: transform 0.2s ease, box-shadow 0.2s ease; border-top: 4px solid transparent !important; }
    .job-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; border-top: 4px solid #198754 !important; }
</style>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
