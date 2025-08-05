package com.infinite.jsf.admin.model;

import java.sql.Timestamp;
import java.util.Set;

public class Claim {
	private String claimId;
	private Subscribe subscribe;
	private MedicalProcedure procedure;
	private Provider provider;
	private Recipient recipient;
	//private String claimStatus;
	private ClaimStatus claimStatus;
	private Timestamp claimDate;
	private double amountClaimed;
	private double amountApproved;
	private Set<PaymentHistory> paymentHistories;

	public Set<PaymentHistory> getPaymentHistories() {
	    return paymentHistories;
	}

	public void setPaymentHistories(Set<PaymentHistory> paymentHistories) {
	    this.paymentHistories = paymentHistories;
	}



	public String getClaimId() {
		return claimId;
	}

	public void setClaimId(String claimId) {
		this.claimId = claimId;
	}

	public Subscribe getSubscribe() {
		return subscribe;
	}

	public void setSubscribe(Subscribe subscribe) {
		this.subscribe = subscribe;
	}

	public MedicalProcedure getProcedure() {
		return procedure;
	}

	public void setProcedure(MedicalProcedure procedure) {
		this.procedure = procedure;
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


	public ClaimStatus getClaimStatus() {
		return claimStatus;
	}

	public void setClaimStatus(ClaimStatus claimStatus) {
		this.claimStatus = claimStatus;
	}

	public Timestamp getClaimDate() {
		return claimDate;
	}

	public void setClaimDate(Timestamp claimDate) {
		this.claimDate = claimDate;
	}

	public double getAmountClaimed() {
		return amountClaimed;
	}

	public void setAmountClaimed(double amountClaimed) {
		this.amountClaimed = amountClaimed;
	}

	public double getAmountApproved() {
		return amountApproved;
	}

	public void setAmountApproved(double amountApproved) {
		this.amountApproved = amountApproved;
	}

	public Claim() {
		super();
		// TODO Auto-generated constructor stub
	}

	// Getters and setters

}