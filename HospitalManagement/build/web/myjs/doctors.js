
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
// Auto-hide success message after 4 seconds
setTimeout(() => {
    const msgDiv = document.querySelector('div[style*="color: green"]');
    if (msgDiv) msgDiv.style.display = 'none';
}, 4000);

//    function deleteDoctor(docId) {
//    if (confirm("Are you sure you want to delete this doctor?")) {
//      const contextPath = "<%= request.getContextPath() %>";
//      // Encode the doctor ID properly to avoid invalid URI characters
//      const encodedId = encodeURIComponent(docId.trim());
//      window.location.href = contextPath + "/DeleteDoctor?docId=" + encodedId;
//  }
// }



// Handle form submission
// document.getElementById('doctorForm').addEventListener('submit', function(e) {
//  e.preventDefault();
//  alert('Doctor saved successfully!');
//  closeModal();
  // Here you would save the doctor data to database
// });

