<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Feedback Submitted</title>
    <link rel="stylesheet" href="/HealthSureClient/resources/css/inquiry.css" />
</head>

<body class="success-body">
<f:view>

    <!-- ✅ Success Container -->
    <div class="success-container">
        <h2 class="success-title">🎉 Thank You!</h2>
        <p class="success-message">Your inquiry or feedback has been successfully submitted.</p>

        <!-- 🔔 JSF Message -->
        <h:messages globalOnly="true" styleClass="success-feedback" />

        <!-- 🔙 Back Button -->
        <h:form>
            <h:commandButton value="Back to Home" action="Home.jsf" styleClass="back-button" />
        </h:form>
    </div>

</f:view>
</body>
</html>
