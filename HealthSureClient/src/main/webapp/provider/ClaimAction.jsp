<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Insurance Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/ClaimActions.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    
</head>
<body>
<f:view>

    <!-- 🔗 Navbar -->
    <jsp:include page="/navbar/NavProvider.jsp" />

    <!-- 📦 Centered Dashboard Section -->
    <div class="dashboard-wrapper">
        <div class="dashboard-container">
            <h1 class="dashboard-title">Welcome to Your Insurance Dashboard</h1>

            <h:form>
                <div class="dashboard-grid">
                    <h:commandButton value="📝 File Insurance Claim"
                                     action="#{claimController.searchUnclaimedProcedure}"
                                     styleClass="dashboard-btn" />

                    <h:commandButton value="✏️ Update Insurance Claim"
                                     action="#{claimController.showPendingClaims}"
                                     styleClass="dashboard-btn" />

                    <h:commandButton value="📜 Claims History"
                                     action="#{claimController.viewClaimHistory}"
                                     styleClass="dashboard-btn" />

                    <h:commandButton value="💳 Payment Records"
                                     action="PaymentPaginations.jsf"
                                     styleClass="dashboard-btn" />
                </div>
            </h:form>
        </div>
    </div>

    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />

</f:view>
</body>
</html>
