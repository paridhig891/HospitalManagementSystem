<%@ page import="java.sql.*, javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patient Management - MediCare</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../mycss/patient.css">
</head>
<body>

<div class="dashboard">
  <!-- Sidebar (same as dashboard) -->
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
      <a href="patient.jsp" class="nav-item active">Patients</a>
      <a href="doctor.jsp" class="nav-item">Doctors</a>
      <a href="department.jsp" class="nav-item">Departments</a>
      <a href="appointment.jsp" class="nav-item">Appointments</a>
      <a href="room.jsp" class="nav-item">Rooms</a>
      <a href="staff.jsp" class="nav-item">Staff</a>
      <a href="bill.jsp" class="nav-item">Billing</a>
    </nav>
    
    <div class="sidebar-footer">
      © 2025 MediCare HMS
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <div class="page-header">
      <h1>Patient Management</h1>
      <button class="btn-primary" onclick="openAddPatientModal()">+ Add New Patient</button>
    </div>

    <!-- Search and Filter Section -->
    <div class="search-filter-section">
      <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search patients by name, ID, or phone..." onkeyup="searchPatients()">
      </div>
      <div class="filter-buttons">
        <select class="filter-select">
          <option value="">All Departments</option>
          <option value="cardiology">Cardiology</option>
          <option value="neurology">Neurology</option>
          <option value="orthopedics">Orthopedics</option>
          <option value="pediatrics">Pediatrics</option>
        </select>
        <select class="filter-select">
          <option value="">All Blood Groups</option>
          <option value="A+">A+</option>
          <option value="A-">A-</option>
          <option value="B+">B+</option>
          <option value="B-">B-</option>
          <option value="O+">O+</option>
          <option value="O-">O-</option>
          <option value="AB+">AB+</option>
          <option value="AB-">AB-</option>
        </select>
      </div>
    </div>

    <!-- Patient Table -->
    <div class="table-container">
      <table class="patients-table" id="patientsTable">
        <thead>
          <tr>
            <th>Patient ID</th>
            <th>Name</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Phone</th>
            <th>Blood Group</th>
            <th>Admission Date</th>
            <th>Status<th>
            <th>Actions</th>
          </tr>
        </thead>
       <tbody>
<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
        st = con.createStatement();

        // Fetch patients data (join with department if needed)
        String query =  "SELECT p.patient_id, p.full_name, p.age, p.gender, p.contact, p.blood_group, " +
            " p.status, p.created_at " +
            "FROM patients p " +
            "ORDER BY p.created_at DESC";
        rs = st.executeQuery(query);

        while (rs.next()) {
%>
  <tr>
    <td><%= rs.getString("patient_id") %></td>
    <td><%= rs.getString("full_name") %></td>
    <td><%= rs.getInt("age") %></td>
    <td><%= rs.getString("gender") %></td>
    <td><%= rs.getString("contact") %></td>
    <td><%= rs.getString("blood_group") %></td>
    <td><%= rs.getTimestamp("created_at") %></td>
    <td><%= rs.getString("status") != null ? rs.getString("status") : "-" %></td>
    <td>
      <button class="btn-icon" title="View">👁️</button>
      <button class="btn-icon" title="Edit">✏️</button>

      <a href="<%= request.getContextPath() %>/DeletePatient?patient_id=<%= rs.getInt("patient_id")%>" 
   onclick="return confirm('Are you sure you want to delete this patient?');" 
   class="btn-icon delete" 
   title="Delete">🗑️</a>
    </td>
  </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='10'>Error loading patients: " + e.getMessage() + "</td></tr>");
    } finally {
        if (rs != null) rs.close();
        if (st != null) st.close();
        if (con != null) con.close();
    }
%>
</tbody>

      </table>
    </div>
  </main>
</div>

<!-- Patient Type Selection Modal -->
<div id="patientTypeModal" class="modal">
  <div class="modal-content type-modal">
    <h2>Select Patient Type</h2>
    <div class="type-options">
      <button class="btn-primary" onclick="selectPatientType('outpatient')">Outpatient</button>
      <button class="btn-primary" onclick="selectPatientType('inpatient')">Inpatient</button>
    </div>
    <button class="close-btn" onclick="closeTypeModal()">Cancel</button>
  </div>
</div>

<%
    Connection con1 = null;
    con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
    Statement sp = con1.createStatement();
    ResultSet rq = sp.executeQuery("SELECT docId, docName FROM doctor");
%>

<!-- Outpatient Modal -->
<div id="outpatientModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2>Add Outpatient</h2>
      <span class="close" onclick="closeModal('outpatientModal')">&times;</span>
    </div>
    <form id="outpatientForm" method="post" action="${pageContext.request.contextPath}/AddPatient">
      <!-- All the fields from your previous form -->
      <input type="hidden" name="patient_type" value="Outpatient">
     <div class="form-row">
    <div class="form-group">
      <label>Patient Name</label>
      <input type="text" name="name" required>
    </div>
    <div class="form-group">
      <label>Age</label>
      <input type="number" name="age" required>
    </div>
  </div>

  <div class="form-row">
    <div class="form-group">
      <label>Gender</label>
      <select name="gender" required>
        <option value="">Select</option>
        <option>Male</option>
        <option>Female</option>
        <option>Other</option>
      </select>
    </div>
    <div class="form-group">
      <label>Phone</label>
      <input type="text" name="phone" required>
    </div>
  </div>

  <div class="form-row">
    <div class="form-group">
      <label>Blood Group</label>
      <select name="blood_group">
        <option value="">Select</option>
        <option>A+</option>
        <option>A-</option>
        <option>B+</option>
        <option>B-</option>
        <option>O+</option>
        <option>O-</option>
        <option>AB+</option>
        <option>AB-</option>
      </select>
    </div>
    <div class="form-group">
      <label>Address</label>
      <input type="text" name="address">
    </div>
  </div>
      <!-- Remove admission/discharge/room/doctor fields -->
      <input type="hidden" name="patient_type" value="outpatient">
      <!-- same form fields here -->
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal('outpatientModal')">Cancel</button>
        <button type="submit" class="btn-primary">Save Outpatient</button>
      </div>
    </form>
  </div>
