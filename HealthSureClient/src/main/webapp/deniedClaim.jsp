<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<f:view>
<head>
<meta charset="UTF-8">
<title>Claim Denied</title>
<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;700&display=swap" rel="stylesheet">
<style>
    body {
        background: linear-gradient(110deg, #e3f1fd 60%, #fbeded 100%);
        font-family: 'Rubik', 'Segoe UI', sans-serif;
		margin-top: 110px;
        padding: 0;
    }
    .container {
        width: 520px;
        margin: 54px auto 35px auto;
        background-color: #fff;
        padding: 34px 36px 19px 36px;
        border-radius: 22px;
        box-shadow: 0 10px 28px 0 #fb9c9c36, 0 2px 4px #ffa5a50e;
    }
    h2 {
        text-align: center;
        color: #e02727;
        font-size: 29px;
        font-weight: 800;
        margin-bottom: 28px;
        letter-spacing: 0.06em;
        text-shadow: 0 2px 9px #fabebcb2;
    }
    h3 {
        color: #af2334;
        font-size: 19px;
        margin-bottom: 13px;
        font-weight: 700;
        letter-spacing: 0.01em;
    }
    .section {
        margin-bottom: 28px;
        padding: 17px 20px 13px 23px;
        border: 1.3px solid #fae0e0;
        border-radius: 15px;
        background: #fff6f6;
        box-shadow: 0 1.5px 8px #fababa18;
    }
    .history {
        margin-bottom: 15px;
        padding: 15px 20px 11px 23px;
        border: 1.2px dashed #f6b4b4;
        border-radius: 14px;
        background: #fcf0f0;
        box-shadow: 0 1.5px 8px #fad0d00f;
    }
    .row {
        margin-bottom: 13px;
        font-size: 15px;
        display: flex;
        align-items: center;
    }
    .label {
        display: inline-block;
        font-weight: 600;
        font-size: 15px;
        color: #ab2339;
        min-width: 120px;
        max-width: 190px;
        width: 37%;
    }
    h\:outputText {
        font-size: 15px;
        color: #7b252a;
        letter-spacing: 0.01em;
        font-weight: 500;
    }
    h\:messages {
        color: #d12f34;
        margin-bottom: 10px;
        display: block;
        font-weight: bold;
        text-align: center;
    }
    @media (max-width: 700px) {
        .container { width: 97vw; padding: 6vw 2vw 4vw 2vw; }
        .section, .history { padding: 6vw 2vw 3vw 3vw; }
        .label { width: 42vw;}
    }
    .btn-cancel {
            background-color: #5c86a6;
            color: white;
            padding: 11px 32px;
            border: none;
            border-radius: 9px;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 2px 8px #aac6e250;
            transition: background 0.14s;
            letter-spacing: 0.03em;
        }
        .btn-cancel:hover {
            background-color: #173a60;
        }
</style>
</head>
<body>
<jsp:include page="Navbar.jsp"/>

<div class="container">
    <h2>This claim is denied</h2>
    <h:form>
        <h:messages globalOnly="true" />
        <!-- Claim Details -->
        <div class="section">
            <h3>Claim Details</h3>
            <div class="row">
                <span class="label">Claim ID:</span>
                <h:outputText value="#{processClaimController.claim.claimId}" />
            </div>
             <div class="row">
                <span class="label">Recipient ID:</span>
            <h:outputText value="#{processClaimController.claim.recipient.hId}" />
            </div>
            <div class="row">
                <span class="label">Policy ID:</span>
                <h:outputText value="#{processClaimController.claim.subscribe.subscribeId}" />
            </div>
            <div class="row">
                <span class="label">Provider:</span>
                <h:outputText value="#{processClaimController.claim.provider.providerId}" />
                -
                <h:outputText value="#{processClaimController.claim.provider.providerName}" />
                -
                <h:outputText value="#{processClaimController.claim.provider.hospitalName}" />
            </div>
            <div class="row">
                <span class="label">Procedure:</span>
                <h:outputText value="#{processClaimController.claim.procedure.procedureId}" />
            </div>
            <div class="row">
                <span class="label">Claim Date:</span>
                <h:outputText value="#{processClaimController.claim.claimDate}">
                    <f:convertDateTime pattern="yyyy-MM-dd" />
                </h:outputText>
            </div>
            <div class="row">
                <span class="label">Status:</span>
                <h:outputText value="#{processClaimController.claim.claimStatus}" />
            </div>
        </div>
        <!-- Payment Details -->
        <div class="section">
            <h3>Payment Details</h3>
            <div class="row">
                <span class="label">Amount Claimed:</span>
                <h:outputText value="#{processClaimController.claim.amountClaimed}" />
            </div>
            <div class="row">
                <span class="label">Amount Approved:</span>
                <h:outputText value="#{processClaimController.claim.amountApproved}" />
            </div>
            <div class="row">
                <span class="label">Available Coverage:</span>
                <h:outputText value="#{processClaimController.remainingCoverageAmount}" />
            </div>
        </div>
        <!-- History -->
        <div class="history">
            <h3>History</h3>
            <div class="row">
                <span class="label">Reason:</span>
                <h:outputText value="#{processClaimController.latestReason}" />
            </div>
        </div>
        <div class="search-btn-row">
				<h:commandButton value="BACK"
					action="#{processClaimController.backToClaims}"
					styleClass="btn-cancel" />
					</div>
    </h:form>
</div>
</body>
</f:view>
</html>
