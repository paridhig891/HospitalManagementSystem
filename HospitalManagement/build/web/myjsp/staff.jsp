<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*, javax.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Staff Management - MediCare</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../mycss/staff.css">
</head>
<body>

<div class="dashboard">
  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="sidebar-header">
      <div class="logo">
        <svg viewBox="0 0 32 24" width="24" height="24">
          <polyline points="2,13 9,13 13,23 21,1 23,13 31,13" stroke="#fff" stroke-width="2" fill="none" />
        </svg>
        <div>
          <div class="brand-name">ADMIN</div>
          <div class="brand-tagline">Hospital Management</div>
        </div>
      </div>
    </div>
    
    <nav class="nav-menu">
      <a href="dashboard.jsp" class="nav-item">Dashboard</a>
      <a href="patient.jsp" class="nav-item">Patients</a>
      <a href="doctor.jsp" class="nav-item">Doctors</a>
      <a href="department.jsp" class="nav-item">Departments</a>
      <a href="appointment.jsp" class="nav-item">Appointments</a>
      <a href="room.jsp" class="nav-item">Rooms</a>
      <a href="staff.jsp" class="nav-item active">Staff</a>
      <a href="bill.jsp" class="nav-item">Billing</a>
    </nav>
    
    <div class="sidebar-footer">
      © 2025 MediCare HMS
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <div class="page-header">
      <h1>Staff Management</h1>
      <button class="btn-primary" onclick="openAddStaffModal()">+ Add New Staff</button>
    </div>

    <!-- Stats Cards -->
    <div class="staff-stats">
      <div class="stat-card">
        <div class="stat-info">
          <h3>Total Staff</h3>
          <div class="stat-value">156</div>
          <div class="stat-detail">Active employees</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Nurses</h3>
          <div class="stat-value">64</div>
          <div class="stat-detail">Nursing staff</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Support Staff</h3>
          <div class="stat-value">92</div>
          <div class="stat-detail">Administrative & support</div>
        </div>
      </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="search-filter-section">
      <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search staff by name, ID, or role..." onkeyup="searchStaff()">
      </div>
      <div class="filter-buttons">
        <select class="filter-select">
          <option value="">All Roles</option>
          <option value="nurse">Nurse</option>
          <option value="receptionist">Receptionist</option>
          <option value="technician">Lab Technician</option>
          <option value="pharmacist">Pharmacist</option>
          <option value="admin">Administrative</option>
          <option value="security">Security</option>
          <option value="housekeeping">Housekeeping</option>
        </select>
        <select class="filter-select">
          <option value="">All Departments</option>
          <option value="cardiology">Cardiology</option>
          <option value="neurology">Neurology</option>
          <option value="orthopedics">Orthopedics</option>
          <option value="pediatrics">Pediatrics</option>
          <option value="general">General</option>
          <option value="emergency">Emergency</option>
        </select>
      </div>
    </div>

    <!-- Staff Table -->
    <div class="table-container">
      <table class="staff-table" id="staffTable">
        <thead>
          <tr>
            <th>Staff ID</th>
            <th>Name</th>
            <th>Role</th>
            <th>Phone</th>
            <th>Department</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
         <%
      // Database connection setup
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
String query = "SELECT s.staff_id, s.name, s.role, s.phone, d.depName FROM staff s LEFT JOIN department d ON s.department = d.depId";
      PreparedStatement st = con.prepareStatement(query);
      
      ResultSet rs = st.executeQuery();

      while (rs.next()) {
    %>
        <tr>
          <td><%= rs.getInt("staff_id") %></td>
          <td><%= rs.getString("name") %></td>
          <td><%= rs.getString("role") %></td>
          <td><%= rs.getString("phone") %></td>
          <td><%= (rs.getString("depName") != null ? rs.getString("depName") : "—") %></td>
          
          <td>
            <button class="btn-icon" onclick="viewStaff(<%= rs.getInt("staff_id") %>)" title="View">👁️</button>
            <button class="btn-icon" onclick="editStaff(<%= rs.getInt("staff_id") %>)" title="Edit">✏️</button>
            <button class="btn-icon delete" onclick="deleteStaff(<%= rs.getInt("staff_id") %>)" title="Delete">🗑️</button>
          </td>
        </tr>
    <%
      }
      con.close();
    %>
         
        </tbody>
      </table>
    </div>
  </main>
</div>

