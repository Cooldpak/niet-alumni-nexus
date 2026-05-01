package com.niet.nexus.dao;

import com.niet.nexus.config.HibernateUtil;
import com.niet.nexus.models.JobPost;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class JobDAO {

    public List<JobPost> getAllJobs() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM JobPost j ORDER BY j.createdAt DESC";
            Query<JobPost> query = session.createQuery(hql, JobPost.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void saveJob(JobPost job) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(job);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
