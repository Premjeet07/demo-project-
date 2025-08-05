<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<f:view>
<html>
<head>
    <title>Claim Search Results</title>
    <style>
        body {
            background: linear-gradient(115deg, #e3f2fd 60%, #e0f7fa 100%);
            font-family: 'Rubik', 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            background: #fff;
            width: 98%;
            max-width: 1100px;
            margin: 80px auto;
            border-radius: 22px;
            box-shadow: 0 14px 34px #b8e4fb32, 0 1.5px 2px #bfe4fa1b;
            padding: 37px 38px 35px 38px;
        }
        h2 {
            text-align: center;
            color: #296490;
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 25px;
            letter-spacing: 0.05em;
        }
        .search-panel {
            background: #f6fbff;
            border-radius: 15px;
            box-shadow: 0 2px 8px #d7ecfd33;
            text-align: center;
            padding: 18px 15px;
            margin-bottom: 22px;
            border: 1.5px solid #b2ddfb6e;
            font-size: 16px;
            color: #1464b0;
            font-weight: 600;
        }
        .table-wrap {
            margin-top: 6px;
        }
        table.claim-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 13px;
            overflow: hidden;
            box-shadow: 0 5px 22px #b3deff22;
            font-size: 16px;
        }
        .claim-table th {
            background: linear-gradient(90deg, #1976d2 88%, #63bff9 100%);
            color: #fff;
            font-weight: bold;
            padding: 13px 6px;
            border-bottom: 2.5px solid #1760ac;
            text-align: center;
        }
        .claim-table td {
            padding: 11px 7px;
            border-bottom: 1.6px solid #e0eaf7;
            background: #f9fcff;
            text-align: center;
        }
        .claim-table tr:nth-child(even) td {
            background: #e6f2fd;
        }
        .claim-table tr:hover td {
            background: #d5e8fa !important;
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
            margin-top: 28px;
        }
        .btn-cancel:hover {
            background-color: #173a60;
        }
        .sort-arrows {
            font-size: 10px;
            line-height: 10px;
            color: white;
            border: none;
            background: none;
            text-decoration: none;
        }
    </style>
</head>
<body>
<jsp:include page="Navbar.jsp"/>

<div class="container">
    <h2>Claim Search Results</h2>

    <h:form>
        <div class="search-panel">
            <h:panelGroup rendered="#{not empty claimController.provider.providerId}">
                Provider ID: <h:outputText value="#{claimController.provider.providerId}" />
            </h:panelGroup>
            <h:panelGroup rendered="#{not empty claimController.subscribe.subscribeId}">
                &nbsp;|&nbsp;Subscribe ID: <h:outputText value="#{claimController.subscribe.subscribeId}" />
            </h:panelGroup>
            <h:panelGroup rendered="#{not empty claimController.recipient.hId}">
                &nbsp;|&nbsp;HID: <h:outputText value="#{claimController.recipient.hId}" />
            </h:panelGroup>
            <h:panelGroup rendered="#{claimController.claim.claimStatus != null}">
                &nbsp;|&nbsp;Status: <h:outputText value="#{claimController.claim.claimStatus}" />
            </h:panelGroup>
        </div>

        <h:panelGroup rendered="#{not empty claimController.claimsList}">
            <div class="table-wrap">
                <h:dataTable value="#{claimController.paginatedClaimsList}" var="claim" styleClass="claim-table">
                    

    <!-- Claim ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Claim ID" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('claimId')}" rendered="#{!(claimController.sortColumn eq 'claimId' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('claimId')}" rendered="#{!(claimController.sortColumn eq 'claimId' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:commandLink value="#{claim.claimId}" action="#{processClaimController.fetchClaimDetails}" styleClass="link-style">
            <f:setPropertyActionListener target="#{processClaimController.claimId}" value="#{claim.claimId}" />
        </h:commandLink>
    </h:column>

    <!-- Policy ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Policy ID" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('subscribeId')}" rendered="#{!(claimController.sortColumn eq 'subscribeId' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('subscribeId')}" rendered="#{!(claimController.sortColumn eq 'subscribeId' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.subscribe.subscribeId}" />
    </h:column>

    <!-- Provider ID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Provider ID" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('providerId')}" rendered="#{!(claimController.sortColumn eq 'providerId' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('providerId')}" rendered="#{!(claimController.sortColumn eq 'providerId' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.provider.providerId}" />
    </h:column>

    <!-- Recipient HID -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Recipient HID" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('hId')}" rendered="#{!(claimController.sortColumn eq 'hId' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('hId')}" rendered="#{!(claimController.sortColumn eq 'hId' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.recipient.hId}" />
    </h:column>

    <!-- Status -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Status" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('claimStatus')}" rendered="#{!(claimController.sortColumn eq 'claimStatus' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('claimStatus')}" rendered="#{!(claimController.sortColumn eq 'claimStatus' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.claimStatus}" />
    </h:column>

    <!-- Claim Date -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Claim Date" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('claimDate')}" rendered="#{!(claimController.sortColumn eq 'claimDate' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('claimDate')}" rendered="#{!(claimController.sortColumn eq 'claimDate' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.claimDate}">
            <f:convertDateTime pattern="yyyy-MM-dd" />
        </h:outputText>
    </h:column>

    <!-- Claimed Amount -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Claimed Amount" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('amountClaimed')}" rendered="#{!(claimController.sortColumn eq 'amountClaimed' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('amountClaimed')}" rendered="#{!(claimController.sortColumn eq 'amountClaimed' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.amountClaimed}" />
    </h:column>

    <!-- Approved Amount -->
    <h:column>
        <f:facet name="header">
            <h:panelGroup layout="block" style="display:flex; justify-content:center; align-items:center;">
                <h:outputText value="Approved Amount" style="color:white; margin-right:4px;" />
                <h:panelGroup layout="block" style="display:flex; flex-direction:column;">
                    <h:commandLink value="▲" action="#{claimController.sortBy('amountApproved')}" rendered="#{!(claimController.sortColumn eq 'amountApproved' and claimController.sortAsc)}" styleClass="sort-arrows" />
                    <h:commandLink value="▼" action="#{claimController.sortBy('amountApproved')}" rendered="#{!(claimController.sortColumn eq 'amountApproved' and not claimController.sortAsc)}" styleClass="sort-arrows" />
                </h:panelGroup>
            </h:panelGroup>
        </f:facet>
        <h:outputText value="#{claim.amountApproved}" />
    </h:column>

</h:dataTable>
                
            </div>

            <!-- Pagination -->
            <div style="text-align:center; margin:20px 0;">
                <h:commandButton value="Previous" action="#{claimController.previousPage}" disabled="#{claimController.previousDisabled}" />
                &nbsp;
                Page <h:outputText value="#{claimController.currentPage}" /> of <h:outputText value="#{claimController.totalPages}" />
                &nbsp;
                <h:commandButton value="Next" action="#{claimController.nextPage}" disabled="#{claimController.nextDisabled}" />
            </div>
            
            <div style="text-align: center; margin-top: 10px;">
					<h:outputText
						value="#{claimController.showingFrom}-#{claimController.showingTo} out of #{claimController.totalRecords}" />
				</div>
        </h:panelGroup>

        <h:panelGroup rendered="#{empty claimController.claimsList}">
            <div class="search-panel" style="color:#d32f2f;">No claims found for the given criteria.</div>
        </h:panelGroup>

        <div style="text-align:center;">
            <h:commandButton value="BACK" action="#{claimController.resetSearch}" styleClass="btn-cancel" />
        </div>
        
        
    </h:form>
</div>
</body>
</html>
</f:view>