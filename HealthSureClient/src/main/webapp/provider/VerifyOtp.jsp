<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<f:view>
<head>
  <meta charset="UTF-8"/>
  <title>Verify OTP</title>
  
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
  
  <!-- Tailwind CSS -->
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
        rel="stylesheet"/>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap"
        rel="stylesheet"/>

  <style>
    body { font-family: 'Poppins', sans-serif; }
    .form-input::placeholder { color: transparent; }
    .form-group label {
      transition: transform .2s, color .2s;
    }
    .form-input:focus + label,
    .form-input:not(:placeholder-shown) + label {
      transform: translateY(-1.2rem) scale(.85);
      color: #3b82f6;
    }
    /* countdown text */
    #countdown {
      color: #6b7280; /* gray-500 */
      font-weight: 500;
    }
  </style>
</head>

<body class="min-h-screen bg-gray-100 flex items-center justify-center p-4">
  <div class="bg-white rounded-2xl shadow-xl overflow-hidden grid grid-cols-1 md:grid-cols-2 w-full max-w-4xl">
    <!-- Left image/branding panel -->
    <div class="hidden md:flex items-center justify-center bg-gradient-to-tr from-blue-600 to-indigo-600 p-10">
      <div class="text-center">
        <i class="fas fa-shield-alt text-white text-6xl mb-4"></i>
        <h2 class="text-white text-3xl font-semibold mb-2">Secure Verification</h2>
        <p class="text-indigo-200">
          Enter the code we sent to your email.<br/>
          Keep your account safe and sound.
        </p>
      </div>
    </div>

    <!-- Right form panel -->
    <div class="p-8">
      <h:form prependId="false" styleClass="space-y-6">
        <h2 class="text-2xl font-semibold text-gray-800 text-center">OTP Verification</h2>

        <!-- Email field -->
        <div class="relative form-group">
          <h:inputText id="email"
                       value="#{providerController.provider.email}"
                       required="true"
                       requiredMessage="Email is required"
                       styleClass="form-input peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
          <label for="email" class="absolute left-1 top-2 text-gray-500">
            Email Address
          </label>
          <h:message for="email" styleClass="text-red-500 text-sm mt-1"/>
        </div>

        <!-- OTP code field -->
        <div class="relative form-group">
          <h:inputText id="otp"
                       value="#{providerController.otpCode}"
                       required="true"
                       requiredMessage="OTP is required"
                       styleClass="form-input peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
          <label for="otp" class="absolute left-1 top-2 text-gray-500">
            OTP Code
          </label>
          <h:commandLink value="Resend Code"
                         action="#{providerController.resendOtp}"
                         styleClass="absolute right-0 top-2 text-sm text-blue-600 hover:text-blue-800"/>
          <h:message for="otp" styleClass="text-red-500 text-sm mt-1"/>
        </div>

        <!-- Countdown timer -->
        <div id="countdown" class="text-center" jsf:oncomplete="startTimer()">
          Time remaining: <span id="timer">02:00</span>
        </div>

        <!-- JSF messages -->
        <h:messages globalOnly="true" layout="list"
                    infoClass="text-green-600 font-medium"
                    warnClass="text-yellow-600 font-medium"
                    errorClass="text-red-600 font-medium"/>

        <!-- Submit button -->
        <div class="text-center">
          <h:commandButton value="Verify OTP"
                           action="#{providerController.verifyOtp}"
                           styleClass="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-8 rounded-full shadow-md"
                           onclick="Toastify({
                           text: 'OTP Verify Successfully',
                           duration: 5000,
                           close: true,
                           gravity: 'top',
                           position: 'center',
                           style: { background: '#4CAF50' }
                           }).showToast();"/>
        </div>
      </h:form>
    </div>
  </div>

  <!-- Icons & Toastify -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

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
  

<c:if test="${not empty facesContext.messageList}">
  <script type="text/javascript">
    (function showOtpToast() {
      if (typeof Toastify === 'undefined') {
        setTimeout(showOtpToast, 100);
        return;
      }

      <c:forEach var="msg" items="${facesContext.messageList}">
        <!-- only fire for our OTP‐verified message -->
        <c:if test="${msg.summary eq 'OTP Verified Successfully'}">
          Toastify({
            text: "${fn:escapeXml(msg.summary)}",
            duration: 4000,
            gravity: "top",
            position: "center",
            style: {
              background: "#4caf50",
              color:      "#fff",
              borderRadius: "6px"
            }
          }).showToast();
        </c:if>
      </c:forEach>
    })();
  </script>
</c:if>
</body>
</f:view>
</html>