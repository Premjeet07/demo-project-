package com.infinite.jsf.admin.controller;

import java.sql.Timestamp;
import java.util.*;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

import com.infinite.jsf.admin.dao.PaymentProcessingDAO;
import com.infinite.jsf.admin.model.Claim;
import com.infinite.jsf.admin.model.PaymentHistory;
import com.infinite.jsf.admin.model.PaymentStatus;

public class PaymentController {

    private PaymentProcessingDAO paymentDAO;

    private String providerId;
    private List<ClaimSelection> selectedClaimsList;

    // Pagination and Sorting
    private int currentPage = 1;
    private int pageSize = 5;
    private String sortColumn = "claimId";
    private boolean sortAsc = true;

    public boolean isSortAsc() {
		return sortAsc;
	}
	public void setSortAsc(boolean sortAsc) {
		this.sortAsc = sortAsc;
	}
	// Getters and Setters
    public String getProviderId() { return providerId; }
    public void setProviderId(String providerId) { this.providerId = providerId; }
    public PaymentProcessingDAO getPaymentDAO() { return paymentDAO; }
    public void setPaymentDAO(PaymentProcessingDAO paymentDAO) { this.paymentDAO = paymentDAO; }
    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public String getSortColumn() { return sortColumn; }
    public void setSortColumn(String sortColumn) { this.sortColumn = sortColumn; }
    
    public int getTotalPages() {
        int totalRecords = selectedClaimsList == null ? 0 : selectedClaimsList.size();
        return (int) Math.ceil((double) totalRecords / pageSize);
    }
    
    
    public List<ClaimSelection> getSelectedClaimsList() {
        // Always fetch fresh data
    	System.out.println("entering get selected claims list");
        List<Claim> claims = (providerId == null || providerId.isEmpty())
                ? paymentDAO.getApprovedAndPendingClaims()
                : paymentDAO.getApprovedAndPendingClaimsByProvider(providerId);

        System.out.println("Provider ID = " + providerId);
        System.out.println("Claims fetched = " + claims.size());

        selectedClaimsList = new ArrayList<>();
        for (Claim claim : claims) {
            selectedClaimsList.add(new ClaimSelection(claim));
        }

        return selectedClaimsList;
    }



    // Pagination Logic
    public List<ClaimSelection> getPaginatedClaimsList() {
        // Always rebuild
        this.selectedClaimsList = getSelectedClaimsList();

        int totalRecords = selectedClaimsList == null ? 0 : selectedClaimsList.size();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 1. Always clamp to valid range
        if (currentPage < 1) currentPage = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        // 2. If no data, return empty
        if (totalRecords == 0) return java.util.Collections.emptyList();

        // 3. Calculate indices
        int fromIndex = (currentPage - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalRecords);

        // 4. Failsafe for bounds (e.g. after deletes, filters)
        if (fromIndex >= totalRecords) {
            currentPage = totalPages; // Go back to last valid page
            fromIndex = Math.max(0, (totalPages - 1) * pageSize);
            toIndex = totalRecords;
        }

        return selectedClaimsList.subList(fromIndex, toIndex);
    }
    public String nextPage() {
        int totalPages = getTotalPages();
        if (currentPage < totalPages) currentPage++;
        return null;
    }
    public String previousPage() {
        if (currentPage > 1) currentPage--;
        return null;
    }
    public String sortBy(String column) { 
        if (sortColumn.equals(column)) {
            sortAsc = !sortAsc;
        } else {
            sortColumn = column;
            sortAsc = true;
        }
        currentPage = 1;
        sortList(); // Only sorts on user action, not during page render
        return null;
    }

    // --- After each search, before rendering results ---
    private void resetToFirstPageAndSort() {
        currentPage = 1;
        sortList();
    }
    public boolean isPreviousDisabled() {
        return currentPage <= 1;
    }
    public boolean isNextDisabled() {
        return currentPage >= getTotalPages();
    }
    
    
    public int getShowingFrom() {
	    return (selectedClaimsList == null || selectedClaimsList.isEmpty()) ? 0 : ((currentPage - 1) * pageSize) + 1;
	}
 
	public int getShowingTo() {
	    if (selectedClaimsList == null || selectedClaimsList.isEmpty())
	        return 0;
	        
	    int toIndex = currentPage * pageSize;
	    return Math.min(toIndex, selectedClaimsList.size());
	}
 
