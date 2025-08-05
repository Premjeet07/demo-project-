package com.infinite.jsf.admin.model;

import java.sql.Timestamp;

public class ProviderPassword {
    private int resetId;
    private Provider provider; // Foreign key relationship
    private String oldPassword;
    private String newPassword;
    private Timestamp resetTime;
	public int getResetId() {
		return resetId;
	}
	public void setResetId(int resetId) {
		this.resetId = resetId;
	}
	public Provider getProvider() {
		return provider;
	}
	public void setProvider(Provider provider) {
		this.provider = provider;
	}
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public Timestamp getResetTime() {
		return resetTime;
	}
	public void setResetTime(Timestamp resetTime) {
		this.resetTime = resetTime;
	}
	public ProviderPassword() {
		
		// TODO Auto-generated constructor stub
	}

    // Getters and Setters
    
}
