<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Provider Profile</title>
    <link rel="stylesheet" href="/HealthSureClient/resources/css/profiles.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>

<f:view>
    <jsp:include page="/navbar/NavProvider.jsp" />

    <div class="container">
        <div class="profile-card">
            <h1 class="heading-primary">
                👨‍⚕️ Welcome, <h:outputText value="#{sessionScope.loggedInRecipient.recipientName}" />
            </h1>

            <div class="details-box">
                <p><i class="fas fa-id-badge text-blue-600"></i> <strong>Health ID:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.providerId}" /></p>
                <p><i class="fas fa-hospital-symbol text-blue-600"></i> <strong>Recipient Name:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.recipientName}" /></p>
                <p><i class="fas fa-envelope text-blue-600"></i> <strong>Email:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.email}" /></p>
                <p><i class="fas fa-map-marker-alt text-blue-600"></i> <strong>Address:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.address}" /></p>
                <p><i class="fas fa-city text-blue-600"></i> <strong>City:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.city}" /></p>
                <p><i class="fas fa-flag text-blue-600"></i> <strong>State:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.state}" /></p>
                <p><i class="fas fa-mail-bulk text-blue-600"></i> <strong>ZIP Code:</strong> <h:outputText value="#{sessionScope.loggedInRecipient.zipcode}" /></p>
            </div>

            <div class="button-group">
                <h:form>
                    <h:commandButton value="Logout" action="#{authBean.logout}" styleClass="button-red" />
                </h:form>
                <h:form>
                    <h:commandButton value="Reset Password" action="#{authBean.resetPassword}" styleClass="button-yellow" />
                </h:form>
                
            </div>
        </div>
    </div>
</f:view>

<jsp:include page="/footer/Footer.jsp" />
</body>
</html>
