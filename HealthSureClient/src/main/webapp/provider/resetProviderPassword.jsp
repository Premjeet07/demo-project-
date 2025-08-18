<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.
 
  Author: Zainab Y
 
  Description: JSF 	Reset-password using CSS for styling.
-->

<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8" />
<title>Change Password</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<style>
body {
	background: linear-gradient(to right, #ece9e6, #ffffff);
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	animation: fadeIn 1s ease-in;
}

.card {
	border-radius: 0.75rem;
	border: 1px solid #dee2e6;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
}

.card:hover {
	transform: scale(1.02);
}

.form-label {
	font-weight: 600;
	color: #343a40;
}

.form-control {
	border-radius: 0.25rem;
	padding-left: 2.5rem;
	position: relative;
}

.form-group {
	position: relative;
}

.form-group::before {
	position: absolute;
	left: 10px;
	top: 10px;
	font-size: 1rem;
}

.error {
	color: #dc3545;
	font-size: 0.9rem;
}

.btn-primary {
	background-color: #0062cc;
	border: none;
	font-weight: bold;
	transition: background-color 0.3s ease;
}

.btn-primary:hover {
	background-color: #004085;
}

.btn-link {
	font-size: 0.95rem;
	color: #007bff;
}

.btn-link:hover {
	text-decoration: underline;
}

.alert-info {
	background-color: #e2f0fb;
	color: #0c5460;
	border-color: #bee5eb;
	font-size: 0.95rem;
}
</style>
<script>
	function togglePasswordVisibility(icon) {
		// Find the closest input field (JSF renders a real <input type="password">)
		var input = icon.parentElement
				.querySelector('input[type="password"], input[type="text"]');
		if (input) {
			input.type = input.type === "password" ? "text" : "password";
		}
	}
</script>

</head>

<body>
	<h:form id="changePwdForm">
		<div class="container py-5">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="card p-4">

						<!-- Instructions -->
						<div class="alert alert-info" role="alert">
							<strong>Password Requirements:</strong>
							<ul class="mb-0">
								<li>Must be <strong>alphanumeric</strong> (include digits
									&amp; special characters)
								</li>
								<li>At least <strong>8–12 characters long</strong></li>
								<li>New password and confirm password must <strong>match</strong></li>
								<li>Don’t reuse any of your <strong>last 3
										passwords</strong></li>
							</ul>
						</div>

						<!-- Global error messages -->
						

						<h:messages globalOnly="true" styleClass="error-message" />




						<!-- Old Password -->
						<div class="form-group position-relative">
							<h:outputLabel for="oldPwd" value="Old Password"
								styleClass="form-label" />

							<h:inputSecret id="oldPwd"
								value="#{providerController.oldPassword}"
								styleClass="form-control" style="padding-right: 40px;" />

							<span class="toggle-password"
								onclick="togglePasswordVisibility(this)"
								style="position: absolute; top: 38px; right: 10px; cursor: pointer;">
								👁️ </span>

							<h:message for="oldPwd" styleClass="error mt-1" />
						</div>





						<!-- New Password -->
						<div class="form-group position-relative">
							<h:outputLabel for="newPwd" value="New Password"
								styleClass="form-label" />

							<h:inputSecret id="newPwd"
								value="#{providerController.newPassword}"
								styleClass="form-control" style="padding-right: 40px;" />

							<span class="toggle-password"
								onclick="togglePasswordVisibility(this)"
								style="position: absolute; top: 38px; right: 10px; cursor: pointer;">
								👁️ </span>

							<h:message for="newPwd" styleClass="error mt-1" />
						</div>
						<!-- Confirm Password -->
						<div class="form-group position-relative">
							<h:outputLabel for="confirmPwd" value="Confirm Password"
								styleClass="form-label" />

							<h:inputSecret id="confirmPwd"
								value="#{providerController.confirmPassword}"
								styleClass="form-control" style="padding-right: 40px;" />

							<span class="toggle-password"
								onclick="togglePasswordVisibility(this)"
								style="position: absolute; top: 38px; right: 10px; cursor: pointer;">
								👁️ </span>

							<h:message for="confirmPwd" styleClass="error mt-1" />
						</div>


						<!-- Submit Button -->
						<div class="form-group">
							<h:commandButton value="Update Password"
								action="#{providerController.resetProviderPassword}"
								styleClass="btn btn-primary btn-block" />
						</div>

						<!-- Navigation Links Cancel -->
						<div class="text-center">
							<h:commandLink value="Cancel" action="dashboard.jsp"
								styleClass="btn btn-link" />
						</div>

					</div>

				</div>
			</div>
		</div>

	</h:form>

	<!-- Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
	</html>
</f:view>
