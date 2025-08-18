<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Recipient Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/Recipient.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>

<f:view>

    <!-- 🌐 Navigation -->
    <jsp:include page="/navbar/NavRecepient.jsp" />

    <!-- 👋 Welcome Message -->
    <div class="container">
        <h2 class="section-header">
            Welcome back, <h:outputText value="#" /> 🌿
        </h2>
        <p class="text-gray-600">Your personal health snapshot is just below.</p>
    </div>

    <!-- 📊 Recipient Overview -->
    <div class="container">
        <div class="dashboard-grid">
            <div class="info-box">
                <h3 class="info-title" style="color: #3b82f6;">Appointments</h3>
                <p class="info-value"><h:outputText value="#" /></p>
                <p class="info-subtext">Upcoming visits</p>
            </div>

            <div class="info-box">
                <h3 class="info-title" style="color: #8b5cf6;">Prescriptions</h3>
                <p class="info-value"><h:outputText value="#" /></p>
                <p class="info-subtext">Your active medications</p>
            </div>

            <div class="info-box">
                <h3 class="info-title" style="color: #10b981;">Insurance Plans</h3>
                <p class="info-value"><h:outputText value="#" /></p>
                <p class="info-subtext">Active coverage</p>
            </div>

            <div class="info-box">
                <h3 class="info-title" style="color: #ef4444;">Test Reports</h3>
                <p class="info-value"><h:outputText value="#" /></p>
                <p class="info-subtext">Viewed recently</p>
            </div>
        </div>
    </div>

    <!-- 💡 Health Tip or Quote -->
    <div class="container">
        <div class="highlight-box">
            <p>“Health is a state of body. Wellness is a state of being.” — J. Stanford</p>
        </div>
    </div>

    <!-- 🚀 Quick Actions -->
    <div class="container quick-access">
        <h3 class="quick-access-title">Quick Access</h3>
        <div class="quick-grid">
            <h:form>
                <h:commandButton value="📖 My Medical History" action="#"
                    styleClass="action-btn btn-blue" />
            </h:form>
            <h:form>
                <h:commandButton value="🧾 Claim Insurance" action="#"
                    styleClass="action-btn btn-purple" />
            </h:form>
            <h:form>
                <h:commandButton value="💊 My Prescriptions" action="#"
                    styleClass="action-btn btn-teal" />
            </h:form>
            <h:form>
                <h:commandButton value="📞 Contact Provider" action="#"
                    styleClass="action-btn btn-pink" />
            </h:form>
        </div>
    </div>

    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />

</f:view>
</body>
</html>
