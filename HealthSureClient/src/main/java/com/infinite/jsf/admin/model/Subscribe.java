package com.infinite.jsf.admin.model;

import java.util.Date;
import java.util.Set;

public class Subscribe {
    private String subscribeId;
    private Recipient recipient;
    private InsuranceCoverageOption insuranceCoverageOption;
    private Date subscribeDate;
    private Date expiryDate;
    private String status;
    private double totalPremium;
    private double amountPaid;
    private double remainingCoverageAmount;
    private Set<Claim> claims;

	public String getSubscribeId() {
		return subscribeId;
	}

	public void setSubscribeId(String subscribeId) {
		this.subscribeId = subscribeId;
	}

	public Recipient getRecipient() {
		return recipient;
	}

	public void setRecipient(Recipient recipient) {
		this.recipient = recipient;
	}

	

	public InsuranceCoverageOption getInsuranceCoverageOption() {
		return insuranceCoverageOption;
	}

	public void setInsuranceCoverageOption(InsuranceCoverageOption insuranceCoverageOption) {
		this.insuranceCoverageOption = insuranceCoverageOption;
	}

	public Date getSubscribeDate() {
		return subscribeDate;
	}

	public void setSubscribeDate(Date subscribeDate) {
		this.subscribeDate = subscribeDate;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getTotalPremium() {
		return totalPremium;
	}

	public void setTotalPremium(double totalPremium) {
		this.totalPremium = totalPremium;
	}

	public double getAmountPaid() {
		return amountPaid;
	}

	public void setAmountPaid(double amountPaid) {
		this.amountPaid = amountPaid;
	}

	public Set<Claim> getClaims() {
		return claims;
	}

	public void setClaims(Set<Claim> claims) {
		this.claims = claims;
	}

	public Subscribe() {
		super();
		// TODO Auto-generated constructor stub
	}

	public double getRemainingCoverageAmount() {
		return remainingCoverageAmount;
	}

	public void setRemainingCoverageAmount(double remainingCoverageAmount) {
		this.remainingCoverageAmount = remainingCoverageAmount;
	}

    
    // Getters and setters
}