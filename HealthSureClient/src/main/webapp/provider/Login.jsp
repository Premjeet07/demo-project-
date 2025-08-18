<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<f:view>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Provider Login - Infinite HealthSure</title>

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <!-- Toastify -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <style>
    .message-container ul  {
    list-style-type: none;
	background-color: #ffe6e6; /* Light red background for visibility */
	color: #c62828; /* Strong red text */
	padding: 0.5rem 1rem;
	margin-bottom: 0.5rem;
	border-radius: 0.5rem;
	font-weight: 500;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}
      body {
        background-color: #f1f5f9;
        font-family: 'Segoe UI', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin-top: 5%;
      }

      .login-card {
        background-color: #ffffff;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 400px;
      }

      .login-header {
        text-align: center;
        margin-bottom: 1.5rem;
      }

      .login-header i {
        font-size: 2.5rem;
        color: #4f46e5;
      }

      .login-header h2 {
        margin-top: 0.5rem;
        font-size: 1.5rem;
        color: #1e293b;
      }

      .subtitle {
        font-size: 0.9rem;
        color: #6b7280;
      }

      .input-group {
        position: relative;
        margin-bottom: 1.5rem;
      }

      .input-group i.prefix {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #9ca3af;
        font-size: 1rem;
      }

      .input-group i.toggle-password {
        position: absolute;
        right: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #9ca3af;
        cursor: pointer;
        font-size: 1rem;
      }

      .input-field {
        width: 100%;
        padding: 0.75rem 2.5rem 0.75rem 2.5rem;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 1rem;
        background-color: #fff;
        box-sizing: border-box;
      }

      .input-field:focus {
        outline: none;
        border-color: #6366f1;
      }

      .btn {
        width: 100%;
        padding: 0.75rem;
        background-color: #4f46e5;
        color: white;
        border: none;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        font-size: 1rem;
      }

      .btn:hover {
        background-color: #4338ca;
      }

      .link {
        display: block;
        text-align: center;
        margin-top: 1rem;
        font-size: 0.9rem;
        color: #4f46e5;
        text-decoration: none;
      }

      .link:hover {
        text-decoration: underline;
      }

      .error-message {
        color: #dc2626;
        font-size: 0.85rem;
        margin-top: 0.3rem;
        padding-left: 2.5rem;
      }

      .global-errors {
        color: #dc2626;
        font-size: 0.85rem;
        text-align: center;
        margin-bottom: 1rem;
      }
    </style>

    <script>
      function togglePassword() {
        const pwd = document.getElementById('loginForm:password');
        const icon = document.getElementById('togglePwdIcon');
        if (pwd.type === 'password') {
          pwd.type = 'text';
          icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
          pwd.type = 'password';
          icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
      }
    </script>
  </head>

  <body>
  	    <jsp:include page="/navbar/NavAuthentication.jsp" />
  	
    <h:form id="loginForm">
      <div class="login-card">
        <div class="login-header">
          <i class="fas fa-infinity"></i>
          <h2>Infinite HealthSure</h2>
          <div class="subtitle">Provider Login</div>
        </div>

        <!-- Global Messages -->
       <div class="message-container">
			<h:messages globalOnly="true" layout="list" />
		</div>
		
		
        <div class="input-group">
          <i class="fas fa-envelope prefix"></i>
          <h:inputText id="email"
                       value="#{providerController.provider.email}"
                       required="true"
                       requiredMessage="Email is required"
                       styleClass="input-field"
                       />
          <h:message for="email" styleClass="error-message"/>
        </div>

        <!-- Password -->
        <div class="input-group">
          <i class="fas fa-lock prefix"></i>
          <h:inputSecret id="password"
                         value="#{providerController.provider.password}"
                         required="true"
                         requiredMessage="Password is required"
                         styleClass="input-field"
                         />
          <i id="togglePwdIcon" class="fas fa-eye toggle-password" onclick="togglePassword()"></i>
          <h:message for="password" styleClass="error-message"/>
        </div>

        <!-- Submit -->
        <h:commandButton value="Login"
                         action="#{providerController.login}"
                         styleClass="btn" />

        <!-- Links -->
        <h:outputLink value="ResetPassword.jsf" styleClass="link">
          Reset Password?
        </h:outputLink>
        <h:outputLink value="LoginWithOtp.jsf" styleClass="link">
           Login With OTP
        </h:outputLink>
        
      </div>
      
      <h:outputLink value="SignUp.jsf" styleClass="link">
          Don't have an account? Sign Up
        </h:outputLink>
        
    </h:form>

    <!-- Success popup + redirect -->
    <c:url var="dashboardUrl" value="/dashboard.xhtml" />
    <c:if test="${not empty facesContext.messageList}">
      <script type="text/javascript">
        (function showLoginSuccess() {
          if (typeof Toastify === 'undefined') {
            setTimeout(showLoginSuccess, 100);
            return;
          }

          <c:forEach var="msg" items="${facesContext.messageList}">
            <c:if test="${msg.summary eq 'Login Successful'}">
              Toastify({
                text: "${fn:escapeXml(msg.summary)}",
                duration: 3000,
                close: true,
                gravity: "top",
                position: "center",
                style: {
                  background: "#4caf50",
                  color: "#fff",
                  borderRadius: "6px"
                }
              }).showToast();

              setTimeout(function() {
                window.location.href = '${dashboardUrl}';
              }, 4000);
            </c:if>
          </c:forEach>
        })();
      </script>
    </c:if>
  </body>
</html>
</f:view>