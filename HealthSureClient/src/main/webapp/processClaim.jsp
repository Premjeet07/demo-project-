<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
	<html>
<head>
<title>Process Claim</title>
<link
	href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;700&display=swap"
	rel="stylesheet">
<style>
body {
	background: linear-gradient(110deg, #e6f1fd 55%, #d8f3fa 100%);
	font-family: 'Rubik', 'Segoe UI', sans-serif;
	margin-top: 110px;
	padding: 0;
}

.container {
	width: 610px;
	margin: 50px auto 35px auto;
	background-color: #fff;
	padding: 36px 36px 22px 36px;
	border-radius: 20px;
	box-shadow: 0 10px 28px 0 #9ed8fb42, 0 2px 4px #bfe4fa15;
}

h2 {
	text-align: center;
	color: #2350a0;
	font-size: 29px;
	font-weight: 800;
	margin-bottom: 28px;
	letter-spacing: 0.062em;
}

h3 {
	color: #2263a8;
	font-size: 20px;
	margin-bottom: 13px;
	font-weight: 700;
}

.section {
	margin-bottom: 30px;
	padding: 20px 23px 17px 23px;
	border: 1.5px solid #d4e6fb;
	border-radius: 16px;
	background: #f6fbff;
	box-shadow: 0 2.5px 10px #cdecfc18;
}

.row {
	margin-bottom: 14px;
	font-size: 16px;
	display: flex;
	align-items: center;
}

.label {
	display: inline-block;
	font-weight: bold;
	font-size: 15px;
	color: #20548e;
	width: 170px;
	min-width: 120px;
}

select, textarea, input[type="text"], .jsf-textarea {
	width: 65%;
	padding: 8px 12px;
	border-radius: 8px;
	border: 1.5px solid #a6bbe7;
	background: #fafdff;
	font-size: 16px;
	font-family: 'Rubik', 'Segoe UI', sans-serif;
	box-shadow: inset 0 2px 5px #6bb8ed12;
	transition: border 0.18s, background 0.18s;
}

select:focus, textarea:focus, input[type="text"]:focus {
	border: 1.5px solid #338de2;
	background: #e5f3fb;
	outline: none;
}

.radio-option {
	margin-right: 25px;
}

.buttons {
	text-align: center;
	margin-top: 20px;
}

.btn {
	padding: 12px 35px;
	font-size: 16px;
	font-weight: bold;
	border: none;
	border-radius: 10px;
	margin: 0 16px;
	cursor: pointer;
	background: linear-gradient(90deg, #3181d1 70%, #90d0fa 100%);
	color: white;
	box-shadow: 0 3px 14px #87bff644;
	transition: background 0.2s, transform 0.16s;
}

.btn:hover {
	background: linear-gradient(90deg, #1557a1 60%, #45b7f7 100%);
	transform: translateY(-1.2px) scale(1.05);
}

h\:messages {
	color: #d12f34;
	margin-bottom: 10px;
	display: block;
	font-weight: bold;
	text-align: center;
}
/* Responsive for small screens */
@media ( max-width : 700px) {
	.container {
		width: 98vw;
		padding: 7vw 2vw;
	}
	.section {
		padding: 2vw 2vw;
	}
	.label {
		width: 37vw;
		font-size: 14px;
	}
	select, textarea, .jsf-textarea {
		width: 90%;
	}
}
.btn-cancel {
            background-color: #5c86a6;
            color: white;
            padding: 11px 32px;
            border: none;
            border-radius: 9px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 2px 8px #aac6e250;
            transition: background 0.14s;
            letter-spacing: 0.03em;
        }
        .btn-cancel:hover {
            background-color: #173a60;
        }
</style>
<script type="text/javascript">
        var formId = 'form'; // matches h:form id below
        function onStatusChange() {
            var approveDiv = document.getElementById(formId + ':approveReasonDiv');
            var denyDiv = document.getElementById(formId + ':denyReasonDiv');
            var otherDiv = document.getElementById(formId + ':otherReasonDiv');
            var statusRadios = document.getElementsByName(formId + ':status');
            var selectedStatus = null;
            for (var i = 0; i < statusRadios.length; i++) {
                if (statusRadios[i].checked) {
                    selectedStatus = statusRadios[i].value;
                    break;
                }
            }
            // Toggle Approve/Deny blocks
            if (selectedStatus === "APPROVED") {
                if (approveDiv) approveDiv.style.display = 'block';
                if (denyDiv) denyDiv.style.display = 'none';
            } else if (selectedStatus === "DENIED") {
                if (approveDiv) approveDiv.style.display = 'none';
                if (denyDiv) denyDiv.style.display = 'block';
            } else {
                if (approveDiv) approveDiv.style.display = 'none';
                if (denyDiv) denyDiv.style.display = 'none';
            }
            // Show Other Reason if "Other" selected
            var showOther = false;
            if (selectedStatus === "APPROVED") {
                var approveReasonSelect = document.getElementById(formId + ':approveReason');
                if (approveReasonSelect && approveReasonSelect.value === 'Other') showOther = true;
            } else if (selectedStatus === "DENIED") {
                var denyReasonSelect = document.getElementById(formId + ':denyReason');
                if (denyReasonSelect && denyReasonSelect.value === 'Other') showOther = true;
            }
            if (otherDiv) otherDiv.style.display = showOther ? 'block' : 'none';
        }
        window.onload = function() {
            onStatusChange();
            // Add event listeners
            var statusRadios = document.getElementsByName(formId + ':status');
            for (var i = 0; i < statusRadios.length; i++) {
                statusRadios[i].onclick = onStatusChange;
            }
            var approveReasonSelect = document.getElementById(formId + ':approveReason');
            if (approveReasonSelect) approveReasonSelect.onchange = onStatusChange;
            var denyReasonSelect = document.getElementById(formId + ':denyReason');
            if (denyReasonSelect) denyReasonSelect.onchange = onStatusChange;
        };
    </script>
</head>
<body>
<jsp:include page="Navbar.jsp"/>

	<div class="container">
		<h2>Process Claim</h2>
		<h:form id="form">
			<h:messages globalOnly="true"
				style="color: #219653; font-weight: bold; text-align: center; font-size: 18px; margin-bottom: 22px;" />

			<!-- Claim Details -->
			<div class="section">
				<h3>Claim Details</h3>
				<div class="row">
					<span class="label">Claim ID:</span>
					<h:outputText value="#{processClaimController.claim.claimId}" />
				</div>
				<div class="row">
					<span class="label">Recipient ID:</span>
					<h:outputText value="#{processClaimController.claim.recipient.hId}" />
				</div>
				<div class="row">
					<span class="label">Policy ID:</span>
					<h:outputText
						value="#{processClaimController.claim.subscribe.subscribeId}" />
				</div>

				<div class="row">
					<span class="label">Provider:</span>
					<h:outputText
						value="#{processClaimController.claim.provider.providerId}" />
					-
					<h:outputText
						value="#{processClaimController.claim.provider.providerName}" />
					-
					<h:outputText
						value="#{processClaimController.claim.provider.hospitalName}" />
				</div>
				<div class="row">
					<span class="label">Procedure:</span>
					<h:outputText
						value="#{processClaimController.claim.procedure.procedureId}" />
				</div>
				<div class="row">
					<span class="label">Claim Date:</span>
					<h:outputText value="#{processClaimController.claim.claimDate}">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:outputText>
				</div>
				<div class="row">
					<span class="label">Status:</span>
					<h:outputText value="#{processClaimController.claim.claimStatus}" />
				</div>
			</div>

			<!-- Payment Details -->
			<div class="section">
				<h3>Payment Details</h3>
				<div class="row">
					<span class="label">Amount Claimed:</span>
					<h:outputText value="#{processClaimController.claim.amountClaimed}" />
				</div>
				<!--   <div class="row">
                <span class="label">Amount Approved:</span>
                <h:outputText value="#{processClaimController.claim.amountApproved}" />
            </div> -->
				<div class="row">
					<span class="label">Available Coverage:</span>
					<h:outputText
						value="#{processClaimController.remainingCoverageAmount}" />
				</div>
			</div>

			<!-- Decision Section -->
			<div class="section">
				<h3>Decision</h3>
				<div class="row">
					<span class="label">Action:</span>
					<h:selectOneRadio id="status" 
						value="#{processClaimController.status}"
						valueChangeListener="#{processClaimController.onStatusChange}"
						immediate="true" onchange="this.form.submit();">
						<f:selectItem itemValue="APPROVED" itemLabel="Approve" />
						<f:selectItem itemValue="DENIED" itemLabel="Deny" />
					</h:selectOneRadio>

				</div>
				<h:message for="status" style="color:red" />
				<!-- Approve Reason Dropdown -->
				<div id="form:approveReasonDiv" style="display: none;">
					<div class="row">
						<span class="label">Approval Reason:</span>
						<h:selectOneMenu id="approveReason"
							value="#{processClaimController.approveReason}">
							<f:selectItem itemValue="" itemLabel="-- Select Reason --" />
							<f:selectItem itemValue="All Documents Verified"
								itemLabel="All Documents Verified" />
							<f:selectItem itemValue="Eligible Procedure"
								itemLabel="Eligible Procedure" />
							<f:selectItem itemValue="Policy Coverage Confirmed"
								itemLabel="Policy Coverage Confirmed" />
							<f:selectItem itemValue="Other" itemLabel="Other (Specify Below)" />
						</h:selectOneMenu>


					</div>
					<h:message for="approveReason" style="color:red" />
				</div>
				<!-- Deny Reason Dropdown -->
				<div id="form:denyReasonDiv" style="display: none;">
					<div class="row">
						<span class="label">Denial Reason:</span>
						<h:selectOneMenu id="denyReason"
							value="#{processClaimController.denyReason}">
							<f:selectItem itemValue="" itemLabel="-- Select Reason --" />
							<f:selectItem itemValue="Incorrect Details"
								itemLabel="Incorrect Details" />
							<f:selectItem itemValue="Exceeds Coverage Limit"
								itemLabel="Exceeds Coverage Limit" />
							<f:selectItem itemValue="Invalid Coverage"
								itemLabel="Invalid Coverage" />
							<f:selectItem itemValue="Other" itemLabel="Other (Specify Below)" />
						</h:selectOneMenu>
						<h:message for="denyReason" style="color:red" />
					</div>
				</div>
				<!-- Other Reason Textarea -->
				<div id="form:otherReasonDiv" style="display: none;">
					<div class="row">
						<span class="label">Other Reason:</span>
						<h:inputTextarea id="otherReasonTextArea"
							value="#{processClaimController.otherReason}" rows="3"
							styleClass="jsf-textarea" />
					</div>
					<h:message for="otherReasonTextArea" style="color:red" />
				</div>
			</div>


			<!--<h:panelGroup rendered="#{processClaimController.claimProcessed}">
    <h:outputText value="#{processClaimController.finalStatusMessage}" style="color:green; font-weight:bold;" />
</h:panelGroup>--!>


        <!-- Buttons -->
			<div class="buttons">
				<!--       <h:commandButton value="Submit" action="#{processClaimController.processClaim}" styleClass="btn" />   -->

				<h:commandButton value="Submit"
					action="#{processClaimController.processClaim}" styleClass="btn" />

				<h:commandButton value="Reset"
					action="#{processClaimController.reset}" styleClass="btn" />
			</div>
			<div class="search-btn-row">
			<h:commandButton value="Back"
				action="searchClaims" styleClass="btn-cancel" />
		</div>
		</h:form>
	</div>
</body>
	</html>
</f:view>
