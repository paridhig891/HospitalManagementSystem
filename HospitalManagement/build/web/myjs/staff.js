/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Open Add Staff Modal
function openAddStaffModal() {
  document.getElementById('modalTitle').textContent = 'Add New Staff';
  document.getElementById('staffModal').style.display = 'flex';
}

// Close Staff Form Modal
function closeModal() {
  document.getElementById('staffModal').style.display = 'none';
  document.getElementById('staffForm').reset();
}

// Open Staff Profile Modal
function viewStaff(id) {
  document.getElementById('profileModal').style.display = 'flex';
}

// Close Profile Modal
function closeProfileModal() {
  document.getElementById('profileModal').style.display = 'none';
}

// Edit Staff
function editStaff(id) {
  document.getElementById('modalTitle').textContent = 'Edit Staff';
  document.getElementById('staffModal').style.display = 'flex';
  // Here you would populate the form with staff data
}

// Delete Staff
function deleteStaff(id) {
  if(confirm('Are you sure you want to delete this staff member?')) {
    alert('Staff deleted successfully!');
    // Here you would delete the staff from database
  }
}

// Search Staff
function searchStaff() {
  const input = document.getElementById('searchInput');
  const filter = input.value.toUpperCase();
  const table = document.getElementById('staffTable');
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
  const modal = document.getElementById('staffModal');
  const profileModal = document.getElementById('profileModal');
  if (event.target == modal) {
    closeModal();
  }
  if (event.target == profileModal) {
    closeProfileModal();
  }
}

// Handle form submission
document.getElementById('staffForm').addEventListener('submit', function(e) {
  e.preventDefault();
  alert('Staff saved successfully!');
  closeModal();
  // Here you would save the staff data to database
});


