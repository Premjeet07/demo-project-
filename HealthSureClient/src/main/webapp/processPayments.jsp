<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<f:view>
	<html>
<head>
<title>Process Payments</title>
<style>
body {
	background: linear-gradient(115deg, #e3f2fd 60%, #e0f7fa 100%);
	margin: 0;
	padding: 0;
	font-family: 'Rubik', 'Segoe UI', sans-serif;
	min-height: 100vh;
}

.container {
	background: #fff;
	width: 910px;
	margin: 48px auto 35px auto;
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
	padding: 18px 15px 15px 15px;
	margin-bottom: 24px;
	border: 1.5px solid #b2ddfb6e;
}

.search-label {
	color: #1464b0;
	font-size: 16px;
	font-weight: 700;
	margin-right: 8px;
}

.search-input {
	font-size: 17px;
	border-radius: 8px;
	border: 1.6px solid #91bbed;
	padding: 7px 12px;
	transition: border 0.2s;
	width: 180px;
	background: #fafdff;
}

.search-input:focus {
	border: 1.6px solid #1d91dc;
}

.search-btn {
	background: linear-gradient(90deg, #1e88e5 70%, #8fd4fa 100%);
	color: white;
	border: none;
	border-radius: 8px;
	padding: 9px 32px;
	font-size: 16px;
	font-weight: 700;
	cursor: pointer;
	margin-left: 18px;
	box-shadow: 0 3px 14px #87bff644;
	transition: background 0.2s;
}

.search-btn:hover {
	background: linear-gradient(90deg, #0b4e8a 70%, #4ad0fa 100%);
}

.messages-section {
	margin-bottom: 18px;
	color:red;
}

h\:messages {
	color: #388e3c;
	font-weight: bold;
	text-align: center;
	font-size: 16px;
	padding: 8px 3px 2px 3px;
}

.table-wrap {
	margin-top: 6px;
	margin-bottom: 22px;
}

table.payment-table {
	width: 100%;
	margin: 0 auto 0 auto;
	border-collapse: separate;
	border-spacing: 0;
	border-radius: 13px;
	overflow: hidden;
	box-shadow: 0 5px 22px #b3deff22;
	font-size: 16px;
}

.payment-table th {
	background: linear-gradient(90deg, #1976d2 88%, #63bff9 100%);
	color: #fff;
	font-weight: bold;
	padding: 13px 6px;
	border-bottom: 2.5px solid #1760ac;
	letter-spacing: 0.03em;
	font-size: 17px;
}

.payment-table td {
	padding: 11px 7px;
	border-bottom: 1.6px solid #e0eaf7;
	background: #f9fcff;
	text-align: center;
}

.payment-table tr:nth-child(even) td {
	background: #e6f2fd;
}

.payment-table tr:hover td {
	background: #d5e8fa !important;
}

.remark-box {
	width: 94%;
	min-height: 37px;
	border-radius: 8px;
	border: 1.3px solid #aecbe7;
	background: #fafdff;
	font-size: 15px;
	font-family: inherit;
	padding: 5px 8px;
	resize: vertical;
}

.method-select {
	width: 90%;
	border-radius: 7px;
	background: #fafdff;
	min-height: 32px;
	font-size: 15px;
	padding: 4px 10px;
}

.process-btn-section {
	text-align: center;
	margin-top: 32px;
}

.pagination-controls {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	text-align: center;
	margin: 25px 0;
}

.pagination-btn {
	background-color: #3b82f6;
	color: #fff;
	padding: 8px 18px;
	border: none;
	border-radius: 10px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s;
}

.pagination-btn:hover:not(:disabled) {
	background-color: #2563eb;
	transform: translateY(-1px);
}

.pagination-btn:disabled {
	background-color: #93c5fd;
	cursor: not-allowed;
}

.page-info {
	font-size: 16px;
	font-weight: 500;
	color: #4a5568;
}

.total-info {
	font-size: 14px;
	font-weight: 400;
	color: #718096;
	margin-top: 5px;
}

.process-btn {
	background: linear-gradient(90deg, #1c8bda 70%, #6cdcff 100%);
	color: #fff;
	border: none;
	border-radius: 12px;
	padding: 13px 60px 13px 53px;
	font-size: 20px;
	font-weight: 800;
	letter-spacing: 0.01em;
	box-shadow: 0 7px 22px #accffd40;
	cursor: pointer;
	transition: background 0.18s, transform 0.15s;
}

.process-btn:hover {
	background: linear-gradient(90deg, #1063ad 80%, #38e2ff 100%);
	transform: scale(1.04);
}

@media ( max-width : 1000px) {
	.container {
		width: 98vw;
		padding: 7vw 2vw;
	}
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
	<jsp:include page="Navbar.jsp" />

	<div class="container">
		<h2>Approved Claims for Payment</h2>
		<h:form>
			<div class="search-panel">
				<span class="search-label">Search by Provider ID:</span>
				<h:inputText value="#{paymentController.providerId}"
					styleClass="search-input" />
				<h:commandButton value="Search" styleClass="search-btn"
					action="#{paymentController.searchByProvider}" />
			</div>

			<div class="messages-section">
				<h:messages globalOnly="true" />
			</div>

			<h:panelGroup
				rendered="#{not empty paymentController.paginatedClaimsList}">
				<div class="table-wrap">
					<h:dataTable value="#{paymentController.paginatedClaimsList}"
						var="row" styleClass="payment-table">

					<!--  -->	<h:column>
							<f:facet name="header">
								<h:outputText value="Select" />
							</f:facet>
							<h:selectBooleanCheckbox value="#{row.selected}" />
						</h:column>

						<!-- Claim ID with Compact Sorting Arrows -->
						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display: flex; justify-content: center; align-items: center;">
									<h:outputText value="Claim ID"
										style="color: white; margin-right: 5px;" />
									<h:panelGroup layout="block"
										style="display: flex; flex-direction: column;">
										<h:commandLink value="▲"
											action="#{paymentController.sortBy('claimId')}"
											rendered="#{!(paymentController.sortColumn eq 'claimId' and paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
										<h:commandLink value="▼"
											action="#{paymentController.sortBy('claimId')}"
											rendered="#{!(paymentController.sortColumn eq 'claimId' and not paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{row.claim.claimId}" />
						</h:column>

						<!-- Provider ID with Compact Sorting Arrows -->
						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display: flex; justify-content: center; align-items: center;">
									<h:outputText value="Provider ID"
										style="color: white; margin-right: 5px;" />
									<h:panelGroup layout="block"
										style="display: flex; flex-direction: column;">
										<h:commandLink value="▲"
											action="#{paymentController.sortBy('providerId')}"
											rendered="#{!(paymentController.sortColumn eq 'providerId' and paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
										<h:commandLink value="▼"
											action="#{paymentController.sortBy('providerId')}"
											rendered="#{!(paymentController.sortColumn eq 'providerId' and not paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{row.claim.provider.providerId}" />
						</h:column>

						<!-- Recipient ID with Compact Sorting Arrows -->
						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display: flex; justify-content: center; align-items: center;">
									<h:outputText value="Recipient ID"
										style="color: white; margin-right: 5px;" />
									<h:panelGroup layout="block"
										style="display: flex; flex-direction: column;">
										<h:commandLink value="▲"
											action="#{paymentController.sortBy('recipientId')}"
											rendered="#{!(paymentController.sortColumn eq 'recipientId' and paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
										<h:commandLink value="▼"
											action="#{paymentController.sortBy('recipientId')}"
											rendered="#{!(paymentController.sortColumn eq 'recipientId' and not paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{row.claim.recipient.hId}" />
						</h:column>

						<!-- Amount Claimed with Compact Sorting Arrows -->
						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display: flex; justify-content: center; align-items: center;">
									<h:outputText value="Amount Claimed"
										style="color: white; margin-right: 5px;" />
									<h:panelGroup layout="block"
										style="display: flex; flex-direction: column;">
										<h:commandLink value="▲"
											action="#{paymentController.sortBy('amountClaimed')}"
											rendered="#{!(paymentController.sortColumn eq 'amountClaimed' and paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
										<h:commandLink value="▼"
											action="#{paymentController.sortBy('amountClaimed')}"
											rendered="#{!(paymentController.sortColumn eq 'amountClaimed' and not paymentController.sortAsc)}"
											style="color: white; font-size: 10px; line-height: 10px; text-decoration: none; border: none; background: none;" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{row.claim.amountClaimed}" />
						</h:column>

						<!-- Payment Method -->
						<h:column>
							<f:facet name="header">
								<h:outputText value="Payment Method" />
								
							</f:facet>
							<h:selectOneMenu value="#{row.paymentMethod}"
								styleClass="method-select">
								<f:selectItem itemLabel="--Select--" itemValue="" />
								<f:selectItem itemLabel="NEFT" itemValue="NEFT" />
								<f:selectItem itemLabel="RTGS" itemValue="RTGS" />
								<f:selectItem itemLabel="UPI" itemValue="UPI" />
								<f:selectItem itemLabel="Cash" itemValue="Cash" />
							</h:selectOneMenu><span style="color: red; font-weight: bold;">*</span>
						</h:column>

						<!-- Remarks -->
						<h:column>
							<f:facet name="header">
								<h:outputText value="Remarks" />
							</f:facet>
							<h:inputTextarea value="#{row.remarks}" rows="2" cols="23"
								styleClass="remark-box" />
						</h:column>
					</h:dataTable>
				</div>

				<!-- Pagination -->


				<div class="pagination-controls">


					<h:outputText
						value="#{paymentController.showingFrom}-#{paymentController.showingTo} of #{paymentController.totalRecords}"
						styleClass="total-info" />
					<div class="pages">
						<h:commandButton value="Previous"
							action="#{paymentController.previousPage}"
							disabled="#{paymentController.previousDisabled}"
							styleClass="pagination-btn" />
						<span class="page-info"> Page <h:outputText
								value="#{paymentController.currentPage}" /> of <h:outputText
								value="#{paymentController.totalPages}" />
						</span>
						<h:commandButton value="Next"
							action="#{paymentController.nextPage}"
							disabled="#{paymentController.nextDisabled}"
							styleClass="pagination-btn" />
					</div>

				</div>

				<!-- Process Button -->
				<div class="process-btn-section" style="margin-top: 24px;">
					<h:commandButton value="Process All Selected Payments"
						action="#{paymentController.processSelectedPayments}"
						styleClass="process-btn" />
				</div>
			</h:panelGroup>

			<!-- Cancel Button -->
			<div class="search-btn-row">
				<h:commandButton value="CANCEL"
					action="#{paymentController.backToSearchClaims}"
					styleClass="btn-cancel" />
			</div>
		</h:form>
	</div>
</body>
	</html>
</f:view>