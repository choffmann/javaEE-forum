package de.hsfl.group.e.javeeeforum.dao;

import de.hsfl.group.e.javeeeforum.model.Creator;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

@ApplicationScoped
public class CreatorDao implements Dao<Creator> {

    private EntityManager manager;

    public CreatorDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Creator> getAll() {
        Query query = manager.createQuery("SELECT e FROM Creator e", Creator.class);
        return query.getResultList();
    }

    @Override
    public List<Creator> getListByQuery(Query query) {
        return query.getResultList();
    }

    public Creator getByUsername(String username) {
        Query query = manager.createQuery("SELECT e FROM Creator e WHERE e.username = '" + username + "'", Creator.class);
        return (Creator) query.getSingleResult();
    }

    @Override
    public Creator getById(Long id) {
        return manager.find(Creator.class, id);
    }

    @Override
    public Creator getElementByQuery(Query query) {
        return (Creator) query.getSingleResult();
    }

    @Override
    public void addElement(Creator e) {
        executeTransaction(manager -> manager.persist(e));
    }

    @Override
    public void updateElement(Creator e) {
        executeTransaction(manager -> manager.merge(e));
    }

    @Override
    public void removeElement(Creator e) {
        executeTransaction(manager -> manager.remove(e));
    }

    private void executeTransaction(Consumer<EntityManager> action) {
        EntityTransaction tx = manager.getTransaction();
        try {
            tx.begin();
            action.accept(manager);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw e;
        }
    }
}
