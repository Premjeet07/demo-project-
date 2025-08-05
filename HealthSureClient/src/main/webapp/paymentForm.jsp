<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<html>
<head>
    <title>Make Payment</title>
    <style>
        form {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #f8f8f8;
        }

        label, input, select, textarea {
            display: block;
            width: 100%;
            margin-bottom: 10px;
        }

        h2 {
            text-align: center;
        }
    </style>
</head>
<f:view>
    <h:form>
        <h2>Payment Form</h2>
        <h:messages style="color: red;" />

        <h:outputLabel value="Claim ID:" />
        <h:outputText value="#{paymentController.selectedClaim.claimId}" />

        <h:outputLabel value="Amount to Pay:" />
        <h:outputText value="#{paymentController.selectedClaim.amountApproved}" />

        <h:outputLabel value="Payment Method:" />
        <h:selectOneMenu value="#{paymentController.paymentMethod}" required="true">
            <f:selectItem itemLabel="--Select--" itemValue="" />
            <f:selectItem itemLabel="NEFT" itemValue="NEFT" />
            <f:selectItem itemLabel="RTGS" itemValue="RTGS" />
            <f:selectItem itemLabel="UPI" itemValue="UPI" />
            <f:selectItem itemLabel="Cash" itemValue="Cash" />
        </h:selectOneMenu>

        <h:outputLabel value="Remarks:" />
        <h:inputTextarea value="#{paymentController.remarks}" rows="4" />

        <h:commandButton value="Submit Payment" action="#{paymentController.processPayment}" />
        <h:commandButton value="Cancel" action="paymentsList.jsp?faces-redirect=true" immediate="true" />
    </h:form>
</f:view>
</html>