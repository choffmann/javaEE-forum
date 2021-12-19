package de.hsfl.group.e.javeeeforum.dao;

import de.hsfl.group.e.javeeeforum.model.Thread;

import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

public class ThreadDao implements Dao<Thread> {

    private EntityManager manager;

    public ThreadDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Thread> getAll() {
        Query query = manager.createQuery("SELECT e FROM Thread e", Thread.class);
        return query.getResultList();
    }

    @Override
    public List<Thread> getListOfQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Thread getById(Long id) {
        return manager.find(Thread.class, id);
    }

    @Override
    public Thread getElementOfQuery(Query query) {
        return (Thread) query.getSingleResult();
    }

    @Override
    public void addElement(Thread e) {
        executeTransaction(manager -> manager.persist(e));
    }

    @Override
    public void updateElement(Thread e) {
        executeTransaction(manager -> manager.merge(e));
    }

    @Override
    public void removeElement(Thread e) {
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
