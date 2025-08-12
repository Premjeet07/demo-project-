package com.infinite.jsf.admin.daoImpl;

import com.infinite.jsf.admin.dao.ProcessClaimDAO;
import com.infinite.jsf.admin.model.Claim;
import com.infinite.jsf.admin.model.ClaimHistory;
import com.infinite.jsf.admin.model.ClaimStatus;
import com.infinite.jsf.admin.model.PaymentHistory;
import com.infinite.jsf.admin.model.PaymentStatus;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class ProcessClaimDAOImpl implements ProcessClaimDAO {

    private static SessionFactory sessionFactory;

    static {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    public void updateClaimStatus(Claim claim) {
        Session session = null;
        Transaction tx = null;

        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.update(claim);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
    @Override
    public void updateClaimDescription(String claimId, String description) {
        Session session = null;
        Transaction tx = null;

        try {
            session = new Configuration().configure().buildSessionFactory().openSession();
            tx = session.beginTransaction();

            // Assuming claimId is unique in ClaimHistory for current logic
            Query query = session.createQuery(
                "update ClaimHistory set description = :desc where claim.claimId = :claimId"
            );
            query.setParameter("desc", description);
            query.setParameter("claimId", claimId);

            int updated = query.executeUpdate();
            System.out.println("Updated rows: " + updated);

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
    @Override
    public void updateClaimStatusById(String claimId, String statusStr) {
        Session session = null;
        Transaction tx = null;

        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            Claim claim = (Claim) session.get(Claim.class, claimId);

            if (claim != null) {
                ClaimStatus newStatus = ClaimStatus.valueOf(statusStr);
                claim.setClaimStatus(newStatus);
                session.update(claim);

                if (newStatus == ClaimStatus.APPROVED) {

                    // 🛡️ Null safety checks
                    if (claim.getRecipient() == null || claim.getProvider() == null) {
                        System.out.println("❌ Recipient or Provider is null for Claim ID: " + claimId);
                        throw new RuntimeException("Missing Recipient or Provider in Claim: " + claimId);
                    }

                    PaymentHistory payment = new PaymentHistory();
                    payment.setClaimId(claim.getClaimId());
                    payment.sethId(claim.getRecipient().gethId());
                    payment.setProviderId(claim.getProvider().getProviderId());
                    payment.setAmount(claim.getAmountClaimed());
                    payment.setPaymentMethod("Not Selected");
                    payment.setPaymentStatus(PaymentStatus.pending);
                    payment.setPaymentDate(new java.sql.Timestamp(new java.util.Date().getTime()));
                    payment.setRemarks("Auto-generated after approval");

                    session.save(payment);
                    System.out.println("✅ PaymentHistory inserted for Claim: " + claimId);
                }
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
    public void saveClaimHistory(ClaimHistory history) {
        Session session = null;
        Transaction tx = null;

        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.save(history);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }


    
    @Override
    public double getCoverageAmountBySubscribeId(String subscribeId) {
       SessionFactory factory = new Configuration().configure().buildSessionFactory();

        Session session = factory.openSession();
        double amount = 0.0;
        try {
            Query query = session.createQuery(
                    "select s.remainingCoverageAmount from Subscribe s where s.subscribeId = :subscribeId"

            );
            query.setParameter("subscribeId", subscribeId);
            Double result = (Double) query.uniqueResult();
            if (result != null) {
                amount = result;
            }
        } finally {
            session.close();
        }
        return amount;
    }
    
   // SessionFactory factory = new Configuration().configure().buildSessionFactory();

    @Override
    public Claim getClaimById(String claimId) {
        SessionFactory factory = new Configuration().configure().buildSessionFactory();

        Session session = factory.openSession();
        Claim claim = null;
        try {
            Query query = session.createQuery(
                "from Claim c " +
                "join fetch c.provider " +
                "join fetch c.subscribe " +
                "join fetch c.procedure " +
                "where c.claimId = :claimId"
            );
            query.setParameter("claimId", claimId);
            query.setMaxResults(1);
            claim = (Claim) query.uniqueResult();
        } finally {
            session.close();
        }
        return claim;
    }
//    @Override
//    public double getCoverageAmountByHid(String hId) {
//        SessionFactory factory = new Configuration().configure().buildSessionFactory();
//        Session session = factory.openSession();
//        double amount = 0.0;
//        try {
//            Query query = session.createQuery(
//                "select s.remainingCoverageAmount from Subscribe s where s.recipient.hId = :hId"
//            );
//            query.setParameter("hId", hId);
//            Double result = (Double) query.uniqueResult();
//            if (result != null) {
//                amount = result;
//            }
//        } finally {
//            session.close();
//        }
//        return amount;
//    }
    
    @Override
    public double getCoverageAmountByHid(String coverageId) {
        SessionFactory factory = new Configuration().configure().buildSessionFactory();
        Session session = factory.openSession();
        double amount = 0.0;
        try {
            Query query = session.createQuery(
                "select s.remainingCoverageAmount from Subscribe s where s.insuranceCoverageOption.coverageId = :coverageId"
            );
            query.setParameter("coverageId", coverageId);
           // List<Double> results = query.list();  // Get all matching values

             Double result = (Double) query.uniqueResult();
                if (result != null) {
                    amount = result;  // Sum them up
                }
            
        } finally {
            session.close();
        }
        return amount;
    }

//    public PaymentHistory getLatestPaymentHistoryByClaimId(String claimId) {
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
	@Override
	public PaymentHistory getPaymentHistoryByClaimId(String claimId) {
		Session session = sessionFactory.openSession();
        try {
            Query query = session.createQuery(
                "FROM PaymentHistory WHERE claimId = :claimId ORDER BY paymentId DESC"
            );
            query.setParameter("claimId", claimId);
            query.setMaxResults(1);
            return (PaymentHistory) query.uniqueResult();
        } finally {
            session.close();
        
	}


	

        

	}	
}