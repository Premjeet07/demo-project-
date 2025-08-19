package com.infinite.jsf.recepient.model;

import java.util.Set;

import com.infinite.jsf.insurance.model.Subscribe;
import com.infinite.jsf.provider.model.Claim;
import com.infinite.jsf.provider.model.MedicalProcedure;

public class Recipient {
    private String hId;
    private String firstName;
    private String lastName;
    private String mobile;
    private String userName;
    private String gender;
    private java.sql.Date dob;
    private String address;
    private java.sql.Timestamp createdAt;
    private String password;
    private String email;
    private String status;

    private Set<Subscribe> subscriptions;
    private Set<Claim> claims;
    private Set<MedicalProcedure> procedures;
   // private Set<PaymentHistory> payments;
	public String gethId() {
		return hId;
	}
	public void sethId(String hId) {
		this.hId = hId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public java.sql.Date getDob() {
		return dob;
	}
	public void setDob(java.sql.Date dob) {
		this.dob = dob;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public java.sql.Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(java.sql.Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Set<Subscribe> getSubscriptions() {
		return subscriptions;
	}
	public void setSubscriptions(Set<Subscribe> subscriptions) {
		this.subscriptions = subscriptions;
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
	public Recipient() {
		super();
		// TODO Auto-generated constructor stub
	}
    
    

    
    
    // Getters and setters
}