<!-- Add/Edit Staff Modal -->
<div id="staffModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="modalTitle">Add New Staff</h2>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
      <form id="staffForm" class="staff-form" action="${pageContext.request.contextPath}/SaveStaff" method="post">
      
      <div class="form-row">
        <div class="form-group">
          <label>Full Name *</label>
          <input type="text" name="name" required placeholder="Enter staff name">
        </div>
        <div class="form-group">
          <label>Role *</label>
          <select name="role" required>
            <option value="">Select Role</option>
            <option value="nurse">Nurse</option>
            <option value="receptionist">Receptionist</option>
            <option value="lab-tech">Lab Technician</option>
            <option value="pharmacist">Pharmacist</option>
            <option value="radiologist">Radiologist</option>
            <option value="admin">Administrative Staff</option>
            <option value="security">Security Guard</option>
            <option value="housekeeping">Housekeeping</option>
            <option value="IT">IT Support</option>
          </select>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Phone Number *</label>
          <input type="tel" name="phone" required placeholder="+1 234-567-8900">
        </div>
        <div class="form-group">
          <label>Gender *</label>
          <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
          </select>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Age *</label>
          <input type="number" name="age" required min="18" max="70" placeholder="Enter age">
        </div>
        <div class="form-group">
          <label>Department</label>
          <select name="department">
            <option value="">Select Department (Optional)</option>
            <option value="DE101">Cardiology</option>
            <option value="DE102">Neurology</option>
            <option value="DE103">Orthopedics</option>
            <option value="DE104">Pediatrics</option>
            <option value="">General Medicine</option>
            <option value="107">Emergency</option>
            <option value="">Laboratory</option>
            <option value="">Pharmacy</option>
            <option value="DE105">Radiology</option>
            <option value="DE106">Administration</option>
          </select>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Date of Joining *</label>
          <input type="date" name="joiningDate" required>
        </div>
        <div class="form-group">
          <label>Shift Timing *</label>
          <select name="shift" required>
            <option value="">Select Shift</option>
            <option value="morning">Morning (6 AM - 2 PM)</option>
            <option value="afternoon">Afternoon (2 PM - 10 PM)</option>
            <option value="night">Night (10 PM - 6 AM)</option>
            <option value="rotational">Rotational</option>
          </select>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Salary (Monthly) *</label>
          <input type="number" name="salary" required placeholder="5000">
        </div>
        <div class="form-group full-width">
          <label>Address</label>
          <textarea name="address" rows="3" placeholder="Enter full address"></textarea>
        </div>
      </div>
      
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn-primary">Save Staff</button>
      </div>
    </form>
  </div>
</div>


<!-- Staff Profile Modal -->
<div id="profileModal" class="modal">
  <div class="modal-content profile-modal">
    <div class="modal-header">
      <h2>Staff Profile</h2>
      <span class="close" onclick="closeProfileModal()">&times;</span>
    </div>
    <div class="profile-content">
      <div class="profile-header">
        <div class="profile-avatar">
          <img src="https://i.pravatar.cc/150?img=44" alt="Staff">
        </div>
        <div class="profile-title">
          <h3>Sarah Johnson</h3>
          <p class="designation">Nurse</p>
          <span class="badge active">Active</span>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Personal Information</h3>
        <div class="profile-grid">
          <div class="profile-item">
            <span class="label">Staff ID:</span>
            <span class="value">#S001</span>
          </div>
          <div class="profile-item">
            <span class="label">Full Name:</span>
            <span class="value">Sarah Johnson</span>
          </div>
          <div class="profile-item">
            <span class="label">Phone:</span>
            <span class="value">+1 234-567-8900</span>
          </div>
          <div class="profile-item">
            <span class="label">Email:</span>
            <span class="value">sarah.j@medicare.com</span>
          </div>
          <div class="profile-item">
            <span class="label">Date of Joining:</span>
            <span class="value">January 15, 2023</span>
          </div>
          <div class="profile-item">
            <span class="label">Address:</span>
            <span class="value">123 Main Street, Health City</span>
          </div>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Professional Information</h3>
        <div class="profile-grid">
          <div class="profile-item">
            <span class="label">Role:</span>
            <span class="value">Nurse</span>
          </div>
          <div class="profile-item">
            <span class="label">Department:</span>
            <span class="value">Cardiology</span>
          </div>
          <div class="profile-item">
            <span class="label">Shift Timing:</span>
            <span class="value">Morning (6 AM - 2 PM)</span>
          </div>
          <div class="profile-item">
            <span class="label">Salary:</span>
            <span class="value">$5,500/month</span>
          </div>
        </div>
      </div>
      
      <div class="profile-actions">
        <button class="btn-primary" onclick="editStaff(1)">Edit Profile</button>
        <button class="btn-secondary" onclick="closeProfileModal()">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="../myjs/staff.js"></script>
</body>
</html>