	public int getTotalRecords() {
	    return selectedClaimsList == null ? 0 : selectedClaimsList.size();
	}
    private void sortList() {
        if (selectedClaimsList == null) return;

        selectedClaimsList.sort((cs1, cs2) -> {
            int result = 0;
            switch (sortColumn) {
                case "claimId":
                    result = cs1.getClaim().getClaimId().compareTo(cs2.getClaim().getClaimId());
                    break;
                case "providerId":
                    result = cs1.getClaim().getProvider().getProviderId().compareTo(cs2.getClaim().getProvider().getProviderId());
                    break;
                case "recipientId": // sorting by recipient ID
                    result = cs1.getClaim().getRecipient().gethId().compareTo(cs2.getClaim().getRecipient().gethId());
                    break;
                case "amountClaimed":
                    result = Double.compare(cs1.getClaim().getAmountClaimed(), cs2.getClaim().getAmountClaimed());
                    break;
            }
            return sortAsc ? result : -result;
        });
    }

    public String searchByProvider() {
        if (providerId == null || providerId.trim().isEmpty()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please enter a provider ID.", null));
            return null;
        }

        selectedClaimsList = null;
        currentPage = 1;
        
        List<ClaimSelection> list = getSelectedClaimsList();

        if (list == null || list.isEmpty()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_WARN,
                    "No approved claims available for payment for the given provider.", null));
        }

        return null;
    }

    public String processSelectedPayments() {
        try {
            boolean anySelected = false;
            List<String> validationErrors = new ArrayList<>();

            Map<String, Double> providerAmounts = new HashMap<>();

            for (ClaimSelection cs : selectedClaimsList) {
                if (cs.isSelected()) {
                    anySelected = true;

                    // Validate payment method
                    if (cs.getPaymentMethod() == null || cs.getPaymentMethod().trim().isEmpty()) {
                        validationErrors.add("⚠ Please select a payment method for Claim ID: " + cs.getClaim().getClaimId());
                        continue;
                    }

                    Claim claim = cs.getClaim();
                    String providerId = claim.getProvider().getProviderId();
                    double amt = claim.getAmountClaimed();

                    providerAmounts.put(providerId, providerAmounts.getOrDefault(providerId, 0.0) + amt);

                    PaymentHistory payment = paymentDAO.getPendingPaymentByClaimId(claim.getClaimId());
                    if (payment != null) {
                        payment.setPaymentMethod(cs.getPaymentMethod());
                        payment.setRemarks(cs.getRemarks());
                        payment.setPaymentStatus(PaymentStatus.completed);
                        payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
                        paymentDAO.saveOrUpdatePayment(payment);

                        if (claim.getSubscribe() != null) {
                            String subId = claim.getSubscribe().getSubscribeId();
                            paymentDAO.updateSubscribeCoverageAmount(subId, amt);
                        }
                        paymentDAO.updateClaimApprovedAmount(claim.getClaimId(), amt);
                    } else {
                        FacesContext.getCurrentInstance().addMessage(null,
                            new FacesMessage("⚠ No pending payment found for Claim ID: " + claim.getClaimId()));
                    }
                }
            }

            // No checkbox selected
            if (!anySelected) {
                FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage(FacesMessage.SEVERITY_WARN, "⚠ Please select at least one claim to process.", null));
                return null;
            }

            // Payment method missing for some selected claims
            if (!validationErrors.isEmpty()) {
                for (String err : validationErrors) {
                    FacesContext.getCurrentInstance().addMessage(null,
                        new FacesMessage(FacesMessage.SEVERITY_WARN, err, null));
                }
                return null;
            }

            // Update provider account balances
            for (Map.Entry<String, Double> entry : providerAmounts.entrySet()) {
                paymentDAO.updateAccountAmountPaid(entry.getKey(), entry.getValue());
            }

            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage("✅ Selected payments processed successfully."));

            selectedClaimsList = null;
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage("❌ Error updating payments: " + e.getMessage()));
            return null;
        }
    }

    // Inner class
    public static class ClaimSelection {
        private Claim claim;
        private boolean selected;
        private String paymentMethod;
        private String remarks;
        //private PaymentHistory paymentHistory;

        public ClaimSelection(Claim claim) { this.claim = claim;
        }

        public Claim getClaim() { return claim; }
        public void setClaim(Claim claim) { this.claim = claim; }
        public boolean isSelected() { return selected; }
        public void setSelected(boolean selected) { this.selected = selected; }
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
        public String getRemarks() { return remarks; }
        public void setRemarks(String remarks) { this.remarks = remarks; 
        

            // Force initialization of paymentHistories
            if (claim.getPaymentHistories() != null) {
                int count = claim.getPaymentHistories().size(); // triggers loading
                System.out.println("Claim ID: " + claim.getClaimId() + " has " + count + " payment histories.");
            }
        }


//		public PaymentHistory getPaymentHistory() {
//			return paymentHistory;
//		}
//
//		public void setPaymentHistory(PaymentHistory paymentHistory) {
//			this.paymentHistory = paymentHistory;
//		}
    }
    public String backToSearchClaims() {
    	return "searchClaims.jsf?faces-redirect=true";
    }

	// --- validations for update ---


}