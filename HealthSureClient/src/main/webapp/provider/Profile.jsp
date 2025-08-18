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
                👨‍⚕️ Welcome, <h:outputText value="#{sessionScope.loggedInProvider.providerName}" />
            </h1>

            <div class="details-box">
                <p><i class="fas fa-id-badge text-blue-600"></i> <strong>Provider ID:</strong> <h:outputText value="#{sessionScope.loggedInProvider.providerId}" /></p>
                <p><i class="fas fa-hospital-symbol text-blue-600"></i> <strong>Hospital Name:</strong> <h:outputText value="#{sessionScope.loggedInProvider.hospitalName}" /></p>
                <p><i class="fas fa-envelope text-blue-600"></i> <strong>Email:</strong> <h:outputText value="#{sessionScope.loggedInProvider.email}" /></p>
                <p><i class="fas fa-phone-alt text-blue-600"></i> <strong>TelePhone:</strong> <h:outputText value="#{sessionScope.loggedInProvider.telephone}" /></p>
                <p><i class="fas fa-map-marker-alt text-blue-600"></i> <strong>Address:</strong> <h:outputText value="#{sessionScope.loggedInProvider.address}" /></p>
                <p><i class="fas fa-city text-blue-600"></i> <strong>City:</strong> <h:outputText value="#{sessionScope.loggedInProvider.city}" /></p>
                <p><i class="fas fa-flag text-blue-600"></i> <strong>State:</strong> <h:outputText value="#{sessionScope.loggedInProvider.state}" /></p>
                <p><i class="fas fa-mail-bulk text-blue-600"></i> <strong>ZIP Code:</strong> <h:outputText value="#{sessionScope.loggedInProvider.zipcode}" /></p>
            </div>

            <div class="button-group">
                <h:form>
                    <h:commandButton value="Logout" action="#{providerController.logout}" styleClass="button-red" />
                </h:form>
                <h:form>
                    <h:commandButton value="Reset Password" action="resetProviderPassword" styleClass="button-yellow" />
                </h:form>
                <h:form>
                    <h:commandButton value="Register as Admin" action="#{authBean.resetPassword}" styleClass="button-red" />
                </h:form>
                
            </div>
        </div>
    </div>
</f:view>

<jsp:include page="/footer/Footer.jsp" />
</body>
</html>
