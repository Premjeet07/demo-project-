<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.
 
  Author: Zainab Y
 
  Description: JSF Search claim Page using CSS for styling.
-->


<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>

<f:view>
	<html>
<head>
<title>Search Claim History</title>
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background: linear-gradient(to right, #eaf0f6, #f7f9fc);
	margin: 0;
	padding: 30px;
	color: #2c3e50;
}

.header-white {
	color: white;
}

.header-bar {
	background-color: #2b4c7e;
	color: white;
	text-align: center;
	font-size: 20px;
	font-weight: 600;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 30px;
	padding: 20px;
}

.search-row, .filter-buttons-bar {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 16px;
	margin-bottom: 20px;
}

.table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 25px;
	font-size: 13px;
	background-color: #fff;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.03);
}

.table th {
	background-color: #2b4c7e;
	color: white;
	padding: 10px;
	text-align: left;
}

.table td {
	padding: 10px;
	border: 1px solid #e0e0e0;
}

.btn, .btn-primary {
	background-color: #2b4c7e;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 13px;
	font-weight: 500;
	transition: background-color 0.3s ease;
}

.btn:hover, .btn-primary:hover {
	background-color: #1f3a63;
}

.date-input {
	padding: 6px 10px;
	width: 150px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 13px;
	background-color: #f9f9f9;
}

h3 {
	color: #2b4c7e;
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 20px;
	text-align: center; /* This centers the text */
}

.second-row {
	display: flex;
}

.lifted-box {
	background-color: white;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.2); /* lifted shadow */
}

.h-panelgroup {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
}

.sort-icons-container {
	display: flex;
	flex-direction: column;
}

.btn-next:disabled {
	background-color: #a0b3cc; /* lighter version of #2b4c7e */
	color: #eee;
	cursor: not-allowed;
	opacity: 0.7;
}

.textSuccess-false {
	color: red;
}