</div>

<!-- Inpatient Modal (Step 1: Common details) -->
<div id="inpatientModalStep1" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2>Add Inpatient - Basic Details</h2>
      <span class="close" onclick="closeModal('inpatientModalStep1')">&times;</span>
    </div>
      <form id="inpatientFormStep1" method="post" action="${pageContext.request.contextPath}/AddInpatient">
      <!-- Same patient form fields (without admission/room/doctor) -->
      <input type="hidden" name="patient_type" value="inpatient">
           <div class="form-row">
    <div class="form-group">
      <label>Patient Name</label>
      <input type="text" name="name" required>
    </div>
    <div class="form-group">
      <label>Age</label>
      <input type="number" name="age" required>
    </div>
  </div>

  <div class="form-row">
    <div class="form-group">
      <label>Gender</label>
      <select name="gender" required>
        <option value="">Select</option>
        <option>Male</option>
        <option>Female</option>
        <option>Other</option>
      </select>
    </div>
    <div class="form-group">
      <label>Phone</label>
      <input type="text" name="phone" required>
    </div>
  </div>

  <div class="form-row">
    <div class="form-group">
      <label>Blood Group</label>
      <select name="blood_group">
        <option value="">Select</option>
        <option>A+</option>
        <option>A-</option>
        <option>B+</option>
        <option>B-</option>
        <option>O+</option>
        <option>O-</option>
        <option>AB+</option>
        <option>AB-</option>
      </select>
    </div>
    <div class="form-group">
      <label>Address</label>
      <input type="text" name="address">
    </div>
  </div>
      <input type="hidden" name="patient_type" value="inpatient">
      <input type="hidden" name="patient_id" id="patient_id_hidden">
      <div class="form-row">
        <div class="form-group">
          <label>Department</label>
          <select name="department">
            <option value="">Select Department</option>
            <option value="DE101">Cardiology</option>
            <option value="DE102">Neurology</option>
            <option value="DE103">Orthopedics</option>
            <option value="DE104">Pediatrics</option>
          </select>
        </div>
      <div class="form-group">
  <label>Assigned Doctor</label>
  <select name="docId" required>
    <option value="">-- Select Doctor --</option>
    <%
        while(rq.next()) {
    %>
        <option value="<%= rq.getString("docId") %>">
            <%= rq.getString("docName") %>
        </option>
    <%
        }
    %>
  </select>
</div>

      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Room Number</label>
          <input type="text" name="room">
        </div>
        <div class="form-group">
          <label>Admission Date</label>
          <input type="date" name="admission_date">
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Discharge Date</label>
          <input type="date" name="discharge_date">
        </div>
      </div>
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal('inpatientModalStep2')">Cancel</button>
        <button type="submit" class="btn-primary">Save Inpatient</button>
      </div>
    </form>
  </div>
</div>

      
<!-- Inpatient Modal (Step 2: Extra details) -->
<div id="inpatientModalStep2" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2>Inpatient - Additional Details</h2>
      <span class="close" onclick="closeModal('inpatientModalStep2')">&times;</span>
    </div>
    <form id="inpatientFormStep2" method="post" action="${pageContext.request.contextPath}/AddInpatient">
      
    </form>
  </div>
</div>


<!-- Patient Profile Modal -->
<div id="profileModal" class="modal">
  <div class="modal-content profile-modal">
    <div class="modal-header">
      <h2>Patient Profile</h2>
      <span class="close" onclick="closeProfileModal()">&times;</span>
    </div>
    <div class="profile-content">
      <div class="profile-section">
        <h3>Personal Information</h3>
        <div class="profile-grid">
          <div class="profile-item">
            <span class="label">Patient ID:</span>
            <span class="value">#P001</span>
          </div>
          <div class="profile-item">
            <span class="label">Full Name:</span>
            <span class="value">John Doe</span>
          </div>
          <div class="profile-item">
            <span class="label">Age:</span>
            <span class="value">45 years</span>
          </div>
          <div class="profile-item">
            <span class="label">Gender:</span>
            <span class="value">Male</span>
          </div>
          <div class="profile-item">
            <span class="label">Phone:</span>
            <span class="value">+1 234-567-8900</span>
          </div>
          <div class="profile-item">
            <span class="label">Blood Group:</span>
            <span class="value">O+</span>
          </div>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Medical Information</h3>
        <div class="profile-grid">
          <div class="profile-item">
            <span class="label">Department:</span>
            <span class="value">Cardiology</span>
          </div>
          <div class="profile-item">
            <span class="label">Assigned Doctor:</span>
            <span class="value">Dr. John Smith</span>
          </div>
          <div class="profile-item">
            <span class="label">Room Number:</span>
            <span class="value">101</span>
          </div>
          <div class="profile-item">
            <span class="label">Admission Date:</span>
            <span class="value">October 15, 2025</span>
          </div>
          <div class="profile-item">
            <span class="label">Discharge Date:</span>
            <span class="value">Not Yet Discharged</span>
          </div>
        </div>
      </div>
      
      <div class="profile-actions">
        <button class="btn-primary" onclick="editPatient(1)">Edit Profile</button>
        <button class="btn-secondary" onclick="closeProfileModal()">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="../myjs/patient.js"></script>
</body>
</html>
