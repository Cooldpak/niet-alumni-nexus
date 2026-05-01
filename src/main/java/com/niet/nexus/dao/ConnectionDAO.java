package com.niet.nexus.dao;

import com.niet.nexus.config.HibernateUtil;
import com.niet.nexus.models.Connection;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class ConnectionDAO {

    public List<Connection> getPendingRequestsForUser(Long receiverId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Connection c JOIN FETCH c.requester WHERE c.receiver.id = :receiverId AND c.status = 'REQUESTED' ORDER BY c.createdAt DESC";
            Query<Connection> query = session.createQuery(hql, Connection.class);
            query.setParameter("receiverId", receiverId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Connection> getRequestsByRequester(Long requesterId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Connection c JOIN FETCH c.receiver JOIN FETCH c.requester WHERE c.requester.id = :requesterId ORDER BY c.createdAt DESC";
            Query<Connection> query = session.createQuery(hql, Connection.class);
            query.setParameter("requesterId", requesterId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Connection> getAcceptedConnectionsForUser(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Connection c JOIN FETCH c.requester JOIN FETCH c.receiver " +
                         "WHERE (c.requester.id = :userId OR c.receiver.id = :userId) " +
                         "AND c.status = 'ACCEPTED' ORDER BY c.createdAt DESC";
            Query<Connection> query = session.createQuery(hql, Connection.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateConnectionStatus(Long connectionId, Connection.Status status) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Connection connection = session.get(Connection.class, connectionId);
            if (connection != null) {
                connection.setStatus(status);
                session.merge(connection);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void createConnectionRequest(Connection connection) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Re-attach the detached User objects to the current Hibernate session
            com.niet.nexus.models.User attachedRequester = session.get(com.niet.nexus.models.User.class, connection.getRequester().getId());
            com.niet.nexus.models.User attachedReceiver = session.get(com.niet.nexus.models.User.class, connection.getReceiver().getId());
            
            connection.setRequester(attachedRequester);
            connection.setReceiver(attachedReceiver);
            
            session.persist(connection);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
