package com.infinite.jsf.admin.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.Query;
import org.hibernate.cfg.Configuration;

import com.infinite.jsf.admin.dao.ClaimHistoryDAO;
import com.infinite.jsf.admin.model.ClaimHistory;

public class ClaimHistoryDAOImpl implements ClaimHistoryDAO {

    SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();

    @Override
    public void addClaimHistory(ClaimHistory claimHistory) {
        Session session = sessionFactory.openSession();
        Transaction trans = session.beginTransaction();
        session.save(claimHistory);
        trans.commit();
        session.close();
    }

    @Override
    public ClaimHistory getLatestHistoryByClaimId(String claimId) {
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("FROM ClaimHistory WHERE claim.claimId = :claimId ORDER BY actionDate DESC");
        query.setParameter("claimId", claimId);
        query.setMaxResults(1);
        List<ClaimHistory> result = query.list();
        session.close();
        return result.isEmpty() ? null : result.get(0);
    }
}