<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - SerenityHub</title>
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
        background: linear-gradient(135deg, #EFF6FF 0%, #F3E8FF 50%, #ECFDF5 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .login-container {
        background: white;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        overflow: hidden;
        max-width: 900px;
        width: 100%;
      }
      .login-image {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 60px 40px;
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
      }
      .login-image h2 {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 20px;
      }
      .login-image p {
        font-size: 1.1rem;
        opacity: 0.9;
      }
      .login-form {
        padding: 60px 40px;
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
      .btn-login {
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
      .btn-login:hover {
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
    </style>
  </head>
  <body>
    <div class="login-container">
      <div class="row g-0">
        <div class="col-lg-6 login-image d-none d-lg-flex">
          <div>
            <i class="fas fa-heart fa-4x mb-4"></i>
            <h2>SerenityHub</h2>
            <p>Your Mental Health Literacy Hub</p>
            <p class="mt-4">
              Promoting awareness, self-care, and access to mental health
              support for UTM students
            </p>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="login-form">
            <h3 class="mb-4 text-center fw-bold">Welcome Back</h3>

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

            <c:if test="${not empty success}">
              <div
                class="alert alert-success alert-dismissible fade show"
                role="alert"
              >
                <i class="fas fa-check-circle me-2"></i>${success}
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="alert"
                ></button>
              </div>
            </c:if>

            <form
              action="${pageContext.request.contextPath}/login"
              method="post"
            >
              <div class="mb-3">
                <label class="form-label">Email Address</label>
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
                <label class="form-label">Password</label>
                <div class="input-group">
                  <input
                    type="password"
                    class="form-control"
                    name="password"
                    id="password"
                    required
                  />
                </div>
              </div>

              <button type="submit" class="btn btn-login">
                Login
              </button>

              <div class="text-center mt-4">
                <p class="mb-0">
                  Don't have an account?
                  <a
                    href="${pageContext.request.contextPath}/register"
                    class="fw-bold text-decoration-none"
                    >Register here</a
                  >
                </p>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

  </body>
</html>
