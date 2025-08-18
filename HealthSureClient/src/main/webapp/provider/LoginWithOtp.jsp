<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<!DOCTYPE html>
<html>
<f:view>
<head>
    <title>Login with OTP</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

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
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: white;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 97vh;
      }
      .otp-container {
        background: #fff;
        padding: 40px 30px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        width: 450px;
        text-align: center;
      }
      h2 {
        margin-bottom: 25px;
        color: #333;
        font-size: 26px;
      }
      label {
        display: block;
        text-align: left;
        margin: 15px 0 5px 0;
        font-weight: 600;
        color: #555;
      }
      input[type="text"] {
        width: 100%;
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #ccc;
        font-size: 16px;
      }
      .btn {
        width: 100%;
        padding: 12px;
        margin-top: 20px;
        background-color: #4a90e2;
        border: none;
        color: white;
        font-weight: bold;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
      }
      .btn:hover {
        background-color: #357ab7;
      }
      .message {
        color: red;
        margin-top: 5px;
        font-size: 14px;
      }
      #timer {
        display:;
        margin-top: 10px;
        font-weight: bold;
        color: #d9534f;
      }
      #resendLink {
        display: none;
        color: #007bff;
        cursor: pointer;
        margin-top: 10px;
      }
      .login-link {
        display: inline-block;
        margin-top: 1rem;
        color: #4f46e5;
        font-weight: 600;
        text-decoration: none;
      }
      .login-link:hover {
        text-decoration: underline;
      }
    </style>

   <!-- Countdown Timer Script -->
  <script>
    function startTimer() {
      var duration = 60 * 2; // minutes * seconds
      var display = document.getElementById('timer');
      var timer = duration, minutes, seconds;
      var interval = setInterval(function () {
        minutes = Math.floor(timer / 60);
        seconds = timer % 60;
        display.textContent = 
          (minutes < 10 ? '0' + minutes : minutes) + ':' + 
          (seconds < 10 ? '0' + seconds : seconds);
        if (--timer < 0) {
          clearInterval(interval);
          document.querySelector('[action*="resendOtp"]').click();
        }
      }, 1000);
    }

    // Start timer on page load
    window.addEventListener('load', startTimer);
  </script>
</head>

<body>
  <div class="otp-container">
    <h:form>
      <h2>Login with OTP</h2>

        <div class="message-container">
			<h:messages globalOnly="true" layout="list" />
		</div>

      <label for="email">Email:</label>
      <h:inputText id="email" value="#{providerController.email}" required="true" />
      <h:message for="email" styleClass="message" />

      <h:commandButton id="sendOtpButton"
                       value="Send OTP"
                       action="#{providerController.sendOtpForLogin}"
                       styleClass="btn" />

      <h:panelGroup rendered="#{providerController.otpSent}">
        <script>
          startOtpTimer();
        </script>

        <label for="otpCode">Enter OTP:</label>
        <h:inputText id="otpCode" 
                     value="#{providerController.otpCode}" 
                     required="true" 
                     requiredMessage="OTP is required"/>
        <h:message for="otpCode" styleClass="message" />
        
        <h:commandLink id="resendOtpBtn"
                       action="#{providerController.sendOtpForLogin}"
                       value="Resend OTP"
                       styleClass="resend-link" />

        <!-- Countdown timer -->
        <div id="countdown" class="text-center text-sm text-gray-600 mb-4">
        Time remaining: 
        <span id="timer">02:00</span></div>

        <h:commandButton value="Verify OTP"
                         action="#{providerController.verifyLoginOtp}"
                         styleClass="btn"
                         onclick="toastr.success('✅ OTP Verified!');" />

        <div class="mt-4">
          <h:outputLink value="HomePage.jsf?faces-redirect=true" 
                        styleClass="login-link">
            ⏭ Skip to Homepage
          </h:outputLink>
        </div>
      </h:panelGroup>

      <br/>

      <h:commandLink value="🔑 Login with Password"
                     action="Login.jsp"
                     styleClass="login-link" />
    </h:form>
  </div>
</body>
</f:view>
</html>