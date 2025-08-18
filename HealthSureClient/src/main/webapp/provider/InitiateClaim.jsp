<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
    <title>Apply Insurance Claim</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/InitiateClaim.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<f:view>

    <!-- 🔗 Navbar -->
    <jsp:include page="/navbar/NavProvider.jsp" />

    <!-- 🧾 Claim Card -->
    <div class="claim-card">

        <h:form id="application">

            <h1 class="page-title">Apply for Insurance Claim</h1>
            <h:messages globalOnly="true" styleClass="error-messages" />

            <!-- 🔍 Recipient & Procedure Info -->
            <div class="section-border">
                <h2 class="section-heading">Recipient & Medical Info</h2>
                <div class="info-grid">
                    <div><strong>Recipient Name:</strong> <h:outputText value="#{sessionScope.recipient.firstName} #{sessionScope.recipient.lastName}" /></div>
                    <div><strong>Health ID:</strong> <h:outputText value="#{sessionScope.recipient.hId}" /></div>
                    <div><strong>Procedure:</strong> <h:outputText value="#{sessionScope.procedure.diagnosis}" /></div>
                    <div><strong>Procedure Date:</strong> <h:outputText value="#{sessionScope.procedure.procedureDate}" /></div>
                    <div><strong>Provider:</strong> <h:outputText value="#{sessionScope.loggedInProvider.providerName}" /></div>
                    <div><strong>Provider ID:</strong> <h:outputText value="#{sessionScope.loggedInProvider.providerId}" /></div>
                </div>
            </div>

            <!-- 🛡️ Insurance Plan Info -->
            <div class="section-border">
                <h2 class="section-heading">Insurance Details</h2>
                <div class="info-grid">
                    <div><strong>Plan Name:</strong> <h:outputText value="#{sessionScope.selectedSubscribe.coverage.insurancePlan.planName}" /></div>
                    <div><strong>Company:</strong> <h:outputText value="#{sessionScope.selectedSubscribe.coverage.insurancePlan.insuranceCompany.companyName}" /></div>
                    <div><strong>Remaining Coverage Amount:</strong> ₹<h:outputText value="#{sessionScope.selectedSubscribe.remainingCoverageAmount}" /></div>
                    <div><strong>Premium Paid:</strong> ₹<h:outputText value="#{sessionScope.selectedSubscribe.amountPaid}" /></div>
                    <div><strong>Subscription:</strong> <h:outputText value="#{sessionScope.selectedSubscribe.subscribeDate}" /></div>
                    <div><strong>Valid Till:</strong> <h:outputText value="#{sessionScope.selectedSubscribe.expiryDate}" /></div>
                </div>
            </div>

            <!-- 💵 Claim Section -->
            <div>
                <h2 class="section-heading">Claim Request</h2>
                <label for="amountClaimed" class="input-label">
                    Amount to Claim <span style="color: #dc2626;">*</span>
                </label>
                <h:inputText id="amountClaimed" value="#{claimController.amountClaimed}"
                             styleClass="claim-input" /><br>
                 <!-- 💬 System Message -->
           		<h:message for="amountClaimed" style="color:red; font-size:12px;" />
            </div>

            <!-- ✅ Submit -->
            <div style="text-align: center; margin-top: 1.5rem;">
                <h:commandButton value="Submit Claim"
                                 action="#{claimController.submitClaim}"
                                 styleClass="submit-btn" /><br>
                <h:commandButton style="margin-top: 1.5rem; background-color: #4b5563; color: white;" value="Back to Insurance Plans"
                                 action="selectInsurancePlan"
                                 styleClass="submit-btn" />
            </div>

           

            <!-- ✳️ Required Field Note -->
            <p class="required-note">
                <span style="color: #dc2626;">*</span> All starred fields are required for submission.
            </p>

        </h:form>

    </div>
	    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />
</f:view>
</body>
</html>
