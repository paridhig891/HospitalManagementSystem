<%-- 
    Document   : doctor
    Created on : 22-Oct-2025, 7:48:04 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Doctor Management - MediCare</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../mycss/doctor.css">
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
          <div class="brand-name">MediCare</div>
          <div class="brand-tagline">Hospital Management</div>
        </div>
      </div>
    </div>
    
  <nav class="nav-menu">
      <a href="dashboard.jsp" class="nav-item">Dashboard</a>
      <a href="patient.jsp" class="nav-item">Patients</a>
      <a href="doctor.jsp" class="nav-item active">Doctors</a>
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
      <h1>Doctor Management</h1>
      <button class="btn-primary" onclick="openAddDoctorModal()">+ Add New Doctor</button>
    </div>

    <!-- Search and Filter Section -->
    <div class="search-filter-section">
      <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search doctors by name, ID, or specialization..." onkeyup="searchDoctors()">
      </div>
      <div class="filter-buttons">
        <select class="filter-select">
          <option value="">All Departments</option>
          <option value="cardiology">Cardiology</option>
          <option value="neurology">Neurology</option>
          <option value="orthopedics">Orthopedics</option>
          <option value="pediatrics">Pediatrics</option>
          <option value="general">General Medicine</option>
        </select>
        <select class="filter-select">
          <option value="">All Specializations</option>
          <option value="cardiologist">Cardiologist</option>
          <option value="neurologist">Neurologist</option>
          <option value="orthopedic">Orthopedic Surgeon</option>
          <option value="pediatrician">Pediatrician</option>
        </select>
      </div>
    </div>

    <!-- Doctor Table -->
    <div class="table-container">
      <table class="doctors-table" id="doctorsTable">
        <thead>
          <tr>
            <th>Doctor ID</th>
            <th>Name</th>
            <th>Specialization</th>
            <th>Phone</th>
            <th>Department</th>
            <th>Salary</th>
            <th>Experience</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>#D001</td>
            <td>Dr. John Smith</td>
            <td>Cardiologist</td>
            <td>+1 234-567-8900</td>
            <td>Cardiology</td>
            <td>$12,000/month</td>
            <td>15 years</td>
            <td>
              <button class="btn-icon" onclick="viewDoctor(1)" title="View">👁️</button>
              <button class="btn-icon" onclick="editDoctor(1)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deleteDoctor(1)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#D002</td>
            <td>Dr. Sarah Williams</td>
            <td>Neurologist</td>
            <td>+1 234-567-8901</td>
            <td>Neurology</td>
            <td>$11,500/month</td>
            <td>12 years</td>
            <td>
              <button class="btn-icon" onclick="viewDoctor(2)" title="View">👁️</button>
              <button class="btn-icon" onclick="editDoctor(2)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deleteDoctor(2)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#D003</td>
            <td>Dr. Michael Brown</td>
            <td>Orthopedic Surgeon</td>
            <td>+1 234-567-8902</td>
            <td>Orthopedics</td>
            <td>$13,000/month</td>
            <td>18 years</td>
            <td>
              <button class="btn-icon" onclick="viewDoctor(3)" title="View">👁️</button>
              <button class="btn-icon" onclick="editDoctor(3)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deleteDoctor(3)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#D004</td>
            <td>Dr. Emily Davis</td>
            <td>Pediatrician</td>
            <td>+1 234-567-8903</td>
            <td>Pediatrics</td>
            <td>$10,500/month</td>
            <td>10 years</td>
            <td>
              <button class="btn-icon" onclick="viewDoctor(4)" title="View">👁️</button>
              <button class="btn-icon" onclick="editDoctor(4)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="deleteDoctor(4)" title="Delete">🗑️</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </main>
</div>

