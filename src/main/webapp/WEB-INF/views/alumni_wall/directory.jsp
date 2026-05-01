<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<style>
    .alumni-card:hover { transform: translateY(-5px); transition: all 0.3s ease; box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; }
    .avatar-circle { width: 80px; height: 80px; background-color: #593196; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin: 0 auto 1rem; }
    .badge-top-mentor { position: absolute; top: 10px; right: 10px; }
</style>

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-5">
        <div class="row mb-5 align-items-center">
            <div class="col-md-6">
                <h1 class="fw-bold text-primary mb-2">Alumni Wall</h1>
                <p class="text-muted">Connect with verified NIET alumni across the globe.</p>
            </div>
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/network/directory" method="GET" class="d-flex gap-2 bg-white p-3 rounded shadow-sm">
                    <input type="text" name="department" class="form-control" placeholder="Dept (e.g. CS, IT)" value="${param.department}">
                    <input type="text" name="industry" class="form-control" placeholder="Industry" value="${param.industry}">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i></button>
                    <a href="${pageContext.request.contextPath}/network/directory" class="btn btn-outline-secondary">Clear</a>
                </form>
            </div>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty alumniList}">
                    <c:forEach var="profile" items="${alumniList}" varStatus="status">
                        <div class="col-md-4 col-lg-3">
                            <div class="card h-100 shadow-sm border-0 position-relative alumni-card">
                                <!-- Gamification Badge -->
                                <c:if test="${profile.mentorshipPoints > 50 || status.index < 3}">
                                    <span class="badge bg-warning text-dark badge-top-mentor rounded-pill shadow-sm">
                                        <i class="bi bi-star-fill"></i> Top Mentor
                                    </span>
                                </c:if>
                                
                                <div class="card-body text-center p-4 mt-3">
                                    <div class="avatar-circle shadow-sm">
                                        ${fn:substring(profile.user.firstName, 0, 1)}${fn:substring(profile.user.lastName, 0, 1)}
                                    </div>
                                    <h5 class="card-title fw-bold mb-1">${profile.user.firstName} ${profile.user.lastName}</h5>
                                    <p class="text-primary mb-1 fw-semibold">${profile.jobTitle}</p>
                                    <p class="text-muted small mb-3">@ ${profile.company}</p>
                                    
                                    <div class="d-flex flex-wrap justify-content-center gap-2 mb-3">
                                        <span class="badge bg-light text-dark border">${profile.department}</span>
                                        <span class="badge bg-light text-dark border">Class of ${profile.graduationYear}</span>
                                    </div>

                                    <c:if test="${profile.willingnessToRefer}">
                                        <p class="text-success small fw-bold mb-2"><i class="bi bi-check-circle-fill"></i> Open to Referrals</p>
                                    </c:if>
                                    
                                    <c:choose>
                                        <c:when test="${profile.user.id != sessionScope.user.id}">
                                            <button class="btn btn-outline-primary btn-sm w-100 mt-2" data-bs-toggle="modal" data-bs-target="#mentorModal${profile.user.id}">
                                                Request Mentorship
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="badge bg-secondary w-100 mt-2 py-2 shadow-sm">This is You</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <!-- Mentorship Modal -->
                        <div class="modal fade" id="mentorModal${profile.user.id}" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content border-0 shadow-lg">
                                    <div class="modal-header bg-primary text-white border-0">
                                        <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill me-2"></i>Connect with ${profile.user.firstName}</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <form action="${pageContext.request.contextPath}/network/request" method="POST">
                                            <input type="hidden" name="receiverId" value="${profile.user.id}">
                                            <div class="mb-4">
                                                <label class="form-label fw-bold text-secondary">Connection Type</label>
                                                <select name="connectionType" class="form-select">
                                                    <option value="MENTORSHIP">Virtual Mentorship</option>
                                                    <option value="B2B_NETWORKING">B2B Networking</option>
                                                </select>
                                            </div>
                                            <div class="mb-4">
                                                <label class="form-label fw-bold text-secondary">Message</label>
                                                <textarea name="message" class="form-control" rows="4" placeholder="Introduce yourself and explain why you'd like to connect..." required></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary w-100 py-2 fw-bold">Send Request</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <div class="display-1 text-muted mb-3"><i class="bi bi-search"></i></div>
                        <h3 class="fw-bold">No Alumni Found</h3>
                        <p class="text-muted">Try adjusting your search filters to find mentors.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
