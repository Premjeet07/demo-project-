<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending & Declined Claims</title>
     <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/ShowPendingClaims.css" />
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
</head>
<f:view>
<body>

    <!-- Navbar -->
    <div class="mb-6">
        <jsp:include page="/navbar/NavProvider.jsp" />
    </div>

    <!-- Claims Panel -->
        <div class="page-wrapper">
            <h2 class="page-title">Pending & Declined Claims</h2>
            <h:form id="searchForm">
			    <div class="search-card">
			        <h3 class="search-title"> Filter Claims</h3>
			        <div class="search-fields">
			            <div class="search-field">
			                <label for="claimId">Claim ID</label>
			                <h:inputText id="claimId" value="#{claimController.searchClaimId}" styleClass="search-input"/>
			                <div class="message-container">
			                    <h:message for="claimId" styleClass="error-message" />
			                    <h:messages globalOnly="true" layout="table" styleClass="error-message" />
			                </div>
			            </div>
			
			            <div class="search-field">
			                <label for="procedureId">Procedure ID</label>
			                <h:inputText id="procedureId" value="#{claimController.searchProcedureId}" styleClass="search-input"/>
							<div class="message-container">
							<h:message for="procedureId" styleClass="error-message" />
							</div>
			            </div>
			
			            <div class="search-field">
			                <label for="claimStatus">Claim Status</label>
			                <h:selectOneMenu id="claimStatus" value="#{claimController.searchClaimStatus}" styleClass="search-input">
			                    <f:selectItem itemLabel="-- Select --" itemValue="" />
			                    <f:selectItem itemLabel="Pending" itemValue="Pending" />
			                    <f:selectItem itemLabel="Declined" itemValue="Declined" />
			                </h:selectOneMenu>
			            </div>
			            
						


			        </div>
			
			        <div class="search-actions">
			            <h:commandButton value="Search" action="#{claimController.searchClaims}" styleClass="search-btn" />
			            <h:commandButton value="Reset" action="#{claimController.clearSearchClaims}" styleClass="clear-btn" />
			        </div>
			    </div>
			</h:form>
   

            <h:form>
		    <h:panelGroup rendered="#{not empty claimController.paginatedPendingOrDeclinedClaim}">
		    	<div class="table-container">
                <h:dataTable value="#{claimController.paginatedPendingOrDeclinedClaim}" var="claim"
                             styleClass="data-table">
				    <!-- Claim ID -->
				    <h:column>
				        <f:facet name="header">
				            <h:panelGroup styleClass="h-panelgroup">
				                <h:outputText value="Claim ID" />
				                <h:panelGroup layout="block" styleClass="sort-icons-container">
				                	<h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByAscPending('claimId')}"
				                                   rendered="#{claimController.renderSortButtonPending('claimId','asc')}">
				                        <h:graphicImage value="/resources/media/images/up-arrow.png" width="10" height="10" title="sort-ascending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                    <h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByDescPending('claimId')}"
				                                   rendered="#{claimController.renderSortButtonPending('claimId','desc')}">
				                        <h:graphicImage value="/resources/media/images/down-arrow.png" width="10" height="10" title="sort-descending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                </h:panelGroup>
				            </h:panelGroup>
				        </f:facet>
				        <h:outputText value="#{claim.claimId}" />
				    </h:column>
				
				    <!-- Procedure ID -->
				    <h:column>
				        <f:facet name="header">
				            <h:panelGroup styleClass="h-panelgroup">
				                <h:outputText value="Procedure ID" />
				                <h:panelGroup layout="block" styleClass="sort-icons-container">
				                	<h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByAscPending('procedureId')}"
				                                   rendered="#{claimController.renderSortButtonPending('procedureId','asc')}">
				                        <h:graphicImage value="/resources/media/images/up-arrow.png" width="10" height="10" title="sort-ascending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                    
				                    <h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByDescPending('procedureId')}"
				                                   rendered="#{claimController.renderSortButtonPending('procedureId','desc')}">
				                        <h:graphicImage value="/resources/media/images/down-arrow.png" width="10" height="10" title="sort-descending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                </h:panelGroup>
				            </h:panelGroup>
				        </f:facet>
				        <h:outputText value="#{claim.procedureId}" />
				    </h:column>
				
				    <!-- ₹ Claimed -->
				    <h:column>
				        <f:facet name="header">
				            <h:panelGroup styleClass="h-panelgroup">
				                <h:outputText value="₹ Claimed" />
				                <h:panelGroup layout="block" styleClass="sort-icons-container">
				                	<h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByAscPending('amountClaimed')}"
				                                   rendered="#{claimController.renderSortButtonPending('amountClaimed','asc')}">
				                        <h:graphicImage value="/resources/media/images/up-arrow.png" width="10" height="10" title="sort-ascending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                    
				                    <h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByDescPending('amountClaimed')}"
				                                   rendered="#{claimController.renderSortButtonPending('amountClaimed','desc')}">
				                        <h:graphicImage value="/resources/media/images/down-arrow.png" width="10" height="10" title="sort-descending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                </h:panelGroup>
				            </h:panelGroup>
				        </f:facet>
				        <h:outputText value="#{claim.amountClaimed}" />
				    </h:column>
				
				    <!-- ₹ Approved -->
				    <h:column>
				        <f:facet name="header">
				            <h:panelGroup styleClass="h-panelgroup">
				                <h:outputText value="₹ Approved" />
				                <h:panelGroup layout="block" styleClass="sort-icons-container">
				                	<h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByAscPending('amountApproved')}"
				                                   rendered="#{claimController.renderSortButtonPending('amountApproved','asc')}">
				                        <h:graphicImage value="/resources/media/images/up-arrow.png" width="10" height="10" title="sort-ascending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                    
				                    <h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByDescPending('amountApproved')}"
				                                   rendered="#{claimController.renderSortButtonPending('amountApproved','desc')}">
				                        <h:graphicImage value="/resources/media/images/down-arrow.png" width="10" height="10" title="sort-descending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                </h:panelGroup>
				            </h:panelGroup>
				        </f:facet>
				        <h:outputText value="#{claim.amountApproved}" />
				    </h:column>
				
				    <!-- Status -->
				    <h:column>
				        <f:facet name="header">
				            <h:panelGroup styleClass="h-panelgroup">
				                <h:outputText value="Status" />
				                <h:panelGroup layout="block" styleClass="sort-icons-container">
				                	<h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByAscPending('claimStatus')}"
				                                   rendered="#{claimController.renderSortButtonPending('claimStatus','asc')}">
				                        <h:graphicImage value="/resources/media/images/up-arrow.png" width="10" height="10" title="sort-ascending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                    
				                    <h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByDescPending('claimStatus')}"
				                                   rendered="#{claimController.renderSortButtonPending('claimStatus','desc')}">
				                        <h:graphicImage value="/resources/media/images/down-arrow.png" width="10" height="10" title="sort-descending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                </h:panelGroup>
				            </h:panelGroup>
				        </f:facet>
				        <h:outputText value="#{claim.claimStatus}" />
				    </h:column>
				
				    <!-- Remarks -->
				    <h:column>
				        <f:facet name="header"><h:outputText value="Remarks" /></f:facet>
				        <h:outputText value="#{claim.description}" />
				    </h:column>
				
				    <!-- Action Date -->
				    <h:column>
				        <f:facet name="header">
				            <h:panelGroup styleClass="h-panelgroup">
				                <h:outputText value="Action Date" />
				                <h:panelGroup layout="block" styleClass="sort-icons-container">
				                	<h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByAscPending('actionDate')}"
				                                   rendered="#{claimController.renderSortButtonPending('actionDate','asc')}">
				                        <h:graphicImage value="/resources/media/images/up-arrow.png" width="10" height="10" title="sort-ascending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                    
				                    <h:panelGroup styleClass="sort-icons">
				                    <h:commandLink action="#{claimController.sortByDescPending('actionDate')}"
				                                   rendered="#{claimController.renderSortButtonPending('actionDate','desc')}">
				                        <h:graphicImage value="/resources/media/images/down-arrow.png" width="10" height="10" title="sort-descending"/>
				                    </h:commandLink>
				                    </h:panelGroup>
				                </h:panelGroup>
				            </h:panelGroup>
				        </f:facet>
				        <h:outputText value="#{claim.actionDate}">
				            <f:convertDateTime pattern="yyyy-MM-dd" />
				        </h:outputText>
				    </h:column>
				
				    <!-- Action -->
				    <h:column>
				        <f:facet name="header"><h:outputText value="Action" /></f:facet>
				        <h:commandButton value="Update Claim"
				                         action="#{claimController.editClaim(claim.claimId)}"
				                         styleClass="update-btn" />
				    </h:column>
                </h:dataTable>
                </div>
                
                <div class="simple-pagination">
                
		        <h:commandButton value="Previous"
		                         action="#{claimController.previousPage1}"
		                         disabled="#{!claimController.hasPreviousPage1}"
		                         styleClass="nav-btn" />
		
		        <h:outputText value="Page #{claimController.currentPage1} of #{claimController.totalPages1}" 
		                      styleClass="page-status" />
		
		        <h:commandButton value="Next"
		                         action="#{claimController.nextPage1}"
		                         disabled="#{!claimController.hasNextPage1}"
		                         styleClass="nav-btn" />
		    </div>
    </h:panelGroup>
            </h:form>
    <!-- No Data Message -->
    <h:panelGroup rendered="#{empty claimController.paginatedPendingOrDeclinedClaim}">
        <p class="empty-message">No Pending or Denied Claim is available for update.</p>
    </h:panelGroup>
        </div>

	    <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />
</body>
</f:view>
</html>
