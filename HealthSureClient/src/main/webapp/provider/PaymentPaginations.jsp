 <!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.
 
  Author: Zainab Y
 
  Description: JSF Search payment Page using CSS for styling.
-->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
	<html>
<head>
<title>Payment History</title>
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background: linear-gradient(to right, #eaf0f6, #f7f9fc);
	margin: 0;
	padding: 30px;
	color: #2c3e50;
}

.heading {
	text-align: center;
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 20px;
	color: #2b4c7e;
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
	border-radius: 8px;
}

h3 {
	color: #2b4c7e;
	font-size: 16px;
	font-weight: 500;
	margin-bottom: 20px;
	text-align: center;
}

.search-row, .filter-buttons-bar {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 16px;
	margin-bottom: 20px;
}

.input-field, .date-input {
	padding: 8px 12px;
	width: 160px;
	border: 1px solid #ccc;
	border-radius: 6px;
	font-size: 14px;
	background-color: #f9f9f9;
	text-align: center;
}

.btn, .btn-primary {
	background-color: #2b4c7e;
	color: white;
	border: none;
	padding: 8px 16px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	transition: background-color 0.3s ease;
}

.btn:hover, .btn-primary:hover {
	background-color: #1f3a63;
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

.action-button {
	background-color: #e0e0e0;
	color: #2c3e50;
	border: none;
	padding: 8px 12px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 13px;
	font-weight: 500;
	margin: 10px;
}

.action-button:disabled {
	background-color: #cccccc;
	cursor: not-allowed;
}

.validation-message {
	color: #d8000c;
	background-color: #ffdddd;
	padding: 10px 20px;
	border-radius: 6px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 20px;
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
	gap: 8px;
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

.textSuccess-true {
	color: green;
}
.textSuccess-false {
	color: red;
}
</style>

<script>
	function showValidationMessage() {
		var msg = document.getElementById("validationMessage");
		if (msg && msg.innerText.trim() !== "") {
			msg.style.display = "block";
			msg.style.opacity = "1";
			msg.style.transition = "opacity 1s ease";

			setTimeout(function() {
				msg.style.opacity = "0";
				setTimeout(function() {
					msg.style.display = "none";
				}, 1000); // Wait for fade-out to complete
			}, 10000); // Hide after 10 seconds
		}
	}

	window.onload = showValidationMessage;
</script>
<body onload="showValidationMessage()">

	<h2 class="heading">Payment History</h2>

	<h:form>
		<div class="lifted-box">
			<!-- ✅ Header -->
			<div class="header-bar">Search Payment History Portal</div>

			<!-- ✅ Section 1: Search by ID Type & Amount -->
			<h3 style="text-align: center;">Search by ID Type & Amount</h3>
			<div class="search-row">
				<h:outputLabel for="searchType" value="Search Type:" />
				<h:selectOneMenu id="searchType"
					value="#{paymentHistoryController.searchType}">
					<f:selectItem itemLabel="--Select--" itemValue="" />
					<f:selectItem itemLabel="Provider ID" itemValue="providerId" />
					<f:selectItem itemLabel="Payment ID" itemValue="paymentId" />
					<f:selectItem itemLabel="Recipient ID" itemValue="recipientId" />
				</h:selectOneMenu>

				<h:outputLabel for="searchValue" value="Enter ID:" />
				<h:inputText id="searchValue"
					value="#{paymentHistoryController.searchValue}" />

				<h:outputLabel for="amount" value="Amount:" />
				<h:inputText id="amount"
					value="#{paymentHistoryController.searchAmount}" />

				<h:commandButton value="Search"
					action="#{paymentHistoryController.searchCombined}"
					styleClass="btn btn-primary" />
				<h:commandButton value="Reset"
					action="#{paymentHistoryController.resetFilters}" styleClass="btn" />
			</div>

			<!-- ✅ Section 2: Search by Date Range -->
			<h3 style="text-align: center;">Search by Date Range</h3>

			<script>
				window.addEventListener('DOMContentLoaded', function() {
					var inputs = document.querySelectorAll('input.date-input');
					for (var i = 0; i < inputs.length; i++) {
						inputs[i].setAttribute('type', 'date');
					}
				});
			</script>

			<div class="filter-buttons-bar">
				<h:outputLabel for="fromDate" value="From:" style="color: #2b4c7e;" />
				<h:inputText id="fromDate"
					value="#{paymentHistoryController.searchDateFrom}"
					styleClass="date-input" style="padding: 6px; border-radius: 4px;"
					onclick="this.type='date'" onfocus="this.type='date'">
					<f:convertDateTime pattern="yyyy-MM-dd" />
				</h:inputText>

				<h:outputLabel for="toDate" value="To:" style="color: #2b4c7e;" />
				<h:inputText id="toDate"
					value="#{paymentHistoryController.searchDateTo}"
					styleClass="date-input" style="padding: 6px; border-radius: 4px;"
					onclick="this.type='date'" onfocus="this.type='date'">
					<f:convertDateTime pattern="yyyy-MM-dd" />
				</h:inputText>

				<h:commandButton value="Filter by Date Range"
					action="#{paymentHistoryController.searchCombined}"
					styleClass="btn btn-primary" style="padding: 6px 12px;" />
			</div>

			<!-- ✅ Messages -->
			<div style="text-align: center;">
				<h:messages id="validationMessage" globalOnly="true" layout="table"
					styleClass="textSuccess-#{paymentHistoryController.showTable}" />
			</div>
		</div>

		<!-- ✅ Data Table -->
		<h:dataTable value="#{paymentHistoryController.pagedPaymentHistories}"
			var="payment" styleClass="table"
			rendered="#{paymentHistoryController.showTable }">

			<!-- 1. Payment ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Payment ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								action="#{paymentHistoryController.sortByAsc('paymentId')}"
								styleClass="sort-icons"
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'paymentId')}">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'paymentId')}"
								action="#{paymentHistoryController.sortByDesc('paymentId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.paymentId}" />
			</h:column>

			<!-- 2. Recipient ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Recipient ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								action="#{paymentHistoryController.sortByAsc('payment.recipient.hId')}"
								styleClass="sort-icons"
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'payment.recipient.hId')}">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								action="#{paymentHistoryController.sortByDesc('payment.recipient.hId')}"
								styleClass="sort-icons"
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'payment.recipient.hId')}">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.recipient.hId}" />
			</h:column>

			<!-- 3. Recipient Name -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Recipient Name" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								action="#{paymentHistoryController.sortByAsc('payment.recipient.userName')}"
								styleClass="sort-icons"
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'payment.recipient.userName')}">

								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								action="#{paymentHistoryController.sortByDesc('payment.recipient.userName')}"
								styleClass="sort-icons"
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'payment.recipient.userName')}">

								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.recipient.userName}" />
			</h:column>

			<!-- 4. Provider ID -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Provider ID" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								action="#{paymentHistoryController.sortByAsc('payment.provider.providerId')}"
								styleClass="sort-icons"
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'payment.provider.providerId')}">


								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'payment.provider.providerId')}"
								action="#{paymentHistoryController.sortByDesc('payment.provider.providerId')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.provider.providerId}" />
			</h:column>

			<!-- 5. Date -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Date" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								action="#{paymentHistoryController.sortByAsc('paymentDate')}"
								styleClass="sort-icons"
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'paymentDate')}">

								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'paymentDate')}"
								action="#{paymentHistoryController.sortByDesc('paymentDate')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.paymentDate}"
					style="white-space: nowrap;">
					<f:convertDateTime pattern="MM-dd-yyyy" />
				</h:outputText>
			</h:column>

			<!-- 6. Amount -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Amount" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								action="#{paymentHistoryController.sortByAsc('amount')}"
								styleClass="sort-icons"
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'amount')}">


								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'amount')}"
								action="#{paymentHistoryController.sortByDesc('amount')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.amount}" />
			</h:column>

			<!-- 7. Status -->
			<h:column>
				<f:facet name="header">
					<h:panelGroup styleClass="h-panelgroup" layout="block">
						<h:outputText value="Status" />
						<h:panelGroup layout="block" styleClass="sort-icons-container">
							<h:commandLink
								rendered="#{!(paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'paymentStatus')}"
								action="#{paymentHistoryController.sortByAsc('paymentStatus')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/up-arrow.png"
									width="10" height="10" title="Sort Ascending" />
							</h:commandLink>
							<h:commandLink
								rendered="#{!(!paymentHistoryController.sortAscending and paymentHistoryController.sortField eq 'paymentStatus')}"
								action="#{paymentHistoryController.sortByDesc('paymentStatus')}"
								styleClass="sort-icons">
								<h:graphicImage value="/resources/media/images/down-arrow.png"
									width="10" height="10" title="Sort Descending" />
							</h:commandLink>
						</h:panelGroup>
					</h:panelGroup>
				</f:facet>
				<h:outputText value="#{payment.paymentStatus}" />
			</h:column>

		</h:dataTable>


		<!-- ✅ Pagination -->
		<br />
		<div>
			<h:commandButton value="Previous"
				action="#{paymentHistoryController.previousPage}"
				disabled="#{paymentHistoryController.currentPage == 1}"
				styleClass=" btn action-buttonbtn-next  btn-next "
				rendered="#{paymentHistoryController.showTable or paymentHistoryController.showTable}" />

			<h:outputText
				value=" Page #{paymentHistoryController.currentPage} of #{paymentHistoryController.totalPages} "
				rendered="#{paymentHistoryController.showTable or paymentHistoryController.showTable}" />

			<h:commandButton value="Next"
				action="#{paymentHistoryController.nextPage}"
				disabled="#{not (paymentHistoryController.currentPage * paymentHistoryController.pageSize lt paymentHistoryController.paymentHistories.size())}"
				styleClass="btn action-button-next btn-next"
				rendered="#{paymentHistoryController.showTable or paymentHistoryController.showTable}" />
		</div>
	</h:form>

</body>
	</html>
</f:view>
