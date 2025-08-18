<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<f:view>
<!DOCTYPE html>
<html>
  <head>
    <title>Generate Password</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <style>
      .message-container ul {
        list-style-type: none;
        background-color: #ffe6e6;
        color: #c62828;
        padding: 0.5rem 1rem;
        margin-bottom: 0.5rem;
        border-radius: 0.5rem;
        font-weight: 500;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
      }
      .icon-section {
        background: linear-gradient(135deg, #60a5fa, #3b82f6);
      }
    </style>

    <script>
      function togglePwdInstructions() {
        const panel = document.getElementById('pwdInstructions') || document.querySelector('[id$="pwdInstructions"]');
        if (panel) panel.classList.toggle('hidden');
      }

      function toggleVisibility(fieldId, iconId) {
        const fld = document.getElementById(fieldId) || document.querySelector('[id$="' + fieldId + '"]');
        const icon = document.getElementById(iconId) || document.querySelector('[id$="' + iconId + '"]');
        if (!fld || !icon) return;
        fld.type = fld.type === 'password' ? 'text' : 'password';
        icon.classList.toggle('fa-eye');
        icon.classList.toggle('fa-eye-slash');
      }

      function checkRequirements(value) {
        const rules = [
          { regex: /.{8,}/, el: document.getElementById('reqLength') },
          { regex: /[A-Z]/, el: document.getElementById('reqUpper') },
          { regex: /[a-z]/, el: document.getElementById('reqLower') },
          { regex: /[0-9]/, el: document.getElementById('reqNumber') },
          { regex: /[^A-Za-z0-9]/, el: document.getElementById('reqSpecial') }
        ];
        rules.forEach(r => {
          if (!r.el) return;
          const ok = r.regex.test(value);
          r.el.classList.toggle('text-green-500', ok);
          r.el.classList.toggle('text-red-500', !ok);
          r.el.querySelector('span').textContent = ok ? '✓' : '✗';
        });
      }

      function toggleRequirementList() {
    	  // find the UL and the chevron icon
    	  const list = document.getElementById('reqList')
    	             || document.querySelector('[id$="reqList"]');
    	  const icon = document.getElementById('reqToggleIcon')
    	             || document.querySelector('[id$="reqToggleIcon"]');
    	  if (!list || !icon) return;

    	  // toggle hidden class
    	  list.classList.toggle('hidden');

    	}
    	      
      function checkStrength(el) {
        const v = el.value || '';
        checkRequirements(v);
        const tests = [
          v.length >= 8,
          v.length >= 12,
          /[A-Z]/.test(v),
          /[a-z]/.test(v),
          /[0-9]/.test(v),
          /[^A-Za-z0-9]/.test(v)
        ];
        const score = tests.filter(Boolean).length;
        const levels = [
          ['bg-red-500', 'Very Weak'],
          ['bg-red-500', 'Very Weak'],
          ['bg-yellow-400', 'Weak'],
          ['bg-green-400', 'Fair'],
          ['bg-green-600', 'Good'],
          ['bg-blue-600', 'Strong']
        ];
        const idx = Math.min(score, levels.length - 1);
        const pct = Math.round((score / tests.length) * 100);
        const [c, txt] = levels[idx];
        const bar = document.querySelector('[id$="strengthIndicator"]');
        const label = document.querySelector('[id$="strengthText"]');
        if (!bar || !label) return;
        bar.style.width = pct + '%';
        bar.className = 'h-full transition-all rounded ' + c;
        label.textContent = txt;
      }

      function validateEmailField() {
        const e = document.querySelector('[id$="email"]');
        const msg = document.getElementById('msgEmail');
        const valid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(e.value);
        if (!valid) {
          msg.textContent = 'Enter a valid email';
          msg.classList.remove('hidden');
          Toastify({
            text: 'Invalid email format',
            duration: 3000,
            gravity: 'top',
            position: 'center',
            style: { background: '#f56565', color: '#fff', borderRadius: '6px' }
          }).showToast();
        } else {
          msg.textContent = '';
          msg.classList.add('hidden');
        }
      }

      function validateConfirmField() {
        const p = document.querySelector('[id$="newPwd"]').value;
        const c = document.querySelector('[id$="confirmPwd"]');
        const msg = document.getElementById('msgConfirmPwd');
        if (c.value !== p) {
          msg.textContent = 'Passwords do not match';
          msg.classList.remove('hidden');
          Toastify({
            text: 'Passwords do not match',
            duration: 3000,
            gravity: 'top',
            position: 'center',
            style: { background: '#f56565', color: '#fff', borderRadius: '6px' }
          }).showToast();
        } else {
          msg.textContent = '';
          msg.classList.add('hidden');
        }
      }

      document.addEventListener('DOMContentLoaded', () => {
        const pwd = document.querySelector('[id$="newPwd"]');
        if (pwd) {
          pwd.addEventListener('input', e => checkStrength(e.target));
          pwd.addEventListener('blur', e => checkStrength(e.target));
        }
        document.querySelector('[id$="email"]').addEventListener('blur', validateEmailField);
        document.querySelector('[id$="confirmPwd"]').addEventListener('blur', validateConfirmField);
        const instrLink = document.querySelector('[id$="pwdInstructionsLink"]') || document.querySelector('a[href="#pwdInstructions"]');
        if (instrLink) instrLink.addEventListener('click', togglePwdInstructions);
      });
    </script>
  </head>

  <body class="min-h-screen bg-gray-100 flex items-center justify-center py-10 px-4">
    <div class="bg-white rounded-lg shadow-2xl w-full max-w-5xl flex flex-col md:flex-row overflow-hidden">
      <div class="icon-section md:w-1/2 flex items-center justify-center p-10 text-white">
        <div class="text-center">
          <i class="fas fa-key text-6xl mb-4"></i>
          <h3 class="text-2xl font-semibold">Secure Access</h3>
          <p class="mt-2 text-lg">Strong passwords protect your data.<br/>Stay secure with Infinite HealthSure.</p>
        </div>
      </div>

      <div class="md:w-1/2 p-8">
        <h2 class="text-2xl font-bold text-gray-700 mb-6 text-center">Generate Password</h2>

        <h:form id="genPwdForm" prependId="false">
          <div class="message-container">
            <h:messages globalOnly="true" layout="list" />
          </div>

          <div class="mb-5">
            <label for="email" class="block text-gray-700 mb-1">
              <i class="fas fa-envelope mr-1 text-gray-500"></i>Email
            </label>
            <h:inputText
              id="email"
              value="#{providerController.provider.email}"
              readonly="true"
              styleClass="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <span id="msgEmail" class="hidden text-red-500 text-sm mt-1"></span>
          </div>

          <div class="mb-5 relative">
            <label for="newPwd" class="block text-gray-700 mb-1">
              <i class="fas fa-lock mr-1 text-gray-500"></i>New Password
            </label>
            <h:inputSecret
              id="newPwd"
              value="#{providerController.provider.newPassword}"
              styleClass="w-full pr-10 border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <button type="button" onclick="toggleVisibility('newPwd','toggleNewPwdIcon')" class="absolute inset-y-0 right-0 px-3 flex items-center text-gray-500">
              <i id="toggleNewPwdIcon" class="fas fa-eye"></i>
            </button>

            <div class="h-2 bg-gray-200 rounded mt-2 overflow-hidden">
              <div id="strengthIndicator" class="h-full transition-all bg-red-500" style="width:0%"></div>
            </div>
            <div class="mt-1">
              <span id="strengthText" class="text-sm font-medium text-gray-700">Very Weak</span>
            </div>

            <div class="mt-2 text-sm">
  <a
    href="javascript:void(0)"
    onclick="toggleRequirementList()"
    class="font-medium text-blue-600 underline flex items-center"
  >
    <i class="fas fa-info-circle mr-2"></i>
    Password must contain
    <i id="reqToggleIcon" class="fas fa-chevron-down ml-auto text-gray-500"></i>
  </a>

  <ul
    id="reqList"
    class="hidden pl-0 list-none space-y-1 mt-2 text-sm"
  >
    <li id="reqLength"  class="flex items-center text-red-500">
      <span class="mr-2">✗</span>8 or more characters
    </li>
    <li id="reqUpper"   class="flex items-center text-red-500">
      <span class="mr-2">✗</span>Uppercase letter (A–Z)
    </li>
    <li id="reqLower"   class="flex items-center text-red-500">
      <span class="mr-2">✗</span>Lowercase letter (a–z)
    </li>
    <li id="reqNumber"  class="flex items-center text-red-500">
      <span class="mr-2">✗</span>Number (0–9)
    </li>
    <li id="reqSpecial" class="flex items-center text-red-500">
      <span class="mr-2">✗</span>Special character (!@#$%&*)
    </li>
  </ul>
</div>


            <!-- <div class="mt-1 text-right">
              <a href="javascript:void(0)" onclick="togglePwdInstructions()" class="text-blue-600 underline text-sm">
                Password instructions
              </a>
            </div>
            <div id="pwdInstructions" class="hidden bg-gray-100 p-2 rounded text-gray-700 text-sm mt-2">
              At least 8 chars, uppercase, lowercase, number, special character.
            </div> -->
          </div> 

          <div class="mb-6 relative">
            <label for="confirmPwd" class="block text-gray-700 mb-1">
              <i class="fas fa-lock-check mr-1 text-gray-500"></i>Confirm Password
            </label>
            <h:inputSecret
              id="confirmPwd"
              value="#{providerController.provider.confirmPassword}"
              styleClass="w-full pr-10 border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <button type="button" onclick="toggleVisibility('confirmPwd','toggleConfirmPwdIcon')" class="absolute inset-y-0 right-0 px-3 flex items-center text-gray-500">
              <i id="toggleConfirmPwdIcon" class="fas fa-eye"></i>
            </button>
            <span id="msgConfirmPwd" class="hidden text-red-500 text-sm mt-1"></span>
          </div>

          <h:commandButton
            value="Generate Password"
            action="#{providerController.updatePassword}"
            styleClass="w-full bg-blue-600 text-white py-3 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
        </h:form>
      </div>
    </div>
  </body>
</html>
</f:view>