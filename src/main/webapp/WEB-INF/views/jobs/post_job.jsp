<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light py-5 min-vh-100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-success text-white p-4">
                        <h3 class="mb-0 fw-bold"><i class="bi bi-megaphone-fill me-2"></i>Post a Job Opportunity</h3>
                        <p class="mb-0 small text-white-50">Share open roles at your company with the NIET student community.</p>
                    </div>
                    <div class="card-body p-5">
                        <form action="${pageContext.request.contextPath}/jobs/post" method="POST">
                            <div class="mb-4">
                                <label class="form-label fw-bold">Job Title</label>
                                <input type="text" name="title" class="form-control form-control-lg" placeholder="e.g. Frontend Developer" required>
                            </div>
                            
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Company Name</label>
                                    <input type="text" name="company" class="form-control" placeholder="e.g. Amazon" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Location</label>
                                    <input type="text" name="location" class="form-control" placeholder="e.g. Remote, Bangalore" required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold">Job Description</label>
                                <textarea name="description" class="form-control" rows="6" placeholder="Provide details about the role, requirements, and responsibilities..." required></textarea>
                            </div>

                            <div class="form-check form-switch mb-5 bg-light p-3 rounded border">
                                <input class="form-check-input ms-0 me-2" type="checkbox" id="referralSwitch" name="isReferralAvailable" checked>
                                <label class="form-check-label fw-bold text-success" for="referralSwitch">I am willing to provide a referral for this role.</label>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success btn-lg fw-bold">Publish Job Post</button>
                                <a href="${pageContext.request.contextPath}/jobs/portal" class="btn btn-outline-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
