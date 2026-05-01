<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - NIET Nexus</title>
    <!-- Bootstrap 5 Pulse Theme -->
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/pulse/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; display: flex; align-items: center; justify-content: center; min-height: 100vh; padding-top: 40px; padding-bottom: 40px; }
        .register-card { border: none; border-radius: 1rem; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15); overflow: hidden; }
    </style>
</head>
<body>

    <main class="form-signin w-100 m-auto" style="max-width: 500px;">
        <div class="card register-card">
            <div class="card-body p-5">
                <div class="text-center">
                    <h2 class="mb-4 text-primary fw-bold">Join NIET Nexus</h2>
                    <p class="text-muted mb-4">Create your account to connect with the network.</p>
                </div>
                
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getParameter("error") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/auth/register" method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
                                <label for="firstName">First Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
                                <label for="lastName">Last Name</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com" required>
                        <label for="floatingInput">Email address</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required>
                        <label for="floatingPassword">Password</label>
                    </div>

                    <div class="form-floating mb-4">
                        <select class="form-select" id="roleSelect" name="role" required>
                            <option value="STUDENT" selected>Student</option>
                            <option value="ALUMNI">Alumni</option>
                        </select>
                        <label for="roleSelect">I am registering as</label>
                    </div>

                    <button class="w-100 btn btn-lg btn-primary" type="submit">Create Account</button>
                    
                    <div class="text-center mt-4">
                        <p class="text-muted">Already have an account? <a href="${pageContext.request.contextPath}/auth/login" class="text-decoration-none fw-bold">Sign In</a></p>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
