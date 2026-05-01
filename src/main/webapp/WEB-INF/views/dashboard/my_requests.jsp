<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-5">
        <div class="mb-5">
            <h1 class="fw-bold text-primary mb-2">My Requests</h1>
            <p class="text-muted mb-0">Track the status of your mentorship and networking requests.</p>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty myRequests}">
                        <div class="list-group list-group-flush rounded-3">
                            <c:forEach var="req" items="${myRequests}">
                                <div class="list-group-item p-4">
                                    <div class="d-flex w-100 justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                                <i class="bi bi-person-fill"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-1 fw-bold">To: ${req.receiver.firstName} ${req.receiver.lastName}</h5>
                                                <span class="badge bg-secondary"><i class="bi bi-tag-fill me-1"></i>${req.connectionType}</span>
                                                <small class="text-muted ms-2">Sent on: ${req.createdAt}</small>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <c:choose>
                                                <c:when test="${req.status == 'REQUESTED'}">
                                                    <span class="badge bg-warning text-dark px-3 py-2 fs-6 rounded-pill">Pending</span>
                                                </c:when>
                                                <c:when test="${req.status == 'ACCEPTED'}">
                                                    <span class="badge bg-success px-3 py-2 fs-6 rounded-pill mb-2 d-block">Accepted</span>
                                                    <a href="${pageContext.request.contextPath}/chat?with=${req.receiver.id}" class="btn btn-sm btn-primary fw-bold w-100">
                                                        <i class="bi bi-chat-dots-fill me-1"></i>Message
                                                    </a>
                                                </c:when>
                                                <c:when test="${req.status == 'REJECTED'}">
                                                    <span class="badge bg-danger px-3 py-2 fs-6 rounded-pill">Declined</span>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-3 p-3 bg-light rounded border-start border-secondary border-4 text-dark small">
                                        <em>"You wrote: ${req.message}"</em>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <div class="display-1 text-muted mb-3"><i class="bi bi-envelope-paper"></i></div>
                            <h4 class="fw-bold text-muted">No Requests Sent</h4>
                            <p class="text-muted">Explore the Alumni Wall to find mentors and send connection requests!</p>
                            <a href="${pageContext.request.contextPath}/network/directory" class="btn btn-primary mt-3">Find Mentors</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
