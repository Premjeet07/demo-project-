<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html >
<f:view>
  <head>
    <meta charset="UTF-8"/>
    <title>Provider SignUp</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

    <!-- Google Font & Tailwind -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
   

    <style>
      body { font-family: 'Poppins', sans-serif; }
      /* override Tailwind for floating labels */
      .form-group input::placeholder { color: transparent; }
      .form-group label {
        transition: transform .2s, color .2s;
      }
      .form-group input:focus + label,
      .form-group input:not(:placeholder-shown) + label {
        transform: translateY(-1.5rem) scale(.85);
        color: #3b82f6; /* blue-500 */
      }
    </style>
  </head>

  <body class="min-h-screen bg-gradient-to-br from-indigo-50 to-indigo-100 flex items-center justify-center p-4">
    <div class="w-full max-w-5xl bg-white rounded-2xl shadow-2xl overflow-hidden grid grid-cols-1 lg:grid-cols-2">
      
      <!-- Left Visual Panel -->
      <div class="hidden lg:flex flex-col items-center justify-center bg-gradient-to-tr from-indigo-600 to-purple-600 text-white p-10">
        <i class="fas fa-user-md text-6xl mb-6"></i>
        <h2 class="text-3xl font-semibold mb-2">Join HealthSure</h2>
        <p class="text-center text-indigo-100">
          Sign up to manage appointments, verify patients,<br/>
          and view reports in one sleek dashboard.
        </p>
      </div>

      <!-- Right Form Panel -->
      <div class="p-8">
        <h:form prependId="false" styleClass="space-y-6">
          
          <h2 class="text-2xl font-semibold text-gray-800 text-center">Provider SignUp</h2>
          <h:messages globalOnly="true" layout="table" 
                     styleClass="text-green-600 font-medium"
                      id="globalMsgs"/>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <!-- Provider Name -->
            <div class="relative form-group">
              <h:inputText id="providerName"
                           value="#{providerController.provider.providerName}"
                           required="true"
                           requiredMessage="Provider name is required"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="providerName" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> Provider Name
              </label>
              <h:message for="providerName" styleClass="text-red-500 text-sm mt-1"/>
            </div>

            <!-- Hospital Name -->
            <div class="relative form-group">
              <h:inputText id="hospitalName"
                           value="#{providerController.provider.hospitalName}"
                           required="true"
                           requiredMessage="Hospital name is required"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="hospitalName" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> Hospital Name
              </label>
              <h:message for="hospitalName" styleClass="text-red-500 text-sm mt-1"/>
            </div>

            <!-- Telephone -->
            <div class="relative form-group">
              <h:inputText id="telephone"
                           value="#{providerController.provider.telephone}"
                           maxlength="10"
                           required="true"
                           requiredMessage="Phone number is required"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="telephone" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> Phone Number
              </label>
              <h:message for="telephone" styleClass="text-red-500 text-sm mt-1"/>
            </div>

            <!-- Email -->
            <div class="relative form-group">
              <h:inputText id="email"
                           value="#{providerController.provider.email}"
                           required="true"
                           requiredMessage="Email is required"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="email" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> Email
              </label>
              <h:message for="email" styleClass="text-red-500 text-sm mt-1"/>
            </div>

            <!-- Address (full width) -->
            <div class="relative form-group md:col-span-2">
              <h:inputTextarea id="address"
                               value="#{providerController.provider.address}"
                               rows="3"
                               required="true"
                               requiredMessage="Address is required"
                               styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent resize-none"/>
              <label for="address" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> 
              </label>
              <h:message for="address" styleClass="text-red-500 text-sm mt-1"/>
            </div>

            <!-- City, State, Zipcode in one row -->
            <div class="relative form-group">
              <h:inputText id="city"
                           value="#{providerController.provider.city}"
                           required="true"
                           requiredMessage="City is required"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="city" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> City
              </label>
              <h:message for="city" styleClass="text-red-500 text-sm mt-1"/>
            </div>
            <div class="relative form-group">
              <h:inputText id="state"
                           value="#{providerController.provider.state}"
                           required="true"
                           requiredMessage="State is required"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="state" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> State
              </label>
              <h:message for="state" styleClass="text-red-500 text-sm mt-1"/>
            </div>
            <div class="relative form-group">
              <h:inputText id="zipcode"
                           value="#{providerController.provider.zipcode}"
                           required="true"
                           requiredMessage="Zipcode is required"
                           maxlength="6"
                           styleClass="peer block w-full border-b-2 border-gray-300 focus:border-blue-500 py-2 px-1 bg-transparent"/>
              <label for="zipcode" class="absolute left-1 top-2 text-gray-500">
                <span class="text-red-500">*</span> Zipcode
              </label>
              <h:message for="zipcode" styleClass="text-red-500 text-sm mt-1"/>
            </div>
          </div>

          <!-- Submit Button -->
           <div class="text-center mt-6">
    <h:commandButton
      value="Sign Up"
      action="#{providerController.register}"
      styleClass="bg-green-600 hover:bg-green-700 text-white font-bold py-2 px-6 rounded shadow-md"
      onclick="Toastify({
        text: 'Provider registered successfully',
        duration: 5000,
        gravity: 'top',
        position: 'center',
        style: { background: '#4CAF50' }
      }).showToast();"/>
  </div>

        </h:form>
      </div>
    </div>
    
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<c:if test="${not empty facesContext.messageList}">
  <script type="text/javascript">
    (function showFacesToasts() {
      if (typeof Toastify === 'undefined') {
        setTimeout(showFacesToasts, 100);
        return;
      }

      <c:forEach var="msg" items="${facesContext.messageList}">
        Toastify({
          text: "${fn:escapeXml(msg.summary)}",
          duration: 4000,
          gravity: "top",
          position: "center",
          style: {
            /* INFO → green, others → red */
            background: "${msg.severity == 'INFO' ? '#4caf50' : '#d32f2f'}",
            color: "#fff",
            borderRadius: "6px"
          }
        }).showToast();
      </c:forEach>

    })();
  </script>
</c:if>

  
  </body>
</f:view>
</html>