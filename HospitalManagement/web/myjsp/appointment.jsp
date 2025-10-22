<%-- 
    Document   : appointment
    Created on : 22-Oct-2025, 7:48:32 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Appointment Management - MediCare</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../mycss/appointment.css">
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
      <a href="dashboard.html" class="nav-item">Dashboard</a>
      <a href="patients.html" class="nav-item">Patients</a>
      <a href="doctors.html" class="nav-item">Doctors</a>
      <a href="#" class="nav-item">Departments</a>
      <a href="appointments.html" class="nav-item active">Appointments</a>
      <a href="#" class="nav-item">Rooms</a>
      <a href="staff.html" class="nav-item">Staff</a>
      <a href="billing.html" class="nav-item">Billing</a>
    </nav>
    
    <div class="sidebar-footer">
      © 2025 MediCare HMS
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <div class="page-header">
      <h1>Appointment Management</h1>
      <button class="btn-primary" onclick="openBookAppointmentModal()">+ Book New Appointment</button>
    </div>

    <!-- Stats Cards -->
    <div class="appointment-stats">
      <div class="stat-card">
        <div class="stat-info">
          <h3>Today's Appointments</h3>
          <div class="stat-value">28</div>
          <div class="stat-detail">Scheduled for today</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Pending Appointments</h3>
          <div class="stat-value">12</div>
          <div class="stat-detail">Awaiting confirmation</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Completed Today</h3>
          <div class="stat-value">16</div>
          <div class="stat-detail">Successfully completed</div>
        </div>
      </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="search-filter-section">
      <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search by patient name, doctor, or appointment ID..." onkeyup="searchAppointments()">
      </div>
      <div class="filter-buttons">
        <select class="filter-select" onchange="filterByStatus(this.value)">
          <option value="">All Status</option>
          <option value="scheduled">Scheduled</option>
          <option value="completed">Completed</option>
          <option value="cancelled">Cancelled</option>
          <option value="pending">Pending</option>
        </select>
        <select class="filter-select">
          <option value="">All Departments</option>
          <option value="cardiology">Cardiology</option>
          <option value="neurology">Neurology</option>
          <option value="orthopedics">Orthopedics</option>
          <option value="pediatrics">Pediatrics</option>
          <option value="general">General Medicine</option>
        </select>
        <input type="date" class="filter-date" placeholder="Filter by date">
      </div>
    </div>

    <!-- Appointments Table -->
    <div class="table-container">
      <table class="appointments-table" id="appointmentsTable">
        <thead>
          <tr>
            <th>Appointment ID</th>
            <th>Patient Name</th>
            <th>Doctor</th>
            <th>Department</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>#APT001</td>
            <td>John Doe</td>
            <td>Dr. John Smith</td>
            <td>Cardiology</td>
            <td>2025-10-23</td>
            <td>10:00 AM</td>
            <td><span class="status-badge scheduled">Scheduled</span></td>
            <td>
              <button class="btn-icon" onclick="viewAppointment(1)" title="View">👁️</button>
              <button class="btn-icon" onclick="editAppointment(1)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="cancelAppointment(1)" title="Cancel">❌</button>
            </td>
          </tr>
          <tr>
            <td>#APT002</td>
            <td>Jane Smith</td>
            <td>Dr. Sarah Williams</td>
            <td>Neurology</td>
            <td>2025-10-23</td>
            <td>11:30 AM</td>
            <td><span class="status-badge pending">Pending</span></td>
            <td>
              <button class="btn-icon" onclick="viewAppointment(2)" title="View">👁️</button>
              <button class="btn-icon" onclick="editAppointment(2)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="cancelAppointment(2)" title="Cancel">❌</button>
            </td>
          </tr>
          <tr>
            <td>#APT003</td>
            <td>Robert Brown</td>
            <td>Dr. Michael Brown</td>
            <td>Orthopedics</td>
            <td>2025-10-22</td>
            <td>01:00 PM</td>
            <td><span class="status-badge completed">Completed</span></td>
            <td>
              <button class="btn-icon" onclick="viewAppointment(3)" title="View">👁️</button>
              <button class="btn-icon" onclick="editAppointment(3)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="cancelAppointment(3)" title="Cancel">❌</button>
            </td>
          </tr>
          <tr>
            <td>#APT004</td>
            <td>Emily Davis</td>
            <td>Dr. Emily Davis</td>
            <td>Pediatrics</td>
            <td>2025-10-24</td>
            <td>03:30 PM</td>
            <td><span class="status-badge scheduled">Scheduled</span></td>
            <td>
              <button class="btn-icon" onclick="viewAppointment(4)" title="View">👁️</button>
              <button class="btn-icon" onclick="editAppointment(4)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="cancelAppointment(4)" title="Cancel">❌</button>
            </td>
          </tr>
          <tr>
            <td>#APT005</td>
            <td>Michael Wilson</td>
            <td>Dr. John Smith</td>
            <td>Cardiology</td>
            <td>2025-10-21</td>
            <td>09:00 AM</td>
            <td><span class="status-badge cancelled">Cancelled</span></td>
            <td>
              <button class="btn-icon" onclick="viewAppointment(5)" title="View">👁️</button>
              <button class="btn-icon" onclick="editAppointment(5)" title="Edit">✏️</button>
              <button class="btn-icon delete" onclick="cancelAppointment(5)" title="Cancel">❌</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </main>
