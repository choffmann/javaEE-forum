package de.hsfl.group.e.javeeeforum.dao;

import de.hsfl.group.e.javeeeforum.model.Comment;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

@ApplicationScoped
public class CommentDao implements Dao<Comment> {

    private EntityManager manager;

    public CommentDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Comment> getAll() {
        Query query = manager.createQuery("SELECT e FROM Comment e", Comment.class);
        return query.getResultList();
    }

    @Override
    public List<Comment> getListByQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Comment getById(Long id) {
        return manager.find(Comment.class, id);
    }

    @Override
    public Comment getElementByQuery(Query query) {
        return (Comment) query.getSingleResult();
    }

    @Override
    public void addElement(Comment e) {
        executeTransaction(manager -> manager.persist(e));
    }

    @Override
    public void updateElement(Comment e) {
        executeTransaction(manager -> manager.merge(e));
    }

    @Override
    public void removeElement(Comment e) {
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
