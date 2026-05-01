package com.niet.nexus.dao;

import com.niet.nexus.config.HibernateUtil;
import com.niet.nexus.models.Message;
import com.niet.nexus.models.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class MessageDAO {

    public List<Message> getConversation(Long userId1, Long userId2) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Message m JOIN FETCH m.sender JOIN FETCH m.receiver " +
                         "WHERE (m.sender.id = :u1 AND m.receiver.id = :u2) " +
                         "   OR (m.sender.id = :u2 AND m.receiver.id = :u1) " +
                         "ORDER BY m.sentAt ASC";
            Query<Message> query = session.createQuery(hql, Message.class);
            query.setParameter("u1", userId1);
            query.setParameter("u2", userId2);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void saveMessage(Message message) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            User attachedSender = session.get(User.class, message.getSender().getId());
            User attachedReceiver = session.get(User.class, message.getReceiver().getId());
            message.setSender(attachedSender);
            message.setReceiver(attachedReceiver);
            
            session.persist(message);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public void deleteConversation(Long userId1, Long userId2) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            String hql = "DELETE FROM Message m WHERE (m.sender.id = :u1 AND m.receiver.id = :u2) OR (m.sender.id = :u2 AND m.receiver.id = :u1)";
            org.hibernate.query.MutationQuery query = session.createMutationQuery(hql);
            query.setParameter("u1", userId1);
            query.setParameter("u2", userId2);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
