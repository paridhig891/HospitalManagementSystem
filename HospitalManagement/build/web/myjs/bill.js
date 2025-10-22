/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Open Generate Bill Modal
function openGenerateBillModal() {
  document.getElementById('billModal').style.display = 'flex';
}

// Close Bill Modal
function closeModal() {
  document.getElementById('billModal').style.display = 'none';
  document.getElementById('billForm').reset();
}

// View Bill Details
function viewBill(id) {
  document.getElementById('billDetailsModal').style.display = 'flex';
}

// Close Bill Details Modal
function closeBillDetailsModal() {
  document.getElementById('billDetailsModal').style.display = 'none';
}

// Print Bill
function printBill(id) {
  alert('Printing bill #' + id);
  window.print();
}

// Delete Bill
function deleteBill(id) {
  if(confirm('Are you sure you want to delete this bill?')) {
    alert('Bill deleted successfully!');
  }
}

// Search Bills
function searchBills() {
  const input = document.getElementById('searchInput');
  const filter = input.value.toUpperCase();
  const table = document.getElementById('billsTable');
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

// Add Service Row
function addServiceRow() {
  const table = document.getElementById('servicesTable').getElementsByTagName('tbody')[0];
  const newRow = table.rows[0].cloneNode(true);
  
  // Clear values
  const inputs = newRow.getElementsByTagName('input');
  for(let i = 0; i < inputs.length; i++) {
    inputs[i].value = i === 2 ? '1' : ''; // Quantity default 1
  }
  
  const selects = newRow.getElementsByTagName('select');
  for(let i = 0; i < selects.length; i++) {
    selects[i].selectedIndex = 0;
  }
  
  table.appendChild(newRow);
}

// Remove Service Row
function removeServiceRow(button) {
  const row = button.closest('tr');
  const table = row.parentElement;
  
  if(table.rows.length > 1) {
    row.remove();
    calculateTotal();
  } else {
    alert('At least one service is required');
  }
}

// Calculate Row Amount
function calculateRow(input) {
  const row = input.closest('tr');
  const quantity = parseFloat(row.querySelector('input[name="quantity[]"]').value) || 0;
  const unitPrice = parseFloat(row.querySelector('input[name="unitPrice[]"]').value) || 0;
  const amount = quantity * unitPrice;
  
  row.querySelector('input[name="amount[]"]').value = amount.toFixed(2);
  calculateTotal();
}

// Calculate Total
function calculateTotal() {
  const amounts = document.querySelectorAll('input[name="amount[]"]');
  let subtotal = 0;
  
  amounts.forEach(input => {
    subtotal += parseFloat(input.value) || 0;
  });
  
  const tax = subtotal * 0.1; // 10% tax
  const total = subtotal + tax;
  
  document.getElementById('subtotal').textContent = '$' + subtotal.toFixed(2);
  document.getElementById('tax').textContent = '$' + tax.toFixed(2);
  document.getElementById('total').textContent = '$' + total.toFixed(2);
}

// Close modal when clicking outside
window.onclick = function(event) {
  const modal = document.getElementById('billModal');
  const detailsModal = document.getElementById('billDetailsModal');
  
  if (event.target == modal) {
    closeModal();
  }
  if (event.target == detailsModal) {
    closeBillDetailsModal();
  }
}

// Handle form submission
document.getElementById('billForm').addEventListener('submit', function(e) {
  e.preventDefault();
  alert('Bill generated successfully!');
  closeModal();
});


