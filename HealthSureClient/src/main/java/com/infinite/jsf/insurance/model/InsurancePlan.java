package com.infinite.jsf.insurance.model;

import java.sql.Date;

public class InsurancePlan {
    private String planId;
    private String companyId;
    private String planName;
    private String planType;
    private int minEntryAge;
    private int maxEntryAge;
    private String description;
    private String availableCoverAmounts;
    private String waitingPeriod;
    private Date createdOn;
    private Date expireDate;
    private String periodicDiseases;

    // Getters and Setters
    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getPlanType() {
        return planType;
    }

    public void setPlanType(String planType) {
        this.planType = planType;
    }

    public int getMinEntryAge() {
        return minEntryAge;
    }

    public void setMinEntryAge(int minEntryAge) {
        this.minEntryAge = minEntryAge;
    }

    public int getMaxEntryAge() {
        return maxEntryAge;
    }

    public void setMaxEntryAge(int maxEntryAge) {
        this.maxEntryAge = maxEntryAge;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAvailableCoverAmounts() {
        return availableCoverAmounts;
    }

    public void setAvailableCoverAmounts(String availableCoverAmounts) {
        this.availableCoverAmounts = availableCoverAmounts;
    }

    public String getWaitingPeriod() {
        return waitingPeriod;
    }

    public void setWaitingPeriod(String waitingPeriod) {
        this.waitingPeriod = waitingPeriod;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getPeriodicDiseases() {
        return periodicDiseases;
    }

    public void setPeriodicDiseases(String periodicDiseases) {
        this.periodicDiseases = periodicDiseases;
    }

	public InsurancePlan() {
		
		// TODO Auto-generated constructor stub
	}
    
}
