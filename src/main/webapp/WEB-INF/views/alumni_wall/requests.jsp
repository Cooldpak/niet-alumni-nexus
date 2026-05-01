<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-5">
        <div class="mb-5">
            <h1 class="fw-bold text-primary mb-2">Mentorship Requests</h1>
            <p class="text-muted mb-0">Manage incoming connections from students seeking your guidance.</p>
        </div>

        <c:if test="${not empty param.msg}">
            <div class="alert alert-success border-0 shadow-sm">${param.msg}</div>
        </c:if>

        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty pendingRequests}">
                        <div class="list-group list-group-flush rounded-3">
                            <c:forEach var="req" items="${pendingRequests}">
                                <div class="list-group-item p-4">
                                    <div class="d-flex w-100 justify-content-between align-items-start">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                                <i class="bi bi-person-fill"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-1 fw-bold">${req.requester.firstName} ${req.requester.lastName}</h5>
                                                <p class="mb-1 text-muted small"><i class="bi bi-envelope me-1"></i>${req.requester.email}</p>
                                                <span class="badge bg-secondary"><i class="bi bi-tag-fill me-1"></i>${req.connectionType}</span>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <small class="text-muted d-block mb-2">Received: ${req.createdAt}</small>
                                            <form action="${pageContext.request.contextPath}/network/requests/update" method="POST" class="d-inline">
                                                <input type="hidden" name="connectionId" value="${req.id}">
                                                <button type="submit" name="action" value="ACCEPT" class="btn btn-sm btn-success me-1 fw-bold"><i class="bi bi-check-lg me-1"></i>Accept</button>
                                                <button type="submit" name="action" value="REJECT" class="btn btn-sm btn-outline-danger fw-bold"><i class="bi bi-x-lg me-1"></i>Reject</button>
                                            </form>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${not empty req.message}">
                                        <div class="mt-3 p-3 bg-light rounded border-start border-primary border-4 text-dark small">
                                            <em>"${req.message}"</em>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <div class="display-1 text-muted mb-3"><i class="bi bi-envelope-paper"></i></div>
                            <h4 class="fw-bold text-muted">No Pending Requests</h4>
                            <p class="text-muted">You're all caught up! When students request mentorship, they'll appear here.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
