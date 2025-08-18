<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core" %>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Pharmacy Dashboard</title>
    <link rel="stylesheet" href="/HealthSureClient/resources/css/pharmacy.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>
<f:view>

    <!-- 🧭 Navigation -->
    <jsp:include page="/navbar/NavPharmacy.jsp" />

    <!-- 👋 Welcome Section -->
    <div class="container">
        <h2 class="heading">
            Welcome, <h:outputText value="#{sessionScope.owner_name}" /> 🧪
        </h2>
        <p class="subheading">Manage your pharmacy operations below.</p>
    </div>

    <!-- 🧠 Metrics Display -->
    <div class="container metrics-wrapper">
        <div class="metric-card">
            <h3 class="metric-title purple">Medicines</h3>
            <p class="metric-value">
                <h:outputText value="#{pharmacyBean.medicineStockCount}" />
            </p>
            <p class="metric-label">Available medicines</p>
        </div>

        <div class="metric-card">
            <h3 class="metric-title green">Equipments</h3>
            <p class="metric-value">
                <h:outputText value="#{pharmacyBean.equipmentStockCount}" />
            </p>
            <p class="metric-label">Available equipments</p>
        </div>

        <div class="metric-card">
            <h3 class="metric-title teal">Payments Received</h3>
            <p class="metric-value">
                ₹<h:outputText value="#{pharmacyBean.totalPayments}" />
            </p>
            <p class="metric-label">Processed this month</p>
        </div>
    </div>

    <!-- 💡 Quote Section -->
    <div class="container quote-box">
        <p>"Behind every prescription is a promise of care." — Unknown</p>
    </div>

    <!-- 🚀 Quick Actions -->
    <div class="container footer-space">
        <h3 class="actions-header">Quick Actions</h3>

        <div class="actions-grid">
            <h:form>
                <h:commandButton value="👁️ View Medicine Stock"
                    action="#{pharmacyBean.viewMedicineStock}"
                    styleClass="action-button blue" />
            </h:form>

            <h:form>
                <h:commandButton value="➕ Add Medicine"
                    action="#{pharmacyBean.addMedicine}"
                    styleClass="action-button purple-btn" />
            </h:form>

            <h:form>
                <h:commandButton value="👁️ View Equipment Stock"
                    action="#{pharmacyBean.viewEquipments}"
                    styleClass="action-button green-btn" />
            </h:form>

            <h:form>
                <h:commandButton value="➕ Add Equipment"
                    action="#{pharmacyBean.addEquipment}"
                    styleClass="action-button pink-btn" />
            </h:form>

            <h:form>
                <h:commandButton value="📄 Previous Sale Details"
                    action="#{pharmacyBean.viewSaleHistory}"
                    styleClass="action-button indigo-btn" />
            </h:form>
        </div>
    </div>

    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />

</f:view>
</body>
</html>
