<%-- 
    Document   : patient
    Created on : 22-Oct-2025, 7:47:22 pm
    Author     : LENOVO
--%>

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
          <div class="brand-name">MediCare</div>
          <div class="brand-tagline">Hospital Management</div>
        </div>
      </div>
    </div>
    
    <nav class="nav-menu">
      <a href="dashboard.html" class="nav-item">Dashboard</a>
      <a href="patients.html" class="nav-item active">Patients</a>
      <a href="#" class="nav-item">Doctors</a>
      <a href="#" class="nav-item">Departments</a>
      <a href="#" class="nav-item">Appointments</a>
      <a href="#" class="nav-item">Rooms</a>
      <a href="#" class="nav-item">Staff</a>
      <a href="#" class="nav-item">Billing</a>
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
            <th>Department</th>
            <th>Room</th>
            <th>Admission Date</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>#P001</td>
            <td>John Doe</td>
            <td>45</td>
            <td>Male</td>
            <td>+1 234-567-8900</td>
            <td>O+</td>
            <td>Cardiology</td>
            <td>101</td>
            <td>2025-10-15</td>
            <td>
              <button class="btn-icon" onclick="viewPatient(1)" title="View">👁️</button>
              <button class="btn-icon" onclick="editPatient(1)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deletePatient(1)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#P002</td>
            <td>Jane Smith</td>
            <td>32</td>
            <td>Female</td>
            <td>+1 234-567-8901</td>
            <td>A+</td>
            <td>Neurology</td>
            <td>205</td>
            <td>2025-10-18</td>
            <td>
              <button class="btn-icon" onclick="viewPatient(2)" title="View">👁️</button>
              <button class="btn-icon" onclick="editPatient(2)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deletePatient(2)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#P003</td>
            <td>Robert Brown</td>
            <td>28</td>
            <td>Male</td>
            <td>+1 234-567-8902</td>
            <td>B+</td>
            <td>Orthopedics</td>
            <td>310</td>
            <td>2025-10-20</td>
            <td>
              <button class="btn-icon" onclick="viewPatient(3)" title="View">👁️</button>
              <button class="btn-icon" onclick="editPatient(3)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deletePatient(3)" title="Delete">🗑️</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </main>
</div>

<!-- Add/Edit Patient Modal -->
<div id="patientModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="modalTitle">Add New Patient</h2>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
    <form id="patientForm" class="patient-form">
      <div class="form-row">
        <div class="form-group">
          <label>Full Name *</label>
          <input type="text" name="name" required placeholder="Enter patient name">
        </div>
        <div class="form-group">
          <label>Age *</label>
          <input type="number" name="age" required placeholder="Age">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Gender *</label>
          <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
          </select>
        </div>
        <div class="form-group">
          <label>Phone Number *</label>
          <input type="tel" name="phone" required placeholder="+1 234-567-8900">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Blood Group *</label>
          <select name="bloodGroup" required>
            <option value="">Select Blood Group</option>
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
        <div class="form-group">
          <label>Department *</label>
          <select name="department" required>
            <option value="">Select Department</option>
            <option value="cardiology">Cardiology</option>
            <option value="neurology">Neurology</option>
            <option value="orthopedics">Orthopedics</option>
            <option value="pediatrics">Pediatrics</option>
            <option value="general">General Medicine</option>
          </select>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Assigned Doctor *</label>
          <select name="doctor" required>
            <option value="">Select Doctor</option>
            <option value="dr-smith">Dr. John Smith</option>
            <option value="dr-williams">Dr. Sarah Williams</option>
            <option value="dr-brown">Dr. Michael Brown</option>
          </select>
        </div>
        <div class="form-group">
          <label>Assigned Room *</label>
          <input type="text" name="room" required placeholder="Room Number">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Admission Date *</label>
          <input type="date" name="admissionDate" required>
        </div>
        <div class="form-group">
          <label>Discharge Date</label>
          <input type="date" name="dischargeDate">
        </div>
      </div>
      
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn-primary">Save Patient</button>
      </div>
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

<script src="patients.js"></script>
</body>
</html>