</div>

<!-- Book/Edit Appointment Modal -->
<div id="appointmentModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="modalTitle">Book New Appointment</h2>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
    <form id="appointmentForm" class="appointment-form">
      <div class="form-row">
        <div class="form-group">
          <label>Patient *</label>
          <select name="patient" required>
            <option value="">Select Patient</option>
            <option value="p001">John Doe - #P001</option>
            <option value="p002">Jane Smith - #P002</option>
            <option value="p003">Robert Brown - #P003</option>
            <option value="p004">Emily Davis - #P004</option>
            <option value="p005">Michael Wilson - #P005</option>
          </select>
        </div>
        <div class="form-group">
          <label>Department *</label>
          <select name="department" required onchange="filterDoctors(this.value)">
            <option value="">Select Department</option>
            <option value="cardiology">Cardiology</option>
            <option value="neurology">Neurology</option>
            <option value="orthopedics">Orthopedics</option>
            <option value="pediatrics">Pediatrics</option>
            <option value="general">General Medicine</option>
            <option value="dermatology">Dermatology</option>
          </select>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Doctor *</label>
          <select name="doctor" required id="doctorSelect">
            <option value="">Select Doctor</option>
            <option value="d001" data-dept="cardiology">Dr. John Smith - Cardiologist</option>
            <option value="d002" data-dept="neurology">Dr. Sarah Williams - Neurologist</option>
            <option value="d003" data-dept="orthopedics">Dr. Michael Brown - Orthopedic</option>
            <option value="d004" data-dept="pediatrics">Dr. Emily Davis - Pediatrician</option>
          </select>
        </div>
        <div class="form-group">
          <label>Appointment Type *</label>
          <select name="appointmentType" required>
            <option value="">Select Type</option>
            <option value="checkup">General Checkup</option>
            <option value="followup">Follow-up</option>
            <option value="consultation">Consultation</option>
            <option value="emergency">Emergency</option>
          </select>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group">
          <label>Appointment Date *</label>
          <input type="date" name="appointmentDate" required min="2025-10-22">
        </div>
        <div class="form-group">
          <label>Appointment Time *</label>
          <input type="time" name="appointmentTime" required>
        </div>
      </div>
      
      <div class="form-row">
        <div class="form-group full-width">
          <label>Reason for Visit</label>
          <textarea name="reason" rows="3" placeholder="Enter reason for appointment"></textarea>
        </div>
      </div>
      
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn-primary">Book Appointment</button>
      </div>
    </form>
  </div>
</div>

<!-- Appointment Details Modal -->
<div id="appointmentDetailsModal" class="modal">
  <div class="modal-content detail-modal">
    <div class="modal-header">
      <h2>Appointment Details</h2>
      <span class="close" onclick="closeDetailsModal()">&times;</span>
    </div>
    <div class="appointment-details">
      <div class="detail-header">
        <div class="detail-id">
          <h3>Appointment #APT001</h3>
          <span class="status-badge scheduled">Scheduled</span>
        </div>
        <div class="detail-date">
          <p><strong>Date:</strong> October 23, 2025</p>
          <p><strong>Time:</strong> 10:00 AM</p>
        </div>
      </div>
      
      <div class="detail-section">
        <h4>Patient Information</h4>
        <div class="detail-grid">
          <div class="detail-item">
            <span class="label">Patient Name:</span>
            <span class="value">John Doe</span>
          </div>
          <div class="detail-item">
            <span class="label">Patient ID:</span>
            <span class="value">#P001</span>
          </div>
          <div class="detail-item">
            <span class="label">Phone:</span>
            <span class="value">+1 234-567-8900</span>
          </div>
          <div class="detail-item">
            <span class="label">Age:</span>
            <span class="value">45 years</span>
          </div>
        </div>
      </div>
      
      <div class="detail-section">
        <h4>Appointment Information</h4>
        <div class="detail-grid">
          <div class="detail-item">
            <span class="label">Doctor:</span>
            <span class="value">Dr. John Smith</span>
          </div>
          <div class="detail-item">
            <span class="label">Department:</span>
            <span class="value">Cardiology</span>
          </div>
          <div class="detail-item">
            <span class="label">Appointment Type:</span>
            <span class="value">General Checkup</span>
          </div>
          <div class="detail-item">
            <span class="label">Status:</span>
            <span class="value">Scheduled</span>
          </div>
        </div>
      </div>
      
      <div class="detail-section">
        <h4>Additional Information</h4>
        <div class="detail-item full-width">
          <span class="label">Reason for Visit:</span>
          <span class="value">Regular cardiac checkup and blood pressure monitoring</span>
        </div>
      </div>
      
      <div class="detail-actions">
        <button class="btn-primary" onclick="editAppointment(1)">Edit Appointment</button>
        <button class="btn-danger" onclick="cancelAppointment(1)">Cancel Appointment</button>
        <button class="btn-secondary" onclick="closeDetailsModal()">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="../myjs/appointments.js"></script>
</body>
</html>

