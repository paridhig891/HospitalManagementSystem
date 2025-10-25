/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Open Add Patient Modal
function openAddPatientModal() {
  document.getElementById('modalTitle').textContent = 'Add New Patient';
  document.getElementById('patientModal').style.display = 'flex';
}

// Close Patient Form Modal
function closeModal() {
  document.getElementById('patientModal').style.display = 'none';
  document.getElementById('patientForm').reset();
}

// Open Patient Profile Modal
function viewPatient(id) {
  document.getElementById('profileModal').style.display = 'flex';
}

// Close Profile Modal
function closeProfileModal() {
  document.getElementById('profileModal').style.display = 'none';
}

// Edit Patient
function editPatient(id) {
  document.getElementById('modalTitle').textContent = 'Edit Patient';
  document.getElementById('patientModal').style.display = 'flex';
  // Here you would populate the form with patient data
}

// Delete Patient
function deletePatient(id) {
  if(confirm('Are you sure you want to delete this patient?')) {
    alert('Patient deleted successfully!');
    // Here you would delete the patient from database
  }
}

// Search Patients
function searchPatients() {
  const input = document.getElementById('searchInput');
  const filter = input.value.toUpperCase();
  const table = document.getElementById('patientsTable');
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
  const modal = document.getElementById('patientModal');
  const profileModal = document.getElementById('profileModal');
  if (event.target == modal) {
    closeModal();
  }
  if (event.target == profileModal) {
    closeProfileModal();
  }
}


