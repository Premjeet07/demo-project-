<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
    <title>Claim Updated</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/UpdationComplete.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<f:view>

    <!-- 🔗 Navbar -->
    <jsp:include page="/navbar/NavProvider.jsp" />

    <!-- 🎉 Confirmation Card -->
    <div class="confirmation-card">
        <h1 class="confirm-title">✅ Claim Updated Successfully!</h1>
        <p class="confirm-text">
            Your insurance claim has been Re-Claimed and is now being processed.
        </p>

        <!-- 📝 Status Overview -->
        <div class="status-box">
            <p>
                Reference ID: <strong><h:outputText value="#{sessionScope.updatedClaim.claimId}" /></strong><br/>
                Re-Claim Date: <strong><h:outputText value="#{sessionScope.history.actionDate}" /></strong><br/>
                Status: <span class="pending-status">Pending Review</span>
            </p>
        </div>

        <!-- 🚀 Navigation Options -->
        <div style="margin-top: 2rem;">
            <h:form>
                <h:commandButton value="🏠 Go to Dashboard"
                                 action="Provider.jsp?faces-redirect=true"
                                 styleClass="dashboard-btn" />
            </h:form>
        </div>

        <!-- 🙏 Footer -->
        <p class="footer-text">
            Need help? Contact support or visit your claim summary page for more details.
        </p>
    </div>
    
        <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />

</f:view>
</body>
</html>
