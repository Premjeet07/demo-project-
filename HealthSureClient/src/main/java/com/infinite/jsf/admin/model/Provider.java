package com.infinite.jsf.admin.model;

import java.util.Set;

public class Provider {
    private String providerId;
    private String providerName;
    private String hospitalName;
    private String email;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private String status;
    private java.sql.Timestamp createdAt;

    private Set<Claim> claims;
    private Set<MedicalProcedure> procedures;
    //private Set<PaymentHistory> payments;
	public String getProviderId() {
		return providerId;
	}
	public void setProviderId(String providerId) {
		this.providerId = providerId;
	}
	public String getProviderName() {
		return providerName;
	}
	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public java.sql.Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(java.sql.Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Set<Claim> getClaims() {
		return claims;
	}
	public void setClaims(Set<Claim> claims) {
		this.claims = claims;
	}
	public Set<MedicalProcedure> getProcedures() {
		return procedures;
	}
	public void setProcedures(Set<MedicalProcedure> procedures) {
		this.procedures = procedures;
	}
//	public Set<PaymentHistory> getPayments() {
//		return payments;
//	}
//	public void setPayments(Set<PaymentHistory> payments) {
//		this.payments = payments;
//	}
	public Provider() {
		super();
		// TODO Auto-generated constructor stub
	}

    // Getters and setters
    
    
}