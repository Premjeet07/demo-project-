package com.infinite.jsf.admin.dao;


import com.infinite.jsf.admin.model.PaymentHistory;
import com.infinite.jsf.provider.model.Claim;

import java.util.List;

public interface PaymentProcessingDAO {
    List<Claim> getApprovedAndPendingClaims();
    List<Claim> getApprovedAndPendingClaimsByProvider(String providerId);

    PaymentHistory getPendingPaymentByClaimId(String claimId);
    void saveOrUpdatePayment(PaymentHistory payment);

    void updateSubscribeCoverageAmount(String subscribeId, double deductionAmount);
    void updateClaimApprovedAmount(String claimId, double amountApproved);
	void updateAccountAmountPaid(String providerId, double addAmount);
	//PaymentHistory getPaymentHistoryByClaimId(String claimId);
}
