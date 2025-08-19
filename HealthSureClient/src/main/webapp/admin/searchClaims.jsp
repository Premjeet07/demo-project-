<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
	<html>
<head>
<title>Search Claims</title>
<link
	href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<script>
	$(function() {
		setTimeout(function() {
			var today = new Date(); // Get current date

			$("input[id$='fromDate']").datepicker({
				dateFormat : 'yy-mm-dd',
				changeMonth : true,
				changeYear : true,
				yearRange : "1990:2050",
				maxDate : today
			// ✅ Restrict to today
			});

			$("input[id$='toDate']").datepicker({
				dateFormat : 'yy-mm-dd',
				changeMonth : true,
				changeYear : true,
				yearRange : "1990:2050",
				maxDate : today
			// ✅ Restrict to today
			});
		}, 200);
	});
</script>
<style>
body {
	font-family: 'Rubik', sans-serif;
	background: linear-gradient(to right, #e3f2fd, #f1f5f9);
	color: #333;
	margin-top: 111px;
	padding: 0;
	min-height: 100vh;
	transition: background 0.5s ease;
}

.main-title {
	text-align: center;
	font-weight: 700;
	font-size: 36px;
	color: #1e3a8a;
	margin-top: 40px;
	margin-bottom: 25px;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
	animation: fadeIn 1s ease-in-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.glass-card {
	width: 90%;
	max-width: 850px;
	margin: 0 auto 40px auto;
	background: rgba(255, 255, 255, 0.95);
	border-radius: 20px;
	box-shadow: 0 12px 35px rgba(0, 0, 0, 0.1);
	padding: 40px 50px;
	border: 1px solid #dbeafe;
	backdrop-filter: blur(10px);
}

.search-form-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	align-items: center;
}

.form-group {
	display: flex;
	flex-direction: column;
	align-items: center;
	min-width: 847px;
	margin-bottom: 10px;
}

.search-label {
	font-size: 15px;
	font-weight: 600;
	color: #1e293b;
	margin-bottom: 8px;
}

.long-select, .long-input {
	width: 50%;
	height: 48px;
	font-size: 16px;
	font-weight: 400;
	color: #1e293b;
	border: 1px solid #cbd5e0;
	border-radius: 12px;
	background: #f8fafc;
	padding: 0 15px;
	transition: all 0.3s ease;
}

.long-select:focus, .long-input:focus {
	border-color: #3b82f6;
	background: #fff;
	box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.25);
	outline: none;
}

.search-btn-row {
	margin-top: 16px;
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 12px;
	padding: 12px;
	border-radius: 10px;
}

.big-search-btn {
	background-color: #2563eb;
	color: #fff;
	font-size: 16px;
	font-weight: 600;
	padding: 12px 48px;
	border: none;
	border-radius: 10px;
	box-shadow: 0 6px 18px rgba(59, 130, 246, 0.3);
	cursor: pointer;
	transition: all 0.3s ease;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.big-search-btn:hover {
	background-color: #1d4ed8;
	transform: translateY(-2px);
	box-shadow: 0 8px 24px rgba(59, 130, 246, 0.4);
}

.big-search-btn:active {
	transform: translateY(0);
	box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
}

.search-extra-panel {
	margin-top: 20px;
	padding: 20px;
	background: #e0f2fe;
	border-radius: 16px;
	border: 1px solid #cbd5e0;
	display: contents;
	flex-wrap: wrap;
	gap: 20px;
	align-items: center;
}

.search-panel {
	margin-left: 0px;
}

.container {
	background: #f8faff;
	width: 95%;
	max-width: 1100px;
	margin: 40px auto;
	border-radius: 20px;
	box-shadow: 0 14px 34px rgba(0, 0, 0, 0.05);
	padding: 30px 35px;
}

h2 {
	text-align: center;
	color: #1a2a4b;
	font-size: 30px;
	font-weight: 700;
	margin-bottom: 25px;
	letter-spacing: 0.05em;
}

.search-panel {
	text-align: center;
	padding: 0px 0px;
	font-size: 16px;
	font-weight: 600;
}

table.claim-table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: 0 5px 25px rgba(0, 0, 0, 0.08);
	font-size: 15px;
}

