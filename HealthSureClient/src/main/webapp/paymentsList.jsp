<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<html>
<head>
    <title>Payments List</title>
    <style>
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        h2 {
            text-align: center;
        }
    </style>
</head>
<f:view>
    <h:form>
        <h2>Approved Claims for Payment</h2>

        <h:panelGroup rendered="#{not empty paymentController.approvedClaimsList}">
            <h:dataTable value="#{paymentController.approvedClaimsList}" var="claim" border="1">
                <h:column>
                    <f:facet name="header">Claim ID</f:facet>
                    <h:outputText value="#{claim.claimId}" />
                </h:column>
                <h:column>
                    <f:facet name="header">Provider ID</f:facet>
                    <h:outputText value="#{claim.provider.providerId}" />
                </h:column>
                <h:column>
                    <f:facet name="header">Hospital ID</f:facet>
                    <h:outputText value="#{claim.recipient.hId}" />
                </h:column>
                <h:column>
                    <f:facet name="header">Amount Approved</f:facet>
                    <h:outputText value="#{claim.amountApproved}" />
                </h:column>
                <h:column>
                    <f:facet name="header">Action</f:facet>
                    <h:commandButton value="Make Payment" action="#{paymentController.makePayment}" />
                </h:column>
            </h:dataTable>
        </h:panelGroup>

        <h:panelGroup rendered="#{empty paymentController.approvedClaimsList}">
            <h:outputText value="No approved claims available for payment." style="color:red;" />
        </h:panelGroup>
    </h:form>
</f:view>
</html>