<!-- Add/Edit Doctor Modal -->
<div id="doctorModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="modalTitle">Add New Doctor</h2>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
    <form id="doctorForm" class="doctor-form">
      <div class="form-row">
        <div class="form-group">
          <label>Full Name *</label>
          <input type="text" name="name" required placeholder="Dr. John Doe">
        </div>
        <div class="form-group">
          <label>Specialization *</label>
          <select name="specialization" required>
            <option value="">Select Specialization</option>
            <option value="cardiologist">Cardiologist</option>
            <option value="neurologist">Neurologist</option>
            <option value="orthopedic">Orthopedic Surgeon</option>
            <option value="pediatrician">Pediatrician</option>
            <option value="general">General Physician</option>
            <option value="dermatologist">Dermatologist</option>
            <option value="ent">ENT Specialist</option>
          </select>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Phone Number *</label>
          <input type="tel" name="phone" required placeholder="+1 234-567-8900">
        </div>
        <div class="form-group">
          <label>Email *</label>
          <input type="email" name="email" required placeholder="doctor@medicare.com">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Department *</label>
          <select name="department" required>
            <option value="">Select Department</option>
            <option value="cardiology">Cardiology</option>
            <option value="neurology">Neurology</option>
            <option value="orthopedics">Orthopedics</option>
            <option value="pediatrics">Pediatrics</option>
            <option value="general">General Medicine</option>
            <option value="dermatology">Dermatology</option>
            <option value="ent">ENT</option>
          </select>
        </div>
        <div class="form-group">
          <label>Experience (Years) *</label>
          <input type="number" name="experience" required placeholder="5">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Salary (Monthly) *</label>
          <input type="number" name="salary" required placeholder="10000">
        </div>
        <div class="form-group">
          <label>Qualification *</label>
          <input type="text" name="qualification" required placeholder="MBBS, MD">
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group full-width">
          <label>Address</label>
          <textarea name="address" rows="3" placeholder="Enter full address"></textarea>
        </div>
      </div>
      
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn-primary">Save Doctor</button>
      </div>
    </form>
  </div>
</div>

<!-- Doctor Profile Modal -->
<div id="profileModal" class="modal">
  <div class="modal-content profile-modal">
    <div class="modal-header">
      <h2>Doctor Profile</h2>
      <span class="close" onclick="closeProfileModal()">&times;</span>
    </div>
    <div class="profile-content">
      <div class="profile-header">
        <div class="profile-avatar">
          <img src="https://i.pravatar.cc/150?img=33" alt="Doctor">
        </div>
        <div class="profile-title">
          <h3>Dr. John Smith</h3>
          <p class="specialization">Cardiologist</p>
          <span class="badge">Active</span>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Personal Information</h3>
        <div class="profile-grid">
          <div class="profile-item">
            <span class="label">Doctor ID:</span>
            <span class="value">#D001</span>
          </div>
          <div class="profile-item">
            <span class="label">Full Name:</span>
            <span class="value">Dr. John Smith</span>
          </div>
          <div class="profile-item">
            <span class="label">Phone:</span>
            <span class="value">+1 234-567-8900</span>
          </div>
          <div class="profile-item">
            <span class="label">Email:</span>
            <span class="value">john.smith@medicare.com</span>
          </div>
          <div class="profile-item">
            <span class="label">Qualification:</span>
            <span class="value">MBBS, MD (Cardiology)</span>
          </div>
          <div class="profile-item">
            <span class="label">Experience:</span>
            <span class="value">15 years</span>
          </div>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Professional Information</h3>
        <div class="profile-grid">
          <div class="profile-item">
            <span class="label">Specialization:</span>
            <span class="value">Cardiologist</span>
          </div>
          <div class="profile-item">
            <span class="label">Department:</span>
            <span class="value">Cardiology</span>
          </div>
          <div class="profile-item">
            <span class="label">Salary:</span>
            <span class="value">$12,000/month</span>
          </div>
          <div class="profile-item">
            <span class="label">Joined Date:</span>
            <span class="value">January 15, 2020</span>
          </div>
        </div>
      </div>
      
      <div class="profile-actions">
        <button class="btn-primary" onclick="editDoctor(1)">Edit Profile</button>
        <button class="btn-secondary" onclick="closeProfileModal()">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="../myjs/doctors.js"></script>
</body>
</html>