.textSuccess-true {
	color: green;
}
</style>
</head>
<body>
	<div class="header-bar">Search Claim History Portal</div>

	<h:form id="claimForm">
		<div class="lifted-box">
			<h3 style="text-align: center;">Search by ID Type</h3>

			<div class="search-row">
				<h:outputLabel for="searchType" value="Search Type:" />
				<h:selectOneMenu id="searchType"
					value="#{claimHistorySearchController.searchType}">
					<f:selectItem itemLabel="--Select--" itemValue="" />
					<f:selectItem itemLabel="Claim ID" itemValue="claimId" />
					<f:selectItem itemLabel="Recipient ID" itemValue="recipientId" />
				</h:selectOneMenu>

				<h:outputLabel for="searchValue" value="Enter ID:" />
				<h:inputText id="searchValue"
					value="#{claimHistorySearchController.searchValue}" />

				<h:commandButton value="Search"
					action="#{claimHistorySearchController.searchByIdType}"
					styleClass="btn btn-primary" />
				<h:commandButton value="Reset"
					action="#{claimHistorySearchController.resetmethod}"
					styleClass="btn" />
			</div>
			<h3 style="text-align: center;">Search By Status And Date Range</h3>
			<!-- Second Row: Status + Date Filters -->

			<!-- Status Buttons -->
			<div class="second-row">
				<div
					style="display: flex; gap: 10px; align-items: center; margin-left: 200px; margin-right: 20px">
					<h:commandButton value="Approved"
						action="#{claimHistorySearchController.searchClaimHistoryByStatus('APPROVED')}"
						styleClass="btn" />
					<h:commandButton value="Pending"
						action="#{claimHistorySearchController.searchClaimHistoryByStatus('PENDING')}"
						styleClass="btn" />
					<h:commandButton value="Denied"
						action="#{claimHistorySearchController.searchClaimHistoryByStatus('DENIED')}"
						styleClass="btn" />
				</div>


				<!-- Script to enable native date picker -->
				<script>
					window.addEventListener('DOMContentLoaded', function() {
						var inputs = document
								.querySelectorAll('input.date-input');
						for (var i = 0; i < inputs.length; i++) {
							inputs[i].setAttribute('type', 'date');
						}
					});
				</script>

				<!-- Date Range Filter Section -->
				<!-- Date Range Filter Section -->
				<div class="filter-buttons-bar"
					style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap; margin-top: 10px; color: white;">

					<h:outputLabel for="fromDate" value="From:" style="color: #2b4c7e;" />
					<h:inputText id="fromDate"
						value="#{claimHistorySearchController.fromDate}"
						styleClass="date-input" style="padding: 6px; border-radius: 4px;"
						onclick="this.type='date'" onfocus="this.type='date'">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:inputText>

					<h:outputLabel for="toDate" value="To:" style="color: #2b4c7e;" />
					<h:inputText id="toDate"
						value="#{claimHistorySearchController.toDate}"
						styleClass="date-input" style="padding: 6px; border-radius: 4px;"
						onclick="this.type='date'" onfocus="this.type='date'">
						<f:convertDateTime pattern="yyyy-MM-dd" />
					</h:inputText>

					<h:commandButton value="Filter by Date Range"
						action="#{claimHistorySearchController.filterByDateRange}"
						styleClass="btn btn-primary" style="padding: 6px 12px;" />
				</div>
			</div>
			<div style="display: flex; text-align: center">
				<!-- Messages -->
				<h:messages globalOnly="true" layout="table" style="color: red;" />


			</div>


			<div>

				<h:outputText id="successmessage" value="" style="display:none;" />
				<h:message for="successmessage" styleClass="textSuccess-true" />


			</div>

		</div>
		<!-- Data Table -->
		<h:dataTable id="testTable"
			value="#{claimHistorySearchController.paginatedList}" var="t"
			styleClass="table" border="1" cellpadding="5"
			rendered="#{not empty claimHistorySearchController.paginatedList}">

			<!-- 1. Claim History ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Claim History ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claimHistoryId')}"
								action="#{claimHistorySearchController.sortByAsc('claimHistoryId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claimHistoryId')}"
								action="#{claimHistorySearchController.sortByDesc('claimHistoryId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claimHistoryId}" />
			</h:column>

			<!-- 2. Claim ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Claim ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.claimId')}"
								action="#{claimHistorySearchController.sortByAsc('claim.claimId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.claimId')}"
								action="#{claimHistorySearchController.sortByDesc('claim.claimId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claim.claimId}" />
			</h:column>

			<!-- 3. Recipient ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Recipient ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.recipient.hId')}"
								action="#{claimHistorySearchController.sortByAsc('claim.recipient.hId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.recipient.hId')}"
								action="#{claimHistorySearchController.sortByDesc('claim.recipient.hId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claim.recipient.hId}" />
			</h:column>

			<!-- 4. Provider ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Provider ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.provider.providerId')}"
								action="#{claimHistorySearchController.sortByAsc('claim.provider.providerId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.provider.providerId')}"
								action="#{claimHistorySearchController.sortByDesc('claim.provider.providerId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claim.provider.providerId}" />
			</h:column>

			<!-- 5. Claim Status -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Claim Status" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq'claim.claimStatus')}"
								action="#{claimHistorySearchController.sortByAsc('claim.claimStatus')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.claimStatus')}"
								action="#{claimHistorySearchController.sortByDesc('claim.claimStatus')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claim.claimStatus}" />
			</h:column>

			<!-- 6. Amount Claimed -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Amount Claimed" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.amountClaimed')}"
								action="#{claimHistorySearchController.sortByAsc('claim.amountClaimed')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.amountClaimed')}"
								action="#{claimHistorySearchController.sortByDesc('claim.amountClaimed')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claim.amountClaimed}" />
			</h:column>

			<!-- 7. Amount Approved -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Amount Approved" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.amountApproved')}"
								action="#{claimHistorySearchController.sortByAsc('claim.amountApproved')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'claim.amountApproved')}"
								action="#{claimHistorySearchController.sortByDesc('claim.amountApproved')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.claim.amountApproved}" />
			</h:column>

			<!-- 8. Description -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Description" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'description')}"
								action="#{claimHistorySearchController.sortByAsc('description')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'description')}"
								action="#{claimHistorySearchController.sortByDesc('description')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.description}" />
			</h:column>


			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Action Date" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'actionDate')}"
								action="#{claimHistorySearchController.sortByAsc('actionDate')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!claimHistorySearchController.ascending and claimHistorySearchController.sortField eq 'actionDate')}"
								action="#{claimHistorySearchController.sortByDesc('actionDate')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{t.actionDate}" style="white-space: nowrap;">
					<f:convertDateTime pattern="MM-dd-yyyy" />
				</h:outputText>
			</h:column>
		</h:dataTable>

		<!-- Pagination Controls -->
		<div
			style="display: flex; justify-content: flex-end; align-items: center; gap: 10px; margin-top: 20px;">
			<h:outputText
				rendered="#{not empty claimHistorySearchController.paginatedList}"
				value="Page #{claimHistorySearchController.currentPage + 1} of #{claimHistorySearchController.totalPages}"
				style="margin-right: 20px;" />

			<h:commandButton value="Previous"
				rendered="#{not empty claimHistorySearchController.paginatedList}"
				action="#{claimHistorySearchController.previousPage}"
				disabled="#{!claimHistorySearchController.hasPreviousPage}"
				styleClass="btn btn-next" />

			<h:commandButton value="Next"
				rendered="#{not empty claimHistorySearchController.paginatedList}"
				action="#{claimHistorySearchController.nextPage}"
				disabled="#{!claimHistorySearchController.hasNextPage}"
				styleClass="btn btn-next" />

		</div>
	</h:form>
</body>
	</html>
</f:view>
