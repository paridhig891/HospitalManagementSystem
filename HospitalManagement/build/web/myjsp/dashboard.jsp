<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import =  "java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Billing Management - MediCare</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../mycss/bill.css">
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
      <a href="staff.jsp" class="nav-item">Staff</a>
      <a href="bill.jsp" class="nav-item active">Billing</a>
    </nav>
    
    <div class="sidebar-footer">
      © 2025 MediCare HMS
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <div class="page-header">
      <h1>Billing & Invoice Management</h1>
      <button class="btn-primary" onclick="openGenerateBillModal()">+ Generate New Bill</button>
    </div>

    <!-- Stats Cards -->
    <div class="billing-stats">
      <div class="stat-card">
        <div class="stat-info">
          <h3>Total Revenue</h3>
          <div class="stat-value">$245,800</div>
          <div class="stat-detail">This month</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Pending Bills</h3>
          <div class="stat-value">23</div>
          <div class="stat-detail">Awaiting payment</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <h3>Paid Bills</h3>
          <div class="stat-value">187</div>
          <div class="stat-detail">This month</div>
        </div>
      </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="search-filter-section">
      <div class="search-box">
        <input type="text" id="searchInput" placeholder="Search bills by bill number, patient name..." onkeyup="searchBills()">
      </div>
      <div class="filter-buttons">
        <select class="filter-select">
          <option value="">All Status</option>
          <option value="paid">Paid</option>
          <option value="pending">Pending</option>
          <option value="overdue">Overdue</option>
        </select>
        <select class="filter-select">
          <option value="">This Month</option>
          <option value="today">Today</option>
          <option value="week">This Week</option>
          <option value="month">This Month</option>
          <option value="year">This Year</option>
        </select>
      </div>
    </div>

    <!-- Bills Table -->
    <div class="table-container">
      <table class="bills-table" id="billsTable">
        <thead>
          <tr>
            <th>Bill No.</th>
            <th>Patient Name</th>
            <th>Patient ID</th>
            <th>Date</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>#INV-001</td>
            <td>John Doe</td>
            <td>#P001</td>
            <td>2025-10-20</td>
            <td>$1,250.00</td>
            <td><span class="status-badge paid">Paid</span></td>
            <td>
              <button class="btn-icon" onclick="viewBill(1)" title="View">👁️</button>
              <button class="btn-icon" onclick="printBill(1)" title="Print">🖨️</button>
              <button class="btn-icon delete" onclick="deleteBill(1)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#INV-002</td>
            <td>Jane Smith</td>
            <td>#P002</td>
            <td>2025-10-21</td>
            <td>$890.00</td>
            <td><span class="status-badge pending">Pending</span></td>
            <td>
              <button class="btn-icon" onclick="viewBill(2)" title="View">👁️</button>
              <button class="btn-icon" onclick="printBill(2)" title="Print">🖨️</button>
              <button class="btn-icon delete" onclick="deleteBill(2)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#INV-003</td>
            <td>Robert Brown</td>
            <td>#P003</td>
            <td>2025-10-15</td>
            <td>$2,150.00</td>
            <td><span class="status-badge overdue">Overdue</span></td>
            <td>
              <button class="btn-icon" onclick="viewBill(3)" title="View">👁️</button>
              <button class="btn-icon" onclick="printBill(3)" title="Print">🖨️</button>
              <button class="btn-icon delete" onclick="deleteBill(3)" title="Delete">🗑️</button>
            </td>
          </tr>
          <tr>
            <td>#INV-004</td>
            <td>Emily Davis</td>
            <td>#P004</td>
            <td>2025-10-22</td>
            <td>$650.00</td>
            <td><span class="status-badge paid">Paid</span></td>
            <td>
              <button class="btn-icon" onclick="viewBill(4)" title="View">👁️</button>
              <button class="btn-icon" onclick="printBill(4)" title="Print">🖨️</button>
              <button class="btn-icon delete" onclick="deleteBill(4)" title="Delete">🗑️</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </main>
</div>

     <%
          Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con1 = null;
    con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital_management", "root", "6755");
%>
          <%  String q = "SELECT patient_id, full_name FROM patients";
              PreparedStatement sm = con1.prepareStatement(q);
          ResultSet rm = sm.executeQuery();
    %>
<!-- Generate Bill Modal -->
<div id="billModal" class="modal">
  <div class="modal-content large-modal">
    <div class="modal-header">
      <h2>Generate New Bill</h2>
      <span class="close" onclick="closeModal()">&times;</span>
    </div>
      <form id="billForm" class="bill-form" action="${pageContext.request.contextPath}/GenerateBillServlet" method="post">
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
        <div class="form-group">
          <label>Bill Date *</label>
          <input type="date" name="billDate" required>
        </div>
      </div>
      <div class="form-group">
  <label>Payment Mode *</label>
  <select name="payMode" required>
    <option value="">Select</option>
    <option value="Cash">Cash</option>
    <option value="Card">Card</option>
    <option value="UPI">UPI</option>
  </select>
