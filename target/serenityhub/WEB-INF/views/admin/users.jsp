<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management - SerenityHub</title>
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
        background: #f5f7fa;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      }
      .sidebar {
        min-height: 100vh;
        background: linear-gradient(180deg, #1e3a8a 0%, #1e40af 100%);
        padding: 0;
        position: fixed;
        width: 250px;
      }
      .sidebar .nav-link {
        color: rgba(255, 255, 255, 0.8);
        padding: 15px 25px;
        border-left: 3px solid transparent;
        transition: all 0.3s;
      }
      .sidebar .nav-link:hover,
      .sidebar .nav-link.active {
        color: white;
        background: rgba(255, 255, 255, 0.1);
        border-left-color: white;
      }
      .sidebar .nav-link i {
        margin-right: 10px;
        width: 20px;
      }
      .main-content {
        margin-left: 250px;
        padding: 20px;
      }
      .navbar {
        background: white;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
        border-radius: 10px;
      }
      .content-card {
        background: white;
        border-radius: 15px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      }
      .filter-tabs {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
        flex-wrap: wrap;
      }
      .filter-tab {
        padding: 8px 20px;
        border-radius: 20px;
        border: 2px solid #e5e7eb;
        background: white;
        cursor: pointer;
        transition: all 0.3s;
        text-decoration: none;
        color: #4b5563;
      }
      .filter-tab:hover,
      .filter-tab.active {
        background: #1e40af;
        color: white;
        border-color: #1e40af;
      }
      .user-table {
        width: 100%;
      }
      .user-table th {
        background: #f8fafc;
        padding: 15px;
        font-weight: 600;
        color: #475569;
        border-bottom: 2px solid #e5e7eb;
      }
      .user-table td {
        padding: 15px;
        border-bottom: 1px solid #e5e7eb;
      }
      .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        margin-right: 10px;
      }
      .badge-status {
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
      }
      .badge-active {
        background: #d1fae5;
        color: #065f46;
      }
      .badge-inactive {
        background: #fee2e2;
        color: #991b1b;
      }
      .badge-student {
        background: #dbeafe;
        color: #1e40af;
      }
      .badge-counselor {
        background: #dcfce7;
        color: #15803d;
      }
      .badge-admin {
        background: #fef3c7;
        color: #92400e;
      }
      .btn-action {
        padding: 5px 10px;
        margin: 0 2px;
        border-radius: 5px;
        font-size: 13px;
      }
      .brand-section {
        padding: 30px 25px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }
      .brand-logo {
        font-size: 32px;
        color: white;
        margin-bottom: 5px;
      }
      .brand-text {
        color: white;
        font-size: 18px;
        font-weight: 600;
        margin: 0;
      }
      .search-box {
        max-width: 400px;
      }
    </style>
  </head>
  <body>
    <!-- Sidebar -->
    <div class="sidebar">
      <div class="brand-section">
        <div class="brand-logo">
          <i class="fas fa-shield-alt"></i>
        </div>
        <p class="brand-text">Admin Panel</p>
      </div>
      <nav class="nav flex-column mt-4">
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/dashboard"
        >
          <i class="fas fa-home"></i> Dashboard
        </a>
        <a
          class="nav-link active"
          href="${pageContext.request.contextPath}/admin/users"
        >
          <i class="fas fa-users"></i> User Management
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/modules"
        >
          <i class="fas fa-book"></i> Learning Modules
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/forum"
        >
          <i class="fas fa-comments"></i> Forum Management
        </a>
        <a
          class="nav-link"
          href="${pageContext.request.contextPath}/admin/reports"
        >
          <i class="fas fa-chart-bar"></i> Reports
        </a>
        <hr style="border-color: rgba(255, 255, 255, 0.1); margin: 20px 25px" />
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
      <!-- Top Navbar -->
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
          <h4 class="mb-0"><i class="fas fa-users me-2"></i>User Management</h4>
          <a
            href="${pageContext.request.contextPath}/admin/user/create"
            class="btn btn-primary"
          >
            <i class="fas fa-plus me-2"></i>Add User
          </a>
        </div>
      </nav>

      <!-- Alerts -->
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

      <!-- Content Card -->
      <div class="content-card">
        <!-- Filter Tabs -->
        <div class="filter-tabs">
          <a
            href="${pageContext.request.contextPath}/admin/users"
            class="filter-tab ${empty filterType ? 'active' : ''}"
          >
            <i class="fas fa-users me-2"></i>All Users
          </a>
          <a
            href="${pageContext.request.contextPath}/admin/users?type=student"
            class="filter-tab ${filterType == 'student' ? 'active' : ''}"
          >
            <i class="fas fa-user-graduate me-2"></i>Students
          </a>
          <a
            href="${pageContext.request.contextPath}/admin/users?type=counselor"
            class="filter-tab ${filterType == 'counselor' ? 'active' : ''}"
          >
            <i class="fas fa-user-tie me-2"></i>Counselors
          </a>
          <a
            href="${pageContext.request.contextPath}/admin/users?type=admin"
            class="filter-tab ${filterType == 'admin' ? 'active' : ''}"
          >
            <i class="fas fa-user-shield me-2"></i>Admins
          </a>
        </div>

        <!-- Search Bar -->
        <div class="mb-4">
          <div class="input-group search-box">
            <span class="input-group-text bg-transparent">
              <i class="fas fa-search text-muted"></i>
            </span>
            <input
              type="text"
              class="form-control"
              placeholder="Search users..."
              id="searchInput"
              onkeyup="searchTable()"
            />
          </div>
        </div>

        <!-- Users Table -->
        <div class="table-responsive">
          <table class="user-table" id="usersTable">
            <thead>
              <tr>
                <th>User</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Joined</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty users}">
                  <tr>
                    <td colspan="6" class="text-center text-muted py-4">
                      No users found
                    </td>
                  </tr>
                </c:when>
                <c:otherwise>
                  <c:forEach items="${users}" var="user">
                    <tr>
                      <td>
                        <div class="d-flex align-items-center">
                          <div class="user-avatar">
                            ${user.fullName.substring(0,1).toUpperCase()}
                          </div>
                          <div>
                            <strong>${user.fullName}</strong>
                          </div>
                        </div>
                      </td>
                      <td>${user.email}</td>
                      <td>
                        <span
                          class="badge-status badge-${user.userType.toString().toLowerCase()}"
                        >
                          ${user.userType}
                        </span>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${user.active}">
                            <span class="badge-status badge-active">
                              <i class="fas fa-check-circle me-1"></i>Active
                            </span>
                          </c:when>
                          <c:otherwise>
                            <span class="badge-status badge-inactive">
                              <i class="fas fa-times-circle me-1"></i>Inactive
                            </span>
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <fmt:formatDate
                          value="${user.createdAt}"
                          pattern="MMM dd, yyyy"
                        />
                      </td>
                      <td>
                        <a
                          href="${pageContext.request.contextPath}/admin/user/${user.userId}"
                          class="btn btn-sm btn-info btn-action"
                          title="View"
                        >
                          <i class="fas fa-eye"></i>
                        </a>
                        <a
                          href="${pageContext.request.contextPath}/admin/user/${user.userId}/edit"
                          class="btn btn-sm btn-warning btn-action"
                          title="Edit"
                        >
                          <i class="fas fa-edit"></i>
                        </a>
                        <c:choose>
                          <c:when test="${user.active}">
                            <form
                              action="${pageContext.request.contextPath}/admin/user/${user.userId}/deactivate"
                              method="post"
                              style="display: inline"
                            >
                              <button
                                type="submit"
                                class="btn btn-sm btn-secondary btn-action"
                                title="Deactivate"
                                onclick="return confirm('Deactivate this user?')"
                              >
                                <i class="fas fa-ban"></i>
                              </button>
                            </form>
                          </c:when>
                          <c:otherwise>
                            <form
                              action="${pageContext.request.contextPath}/admin/user/${user.userId}/activate"
                              method="post"
                              style="display: inline"
                            >
                              <button
                                type="submit"
                                class="btn btn-sm btn-success btn-action"
                                title="Activate"
                                onclick="return confirm('Activate this user?')"
                              >
                                <i class="fas fa-check"></i>
                              </button>
                            </form>
                          </c:otherwise>
                        </c:choose>
                        <form
                          action="${pageContext.request.contextPath}/admin/user/${user.userId}/delete"
                          method="post"
                          style="display: inline"
                        >
                          <button
                            type="submit"
                            class="btn btn-sm btn-danger btn-action"
                            title="Delete"
                            onclick="return confirm('Are you sure you want to delete this user? This action cannot be undone.')"
                          >
                            <i class="fas fa-trash"></i>
                          </button>
                        </form>
                      </td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function searchTable() {
        const input = document.getElementById("searchInput");
        const filter = input.value.toUpperCase();
        const table = document.getElementById("usersTable");
        const tr = table.getElementsByTagName("tr");

        for (let i = 1; i < tr.length; i++) {
          const td = tr[i].getElementsByTagName("td");
          let found = false;

          for (let j = 0; j < td.length; j++) {
            if (td[j]) {
              const txtValue = td[j].textContent || td[j].innerText;
              if (txtValue.toUpperCase().indexOf(filter) > -1) {
                found = true;
                break;
              }
            }
          }

          tr[i].style.display = found ? "" : "none";
        }
      }
    </script>
  </body>
</html>
