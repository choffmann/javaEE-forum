package de.hsfl.group.e.javaeeforum.dao;

import de.hsfl.group.e.javaeeforum.model.Answer;
import de.hsfl.group.e.javaeeforum.model.Thread;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

@ApplicationScoped
public class AnswerDao implements Dao<Answer> {

    private EntityManager manager;

    public AnswerDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Answer> getAll() {
        Query query = manager.createQuery("SELECT e FROM Answer e", Answer.class);
        return query.getResultList();
    }

    public List<Answer> getAllFromThread(Thread thread) {
        Query query = manager.createQuery("SELECT e FROM Answer e WHERE e.thread.id = " + thread.getId(), Answer.class);
        return query.getResultList();
    }

    public Answer getByIdFromThread(long threadId, long id) {
        Query query = manager.createQuery("SELECT e FROM Answer e WHERE e.thread.id = " + threadId + " AND e.id = " + id, Answer.class);
        return (Answer) query.getSingleResult();
    }

    @Override
    public List<Answer> getListByQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Answer getById(Long id) {
        return manager.find(Answer.class, id);
    }

    @Override
    public Answer getElementByQuery(Query query) {
        return (Answer) query.getSingleResult();
    }

    @Override
    public void addElement(Answer e) {
        executeTransaction(manager -> manager.persist(e));
    }

    @Override
    public void updateElement(Answer e) {
        executeTransaction(manager -> manager.merge(e));
    }

    @Override
    public void removeElement(Answer e) {
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
