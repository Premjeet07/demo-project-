  package com.infinite.jsf.admin.model;

import java.io.Serializable;
import java.util.Date;

public class ClaimHistory implements Serializable{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String claimHistoryId;

    private Claim claim;  // Many-to-one relationship with Claims

    private String description;

    private Date actionDate;

    // Getters and Setters

    public String getClaimHistoryId() {
        return claimHistoryId;
    }

    public void setClaimHistoryId(String claimHistoryId) {
        this.claimHistoryId = claimHistoryId;
    }

    public Claim getClaim() {
        return claim;
    }

    public void setClaim(Claim claim) {
        this.claim = claim;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getActionDate() {
        return actionDate;
    }

    public void setActionDate(Date actionDate) {
        this.actionDate = actionDate;
    }
}