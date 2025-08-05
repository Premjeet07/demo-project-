package com.infinite.jsf.admin.daoImpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Query;

import com.infinite.jsf.admin.dao.PaymentProcessingDAO;
import com.infinite.jsf.admin.model.Claim;
import com.infinite.jsf.admin.model.PaymentHistory;
import com.infinite.jsf.admin.model.PaymentStatus;

public class PaymentProcessingDAOImpl implements PaymentProcessingDAO {

    private SessionFactory sessionFactory;

    public PaymentProcessingDAOImpl() {
        sessionFactory = new Configuration().configure().buildSessionFactory();
    }

    @Override
    public List<Claim> getApprovedAndPendingClaims() {
        Session session = sessionFactory.openSession();
        try {
            String hql = "SELECT DISTINCT c FROM Claim c " +
                    "JOIN FETCH c.paymentHistories p " +
                    "WHERE c.claimStatus = :approved AND p.paymentStatus = :pending";

            Query query = session.createQuery(hql);
            query.setParameter("approved", com.infinite.jsf.admin.model.ClaimStatus.APPROVED);
            query.setParameter("pending", com.infinite.jsf.admin.model.PaymentStatus.pending);
            
            return query.list();
        } finally {
            session.close();
        }
    }


    @Override
    public List<Claim> getApprovedAndPendingClaimsByProvider(String providerId) {
        Session session = sessionFactory.openSession();
        try {
            String hql = "SELECT DISTINCT c FROM Claim c " +
                         "JOIN c.paymentHistories p " +
                         "WHERE c.claimStatus = :approved " +
                         "AND p.paymentStatus = :pending " +
                         "AND c.provider.providerId = :providerId";
            Query query = session.createQuery(hql);
            query.setParameter("approved", com.infinite.jsf.admin.model.ClaimStatus.APPROVED);
            query.setParameter("pending", com.infinite.jsf.admin.model.PaymentStatus.pending);
            query.setParameter("providerId", providerId);
            return query.list();
        } finally {
            session.close();
        }
    }


    public PaymentHistory getPendingPaymentByClaimId(String claimId) {
        Session session = sessionFactory.openSession();
        try {
            String hql = "SELECT c FROM Claim c LEFT JOIN FETCH c.paymentHistories WHERE c.claimId = :claimId";
            Query query = session.createQuery(hql);
            query.setParameter("claimId", claimId);
            Claim claim = (Claim) query.uniqueResult();
            if (claim != null && claim.getPaymentHistories() != null) {
                // Find first payment with status not 'completed'
                for (PaymentHistory p : claim.getPaymentHistories()) {
                    if (!PaymentStatus.completed.equals(p.getPaymentStatus())) {
                        return p;
                    }
                }
            }
            return null;  // No pending payment found
        } finally {
            session.close();
        }
    }



    @Override
    public void saveOrUpdatePayment(PaymentHistory payment) {
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            session.update(payment); // Only updates existing records
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public void updateSubscribeCoverageAmount(String subscribeId, double deductionAmount) {
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            String hql = "UPDATE Subscribe s SET s.remainingCoverageAmount = s.remainingCoverageAmount - :deduct "
                    + "WHERE s.subscribeId = :sid";
            Query q = session.createQuery(hql);
            q.setParameter("deduct", deductionAmount);
            q.setParameter("sid", subscribeId);
            q.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public void updateClaimApprovedAmount(String claimId, double amountApproved) {
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            String hql = "UPDATE Claim c SET c.amountApproved = :amt WHERE c.claimId = :cid";
            Query q = session.createQuery(hql);
            q.setParameter("amt", amountApproved);
            q.setParameter("cid", claimId);
            q.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public void updateAccountAmountPaid(String providerId, double addAmount) {
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            String hql = "UPDATE Account a SET a.amountPaid = a.amountPaid + :amt WHERE a.provider.providerId = :pid";
            Query q = session.createQuery(hql);
            q.setParameter("amt", addAmount);
            q.setParameter("pid", providerId);
            q.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

//    @Override
//    public PaymentHistory getPaymentHistoryByClaimId(String claimId) {
//        Session session = sessionFactory.openSession();
//        try {
//            Query query = session.createQuery(
//                "FROM PaymentHistory WHERE claimId = :claimId ORDER BY paymentId DESC"
//            );
//            query.setParameter("claimId", claimId);
//            query.setMaxResults(1);
//            return (PaymentHistory) query.uniqueResult();
//        } finally {
//            session.close();
//        }
//    }


	


}
