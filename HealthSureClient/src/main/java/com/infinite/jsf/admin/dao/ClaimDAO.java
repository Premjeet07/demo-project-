package com.infinite.jsf.admin.dao;



import java.util.Date;
import java.util.List;

import com.infinite.jsf.provider.model.Claim;

public interface ClaimDAO {

	List<Claim> searchClaims(String searchType, String searchValue, Date fromDate, Date toDate);
    //List<Claim> searchClaims(String subscribeId, String providerId, String hId, String status, Date fromDate, Date toDate);
}