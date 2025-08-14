package com.infinite.jsf.admin.controller;

import com.infinite.jsf.admin.dao.ClaimDAO;
import com.infinite.jsf.admin.model.Claim;
import com.infinite.jsf.admin.model.Provider;
import com.infinite.jsf.admin.model.Recipient;
import com.infinite.jsf.admin.model.Subscribe;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;

import org.apache.log4j.Logger;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class ClaimController implements Serializable {

    private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(ClaimController.class.getName()); 

    private ClaimDAO claimDao;
    private Claim claim;
    private Provider provider;
    private Recipient recipient;
    private Subscribe subscribe;

    private String searchType;
    private String searchValue;
    private Date fromDate;
    private Date toDate;
    private String fromDateStr;
    private String toDateStr;
    private int currentPage = 1;
    private int pageSize = 5;
    private String sortColumn = "claimId"; // Default sort column
    private boolean sortAsc = true;

    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public String getSortColumn() { return sortColumn; }
    public void setSortColumn(String sortColumn) { this.sortColumn = sortColumn; }
    public boolean isSortAsc() { return sortAsc; }
    public void setSortAsc(boolean sortAsc) { this.sortAsc = sortAsc; }

    public int getTotalPages() {
        if (claimsList == null || claimsList.isEmpty()) return 1;
        return (int) Math.ceil((double) claimsList.size() / pageSize);
    }



    public String getFromDateStr() { return fromDateStr; }
    public void setFromDateStr(String fromDateStr) { this.fromDateStr = fromDateStr; }
    public String getToDateStr() { return toDateStr; }
    public void setToDateStr(String toDateStr) { this.toDateStr = toDateStr; }


    private List<Claim> claimsList;

    public String searchClaims() {
    	
    	
        try {
        	this.sortColumn= "claimId";
        	this.sortAsc= true;
        	this.currentPage=1;
        	logger.info("Claim Id  : " + claim.getClaimId());
            FacesContext context = FacesContext.getCurrentInstance();

            if (searchType == null || searchType.isEmpty()) {
                context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please select a search type.", null));
                return null;
            }

            // Safely trim searchValue unless searchType is "dateRange"
            if (!"dateRange".equals(searchType) && searchValue != null) {
                searchValue = searchValue.trim();
            }

            switch (searchType) {
                case "subscribeId":
                    if (searchValue == null || searchValue.isEmpty()) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Subscribe ID is required.", null));
                        return null;
                    }
                    if (!searchValue.matches("^SUB\\d+$")) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                "Subscribe ID must start with 'SUB' followed by digits (e.g., SUB101).", null));
                        return null;
                    }
                    break;

                case "providerId":
                    if (searchValue == null || searchValue.isEmpty()) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Provider ID is required.", null));
                        return null;
                    }
                    if (!searchValue.matches("^P\\d+$")) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                "Provider ID must start with 'P' followed by digits (e.g., P001).", null));
                        return null;
                    }
                    break;

                case "hId":
                    if (searchValue == null || searchValue.isEmpty()) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Recipient HID is required.", null));
                        return null;
                    }
                    if (!searchValue.matches("^H\\d+$")) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                "Recipient HID must start with 'H' followed by digits (e.g., H123).", null));
                        return null;
                    }
                    break;

                case "status":
                    if (searchValue == null || searchValue.isEmpty()) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Claim Status is required.", null));
                        return null;
                    }
                    String statusVal = searchValue.toUpperCase();
                    if (!statusVal.equals("PENDING") && !statusVal.equals("APPROVED") && !statusVal.equals("DENIED")) {
                        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                                "Invalid Claim Status. Must be PENDING, APPROVED, or DENIED.", null));
                        return null;
                    }
                    break;

                case "dateRange":
                    String userFromDate = fromDateStr != null ? fromDateStr.trim() : null;
                    String userToDate   = toDateStr != null ? toDateStr.trim() : null;

                    // Check if either date is exactly 8 digits and validate as yyyyMMdd
                    String eightDigitPattern = "^\\d{8}$"; // Strictly 8 digits

                 // Validate strict 8-digit yyyyMMdd if entered
                    try {
                        java.text.SimpleDateFormat ymdFormat = new java.text.SimpleDateFormat("yyyyMMdd");
                        ymdFormat.setLenient(false);

                        if (userFromDate != null && userFromDate.matches("^\\d+$")) {
                            if (userFromDate.length() != 8) {
                                throw new IllegalArgumentException("Invalid from date format.");
                            }
                            ymdFormat.parse(userFromDate); // throws if like 20251301
                        }

                        if (userToDate != null && userToDate.matches("^\\d+$")) {
                            if (userToDate.length() != 8) {
                                throw new IllegalArgumentException("Invalid to date format.");
                            }
                            ymdFormat.parse(userToDate);
                        }

                    } catch (Exception e) {
                        context.addMessage(null, new FacesMessage(
                            FacesMessage.SEVERITY_ERROR,
                            "Invalid date format. Please enter 8-digit valid date like 20250801.", null
                        ));
                        return null;
                    }

                    // Existing logic
                    String[] patterns = { "yyyy-MM-dd", "yyyy/MM/dd", "yyyyMMdd" };
                    Date parsedFrom = null, parsedTo = null;

                    for (String p : patterns) {
                        if (parsedFrom == null && userFromDate != null && !userFromDate.isEmpty()) {
                            try {
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(p);
                                sdf.setLenient(false);
                                parsedFrom = sdf.parse(userFromDate);
                            } catch (Exception ignore) {}
                        }
                        if (parsedTo == null && userToDate != null && !userToDate.isEmpty()) {
                            try {
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(p);
                                sdf.setLenient(false);
                                parsedTo = sdf.parse(userToDate);
                            } catch (Exception ignore) {}
                        }
                    }

                    if (parsedFrom == null || parsedTo == null) {
                        context.addMessage(null, new FacesMessage(
                            FacesMessage.SEVERITY_ERROR,
                            "Invalid date format or values. Please use proper format: 2024-01-01 or 20240101 ", null
                        ));
                        return null;
                    }

                    Calendar todayCal = Calendar.getInstance();
                    todayCal.set(Calendar.HOUR_OF_DAY, 0);
                    todayCal.set(Calendar.MINUTE, 0);
                    todayCal.set(Calendar.SECOND, 0);
                    todayCal.set(Calendar.MILLISECOND, 0);
                    Date today = todayCal.getTime();

                    if (parsedFrom.after(today) || parsedTo.after(today)) {
                        context.addMessage(null, new FacesMessage(
                            FacesMessage.SEVERITY_ERROR,
                            "Dates cannot be in the future.", null
                        ));
                        return null;
                    }

                    Calendar cal = Calendar.getInstance();
                    cal.setTime(parsedFrom);
                    cal.set(Calendar.HOUR_OF_DAY, 0);
                    cal.set(Calendar.MINUTE, 0);
                    cal.set(Calendar.SECOND, 0);
                    cal.set(Calendar.MILLISECOND, 0);
                    fromDate = cal.getTime();

                    cal.setTime(parsedTo);
                    cal.set(Calendar.HOUR_OF_DAY, 23);
                    cal.set(Calendar.MINUTE, 59);
                    cal.set(Calendar.SECOND, 59);
                    cal.set(Calendar.MILLISECOND, 999);
                    toDate = cal.getTime();

                    if (fromDate.after(toDate)) {
                        context.addMessage(null, new FacesMessage(
                            FacesMessage.SEVERITY_ERROR, "From Date must not be after To Date.", null
                        ));
                        return null;
                    }
                    break;
                default:
                    context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                            "Unknown search type selected.", null));
                    return null;
            }

            // Debug logs
            System.out.println("=== [ClaimController] searchClaims() called ===");
            System.out.println("Search Type: " + searchType);
            System.out.println("Search Value: " + searchValue);
            System.out.println("From Date: " + fromDate);
            System.out.println("To Date: " + toDate);

            claimsList = claimDao.searchClaims(searchType.trim(), searchValue, fromDate, toDate);

            if (claimsList == null || claimsList.isEmpty()) {
                context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN,
                        "No claims found for the given criteria.", null));
                return null;
            }

            System.out.println("Claims Found: " + claimsList.size());
            return "searchClaims.jsp?faces-redirect=true";
        } catch (Exception e) {
            e.printStackTrace();
            FacesContext.getCurrentInstance().addMessage(null,
                    new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error while searching claims.", null));
            return null;
        }
    }

    public String resetSearch() {
        this.searchType = null;
        this.searchValue = null;
        this.fromDate = null;
        this.toDate = null;
        this.claimsList = null;
        return "searchClaims";
    }
    public String resetButton() {
        this.searchType = null;
        this.searchValue = null;
        this.fromDate = null;
        this.toDate = null;
        this.fromDateStr = null;
        this.toDateStr = null;
        this.claimsList = null;
        this.currentPage = 1;

        // Reset sorting
        this.sortColumn = "claimId";
        this.sortAsc = true;

        return "searchClaims?faces-redirect=true"; // force full refresh
    }

    // Getters and Setters
    public ClaimDAO getClaimDao() {
        return claimDao;
    }

    public void setClaimDao(ClaimDAO claimDao) {
        this.claimDao = claimDao;
    }

    public Claim getClaim() {
        return claim;
    }

    public void setClaim(Claim claim) {
        this.claim = claim;
    }

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public Recipient getRecipient() {
        return recipient;
    }

    public void setRecipient(Recipient recipient) {
        this.recipient = recipient;
    }

    public Subscribe getSubscribe() {
        return subscribe;
    }

    public void setSubscribe(Subscribe subscribe) {
        this.subscribe = subscribe;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchValue() {
        return searchValue;
    }

    public void setSearchValue(String searchValue) {
        this.searchValue = searchValue;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public List<Claim> getClaimsList() {
        return claimsList;
    }

    public void setClaimsList(List<Claim> claimsList) {
        this.claimsList = claimsList;
    }

    public String updateSearchType() {
        return "searchClaims";
    }

    public void searchTypeChanged(ValueChangeEvent event) {
        this.searchType = (String) event.getNewValue();
        this.searchType = null;
        this.searchValue = null;
        this.fromDate = null;
        this.toDate = null;
        this.fromDateStr = null;
        this.toDateStr = null;
        this.claimsList = null;
         
    }
    private void sortClaimsList() {
        if (claimsList == null) return;
        claimsList.sort((c1, c2) -> {
            int cmp = 0;
            switch (sortColumn) {
                case "claimId":
                    cmp = c1.getClaimId().compareTo(c2.getClaimId()); break;
                case "providerId":
                    cmp = c1.getProvider().getProviderId().compareTo(c2.getProvider().getProviderId()); break;
                case "subscribeId":
                    cmp = c1.getSubscribe().getSubscribeId().compareTo(c2.getSubscribe().getSubscribeId()); break;
                case "status":
                    cmp = c1.getClaimStatus().name().compareTo(c2.getClaimStatus().name()); break;
                case "claimDate":
                    cmp = c1.getClaimDate().compareTo(c2.getClaimDate()); break;
                case "amountClaimed":
                    cmp = Double.compare(c1.getAmountClaimed(), c2.getAmountClaimed()); break;
                case "amountApproved":
                    cmp = Double.compare(c1.getAmountApproved(), c2.getAmountApproved()); break;
                case "hId":
                    cmp = c1.getRecipient().gethId().compareTo(c2.getRecipient().gethId()); break;
            }
            return sortAsc ? cmp : -cmp;
        });
    }

        
    // --- Pagination (safe to call from getter; DO NOT mutate list here) ---
    public List<Claim> getPaginatedClaimsList() {
        if (claimsList == null) return java.util.Collections.emptyList();
        int fromIndex = (currentPage - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, claimsList.size());
        if (fromIndex > toIndex) {
            currentPage = 1;
            fromIndex = 0;
            toIndex = Math.min(pageSize, claimsList.size());
        }
        return claimsList.subList(fromIndex, toIndex);
    }
    public String nextPage() {
        if (currentPage < getTotalPages()) currentPage++;
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
        sortClaimsList(); // Only sorts on user action, not during page render
        return null;
    }

    // --- After each search, before rendering results ---
    private void resetToFirstPageAndSort() {
        currentPage = 1;
        sortClaimsList();
    }
    public boolean isPreviousDisabled() {
        return currentPage <= 1;
    }
    public boolean isNextDisabled() {
        return currentPage >= getTotalPages();
    }
    
    
    public int getShowingFrom() {
	    return (claimsList == null || claimsList.isEmpty()) ? 0 : ((currentPage - 1) * pageSize) + 1;
	}
 
	public int getShowingTo() {
	    if (claimsList == null || claimsList.isEmpty())
	        return 0;
	        
	    int toIndex = currentPage * pageSize;
	    return Math.min(toIndex, claimsList.size());
	}
 
	public int getTotalRecords() {
	    return claimsList == null ? 0 : claimsList.size();
	}

    

}