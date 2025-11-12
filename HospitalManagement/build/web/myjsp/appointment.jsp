
<%@ page import = "java.sql.*, javax.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
          <div class="brand-name"ADMIN</div>
          <div class="brand-tagline">Hospital Management</div>
        </div>
      </div>
    </div>
    
    <nav class="nav-menu">
      <a href="dashboard.jsp" class="nav-item">Dashboard</a>
      <a href="patient.jsp" class="nav-item">Patients</a>
      <a href="doctor.jsp" class="nav-item">Doctors</a>
      <a href="department.jsp" class="nav-item">Departments</a>
      <a href="appointment.jsp" class="nav-item active">Appointments</a>
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
      <h1>Appointment Management</h1>
      <button class="btn-primary" onclick="openBookAppointmentModal()">+ Book New Appointment</button>
    </div>

      <%
          int todayAppointments =0;
          int pendingAppointments = 0;
          int completedToday = 0;
         Connection con = null;
         PreparedStatement ps1 = null;
         try{
       Class.forName("com.mysql.cj.jdbc.Driver");
       con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management","root","6755"); 
          ps1 = con.prepareStatement("SELECT COUNT(*) FROM appointments WHERE DATE(appointment_date) = CURDATE() AND status='scheduled'");
          ResultSet rs1 = ps1.executeQuery();
          
          if(rs1.next()) todayAppointments=rs1.getInt(1);
          
          PreparedStatement ps2 =  con.prepareStatement("SELECT COUNT(*) FROM appointments WHERE status ='scheduled'");
          
          ResultSet rs2 = ps2.executeQuery();
          if(rs2.next()) pendingAppointments = rs2.getInt(1);
          
          PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM appointments WHERE status = 'completed' AND DATE(appointment_date) = CURDATE()");
          ResultSet rs3 = ps3.executeQuery();
          
          if(rs3.next()) completedToday = rs3.getInt(1);
          }catch(Exception e){ }
      %>
    <!-- Stats Cards -->
    <div class="appointment-stats">
      <div class="stat-card">
        <div class="stat-info">
          <h3>Today's Appointments</h3>
          <div class="stat-value"><%= todayAppointments%></div>
          <div class="stat-detail">Scheduled for today</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Pending Appointments</h3>
          <div class="stat-value"><%= pendingAppointments%></div>
          <div class="stat-detail">Awaiting confirmation</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Completed Today</h3>
          <div class="stat-value"><%= completedToday%></div>
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
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
            
    <% 
    ResultSet rs = null;
    PreparedStatement s = null;
try{ 
      
        s = con.prepareStatement("SELECT a.appointment_id, p.full_name, d.docName, a.appointment_type, a.appointment_date, a.appointment_time, a.reason, a.status  FROM appointments a JOIN patients p ON a.patient_id = p.patient_id JOIN doctor d ON a.doctor_id = d.docId");
       rs = s.executeQuery();
       
while(rs.next()){
    %>
        <tbody>
          <tr>
            <td><%= rs.getInt("appointment_id")%></td>
            <td><%= rs.getString("full_name")%></td>
            <td><%= rs.getString("docName")%></td>
            <td><%= rs.getDate("appointment_date")%></td>
            <td><%= rs.getTime("appointment_time")%></td>
            <td><span class="status-badge scheduled"><%= rs.getString("status")%></span></td>
            <td>
              <button class="btn-icon" onclick="viewAppointment(1)" title="View">👁️</button>
              <a class="btn-icon delete" href="${pageContext.request.contextPath}/CancelAppointment?cancel=<%= rs.getInt("appointment_id") %>" 
   class="btn-icon delete" 
   title="Cancel">❌</a>

            </td>
          </tr>
          <%
        }
    } catch (Exception e) {
      out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (s != null) s.close();
        if (con != null) con.close();
    }
%>
        </tbody>
      </table>
    </div>
  </main>
</div>

          <%
          Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con1 = null;
    con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
    Statement sp = con1.createStatement();
    ResultSet rq = sp.executeQuery("SELECT docId, docName FROM doctor");
%>
          <%  String q = "SELECT patient_id, full_name FROM patients WHERE patient_type = ?";
          String p = "outpatient";
              PreparedStatement sm = con1.prepareStatement(q);
              sm.setString(1, p);
          ResultSet rm = sm.executeQuery();
    %>
<!-- Book/Edit Appointment Modal -->
<div id="appointmentModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="modalTitle">Book New Appointment</h2>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
      <form id="appointmentForm" class="appointment-form" action="${pageContext.request.contextPath}/AddAppointment" method="post">
      <div class="form-row">
        <div class="form-group">
          <label>Patient *</label>
          <select name="patient" required>
            <option value="">Select Patient</option>
            <% while(rm.next()){
               %>
               <option value="<%=  rm.getInt("patient_id")%>">
                    <%= rm.getString("full_name")%> - <%=  rm.getInt("patient_id")%>
               </option>
               <% } %>
          </select>
        </div>

      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Doctor *</label>
          <select name="doctor" required id="doctorSelect">
            <option value="">Select Doctor</option>
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

