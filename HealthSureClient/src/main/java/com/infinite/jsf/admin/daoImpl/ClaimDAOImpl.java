package com.infinite.jsf.admin.daoImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.infinite.jsf.admin.dao.ClaimDAO;
import com.infinite.jsf.provider.model.Claim;
import com.infinite.jsf.provider.model.ClaimStatus;

public class ClaimDAOImpl implements ClaimDAO {

	private static SessionFactory sessionFactory;

	static {
		try {
			sessionFactory = new Configuration().configure().buildSessionFactory();
			System.out.println("=== [Hibernate] SessionFactory initialized ===");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Claim> searchClaims(String searchType, String searchValue, Date fromDate, Date toDate) {
	    Session session = null;
	    Transaction tx = null;
	    List<Claim> result = new ArrayList<>();

	    try {
	        System.out.println("=== [DAO] searchClaims() called ===");
	        System.out.println("Search Type: " + searchType);
	        System.out.println("Search Value: " + searchValue);
	        System.out.println("From Date: " + fromDate);
	        System.out.println("To Date: " + toDate);

	        session = sessionFactory.openSession();
	        tx = session.beginTransaction();

	        StringBuilder hql = new StringBuilder("from Claim c where 1=1");

	        if ("subscribeId".equalsIgnoreCase(searchType)) {
	            hql.append(" and c.subscribe.subscribeId = :searchValue");
	        } else if ("providerId".equalsIgnoreCase(searchType)) {
	            hql.append(" and c.provider.providerId = :searchValue");
	        } else if ("hId".equalsIgnoreCase(searchType)) {
	            hql.append(" and c.recipient.hId = :searchValue");
	        } else if ("status".equalsIgnoreCase(searchType)) {
	            hql.append(" and c.claimStatus = :searchValue");
	        } else if ("dateRange".equalsIgnoreCase(searchType)) {
	            if (fromDate != null) {
	                hql.append(" and c.claimDate >= :fromDate");
	            }
	            if (toDate != null) {
	                hql.append(" and c.claimDate <= :toDate");
	            }
	        }

	        System.out.println("Generated HQL: " + hql.toString());

	        Query query = session.createQuery(hql.toString());

	        // Bind parameters
	        if ("status".equalsIgnoreCase(searchType)) {
	            try {
	                ClaimStatus statusEnum = ClaimStatus.valueOf(searchValue.toUpperCase());
	                query.setParameter("searchValue", statusEnum);
	                System.out.println("Set parameter: searchValue = " + statusEnum);
	            } catch (IllegalArgumentException e) {
	                throw new RuntimeException("Invalid claim status: " + searchValue, e);
	            }
	        } else if (!"dateRange".equalsIgnoreCase(searchType)) {
	            query.setParameter("searchValue", searchValue);
	            System.out.println("Set parameter: searchValue = " + searchValue);
	        }

	        if ("dateRange".equalsIgnoreCase(searchType)) {
	            if (fromDate != null) {
	                query.setParameter("fromDate", fromDate);
	                System.out.println("Set parameter: fromDate = " + fromDate);
	            }
	            if (toDate != null) {
	                query.setParameter("toDate", toDate);
	                System.out.println("Set parameter: toDate = " + toDate);
	            }
	        }

	        result = query.list();
	        System.out.println("=== [DAO] Claims found: " + result.size() + " ===");

	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) tx.rollback();
	        System.out.println("!!! [DAO ERROR] Exception in searchClaims(): " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        if (session != null) session.close();
	    }

	    return result;
	}
}