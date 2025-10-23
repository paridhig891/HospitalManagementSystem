<%-- 
    Document   : dashboard
    Created on : 18-Oct-2025, 11:18:05 pm
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MediCare Hospital Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="dashboard.css">
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
      <a href="dashboard.jsp" class="nav-item active">Dashboard</a>
      <a href="patient.jsp" class="nav-item">Patients</a>
      <a href="doctor.jsp" class="nav-item">Doctors</a>
      <a href="department" class="nav-item">Departments</a>
      <a href="appointment" class="nav-item">Appointments</a>
      <a href="room.jsp" class="nav-item">Rooms</a>
      <a href="staff.jsp" class="nav-item">Staff</a>
      <a href="bill.jsp" class="nav-item">Billing</a>
    </nav>
    
    <div class="appointments-sidebar">
      <h3>Today's Appointments</h3>
      <div class="appointment">
        <img src="https://i.pravatar.cc/40?img=1" alt="Patient">
        <div>
          <div class="patient-name">John Doe</div>
          <div class="time">10:00 AM - General Checkup</div>
        </div>
      </div>
    </div>
    
    <div class="sidebar-footer">
      © 2025 MediCare HMS
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <div class="header-gradient">
      <div class="header-content">
        <div>
          <h1>Dashboard</h1>
          <p>Welcome back! Here's what's happening today.</p>
        </div>
        <div class="user-profile">
          <div class="user-info">
            <div class="user-name">Admin User</div>
            <div class="user-email">admin@medicare.com</div>
          </div>
          <div class="user-avatar">A</div>
        </div>
      </div>
    </div>

    <div class="content-area">
      <!-- Stats Cards -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon blue">👥</div>
          <div class="stat-info">
            <h3>Total Patients</h3>
            <div class="stat-number">1,234</div>
            <div class="stat-detail">+12% this month</div>
          </div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon green">👨‍⚕️</div>
          <div class="stat-info">
            <h3>Total Doctors</h3>
            <div class="stat-number">87</div>
            <div class="stat-detail">+3 new this week</div>
          </div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon purple">📅</div>
          <div class="stat-info">
            <h3>Appointments</h3>
            <div class="stat-number">342</div>
            <div class="stat-detail">28 today</div>
          </div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon orange">🛏️</div>
          <div class="stat-info">
            <h3>Available Rooms</h3>
            <div class="stat-number">45</div>
            <div class="stat-detail">15 occupied</div>
          </div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon blue">🏥</div>
          <div class="stat-info">
            <h3>Departments</h3>
            <div class="stat-number">12</div>
          </div>
        </div>
        
        <div class="stat-card">
          <div class="stat-icon green">👥</div>
          <div class="stat-info">
            <h3>Staff Members</h3>
            <div class="stat-number">156</div>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>

</body>
</html>