</div>

      <div class="services-section">
        <div class="section-header">
          <h3>Services / Items</h3>
          <button type="button" class="btn-add" onclick="addServiceRow()">+ Add Service</button>
        </div>
        
        <table class="services-table" id="servicesTable">
          <thead>
            <tr>
              <th>Service/Item</th>
              <th>Description</th>
              <th>Quantity</th>
              <th>Unit Price</th>
              <th>Amount</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr class="service-row">
              <td>
                <select name="service[]" required>
                  <option value="">Select Service</option>
                  <option value="consultation">Consultation</option>
                  <option value="xray">X-Ray</option>
                  <option value="bloodtest">Blood Test</option>
                  <option value="surgery">Surgery</option>
                  <option value="medicine">Medicine</option>
                  <option value="room">Room Charges</option>
                </select>
              </td>
              <td><input type="text" name="description[]" placeholder="Description"></td>
              <td><input type="number" name="quantity[]" value="1" min="1" onchange="calculateRow(this)"></td>
              <td><input type="number" name="unitPrice[]" placeholder="0.00" step="0.01" onchange="calculateRow(this)"></td>
              <td><input type="number" name="amount[]" placeholder="0.00" readonly></td>
              <td><button type="button" class="btn-remove" onclick="removeServiceRow(this)">🗑️</button></td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <div class="bill-summary">
        <div class="summary-row">
          <span>Subtotal:</span>
          <span id="subtotal">$0.00</span>
        </div>
        <div class="summary-row">
          <span>Tax (10%):</span>
          <span id="tax">$0.00</span>
        </div>
        <div class="summary-row total">
          <span>Total Amount:</span>
          <span id="total">$0.00</span>
        </div>
      </div>
      
      <div class="form-actions">
        <button type="button" class="btn-secondary" onclick="closeModal()">Cancel</button>
        <button type="submit" class="btn-primary">Generate Bill</button>
      </div>
    </form>
  </div>
</div>

<!-- Bill Details Modal -->
<div id="billDetailsModal" class="modal">
  <div class="modal-content large-modal">
    <div class="modal-header">
      <h2>Bill Details</h2>
      <span class="close" onclick="closeBillDetailsModal()">&times;</span>
    </div>
    <div class="bill-details">
      <div class="invoice-header">
        <div class="invoice-logo">
          <h2>MediCare Hospital</h2>
          <p>123 Medical Street, Health City</p>
          <p>Phone: +1 234-567-8900</p>
        </div>
        <div class="invoice-info">
          <h3>INVOICE</h3>
          <p><strong>Invoice No:</strong> #INV-001</p>
          <p><strong>Date:</strong> October 20, 2025</p>
          <p><strong>Status:</strong> <span class="status-badge paid">Paid</span></p>
        </div>
      </div>
      
      <div class="patient-info">
        <h4>Bill To:</h4>
        <p><strong>John Doe</strong></p>
        <p>Patient ID: #P001</p>
        <p>Phone: +1 234-567-8900</p>
      </div>
      
      <table class="invoice-items">
        <thead>
          <tr>
            <th>Service/Item</th>
            <th>Description</th>
            <th>Qty</th>
            <th>Unit Price</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Consultation</td>
            <td>General Checkup</td>
            <td>1</td>
            <td>$100.00</td>
            <td>$100.00</td>
          </tr>
          <tr>
            <td>Blood Test</td>
            <td>Complete Blood Count</td>
            <td>1</td>
            <td>$50.00</td>
            <td>$50.00</td>
          </tr>
          <tr>
            <td>X-Ray</td>
            <td>Chest X-Ray</td>
            <td>1</td>
            <td>$150.00</td>
            <td>$150.00</td>
          </tr>
          <tr>
            <td>Medicine</td>
            <td>Prescribed Medications</td>
            <td>1</td>
            <td>$200.00</td>
            <td>$200.00</td>
          </tr>
          <tr>
            <td>Room Charges</td>
            <td>3 Days - Standard Room</td>
            <td>3</td>
            <td>$250.00</td>
            <td>$750.00</td>
          </tr>
        </tbody>
      </table>
      
      <div class="invoice-summary">
        <div class="summary-row">
          <span>Subtotal:</span>
          <span>$1,250.00</span>
        </div>
        <div class="summary-row">
          <span>Tax (10%):</span>
          <span>$125.00</span>
        </div>
        <div class="summary-row total">
          <span>Total Amount:</span>
          <span>$1,375.00</span>
        </div>
      </div>
      
      <div class="invoice-actions">
        <button class="btn-primary" onclick="printBill(1)">Print Invoice</button>
        <button class="btn-secondary" onclick="closeBillDetailsModal()">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="../myjs/bill.js"></script>
</body>
</html>
