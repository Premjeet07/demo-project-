<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recipient Medical & Insurance Details</title>
    <link rel="stylesheet" type="text/css" href="/HealthSureClient/resources/css/searchRecipient.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	
    
</head>
<f:view>
<body>

    <!-- Navbar -->
    <div class="mb-6">
        <jsp:include page="/navbar/NavProvider.jsp" />
    </div>

    <!-- Gap -->
    <div class="h-6"></div>

    <!-- Recipient + Medical Info -->
    <h:panelGroup rendered="#{not empty sessionScope.recipient}">
        <div class="page-container">
		<div class="pdf">
            <!-- Recipient Info -->
            <div>
                <h2 class="section-heading">Recipient Prescription</h2>
                <div class="info-grid">
                    <div><strong>Health ID:</strong> <h:outputText value="#{sessionScope.recipient.hId}" /></div>
                    <div><strong>First Name:</strong> <h:outputText value="#{sessionScope.recipient.firstName}" /></div>
                    <div><strong>Last Name:</strong> <h:outputText value="#{sessionScope.recipient.lastName}" /></div>
                    <div><strong>Email:</strong> <h:outputText value="#{sessionScope.recipient.email}" /></div>
                    <div><strong>Mobile:</strong> <h:outputText value="#{sessionScope.recipient.mobile}" /></div>
                    <div><strong>Gender:</strong> <h:outputText value="#{sessionScope.recipient.gender}" /></div>
                    <div><strong>DOB:</strong> <h:outputText value="#{sessionScope.recipient.dob}" /></div>
                    <div><strong>Address:</strong> <h:outputText value="#{sessionScope.recipient.address}" /></div>
                </div>
            </div>

            <!-- Procedure -->
            <h:panelGroup rendered="#{not empty sessionScope.procedure}">
                <div>
                    <h2 class="section-heading">Latest Medical Procedure</h2>
                    <div class="info-grid">
                        <div><strong>Procedure ID:</strong> <h:outputText value="#{sessionScope.procedure.procedureId}" /></div>
                        <div><strong>Date:</strong> <h:outputText value="#{sessionScope.procedure.procedureDate}" /></div>
                        <div style="grid-column: span 2;"><strong>Diagnosis:</strong> <h:outputText value="#{sessionScope.procedure.diagnosis}" /></div>
                        <div style="grid-column: span 2;"><strong>Recommendations:</strong> <h:outputText value="#{sessionScope.procedure.recommendations}" /></div>
                    </div>
                </div>
            </h:panelGroup>

            <!-- Medicines -->
            <h:panelGroup rendered="#{not empty sessionScope.medicines}">
                <div>
                    <h2 class="section-heading">Prescribed Medicines</h2>
                    <h:dataTable value="#{sessionScope.medicines}" var="med" styleClass="table-style">
                        <h:column>
                            <f:facet name="header"> <h:outputText value="Medicine Name" /></f:facet>
                            <h:outputText value="#{med.medicineName}" />
                        </h:column>
                        <h:column>
                            <f:facet name="header"><h:outputText value="Type" /></f:facet>
                            <h:outputText value="#{med.medicineType}" />
                        </h:column>
                        <h:column>
                            <f:facet name="header"><h:outputText value="Dosage" /></f:facet>
                            <h:outputText value="#{med.dosage}" />
                        </h:column>
                        <h:column>
                            <f:facet name="header"><h:outputText value="Duration" /></f:facet>
                            <h:outputText value="#{med.duration}" />
                        </h:column>
                    </h:dataTable>
                </div>
            </h:panelGroup>

            <!-- Tests -->
            <h:panelGroup rendered="#{not empty sessionScope.tests}">
                <div>
                    <h2 class="section-heading">Prescribed Tests</h2>
                    <h:dataTable value="#{sessionScope.tests}" var="test" styleClass="table-style">
                        <h:column>
                            <f:facet name="header"><h:outputText value="Test Name" /></f:facet>
                            <h:outputText value="#{test.testName}" />
                        </h:column>
                        <h:column>
                            <f:facet name="header"><h:outputText value="Test Date" /></f:facet>
                            <h:outputText value="#{test.testDate}" />
                        </h:column>
                        <h:column>
                            <f:facet name="header"><h:outputText value="Result Summary" /></f:facet>
                            <h:outputText value="#{test.resultSummary}" />
                        </h:column>
                    </h:dataTable>
                </div>
            </h:panelGroup>
			</div>
			<div class="download-btn-container">
			  <button type="button" onclick="downloadPDF()" class="download-btn">
			    Download Summary <span class="download-icon">📥</span>
			  </button>
			</div>  
            <!-- Claim Insurance Button -->
            <h:form>
                <div style="text-align: center;">
                    <h:commandButton value="🧾 Claim Insurance for This Recipient"
                                     action="#{claimController.showPlans}"
                                     styleClass="btn" />
                </div>
                
                <div style="text-align:center; margin-top:8px;">
                    <h:commandButton style="background-color: #4b5563; color: white;" value="Back to Procedure Details"
                                     action="ShowMedicalProcedureToClaim"
                                     styleClass="btn" />
                    
                </div>
            </h:form>
        </div>
    </h:panelGroup>
    
        <!-- 📎 Footer -->
    <jsp:include page="/footer/Footer.jsp" />

</body>


</f:view>
<script>
  async function downloadPDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    // Select the content you want to capture
    const element = document.querySelector('.pdf');

    // Convert to canvas
    const canvas = await html2canvas(element);
    const imgData = canvas.toDataURL('image/png');

    // PDF page dimensions
    const pdfPageWidth = doc.internal.pageSize.getWidth();
    const pdfPageHeight = doc.internal.pageSize.getHeight();

    // Desired margin (in mm)
    const margin = 10; // adjust as needed

    // Calculate image dimensions with margin
    const imgProps = doc.getImageProperties(imgData);
    const imgWidth = pdfPageWidth - 2 * margin;
    const imgHeight = (imgProps.height * imgWidth) / imgProps.width;

    // Center the image horizontally
    const x = margin;
    const y = 10; // top margin

    // Add image to PDF
    doc.addImage(imgData, 'PNG', x, y, imgWidth, imgHeight);

    // Save the PDF
    doc.save('ClaimSummary.pdf');
  }
</script>


</html>
