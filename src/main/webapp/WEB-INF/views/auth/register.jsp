<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register - SerenityHub</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(
          135deg,
          #eff6ff 0%,
          #f3e8ff 50%,
          #ecfdf5 100%
        );
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        padding: 20px;
      }
      .register-container {
        background: white;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        max-width: 600px;
        width: 100%;
        padding: 40px;
      }
      .register-header {
        text-align: center;
        margin-bottom: 30px;
      }
      .register-header h2 {
        color: #667eea;
        font-weight: 700;
        margin-bottom: 10px;
      }
      .form-control {
        border-radius: 10px;
        padding: 12px 15px;
        border: 1px solid #ddd;
      }
      .form-control:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      }
      .btn-register {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        border-radius: 10px;
        padding: 12px;
        font-weight: 600;
        color: white;
        width: 100%;
        margin-top: 20px;
        transition: transform 0.2s;
      }
      .btn-register:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
      }
      .input-group-text {
        background: transparent;
        border-right: none;
        border-radius: 10px 0 0 10px;
      }
      .input-group .form-control {
        border-left: none;
      }
      .alert {
        border-radius: 10px;
      }
      .login-link {
        text-align: center;
        margin-top: 20px;
      }
    </style>
  </head>
  <body>
    <div class="register-container">
      <div class="register-header">
        <h2>Create Account</h2>
        <p class="text-muted">Join SerenityHub Community</p>
      </div>

      <c:if test="${not empty error}">
        <div
          class="alert alert-danger alert-dismissible fade show"
          role="alert"
        >
          <i class="fas fa-exclamation-circle me-2"></i>${error}
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="alert"
          ></button>
        </div>
      </c:if>

      <form
        action="${pageContext.request.contextPath}/register"
        method="post"
        id="registerForm"
      >
        <div class="mb-3">
          <label class="form-label"
            >Full Name <span class="text-danger">*</span></label
          >
          <div class="input-group">
            <input
              type="text"
              class="form-control"
              name="fullName"
              required
            />
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label"
            >Email Address <span class="text-danger">*</span></label
          >
          <div class="input-group">
            <input
              type="email"
              class="form-control"
              name="email"
              required
            />
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label">Matrics Number</label>
          <div class="input-group">
            <input
              type="text"
              class="form-control"
              name="studentNumber"
            />
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label">Phone Number</label>
          <div class="input-group">
            <input
              type="tel"
              class="form-control"
              name="phone"
            />
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label"
            >Password <span class="text-danger">*</span></label
          >
          <div class="input-group">
            <input
              type="password"
              class="form-control"
              name="password"
              id="password"
              required
              minlength="6"
            />
          </div>
        </div>

        <div class="mb-3">
          <label class="form-label"
            >Confirm Password <span class="text-danger">*</span></label
          >
          <div class="input-group">
            <input
              type="password"
              class="form-control"
              name="confirmPassword"
              id="confirmPassword"
              required
            />
          </div>
        </div>

        <div class="form-check mb-3">
          <input class="form-check-input" type="checkbox" id="terms" required />
          <label class="form-check-label" for="terms">
            I agree to the
            <a href="#" class="text-decoration-none">Terms & Conditions</a>
          </label>
        </div>

        <button type="submit" class="btn btn-register">
        Create Account
        </button>

        <div class="login-link">
          <p class="mb-0">
            Already have an account?
            <a
              href="${pageContext.request.contextPath}/login"
              class="fw-bold text-decoration-none"
              >Login here</a
            >
          </p>
        </div>
      </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Password validation
      document
        .getElementById("registerForm")
        .addEventListener("submit", function (e) {
          const password = document.getElementById("password").value;
          const confirmPassword =
            document.getElementById("confirmPassword").value;

          if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
            return false;
          }

          if (password.length < 6) {
            e.preventDefault();
            alert("Password must be at least 6 characters long!");
            return false;
          }
        });
    </script>
  </body>
</html>
