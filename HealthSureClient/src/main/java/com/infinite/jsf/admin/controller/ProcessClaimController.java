package com.infinite.jsf.admin.controller;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;

import com.infinite.jsf.admin.dao.ProcessClaimDAO;
import com.infinite.jsf.admin.daoImpl.ClaimHistoryDAOImpl;
import com.infinite.jsf.admin.model.Claim;
import com.infinite.jsf.admin.model.ClaimHistory;
import com.infinite.jsf.admin.model.ClaimStatus;
import com.infinite.jsf.admin.model.PaymentHistory;



public class ProcessClaimController {

	
    private Claim claim;
    private String claimId;
    private String description;
    private ClaimHistoryDAOImpl claimHistoryDao;
    private PaymentHistory paymentHistory;
    
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


	//private double remainingCoverageAmount;


    public String getClaimId() {
		return claimId;
	}

	public void setClaimId(String claimId) {
		this.claimId = claimId;
	}


	private ClaimHistory claimHistory = new ClaimHistory();  // ✅ Needed for <h:inputTextarea value="#{...}"/>
    private String status; // APPROVED or DENIED
    private String selectedReason;
    private String otherReason;

    private ProcessClaimDAO processClaimDAO; // ✅ Injected via faces-config.xml

    public ProcessClaimController() {
        // No manual DAO initialization here
    }
    private String approveReason="";
    private String denyReason="";

    public String getApproveReason() {
        return approveReason;
    }
    public void setApproveReason(String approveReason) {
        this.approveReason = approveReason;
    }

    public String getDenyReason() {
        return denyReason;
    }
    public void setDenyReason(String denyReason) {
        this.denyReason = denyReason;
    }
    private String hId;
    private Double remainingCoverageAmount;

    public Double getRemainingCoverageAmount() {
		return remainingCoverageAmount;
	}

//	public void setRemainingCoverageAmount(Double remainingCoverageAmount) {
//		this.remainingCoverageAmount = remainingCoverageAmount;
//	}
    public String gethId() { return hId; }
    public void sethId(String hId) { this.hId = hId; }


    // ==== GETTERS & SETTERS ====

    public Claim getClaim() {
        return claim;
    }

    public void setClaim(Claim claim) {
        this.claim = claim;
    }

    public ClaimHistory getClaimHistory() {
        return claimHistory;
    }

    public void setClaimHistory(ClaimHistory claimHistory) {
        this.claimHistory = claimHistory;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSelectedReason() {
        return selectedReason;
    }

    public void setSelectedReason(String selectedReason) {
        this.selectedReason = selectedReason;
    }

    public String getOtherReason() {
        return otherReason;
    }

    public void setOtherReason(String otherReason) {
        this.otherReason = otherReason;
    }

    public ProcessClaimDAO getProcessClaimDAO() {
        return processClaimDAO;
    }

    public void setProcessClaimDAO(ProcessClaimDAO processClaimDAO) {
        this.processClaimDAO = processClaimDAO;
    }

  
    
    public String fetchClaimDetails() {
        claim = processClaimDAO.getClaimById(claimId);

        if (claim != null && claim.getSubscribe() != null) {
            String subscribeId = claim.getSubscribe() != null ? claim.getSubscribe().getSubscribeId() : null;
            // If hId via recipient, use getCoverageAmountByHid; if subscribeId is more accurate, use that.
            if(subscribeId != null) {
                 remainingCoverageAmount = processClaimDAO.getCoverageAmountBySubscribeId(claim.getSubscribe().getSubscribeId());
            }
            // OR if you want to fetch by subscribeId:
            // remainingCoverageAmount = processClaimDAO.getRemainingCoverageAmountBySubscribeId(claim.getSubscribe().getSubscribeId());
        } else {
            remainingCoverageAmount = null;
        }

        if (claim != null) {
            ClaimStatus currentStatus = claim.getClaimStatus(); // ✅ enum type
            
            if (currentStatus == ClaimStatus.PENDING) {
                return "processClaim.jsf";
            } else if (currentStatus == ClaimStatus.APPROVED) {
                this.paymentHistory = processClaimDAO.getPaymentHistoryByClaimId(claim.getClaimId()); // ✅ Fetch from DB
                return "approvedClaim.jsf";
            
            } else if (currentStatus == ClaimStatus.DENIED) {
                return "deniedClaim.jsf";
            } else {
                FacesContext.getCurrentInstance().addMessage(null, 
                    new FacesMessage(FacesMessage.SEVERITY_WARN, "Unknown claim status", null));
                return null;
            }
        } else {
            FacesContext.getCurrentInstance().addMessage(null, 
                new FacesMessage(FacesMessage.SEVERITY_ERROR, "Claim not found", null));
            return null;
        }
    }


    // ==== MAIN CLAIM PROCESSING ====

    public String processClaim() {
        FacesContext context = FacesContext.getCurrentInstance();

        // 🚦 Always retrieve the most up-to-date claim object from DB
        Claim latestClaim = processClaimDAO.getClaimById(claim.getClaimId());

        // 🚧 Double-submit / double-action protection: only if status is still PENDING!
        if (latestClaim == null) {
            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR,
                    "This claim no longer exists or cannot be found.", null));
            claimProcessed = true;
            return null;
        }
        if (!ClaimStatus.PENDING.equals(latestClaim.getClaimStatus())) {
            context.addMessage(null, new FacesMessage(
                FacesMessage.SEVERITY_WARN,
                "This claim is already " + latestClaim.getClaimStatus().name().toLowerCase() +
                ".", null
            ));
            claimProcessed = true;
            return null;
        }

