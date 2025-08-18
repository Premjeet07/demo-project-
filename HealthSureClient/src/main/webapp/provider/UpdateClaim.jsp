<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Insurance Claim</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/updateClaim.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<f:view>

    <!-- 🔗 Navbar -->
    <jsp:include page="/navbar/NavProvider.jsp" />

    <!-- 🧾 Claim Card -->
    <div class="card-container">

        <h:form id="updation">

            <h1 class="page-heading">Update for Insurance Claim</h1>
            <h:messages globalOnly="true" styleClass="global-error" />

            <!-- 🔍 Recipient & Procedure Info -->
            <div class="border-bottom">
                <h2 class="section-header">Recipient & Medical Info</h2>
                <div class="info-grid">
                    <div><strong>Recipient Name:</strong> <h:outputText value="#{sessionScope.claim.recipient.firstName} #{sessionScope.recipient.lastName}" /></div>
                    <div><strong>Health ID:</strong> <h:outputText value="#{sessionScope.recipient.hId}" /></div>
                    <div><strong>Procedure:</strong> <h:outputText value="#{sessionScope.procedure.diagnosis}" /></div>
                    <div><strong>Procedure Date:</strong> <h:outputText value="#{sessionScope.procedure.procedureDate}" /></div>
                    <div><strong>Provider:</strong> <h:outputText value="#{sessionScope.loggedInProvider.providerName}" /></div>
                    <div><strong>Provider ID:</strong> <h:outputText value="#{sessionScope.loggedInProvider.providerId}" /></div>
                </div>
            </div>

            <!-- 🛡️ Insurance Plan Info -->
            <div class="border-bottom">
                <h2 class="section-header">Insurance Details</h2>
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
            <div class="border-bottom">
			    <h2 class="section-header">Update Insurance Plan</h2>
			    <label for="planSelect" class="claim-label">
			        Select New Plan <span style="color: #dc2626;">*</span>
			    </label>
			    <h:selectOneMenu id="planSelect" value="#{claimController.selectedSubscription}" styleClass="claim-input" required="true"
                 requiredMessage="Please select a valid insurance plan.">
			        <f:selectItem itemLabel="-- Select Plan --" itemValue="#{null}" />
			        <f:selectItems value="#{claimController.subscriptions}" var="sub"
			                       itemLabel="#{sub.coverage.insurancePlan.planName} - #{sub.coverage.insurancePlan.insuranceCompany.companyName} (₹#{sub.remainingCoverageAmount})"
			                        itemValue="#{sub.subscribeId}" />
			    </h:selectOneMenu>
			    <h:message for="planSelect" styleClass="error-message" />
			</div>
            <div>
                <h2 class="section-header">Update Claim Amount</h2>
                <label for="amountClaimed" class="claim-label">
                    Amount to Claim <span style="color: #dc2626;">*</span>
                </label>
                <h:inputText id="amountUpdated" value="#{claimController.amountClaimed}"
                             styleClass="claim-input" />
				<h:message  for="amountUpdated" styleClass="error-message" />           
				</div>

            <!-- ✅ Submit -->
            <div style="text-align: center; margin-top: 1.5rem;">
                <h:commandButton value="Update Claim"
                                 action="#{claimController.updateClaim}"
                                 styleClass="submit-btn" />
            </div>
            <div style="text-align: center; margin-top: 1.5rem;">
                <h:commandButton style="background-color: #4b5563; color: white;"
                				 value="Back to show Claims"
                                 action="ShowPendingOrDeclinedClaims"
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
