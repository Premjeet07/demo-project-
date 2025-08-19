package com.infinite.jsf.admin.dao;


import com.infinite.jsf.admin.model.PaymentHistory;
import com.infinite.jsf.provider.model.Claim;
import com.infinite.jsf.provider.model.ClaimHistory;

public interface ProcessClaimDAO {
    

   // void updateClaimStatus(String claimId, String status);

    //void addClaimHistory(String claimId, String description);
    public double getCoverageAmountBySubscribeId(String subscribeId);
    public double getCoverageAmountByHid(String coverageId);
   
        Claim getClaimById(String claimId);
        void updateClaimStatus(Claim claim);
        void updateClaimStatusById(String claimId, String statusStr);
        void saveClaimHistory(ClaimHistory claimHistory);
        public void updateClaimDescription(String claimId,String description);
       // void processClaim(Claim claim, String status, String remarks, String reason, double approvedAmount);
		public PaymentHistory getPaymentHistoryByClaimId(String claimId);
    }