.claim-table th {
	background: linear-gradient(90deg, #1e3a8a 0%, #3b82f6 100%);
	color: #fff;
	font-weight: 600;
	padding: 14px 8px;
	border-bottom: 2.5px solid #1e3a8a;
	text-align: center;
	white-space: nowrap;
}

.claim-table td {
	padding: 12px 8px;
	border-bottom: 1px solid #e2e8f0;
	background: #ffffff;
	text-align: center;
	vertical-align: middle;
}

.claim-table tr:nth-child(even) td {
	background: #f1f5f9;
}

.claim-table tr:hover td {
	background: #dbeafe !important;
}

.btn-back {
	background-color: #475569;
	color: white;
	padding: 12px 35px;
	border: none;
	border-radius: 12px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 30px;
	transition: all 0.3s ease;
}

.btn-back:hover {
	background-color: #1e293b;
	transform: translateY(-2px);
}

.sort-arrows {
	font-size: 10px;
	line-height: 10px;
	color: white;
	border: none;
	background: none;
	text-decoration: none;
	display: block;
	padding: 1px 0;
	transition: color 0.2s;
}

.sort-arrows:hover {
	color: #d1e1f7;
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
</style>
</head>
<body>
	<jsp:include page="/navbar/NavAdmin.jsp" />
	<div class="main-title">Search Claims</div>
	<h:form styleClass="glass-card" prependId="true" id="red">
		<h:messages globalOnly="true" style="color:red" />

		<div class="search-form-container">
			<div class="form-group">
				<h:outputLabel for="searchType" value="Search By"
					styleClass="search-label" />
				<h:selectOneMenu id="searchType" styleClass="long-select"
					value="#{claimController.searchType}"
					valueChangeListener="#{claimController.searchTypeChanged}"
					immediate="true" onchange="this.form.submit();">
					<f:selectItem itemLabel="-- Select --" itemValue="" />
					<f:selectItem itemLabel="Policy ID" itemValue="subscribeId" />
					<f:selectItem itemLabel="Provider ID" itemValue="providerId" />
					<f:selectItem itemLabel="Recipient HID" itemValue="hId" />
					<f:selectItem itemLabel="Claim Status" itemValue="status" />
					<f:selectItem itemLabel="Date Range" itemValue="dateRange" />
				</h:selectOneMenu>
				<h:message for="searchType" showSummary="true" showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />
			</div>
		</div>

		<h:panelGroup layout="block" styleClass="search-extra-panel"
			rendered="#{claimController.searchType eq 'status'}">
			<div class="form-group">
				<h:outputLabel for="statusField" value="Claim Status:"
					styleClass="search-label" />
				<h:selectOneMenu id="statusField" styleClass="long-select"
					value="#{claimController.searchValue}">
					<f:selectItem itemLabel="-- Select Status --" itemValue="" />
					<f:selectItem itemLabel="PENDING" itemValue="PENDING" />
					<f:selectItem itemLabel="APPROVED" itemValue="APPROVED" />
					<f:selectItem itemLabel="DENIED" itemValue="DENIED" />
				</h:selectOneMenu>
				<h:message for="statusField" showSummary="true" showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />
			</div>
		</h:panelGroup>

		<h:panelGrid styleClass="search-panel"
			rendered="#{claimController.searchType eq 'subscribeId'}">
			<div class="form-group">
				<h:outputLabel for="subscribeIdField" value="Policy ID:" />
				<h:inputText id="subscribeIdField" styleClass="long-input"
					value="#{claimController.searchValue}" />
				<h:message for="subscribeIdField" showSummary="true"
					showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />
			</div>
		</h:panelGrid>

		<h:panelGrid styleClass="search-panel"
			rendered="#{claimController.searchType eq 'providerId'}">
			<div class="form-group">
				<h:outputLabel for="providerIdField" value="Provider ID:" />
				<h:inputText id="providerIdField" styleClass="long-input"
					value="#{claimController.searchValue}" />
				<h:message for="providerIdField" showSummary="true"
					showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />
			</div>
		</h:panelGrid>

		<h:panelGrid styleClass="search-panel"
			rendered="#{claimController.searchType eq 'hId'}">
			<div class="form-group">
				<h:outputLabel for="recipientIdField" value="Recipient HID:" />
				<h:inputText id="recipientIdField" styleClass="long-input"
					value="#{claimController.searchValue}" />
				<h:message for="recipientIdField" showSummary="true"
					showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />
			</div>
		</h:panelGrid>

		<h:panelGrid styleClass="search-panel"
			rendered="#{claimController.searchType eq 'dateRange'}">
			<div class="form-group">
				<h:outputLabel for="fromDate" value="From Date: [ YYYY-MM-DD ]" />
				<h:inputText id="fromDate" styleClass="long-input"
					value="#{claimController.fromDateStr}" />
				<h:message for="fromDate" showSummary="true" showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />

				<h:outputLabel for="toDate" value="To Date: [ YYYY-MM-DD ]" />
				<h:inputText id="toDate" styleClass="long-input"
					value="#{claimController.toDateStr}" />
				<h:message for="toDate" showSummary="true" showDetail="false"
					style="color:red; font-size:15px; margin-top:4px;" />
			</div>
		</h:panelGrid>

		<div class="search-btn-row">
			<h:commandButton value="Search"
				action="#{claimController.searchClaims}" styleClass="big-search-btn" />
			<h:commandButton value="RESET"
				action="#{claimController.resetButton}" styleClass="big-search-btn" />

		</div>
		<!-- Back Button -->
		<div class="search-btn-row">
			<h:commandButton value="BACK TO DASHBOARD" action="#{claimController.backToDashboard}"
				styleClass="big-search-btn" />
		</div>
	</h:form>
	<h:form id="claimForm">
		<h:panelGroup rendered="#{not empty claimController.claimsList}">
			<div class="container">
				<h2>Claim Search Results</h2>

				<div class="search-panel">
					<h:panelGroup
						rendered="#{not empty claimController.provider.providerId}">
            Provider ID: <h:outputText
							value="#{claimController.provider.providerId}" />
					</h:panelGroup>
					<h:panelGroup
						rendered="#{not empty claimController.subscribe.subscribeId}">
						<span class="panel-separator"> | </span>Subscribe ID: <h:outputText
							value="#{claimController.subscribe.subscribeId}" />
					</h:panelGroup>
					<h:panelGroup rendered="#{not empty claimController.recipient.hId}">
						<span class="panel-separator"> | </span>HID: <h:outputText
							value="#{claimController.recipient.hId}" />
					</h:panelGroup>
					<h:panelGroup
						rendered="#{claimController.claim.claimStatus != null}">
						<span class="panel-separator"> | </span>Status: <h:outputText
							value="#{claimController.claim.claimStatus}" />
					</h:panelGroup>
				</div>

				<div class="table-wrap">
					<h:dataTable id="claimsTable"
						value="#{claimController.paginatedClaimsList}" var="claim"
						styleClass="claim-table">
						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Claim ID"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('claimId')}"
											rendered="#{!(claimController.sortColumn eq 'claimId' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('claimId')}"
											rendered="#{!(claimController.sortColumn eq 'claimId' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />

									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:commandLink value="#{claim.claimId}"
								action="#{processClaimController.fetchClaimDetails}"
								styleClass="link-style">
								<f:setPropertyActionListener
									target="#{processClaimController.claimId}"
									value="#{claim.claimId}" />
							</h:commandLink>
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Policy ID"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('subscribeId')}"
											rendered="#{!(claimController.sortColumn eq 'subscribeId' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('subscribeId')}"
											rendered="#{!(claimController.sortColumn eq 'subscribeId' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.subscribe.subscribeId}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Provider ID"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('providerId')}"
											rendered="#{!(claimController.sortColumn eq 'providerId' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('providerId')}"
											rendered="#{!(claimController.sortColumn eq 'providerId' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.provider.providerId}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Recipient HID"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('hId')}"
											rendered="#{!(claimController.sortColumn eq 'hId' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('hId')}"
											rendered="#{!(claimController.sortColumn eq 'hId' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.recipient.hId}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Status"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('claimStatus')}"
											rendered="#{!(claimController.sortColumn eq 'claimStatus' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('claimStatus')}"
											rendered="#{!(claimController.sortColumn eq 'claimStatus' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.claimStatus}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Claim Date"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('claimDate')}"
											rendered="#{!(claimController.sortColumn eq 'claimDate' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('claimDate')}"
											rendered="#{!(claimController.sortColumn eq 'claimDate' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.claimDate}">
								<f:convertDateTime pattern="yyyy-MM-dd" />
							</h:outputText>
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Claimed Amount"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('amountClaimed')}"
											rendered="#{!(claimController.sortColumn eq 'amountClaimed' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('amountClaimed')}"
											rendered="#{!(claimController.sortColumn eq 'amountClaimed' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.amountClaimed}" />
						</h:column>

						<h:column>
							<f:facet name="header">
								<h:panelGroup layout="block"
									style="display:flex; justify-content:center; align-items:center;">
									<h:outputText value="Approved Amount"
										style="color:white; margin-right:4px;" />
									<h:panelGroup layout="block"
										style="display:flex; flex-direction:column;">
										<h:commandLink value="▲"
											action="#{claimController.sortBy('amountApproved')}"
											rendered="#{!(claimController.sortColumn eq 'amountApproved' and claimController.sortAsc)}"
											styleClass="sort-arrows" />
										<h:commandLink value="▼"
											action="#{claimController.sortBy('amountApproved')}"
											rendered="#{!(claimController.sortColumn eq 'amountApproved' and not claimController.sortAsc)}"
											styleClass="sort-arrows" />
									</h:panelGroup>
								</h:panelGroup>
							</f:facet>
							<h:outputText value="#{claim.amountApproved}" />
						</h:column>

					</h:dataTable>

				</div>

				<div class="pagination-controls">

					<h:outputText
						value="#{claimController.showingFrom}-#{claimController.showingTo} of #{claimController.totalRecords}"
						styleClass="total-info" />
					<div class="pages">
						<h:commandButton value="Previous"
							action="#{claimController.previousPage}"
							disabled="#{claimController.previousDisabled}"
							styleClass="pagination-btn" />
						<span class="page-info"> Page <h:outputText
								value="#{claimController.currentPage}" /> of <h:outputText
								value="#{claimController.totalPages}" />
						</span>
						<h:commandButton value="Next" action="#{claimController.nextPage}"
							disabled="#{claimController.nextDisabled}"
							styleClass="pagination-btn" />
					</div>

				</div>
			</div>
		</h:panelGroup>



	</h:form>
	<script>
		// Function to scroll to the table
		function scrollToTable() {
			// Corrected selector to match JSF's generated ID for the table
			// Assuming your form ID is 'insuranceForm' and table ID is 'insuranceTable'
			const table = document.getElementById('claimForm:claimsTable');
			if (table) {
				const offset = 80; // Adjust for navbar height so that table doesn't go underneath of it
				//adds the current scroll position to get the true position relative to the document.
				const tablePosition = table.getBoundingClientRect().top
						+ window.pageYOffset - offset;

				//Scrolls the page to bring the table into view.
				window.scrollTo({
					top : tablePosition,
					behavior : 'smooth'
				});
			}
		}
		// Call scroll to table on page load (after DOM is ready)
		window.addEventListener('DOMContentLoaded', function() {
			// Call scroll to table. It will scroll if the table is rendered.
			const table = document.getElementById('claimForm:claimsTable');
			if (table) {
				scrollToTable();
			}
		});
	</script>

</body>
	</html>
	<!-- 📘 Footer -->
	<jsp:include page="/footer/Footer.jsp" />
</f:view>
