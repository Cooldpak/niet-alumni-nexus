<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-5">
        <div class="mb-5">
            <h1 class="fw-bold text-success mb-2">My Network</h1>
            <p class="text-muted mb-0">View and message your accepted connections.</p>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty connections}">
                        <div class="list-group list-group-flush rounded-3">
                            <c:forEach var="conn" items="${connections}">
                                <!-- Determine who the 'other' user is -->
                                <c:set var="otherUser" value="${conn.requester.id == sessionScope.user.id ? conn.receiver : conn.requester}" />
                                
                                <div class="list-group-item p-4">
                                    <div class="d-flex w-100 justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                                <i class="bi bi-person-check-fill"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-1 fw-bold">${otherUser.firstName} ${otherUser.lastName}</h5>
                                                <span class="badge bg-secondary"><i class="bi bi-tag-fill me-1"></i>${conn.connectionType}</span>
                                                <small class="text-muted ms-2">Connected since: ${conn.createdAt}</small>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <a href="${pageContext.request.contextPath}/chat?with=${otherUser.id}" class="btn btn-primary fw-bold px-4 rounded-pill">
                                                <i class="bi bi-chat-dots-fill me-2"></i>Open Chat
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <div class="display-1 text-muted mb-3"><i class="bi bi-people"></i></div>
                            <h4 class="fw-bold text-muted">Your network is empty</h4>
                            <p class="text-muted">You haven't made any connections yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
