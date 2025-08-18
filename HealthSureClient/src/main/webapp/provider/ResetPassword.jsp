<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<f:view>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Change Password</title>
  <style>
    body { font-family: 'Segoe UI', sans-serif; background: #f4f4f4; }
    .container { max-width: 400px; margin: 60px auto; padding: 30px; background: #fff; border-radius:8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    .form-group { margin-bottom: 20px; position: relative; }
    .form-control { width:100%; padding:10px; font-size:14px; border:1px solid #ccc; border-radius:4px; }
    .btn { width:100%; padding:10px; background:#10a37f; color:#fff; border:none; font-size:16px; cursor:pointer; border-radius:4px; }
    .btn:hover { background:#0e8c6a; }
    .toggle-btn { position:absolute; top:35px; right:10px; background:none; border:none; cursor:pointer; }
    .strength-bar { height:8px; background:#eee; border-radius:4px; overflow:hidden; margin-top:5px; }
    .strength-indicator { width:0; height:100%; transition: width 0.3s; }
    .strength-weak { background:#dc3545; width:25%; }
    .strength-medium { background:#ffc107; width:50%; }
    .strength-strong { background:#28a745; width:75%; }
    .strength-very-strong { background:#007bff; width:100%; }
    #capsWarning { color:#d00; display:none; margin-top:5px; }
  </style>
  
  <script>
    function toggleShow(id, btn) {
      const inp = document.getElementById(id);
      inp.type = inp.type === 'password' ? 'text' : 'password';
      btn.textContent = inp.type === 'text' ? 'Hide' : 'Show';
    }
    document.addEventListener('DOMContentLoaded', function() {
      const np = document.getElementById('newPassword');
      const ci = document.getElementById('strengthIndicator');
      const ct = document.getElementById('strengthText');
 
      function checkStrength(val) {
        let score = 0;
        if (val.length >= 8) score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;
        return score;
      }
 
      np.addEventListener('input', () => {
        const s = checkStrength(np.value);
        ci.className = 'strength-indicator';
        let txt = '';
        switch (s) {
          case 0: case 1: ci.classList.add('strength-weak'); txt='Weak'; break;
          case 2: ci.classList.add('strength-medium'); txt='Medium'; break;
          case 3: ci.classList.add('strength-strong'); txt='Strong'; break;
          case 4: ci.classList.add('strength-very-strong'); txt='Very Strong'; break;
        }
        ct.textContent = txt;
      });
 
      np.addEventListener('keydown', e => {
        document.getElementById('capsWarning').style.display = e.getModifierState('CapsLock') ? 'block' : 'none';
      });
    });
  </script>
</head>
<body>
  <div class="container">
    <h2>Reset Password</h2>
    <h:form>
      <div class="form-group">
        <h:outputLabel for="email" value="Email:" />
        <h:inputText id="email" value="#{userController.user.email}" styleClass="form-control" required="true" />
        <h:message for="email" style="color:red" />
      </div>
 
      <div class="form-group">
        <h:outputLabel for="oldPassword" value="Old Password:" />
        <h:inputSecret id="oldPassword" value="#{userController.oldPassword}" styleClass="form-control" required="true"/>
        <h:message for="oldPassword" style="color:red" />
      </div>
 
      <div class="form-group">
        <h:outputLabel for="newPassword" value="New Password:" />
        <h:inputSecret id="newPassword" value="#{userController.newPassword}" styleClass="form-control" required="true"/>
        <button type="button" class="toggle-btn" onclick="toggleShow('newPassword', this)">Show</button>
        <div id="capsWarning">⚠ Caps Lock is on!</div>
        <div class="strength-bar"><div id="strengthIndicator" class="strength-indicator"></div></div>
        <div id="strengthText" style="text-align:right; font-size:12px;"></div>
        <h:message for="newPassword" style="color:red" />
      </div>
 
      <div class="form-group">
        <h:outputLabel for="confirmPassword" value="Confirm New Password:" />
        <h:inputSecret id="confirmPassword" value="#{userController.confirmPassword}" styleClass="form-control" required="true"/>
        <h:message for="confirmPassword" style="color:red" />
      </div>
 
      <div class="form-group">
        <h:commandButton value="Change Password" action="#{userController.changePassword}" styleClass="btn" />
      </div>
    </h:form>
  </div>
</body>
</html>
</f:view>