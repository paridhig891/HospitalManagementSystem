
// Close Patient Form Modal
function closeModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = "none"; // hide modal
    modal.classList.remove("show"); // remove Bootstrap 'show' class
    document.body.classList.remove("modal-open"); // restore scroll
    const backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) backdrop.remove(); // remove overlay
  }
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

document.querySelector('select[name="patient_type"]').addEventListener('change', function() {
  const inpatientFields = document.querySelectorAll('.inpatient-fields');
  inpatientFields.forEach(f => {
    f.style.display = (this.value === 'inpatient') ? 'flex' : 'none';
  });
});



function closeTypeModal() {
  document.getElementById('patientTypeModal').style.display = 'none';
}



// Open Add Patient Modal — show type selection first
function openAddPatientModal() {
  // Safely hide other modals if they exist
  const outpatientModal = document.getElementById('outpatientModal');
  const inpatientModalStep1 = document.getElementById('inpatientModalStep1');
  const inpatientModalStep2 = document.getElementById('inpatientModalStep2');
  const typeModal = document.getElementById('patientTypeModal');

  if (outpatientModal) outpatientModal.style.display = 'none';
  if (inpatientModalStep1) inpatientModalStep1.style.display = 'none';
  if (inpatientModalStep2) inpatientModalStep2.style.display = 'none';

  // Show type selection card
  if (typeModal) typeModal.style.display = 'flex';
}


// When user selects patient type
function selectPatientType(type) {
  // Close the type selection card
  document.getElementById('patientTypeModal').style.display = 'none';

  // Show the appropriate modal based on type
  if (type === 'outpatient') {
    document.getElementById('outpatientModal').style.display = 'flex';
  } 
  else if (type === 'inpatient') {
    document.getElementById('inpatientModalStep1').style.display = 'flex';
  }
}

function goToInpatientStep2() {
  // You can validate step 1 fields before proceeding if needed
  document.getElementById('inpatientModalStep1').style.display = 'none';
  document.getElementById('inpatientModalStep2').style.display = 'flex';
}


