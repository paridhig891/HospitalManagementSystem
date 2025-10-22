/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// Password strength checker
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('confirmPassword');
const passwordStrength = document.getElementById('passwordStrength');
const errorMessage = document.getElementById('errorMessage');

passwordInput.addEventListener('input', function() {
    const password = this.value;
    const strength = checkPasswordStrength(password);
    
    // Remove previous classes
    passwordStrength.className = 'password-strength';
    
    // Add new class based on strength
    if (password.length > 0) {
        if (strength >= 4) {
            passwordStrength.classList.add('strong');
        } else if (strength >= 2) {
            passwordStrength.classList.add('medium');
        } else {
            passwordStrength.classList.add('weak');
        }
    }
});

confirmPasswordInput.addEventListener('input', function() {
    checkPasswordMatch();
});

function checkPasswordStrength(password) {
    let strength = 0;
    
    // Check length
    if (password.length >= 8) strength++;
    
    // Check for uppercase
    if (/[A-Z]/.test(password)) strength++;
    
    // Check for lowercase
    if (/[a-z]/.test(password)) strength++;
    
    // Check for numbers
    if (/[0-9]/.test(password)) strength++;
    
    // Check for special characters
    if (/[^A-Za-z0-9]/.test(password)) strength++;
    
    return strength;
}

function checkPasswordMatch() {
    const password = passwordInput.value;
    const confirmPassword = confirmPasswordInput.value;
    
    if (confirmPassword.length > 0) {
        if (password !== confirmPassword) {
            errorMessage.textContent = 'Passwords do not match';
            errorMessage.style.display = 'block';
            return false;
        } else {
            errorMessage.textContent = '';
            errorMessage.style.display = 'none';
            return true;
        }
    }
    return true;
}

function validateForm() {
    const password = passwordInput.value;
    const confirmPassword = confirmPasswordInput.value;
    
    // Check if passwords match
    if (password !== confirmPassword) {
        errorMessage.textContent = 'Passwords do not match';
        return false;
    }
    
    // Check password strength
    const strength = checkPasswordStrength(password);
    if (strength < 4) {
        errorMessage.textContent = 'Password is too weak. Please meet all requirements.';
        return false;
    }
    
    errorMessage.textContent = '';
    return true;
}

