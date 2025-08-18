package com.infinite.jsf.admin.controller;

import java.sql.Timestamp;
import java.util.*;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

import com.infinite.jsf.admin.dao.PaymentProcessingDAO;
import com.infinite.jsf.admin.model.Claim;
import com.infinite.jsf.admin.model.PaymentHistory;
import com.infinite.jsf.admin.model.PaymentStatus;

/**
 * PaymentController with user edit state overlay.
 * Your other logic, field names, and business rules are preserved.
 */
public class PaymentController {

    private PaymentProcessingDAO paymentDAO;

    private String providerId;
    private List<ClaimSelection> selectedClaimsList;

    // ⭐️ Map to preserve user edits even when list is rebuilt
    private Map<String, ClaimSelection> userEditState = new HashMap<>();

    // Pagination and Sorting
    private int currentPage = 1;
    private int pageSize = 5;
    private String sortColumn = "claimId";
    private boolean sortAsc = true;

    // --- Getters and Setters ---

    public boolean isSortAsc() {
        return sortAsc;
    }
    public void setSortAsc(boolean sortAsc) {
        this.sortAsc = sortAsc;
    }
    public String getProviderId() {
        return providerId;
    }
    public void setProviderId(String providerId) {
        this.providerId = providerId;
    }
    public PaymentProcessingDAO getPaymentDAO() {
        return paymentDAO;
    }
    public void setPaymentDAO(PaymentProcessingDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }
    public int getCurrentPage() {
        return currentPage;
    }
    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }
    public int getPageSize() {
        return pageSize;
    }
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    public String getSortColumn() {
        return sortColumn;
    }
    public void setSortColumn(String sortColumn) {
        this.sortColumn = sortColumn;
    }

    public int getTotalPages() {
        int totalRecords = selectedClaimsList == null ? 0 : selectedClaimsList.size();
        return (int) Math.ceil((double) totalRecords / pageSize);
    }

    // --- USER STATE OVERLAY LOGIC ---
    /** Save current user edits before rebuilding the list from DB */
    private void captureUserEditState() {
        userEditState.clear();
        if (selectedClaimsList != null) {
            for (ClaimSelection cs : selectedClaimsList) {
                userEditState.put(
                    cs.getClaim().getClaimId(),
                    cloneSelection(cs)
                );
            }
        }
    }
    /** Overlay user changes onto freshly loaded ClaimSelection items */
    private void applyUserEditState(List<ClaimSelection> freshList) {
        for (ClaimSelection cs : freshList) {
            ClaimSelection prior = userEditState.get(cs.getClaim().getClaimId());
            if (prior != null) {
                cs.setSelected(prior.isSelected());
                cs.setPaymentMethod(prior.getPaymentMethod());
                cs.setRemarks(prior.getRemarks());
            }
        }
    }
    private ClaimSelection cloneSelection(ClaimSelection orig) {
        ClaimSelection c = new ClaimSelection(orig.getClaim());
        c.setSelected(orig.isSelected());
        c.setPaymentMethod(orig.getPaymentMethod());
        c.setRemarks(orig.getRemarks());
        return c;
    }
    // --- DATA FETCH/OVERLAY ---

    public List<ClaimSelection> getSelectedClaimsList() {
        // Always fetch fresh data (your original logic)
        System.out.println("entering get selected claims list");
        List<Claim> claims = (providerId == null || providerId.isEmpty())
            ? paymentDAO.getApprovedAndPendingClaims()
            : paymentDAO.getApprovedAndPendingClaimsByProvider(providerId);

        System.out.println("Provider ID = " + providerId);
        System.out.println("Claims fetched = " + claims.size());

        List<ClaimSelection> list = new ArrayList<>();
        for (Claim claim : claims) {
            list.add(new ClaimSelection(claim));
        }

        // ⭐️ Overlay user changes if present (otherwise, no-op)
        applyUserEditState(list);

        selectedClaimsList = list;
        sortList();

        return selectedClaimsList;
    }
    private void sortList() {
        if (selectedClaimsList == null) {
            System.out.println("[DEBUG] selectedClaimsList is null. Nothing to sort.");
            return;
        }

        System.out.println("[DEBUG] Sorting started. Sort Column: " + sortColumn + ", Ascending: " + sortAsc);
        System.out.println("[DEBUG] Total items before sort: " + selectedClaimsList.size());

        selectedClaimsList.sort((cs1, cs2) -> {
            System.out.println("[DEBUG] Comparing: "
                + (cs1.getClaim() != null ? cs1.getClaim().getClaimId() : "null")
                + " vs "
                + (cs2.getClaim() != null ? cs2.getClaim().getClaimId() : "null")
            );

            int result = 0;
            try {
                switch (sortColumn) {
                    case "claimId":
                        System.out.println("[DEBUG] Comparing Claim IDs: "
                            + cs1.getClaim().getClaimId() + " vs " + cs2.getClaim().getClaimId());
                        result = cs1.getClaim().getClaimId().compareTo(cs2.getClaim().getClaimId());
                        break;

                    case "providerId":
                        System.out.println("[DEBUG] Comparing Provider IDs: "
                            + cs1.getClaim().getProvider().getProviderId()
                            + " vs " + cs2.getClaim().getProvider().getProviderId());
                        result = cs1.getClaim().getProvider().getProviderId()
                            .compareTo(cs2.getClaim().getProvider().getProviderId());
                        break;

                    case "recipientId":
                        System.out.println("[DEBUG] Comparing Recipient HIDs: "
                            + cs1.getClaim().getRecipient().gethId()
                            + " vs " + cs2.getClaim().getRecipient().gethId());
                        result = cs1.getClaim().getRecipient().gethId()
                            .compareTo(cs2.getClaim().getRecipient().gethId());
                        break;

                    case "amountClaimed":
                        System.out.println("[DEBUG] Comparing Amount Claimed: "
                            + cs1.getClaim().getAmountClaimed()
                            + " vs " + cs2.getClaim().getAmountClaimed());
                        result = Double.compare(
                            cs1.getClaim().getAmountClaimed(),
                            cs2.getClaim().getAmountClaimed()
                        );
                        break;

                    default:
                        System.out.println("[DEBUG] Unknown sort column: " + sortColumn);
                        break;
                }
            } catch (NullPointerException e) {
                System.out.println("[ERROR] Null value found while comparing. Details: " + e.getMessage());
                e.printStackTrace();
            }

            return sortAsc ? result : -result;
        });

        System.out.println("[DEBUG] Sorting completed.");
        System.out.println("[DEBUG] First item after sort: " +
            (selectedClaimsList.isEmpty() ? "No data" :
                selectedClaimsList.get(0).getClaim().getClaimId()));
    }

    // --- Pagination Logic ---
    public List<ClaimSelection> getPaginatedClaimsList() {
        // ⭐️ Before rebuilding, snapshot user edits from current list
        captureUserEditState();
        this.selectedClaimsList = getSelectedClaimsList();

        int totalRecords = selectedClaimsList == null ? 0 : selectedClaimsList.size();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (currentPage < 1) currentPage = 1;
        if (currentPage > totalPages) currentPage = totalPages;
        if (totalRecords == 0) return java.util.Collections.emptyList();

        int fromIndex = (currentPage - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalRecords);

        if (fromIndex >= totalRecords) {
            currentPage = totalPages > 0 ? totalPages : 1;
            fromIndex = Math.max(0, (currentPage - 1) * pageSize);
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
        sortList();
        return null;
    }
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
 

    // --- SEARCH ---

    public String searchByProvider() {
        if (providerId == null || providerId.trim().isEmpty()) {
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please enter a provider ID.", null));
            return null;
        }
        userEditState.clear();        // ⭐️ On search, CLEAR user state!
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

    // --- PROCESS PAYMENTS ---

    /**
     * @return
     */
    public String processSelectedPayments() {
        try {
            boolean anySelected = false;
            List<String> validationErrors = new ArrayList<>();
            Map<String, Double> providerAmounts = new HashMap<>();

            // === VALIDATION LOOP ===
            for (ClaimSelection cs : selectedClaimsList) {
                boolean selected = cs.isSelected();
                boolean methodEntered = cs.getPaymentMethod() != null && !cs.getPaymentMethod().trim().isEmpty();

                if (selected && !methodEntered) {
                    validationErrors.add("❗ Please select a payment method for Claim ID: " + cs.getClaim().getClaimId());
                }
                if (!selected && methodEntered) {
                    validationErrors.add("❗ Cannot process Claim ID: " + cs.getClaim().getClaimId() +
                                         " – Checkbox not selected for entered payment method.");
                }
            }

            // === SHOW ERRORS & EXIT ON FAILURE ===
            if (!validationErrors.isEmpty()) {
                for (String err : validationErrors) {
                    FacesContext.getCurrentInstance().addMessage(null,
                        new FacesMessage(FacesMessage.SEVERITY_WARN, err, null));
                }
                // ⭐️ DO NOT clear or reset user state/list!
                return null;
            }

            // === PROCESS PAYMENTS BLOCK ===
            for (ClaimSelection cs : selectedClaimsList) {
                if (cs.isSelected()) {
                    anySelected = true;
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
                            new FacesMessage("❗ No pending payment found for Claim ID: " + claim.getClaimId()));
                    }
                }
            }

            if (!anySelected) {
                FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage(FacesMessage.SEVERITY_WARN, "❗ Please select at least one claim to process.", null));
                return null;
            }

            for (Map.Entry<String, Double> entry : providerAmounts.entrySet()) {
                paymentDAO.updateAccountAmountPaid(entry.getKey(), entry.getValue());
            }

            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage("✅ Selected payments processed successfully."));

            // ⭐️ Only NOW clear for fresh rebuild (successful process):
            userEditState.clear();
            selectedClaimsList = null;
            currentPage = 1;
            return null;

        } catch (Exception e) {
            e.printStackTrace();
            FacesContext.getCurrentInstance().addMessage(null,
                new FacesMessage("❌ Error updating payments: " + e.getMessage()));
            return null;
        }
    }

    // --- INNER CLASS ---
    public static class ClaimSelection {
        private Claim claim;
        private boolean selected;
        private String paymentMethod;
        private String remarks;

        public ClaimSelection(Claim claim) { this.claim = claim; }
        public Claim getClaim() { return claim; }
        public void setClaim(Claim claim) { this.claim = claim; }
        public boolean isSelected() { return selected; }
        public void setSelected(boolean selected) { this.selected = selected; }
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
        public String getRemarks() { return remarks; }
        public void setRemarks(String remarks) { this.remarks = remarks; }
    }

    private ClaimController claimController;

    public ClaimController getClaimController() {
        return claimController;
    }

    public void setClaimController(ClaimController claimController) {
        this.claimController = claimController;
    }

    public String backToDashboard() {
        if (claimController != null) {
            claimController.resetButton();
        }
        userEditState.clear(); // back to search: clear state!
        selectedClaimsList = null;
        currentPage = 1;
        return "Admin?faces-redirect=true";
    }

    // --- validations for update ---
}
