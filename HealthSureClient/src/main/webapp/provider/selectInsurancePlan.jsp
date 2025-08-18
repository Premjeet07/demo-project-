<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Insurance Plan</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/selectInsurancePlan.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<f:view>
<body>

    <!-- Navbar -->
    <div class="mb-6">
        <jsp:include page="/navbar/NavProvider.jsp" />
    </div>

    <h:form>
        <div class="page-box">
            <h1 class="page-title">
                Select an Active Insurance Plan
            </h1>

            <!-- No Plans Found Message -->
            <h:panelGroup rendered="#{empty sessionScope.subscriptions}">
                <div class="message-error">
                    No active insurance subscriptions found for this recipient.
                </div>
                <div style="text-align:center; margin-top:1rem;">
                    <h:commandButton value="Back to Recipient Details"
                                     action="searchRecipient"
                                     styleClass="btn-neutral" />
                </div>
            </h:panelGroup>

            <!-- Card View for Plans -->
            <h:panelGroup rendered="#{not empty sessionScope.subscriptions}">
                <h:dataTable value="#{sessionScope.subscriptions}" var="sub" styleClass="w-full">
                    <h:column>
                        <div class="card">
                            <div class="card-title">
                                <h:outputText value="#{sub.coverage.insurancePlan.planName}" />
                            </div>
                            <div class="card-subtitle">
                                Provided by: <h:outputText value="#{sub.coverage.insurancePlan.insuranceCompany.companyName}" />
                            </div>
                            <div class="card-grid">
                                <div><strong>Remaining Coverage Amount:</strong> ₹<h:outputText value="#{sub.remainingCoverageAmount}" /></div>
                                <div><strong>Plan Type:</strong> <h:outputText value="#{sub.coverage.insurancePlan.planType}" /></div>
                                <div><strong>Subscribed On:</strong> <h:outputText value="#{sub.subscribeDate}" /></div>
                                <div><strong>Valid Till:</strong> <h:outputText value="#{sub.expiryDate}" /></div>
                            </div>
                            <div style="margin-top:1rem; text-align:center;">
                                <h:commandButton value="🧾 Use This Plan to Claim"
                                                 action="#{claimController.selectPlan(sub.subscribeId)}"
                                                 styleClass="btn-claim" />
                            </div>
                        </div>
                    </h:column>
                </h:dataTable>
                <div style="text-align:center; margin-top:8px;">
                    <h:commandButton style="background-color: #4b5563; color: white;" value="Back to Recipient Details"
                                     action="searchRecipient"
                                     styleClass="btn-claim" />
                </div>
            </h:panelGroup>
        </div>
    </h:form>
	    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />
</body>
</f:view>
</html>