        // Proceed with all existing validation BEFORE updating anything
        String finalReason = "";
        if ("APPROVED".equals(status)) {
            finalReason = "Other".equals(approveReason) ? otherReason : approveReason;
        } else if ("DENIED".equals(status)) {
            finalReason = "Other".equals(denyReason) ? otherReason : denyReason;
        }

        boolean isValid = true;
        if (status == null || status.trim().isEmpty()) {
            context.addMessage("form:status", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please choose one radio button", null));
            isValid = false;
        }
        if ("APPROVED".equals(status) && claim.getAmountClaimed() > getRemainingCoverageAmount()) {
            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, " The Amount Claimed Exceeds The Available Coverage:", null));
            isValid = false;
        }
        if ("APPROVED".equals(status) && (approveReason == null || approveReason.trim().isEmpty())) {
            context.addMessage("form:approveReason", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please choose one reason", null));
            isValid = false;
        }
        if ("DENIED".equals(status) && (denyReason == null || denyReason.trim().isEmpty())) {
            context.addMessage("form:denyReason", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Please choose one denied reason", null));
            isValid = false;
        }
        if (("APPROVED".equals(status) && "Other".equals(approveReason) && (otherReason == null || otherReason.trim().isEmpty()))
            || ("DENIED".equals(status) && "Other".equals(denyReason) && (otherReason == null || otherReason.trim().isEmpty()))) {
            context.addMessage("form:otherReasonTextArea", new FacesMessage(FacesMessage.SEVERITY_ERROR, "Description is required", null));
            isValid = false;
        }
        if (!isValid) {
            context.validationFailed();
            return null;
        }

        // ---- ACTUAL PROCESSING ----
        claimProcessed = true;
        finalStatusMessage = "Claim " + status + " successfully.";

        processClaimDAO.updateClaimDescription(claim.getClaimId(), finalReason);
        processClaimDAO.updateClaimStatusById(claim.getClaimId(), status);
        //processClaimDAO.updateClaimDescription(claim.getClaimId(),finalReason);

        // 🔄 Refetch latest claim, so details/status update IMMEDIATELY on page!
        this.claim = processClaimDAO.getClaimById(claim.getClaimId());

        // ✅ Show info message (top-of-page if <h:messages/> is placed before details)
        context.addMessage(null, new FacesMessage(
            FacesMessage.SEVERITY_INFO,
            "Claim has been " + status.toLowerCase() + " successfully.",
            null
        ));

        return "claimUpdated.jsf"; // forward/navigation as needed
    }



    

	public String updateDescription() {
	    System.out.println("Updating description for claimId: " + claimId);
	    processClaimDAO.updateClaimDescription(claimId, description);
	    return "claimUpdated.jsf";  // Or stay on same page
	}
	
	public String reset() {
		this.status = null;
		this.approveReason="";
		this.denyReason="";
		
		return null;
	}
	public void onStatusChange(ValueChangeEvent event) {
	    String newStatus = (String) event.getNewValue();
	    // Reset both dropdowns to default on radio change
	    this.approveReason = "";
	    this.denyReason = "";
	    this.otherReason = "";
	    this.status = newStatus;
	    
	    FacesContext.getCurrentInstance().renderResponse();
	    //System.out.println("i am very close");
	    
	}
	


	public ClaimHistoryDAOImpl getClaimHistoryDao() {
		return claimHistoryDao;
	}

	public void setClaimHistoryDao(ClaimHistoryDAOImpl claimHistoryDao) {
		this.claimHistoryDao = claimHistoryDao;
	}
	
	
	public String getLatestDescriptionByClaimId(String claimId) {
	    ClaimHistory history = claimHistoryDao.getLatestHistoryByClaimId(claimId);
	    return history != null ? history.getDescription() : null;
	}
	//private String latestReason;

	public String getLatestReason() {
	    if (claimId != null && claimHistoryDao != null) {
	        ClaimHistory history = claimHistoryDao.getLatestHistoryByClaimId(claimId);
	        if (history != null) {
	            return history.getDescription();  // <-- Always return FRESH DB value!
	        }
	    }
	    return "";
	}


//	public void setLatestReason(String latestReason) {
//	    this.latestReason = latestReason;
//	}
	
	public boolean isClaimProcessed() {
		return claimProcessed;
	}

	public void setClaimProcessed(boolean claimProcessed) {
		this.claimProcessed = claimProcessed;
	}

	public String getFinalStatusMessage() {
		return finalStatusMessage;
	}

	public void setFinalStatusMessage(String finalStatusMessage) {
		this.finalStatusMessage = finalStatusMessage;
	}


	public PaymentHistory getPaymentHistory() {
		return paymentHistory;
	}

	public void setPaymentHistory(PaymentHistory paymentHistory) {
		this.paymentHistory = paymentHistory;
	}

	private boolean claimProcessed = false;
	private String finalStatusMessage;

public String backToSearchClaims() {
	return "claimResult.jsf?faces-redirect=true";
}



}
