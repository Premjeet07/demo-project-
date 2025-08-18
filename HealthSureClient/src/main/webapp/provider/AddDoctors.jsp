<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %> 
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<f:view>
<html lang="en">
<head><meta charset="UTF-8">
<title>Register Doctor – Infinite HealthSure</title>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<!-- Toastify -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(to right, #e0f7fa, #ffffff);
        margin: 0;
        padding: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .main-container {
        display: flex;
        background: #ffffff;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 1080px;
        overflow: hidden;
    }

    .form-container {
        width: 65%;
        padding: 40px;
    }

    .icon-container {
        width: 35%;
        background: #e0f7fa;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .icon-container i {
        font-size: 130px;
        color: #0288d1;
    }

    h2 {
        color: #0077b6;
        text-align: center;
        margin-bottom: 30px;
    }

    .form-group {
        margin-bottom: 18px;
    }

    label {
        font-weight: bold;
        display: block;
        margin-bottom: 6px;
        color: #333;
    }

    .required {
        color: #e53935;
    }

    .input-field {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 15px;
        box-sizing: border-box;
    }

    .input-field:focus {
        border-color: #0288d1;
        outline: none;
    }

    .field-message {
        color: #d32f2f;
        font-size: 12px;
        padding-top: 4px;
    }

    .submit-button {
        background-color: #0288d1;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 15px;
        font-size: 15px;
        margin: 10px 6px;
        cursor: pointer;
    }

    .submit-button:hover {
        background-color: #0277bd;
    }

    .message-container ul {
        list-style-type: none;
        background-color: #ffe6e6;
        color: #c62828;
        padding: 0.5rem 1rem;
        margin-bottom: 1rem;
        border-radius: 0.5rem;
        font-weight: 500;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    }

    small {
        font-size: 11px;
        color: #777;
    }
</style>
</head>
<body>
<div class="main-container"><!-- Left: Form Area -->
<div class="form-container">
<h2><i class="fas fa-user-md">
</i> Register New Doctor</h2>
<h:form id="doctorForm">
<!-- Global messages -->
<div class="message-container">
    <h:messages id="globalMsg" globalOnly="true" layout="list"
                 style="color:red; font-weight:bold; margin-bottom:10px"/>
</div>

<!-- Provider ID -->
<div class="form-group">
    <label for="providerId"><span class="required">*</span> Provider ID</label>
    <h:inputText id="providerId" 
                 value="#{doctorsController.providerId}" 
                 required="true"
                 readonly="true"
                 styleClass="input-field" 
                 requiredMessage="Provider ID is required."/>
    <h:message for="providerId" styleClass="field-message"/>
</div>

<!-- Doctor Name -->
<div class="form-group">
    <label for="doctorName"><span class="required">*</span> Doctor Name</label>
    <h:inputText id="doctorName" 
                 value="#{doctorsController.doctors.doctorName}" 
                 required="true"
                 requiredMessage="Doctor Name is required."
                 styleClass="input-field"/>
    <h:message for="doctorName" styleClass="field-message"/>
</div>

<!-- Qualification -->
<div class="form-group">
    <label for="qualification"><span class="required">*</span> Qualification</label>
    <h:selectOneMenu id="qualification" 
                     value="#{doctorsController.doctors.qualification}" 
                     required="true"
                     requiredMessage="Qualification is required."
                     styleClass="input-field">
        <f:selectItem itemLabel="-- Select Qualification --" itemValue=""/>
        <f:selectItem itemLabel="MBBS" itemValue="MBBS"/>
        <f:selectItem itemLabel="BDS" itemValue="BDS"/>
        <f:selectItem itemLabel="BAMS" itemValue="BAMS"/>
        <f:selectItem itemLabel="BHMS" itemValue="BHMS"/>
        <f:selectItem itemLabel="BUMS" itemValue="BUMS"/>
        <f:selectItem itemLabel="MD" itemValue="MD"/>
        <f:selectItem itemLabel="MS" itemValue="MS"/>
        <f:selectItem itemLabel="DNB" itemValue="DNB"/>
    </h:selectOneMenu>
    <h:message for="qualification" styleClass="field-message"/>
</div>

<!-- Specialization -->
<div class="form-group">
    <label for="specialization"><span class="required">*</span> Specialization</label>
    <h:selectOneMenu id="specialization" 
                     value="#{doctorsController.doctors.specialization}" 
                     required="true"
                     requiredMessage="Specialization is required." 
                     styleClass="input-field">
        <f:selectItem itemLabel="-- Select Specialization --" itemValue=""/>
        <f:selectItem itemLabel="Cardiologist" itemValue="Cardiologist"/>
        <f:selectItem itemLabel="Dermatologist" itemValue="Dermatologist"/>
        <f:selectItem itemLabel="Neurologist" itemValue="Neurologist"/>
        <f:selectItem itemLabel="Oncologist" itemValue="Oncologist"/>
        <f:selectItem itemLabel="Orthopedic" itemValue="Orthopedic"/>
        <f:selectItem itemLabel="Psychiatrist" itemValue="Psychiatrist"/>
        <f:selectItem itemLabel="General Surgeon" itemValue="General Surgeon"/>
        <f:selectItem itemLabel="Neurosurgeon" itemValue="Neurosurgeon"/>
    </h:selectOneMenu>
    <h:message for="specialization" styleClass="field-message"/>
</div>

<!-- License Number -->
<div class="form-group">
    <label for="licenseNo"><span class="required">*</span> License Number</label>
    <h:inputText id="licenseNo" 
                 value="#{doctorsController.doctors.licenseNo}" 
                 required="true" 
                 requiredMessage="License Number is required."
                 styleClass="input-field"/>
    <small>Format: MH/2023/12345/P</small>
    <h:message for="licenseNo" styleClass="field-message"/>
</div>

<!-- Email -->
<div class="form-group">
    <label for="email"><span class="required">*</span> Email</label>
    <h:inputText id="email" 
                 value="#{doctorsController.doctors.email}" 
                 required="true"
                 requiredMessage="Email is required."
                 styleClass="input-field"/>
    <h:message for="email" styleClass="field-message"/>
</div>

<!-- Phone -->
<div class="form-group">
    <label for="phoneNumber"><span class="required">*</span> Phone Number</label>
    <h:inputText id="phoneNumber" 
                 value="#{doctorsController.doctors.phoneNumber}" 
                 maxlength="10" required="true"
                 requiredMessage="Phone Number is required."
                 styleClass="input-field"/>
    <h:message for="phoneNumber" styleClass="field-message"/>
</div>

<!-- Address -->
<div class="form-group">
    <label for="address"><span class="required">*</span> Address</label>
    <h:inputTextarea id="address" 
                     value="#{doctorsController.doctors.address}" 
                     rows="3" required="true"
                     requiredMessage="Address is required." 
                     styleClass="input-field"/>
    <h:message for="address" styleClass="field-message"/>
</div>

<!-- Gender -->
<div class="form-group">
    <label for="gender"><span class="required">*</span> Gender</label>
    <h:selectOneMenu id="gender" 
                     value="#{doctorsController.doctors.gender}" 
                     required="true"
                     requiredMessage="Gender is required."
                     styleClass="input-field">
        <f:selectItem itemLabel="-- Select Gender --" itemValue=""/>
        <f:selectItem itemLabel="Male" itemValue="MALE"/>
        <f:selectItem itemLabel="Female" itemValue="FEMALE"/>
    </h:selectOneMenu>
    <h:message for="gender" styleClass="field-message"/>
</div>

<!-- Doctor Type -->
<div class="form-group">
    <label for="type"><span class="required">*</span> Doctor Type</label>
    <h:selectOneMenu id="type" 
                     value="#{doctorsController.doctors.doctorType}" 
                     required="true"
                     requiredMessage="Doctor Type is required."
                     styleClass="input-field">
        <f:selectItem itemLabel="-- Select Type --" itemValue=""/>
        <f:selectItem itemLabel="Standard" itemValue="STANDARD"/>
        <f:selectItem itemLabel="Adhoc" itemValue="ADHOC"/>
    </h:selectOneMenu>
    <h:message for="type" styleClass="field-message"/>
</div>

<!-- Buttons -->
<div class="form-group" style="text-align: center;">
    <h:commandButton value="← Back" 
                     action="HomePage.jsp?faces-redirect=true"
                     immediate="true" 
                     styleClass="submit-button"/>
                     
    <h:commandButton value="Add Doctor" 
                     action="#{doctorsController.addDoctors}" 
                     styleClass="submit-button"
                     onclick="Toastify({
                           text: 'Doctor Added Successfully',
                           duration: 5000,
                           gravity: 'top',
                           position: 'center',
                           style: { background: '#4CAF50' }
                           }).showToast();"/>
</div>
</h:form>
</div>

<!-- Right: Icon Area -->
<div class="icon-container">
    <i class="fas fa-stethoscope"></i>
    <p style="color: #0077b6; 
              font-size: 18px; 
              margin-top: 20px;">
              Join Our Expert Medical Team!</p>
</div>
</div>
</body>
</html>
</f:view>