/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Open Add Doctor Modal
function openAddDoctorModal() {
  document.getElementById('modalTitle').textContent = 'Add New Doctor';
  document.getElementById('doctorModal').style.display = 'flex';
}

// Close Doctor Form Modal
function closeModal() {
  document.getElementById('doctorModal').style.display = 'none';
  document.getElementById('doctorForm').reset();
}

// Open Doctor Profile Modal
function viewDoctor(id) {
  document.getElementById('profileModal').style.display = 'flex';
}

// Close Profile Modal
function closeProfileModal() {
  document.getElementById('profileModal').style.display = 'none';
}

// Edit Doctor
function editDoctor(id) {
  document.getElementById('modalTitle').textContent = 'Edit Doctor';
  document.getElementById('doctorModal').style.display = 'flex';
  // Here you would populate the form with doctor data
}

// Delete Doctor
function deleteDoctor(id) {
  if(confirm('Are you sure you want to delete this doctor?')) {
    alert('Doctor deleted successfully!');
    // Here you would delete the doctor from database
  }
}

// Search Doctors
function searchDoctors() {
  const input = document.getElementById('searchInput');
  const filter = input.value.toUpperCase();
  const table = document.getElementById('doctorsTable');
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

// Close modal when clicking outside
window.onclick = function(event) {
  const modal = document.getElementById('doctorModal');
  const profileModal = document.getElementById('profileModal');
  if (event.target == modal) {
    closeModal();
  }
  if (event.target == profileModal) {
    closeProfileModal();
  }
}

// Handle form submission
document.getElementById('doctorForm').addEventListener('submit', function(e) {
  e.preventDefault();
  alert('Doctor saved successfully!');
  closeModal();
  // Here you would save the doctor data to database
});

