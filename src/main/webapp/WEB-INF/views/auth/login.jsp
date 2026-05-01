<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - NIET Alumni Nexus</title>
    <!-- Bootstrap 5 Pulse Theme from Bootswatch -->
    <link href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/pulse/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .login-card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    </style>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary min-vh-100">
    <main class="form-signin w-100 m-auto" style="max-width: 400px;">
        <div class="card login-card">
            <div class="card-body p-5 text-center">
                <h2 class="mb-4 text-primary fw-bold">NIET Nexus</h2>
                <p class="text-muted mb-4">Welcome back! Please login to your account.</p>
                
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getParameter("error") %>
                    </div>
                <% } %>
                
                <% if(request.getParameter("msg") != null) { %>
                    <div class="alert alert-success" role="alert">
                        <%= request.getParameter("msg") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/auth/login" method="POST">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com" required>
                        <label for="floatingInput">Email address</label>
                    </div>
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required>
                        <label for="floatingPassword">Password</label>
                    </div>

                    <button class="btn btn-primary w-100 py-2 mb-3" type="submit">Sign in</button>
                    
                    <div class="mt-3">
                        <p class="mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/auth/register" class="text-primary fw-bold">Register</a></p>
                    </div>
                </form>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
