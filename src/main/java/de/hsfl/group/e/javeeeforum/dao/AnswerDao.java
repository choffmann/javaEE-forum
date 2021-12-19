package de.hsfl.group.e.javeeeforum.dao;

import de.hsfl.group.e.javeeeforum.model.Answer;

import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

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

    @Override
    public List<Answer> getListOfQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Answer getById(Long id) {
        return manager.find(Answer.class, id);
    }

    @Override
    public Answer getElementOfQuery(Query query) {
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
