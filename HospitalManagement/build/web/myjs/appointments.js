/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Open Book Appointment Modal
function openBookAppointmentModal() {
  document.getElementById('modalTitle').textContent = 'Book New Appointment';
  document.getElementById('appointmentModal').style.display = 'flex';
}

// Close Appointment Modal
function closeModal() {
  document.getElementById('appointmentModal').style.display = 'none';
  document.getElementById('appointmentForm').reset();
}

// View Appointment Details
function viewAppointment(id) {
  document.getElementById('appointmentDetailsModal').style.display = 'flex';
}

// Close Details Modal
function closeDetailsModal() {
  document.getElementById('appointmentDetailsModal').style.display = 'none';
}

// Edit Appointment
function editAppointment(id) {
  document.getElementById('modalTitle').textContent = 'Edit Appointment';
  document.getElementById('appointmentModal').style.display = 'flex';
  // Populate form with appointment data
}

// Cancel Appointment
function cancelAppointment(id) {
  if(confirm('Are you sure you want to cancel this appointment?')) {
    alert('Appointment cancelled successfully!');
    // Update appointment status to cancelled
  }
}

// Search Appointments
function searchAppointments() {
  const input = document.getElementById('searchInput');
  const filter = input.value.toUpperCase();
  const table = document.getElementById('appointmentsTable');
  const tr = table.getElementsByTagName('tr');

  for (let i = 1; i < tr.length; i++) {
    let txtValue = tr[i].textContent || tr[i].innerText;
    if (txtValue.toUpperCase().indexOf(filter) > -1) {
      tr[i].style.display = '';
    } else {
      tr[i].style.display = 'none';
    }
  }
}

// Filter by Status
function filterByStatus(status) {
  const table = document.getElementById('appointmentsTable');
  const tr = table.getElementsByTagName('tr');

  for (let i = 1; i < tr.length; i++) {
    if (status === '') {
      tr[i].style.display = '';
    } else {
      const statusBadge = tr[i].querySelector('.status-badge');
      if (statusBadge && statusBadge.classList.contains(status)) {
        tr[i].style.display = '';
      } else {
        tr[i].style.display = 'none';
      }
    }
  }
}

// Filter Doctors by Department
function filterDoctors(department) {
  const doctorSelect = document.getElementById('doctorSelect');
  const options = doctorSelect.querySelectorAll('option');
  
  options.forEach(option => {
    if (option.value === '') {
      option.style.display = 'block';
    } else if (department === '' || option.dataset.dept === department) {
      option.style.display = 'block';
    } else {
      option.style.display = 'none';
    }
  });
  
  doctorSelect.value = '';
}

// Close modal when clicking outside
window.onclick = function(event) {
  const modal = document.getElementById('appointmentModal');
  const detailsModal = document.getElementById('appointmentDetailsModal');
  
  if (event.target == modal) {
    closeModal();
  }
  if (event.target == detailsModal) {
    closeDetailsModal();
  }
}

// Handle form submission
document.getElementById('appointmentForm').addEventListener('submit', function(e) {
  e.preventDefault();
  alert('Appointment booked successfully!');
  closeModal();
  // Save appointment to database
});

