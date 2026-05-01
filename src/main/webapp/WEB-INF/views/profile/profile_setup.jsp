<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<main class="bg-light pb-5 min-vh-100">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white p-4">
                        <h3 class="mb-0 fw-bold"><i class="bi bi-person-lines-fill me-2"></i>Profile Setup</h3>
                        <p class="mb-0 small text-white-50">Complete your profile to unlock full platform features.</p>
                    </div>
                    <div class="card-body p-5">
                        <form action="${pageContext.request.contextPath}/profile/save" method="POST">
                            <h5 class="text-primary fw-bold mb-3 border-bottom pb-2">Academic Details</h5>
                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Department / Branch</label>
                                    <select name="department" class="form-select" required>
                                        <option value="Computer Science" ${profile.department == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                                        <option value="Information Technology" ${profile.department == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                                        <option value="Electronics" ${profile.department == 'Electronics' ? 'selected' : ''}>Electronics</option>
                                        <option value="Mechanical" ${profile.department == 'Mechanical' ? 'selected' : ''}>Mechanical</option>
                                        <option value="Civil" ${profile.department == 'Civil' ? 'selected' : ''}>Civil</option>
                                        <option value="Other" ${profile.department == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 'STUDENT'}">Expected Graduation Year</c:when>
                                            <c:otherwise>Graduation Year</c:otherwise>
                                        </c:choose>
                                    </label>
                                    <input type="number" name="graduationYear" class="form-control" value="${profile.graduationYear}" placeholder="e.g. 2024" required min="1990" max="2030">
                                </div>
                            </div>

                            <c:if test="${sessionScope.user.role == 'ALUMNI'}">
                                <h5 class="text-primary fw-bold mb-3 border-bottom pb-2">Professional Details</h5>
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Current Industry</label>
                                        <input type="text" name="currentIndustry" class="form-control" value="${profile.currentIndustry}" placeholder="e.g. Software, Finance" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Company / Organization</label>
                                        <input type="text" name="company" class="form-control" value="${profile.company}" placeholder="e.g. Google, Microsoft" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold">Job Title</label>
                                        <input type="text" name="jobTitle" class="form-control" value="${profile.jobTitle}" placeholder="e.g. SDE II, Data Scientist" required>
                                    </div>
                                </div>
                            </c:if>

                            <div class="row g-3 mb-4">
                                <div class="col-12">
                                    <label class="form-label fw-bold">Key Skills</label>
                                    <textarea name="skills" class="form-control" rows="3" placeholder="Java, Python, React, AWS...">${profile.skills}</textarea>
                                </div>
                            </div>

                            <c:if test="${sessionScope.user.role == 'ALUMNI'}">
                                <div class="form-check form-switch mb-4 bg-light p-3 rounded">
                                    <input class="form-check-input ms-0 me-2" type="checkbox" id="referralSwitch" name="willingnessToRefer" ${profile.willingnessToRefer ? 'checked' : ''}>
                                    <label class="form-check-label fw-bold text-success" for="referralSwitch">I am open to providing job referrals to students.</label>
                                </div>
                            </c:if>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg fw-bold">Save Profile</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
