package com.niet.nexus.dao;

import com.niet.nexus.config.HibernateUtil;
import com.niet.nexus.models.Profile;
import com.niet.nexus.models.User;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class ProfileDAO {

    public List<Profile> getAllAlumniProfiles() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Fetch all profiles where the associated user is an ALUMNI and APPROVED
            String hql = "SELECT p FROM Profile p JOIN FETCH p.user WHERE p.user.role = :role ORDER BY p.mentorshipPoints DESC";
            Query<Profile> query = session.createQuery(hql, Profile.class);
            query.setParameter("role", User.Role.ALUMNI);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Profile> searchAlumniProfiles(String department, String industry) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("SELECT p FROM Profile p JOIN FETCH p.user WHERE p.user.role = 'ALUMNI'");
            
            if (department != null && !department.isEmpty()) {
                hql.append(" AND p.department LIKE :dept");
            }
            if (industry != null && !industry.isEmpty()) {
                hql.append(" AND p.currentIndustry LIKE :ind");
            }
            hql.append(" ORDER BY p.mentorshipPoints DESC");

            Query<Profile> query = session.createQuery(hql.toString(), Profile.class);
            
            if (department != null && !department.isEmpty()) {
                query.setParameter("dept", "%" + department + "%");
            }
            if (industry != null && !industry.isEmpty()) {
                query.setParameter("ind", "%" + industry + "%");
            }
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public Profile getProfileByUserId(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Profile.class, userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void saveOrUpdateProfile(Profile profile) {
        org.hibernate.Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            // Re-attach the User to the current session to avoid detached entity errors
            User attachedUser = session.get(User.class, profile.getUserId());
            
            Profile existing = session.get(Profile.class, profile.getUserId());
            if (existing == null) {
                profile.setUser(attachedUser);
                session.persist(profile);
            } else {
                existing.setDepartment(profile.getDepartment());
                existing.setGraduationYear(profile.getGraduationYear());
                existing.setCurrentIndustry(profile.getCurrentIndustry());
                existing.setCompany(profile.getCompany());
                existing.setJobTitle(profile.getJobTitle());
                existing.setSkills(profile.getSkills());
                existing.setWillingnessToRefer(profile.getWillingnessToRefer());
                session.merge(existing);
            }
            
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
