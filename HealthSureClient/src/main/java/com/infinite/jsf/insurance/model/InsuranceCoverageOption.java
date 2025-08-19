package com.infinite.jsf.insurance.model;

public class InsuranceCoverageOption {
    private String coverageId;
    private String planId;
    private double premiumAmount;
    private double coverageAmount;
    private String status;
   // private double insuranceCoverageOption;

    // Getters and Setters
    public String getCoverageId() {
        return coverageId;
    }
    public void setCoverageId(String coverageId) {
        this.coverageId = coverageId;
    }
    public String getPlanId() {
        return planId;
    }
    public void setPlanId(String planId) {
        this.planId = planId;
    }
    public double getPremiumAmount() {
        return premiumAmount;
    }
    public void setPremiumAmount(double premiumAmount) {
        this.premiumAmount = premiumAmount;
    }
    public double getCoverageAmount() {
        return coverageAmount;
    }
    public void setCoverageAmount(double coverageAmount) {
        this.coverageAmount = coverageAmount;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
//	public double getInsuranceCoverageOption() {
//		return insuranceCoverageOption;
//	}
//	public void setInsuranceCoverageOption(double insuranceCoverageOption) {
//		this.insuranceCoverageOption = insuranceCoverageOption;
//	}
}