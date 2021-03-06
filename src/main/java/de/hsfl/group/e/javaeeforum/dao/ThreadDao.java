package de.hsfl.group.e.javaeeforum.dao;

import de.hsfl.group.e.javaeeforum.model.Thread;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

@ApplicationScoped
public class ThreadDao implements Dao<Thread> {

    private final EntityManager manager;

    public ThreadDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Thread> getAll() {
        Query query = manager.createQuery("SELECT e FROM Thread e", Thread.class);
        return query.getResultList();
    }

    public List<Thread> getAllByCategory(long id) {
        Query query = manager.createQuery("SELECT e FROM Thread e INNER JOIN e.category d WHERE d.id = " + id, Thread.class);
        return query.getResultList();
    }

    public List<Thread> getAllByCreator(long id) {
        Query query = manager.createQuery("SELECT e FROM Thread e INNER JOIN e.creator d WHERE d.id = " + id, Thread.class);
        return query.getResultList();
    }

    public List<Thread> searchThread(String searchText) {
        String s = searchText.toLowerCase();
        Query query = manager.createQuery("SELECT e FROM Thread e INNER JOIN e.category d LEFT JOIN e.tags f " +
                "WHERE lower(e.title) like '%" + s + "%' OR lower(d.text) like '%" + s + "%' " +
                "OR lower(f.tag) like '%" + s + "%' OR lower(e.text) like '%" + s + "%' GROUP BY e.id", Thread.class);
        return query.getResultList();
    }

    @Override
    public List<Thread> getListByQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Thread getById(Long id) {
        return manager.find(Thread.class, id);
    }

    @Override
    public Thread getElementByQuery(Query query) {
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
