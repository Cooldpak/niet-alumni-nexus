package com.niet.nexus.dao;

import com.niet.nexus.config.HibernateUtil;
import com.niet.nexus.models.Resource;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class ResourceDAO {

    public List<Resource> getAllResources() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Resource r ORDER BY r.createdAt DESC";
            Query<Resource> query = session.createQuery(hql, Resource.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
