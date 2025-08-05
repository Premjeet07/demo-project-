package com.infinite.jsf.admin.dao;

import com.infinite.jsf.admin.model.ClaimHistory;

public interface ClaimHistoryDAO {
    
    void addClaimHistory(ClaimHistory claimHistory);
    
    ClaimHistory getLatestHistoryByClaimId(String claimId);
}