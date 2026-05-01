<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100 d-flex align-items-center justify-content-center">
    <div class="container text-center py-5">
        <div class="display-1 text-purple mb-4" style="color: #6f42c1;"><i class="bi bi-buildings-fill"></i></div>
        <h1 class="fw-bold mb-3">Welcome to the B2B Lounge</h1>
        <p class="lead text-muted mb-5 max-w-75 mx-auto">This exclusive section is designed for Alumni to find co-founders, pitch startups to investors, and share B2B client opportunities.</p>
        
        <div class="card border-0 shadow-sm mx-auto" style="max-width: 600px;">
            <div class="card-body p-5">
                <i class="bi bi-tools text-warning display-4 mb-3 d-block"></i>
                <h3 class="fw-bold">Under Construction</h3>
                <p class="text-muted">Our development team is currently wiring up the WebSocket messaging channels for the B2B lounge. Check back soon for the grand opening!</p>
                <a href="${pageContext.request.contextPath}/dashboard/home" class="btn text-white mt-3" style="background-color: #6f42c1;">Return to Dashboard</a>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
