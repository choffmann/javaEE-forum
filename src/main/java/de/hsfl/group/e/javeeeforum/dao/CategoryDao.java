package de.hsfl.group.e.javeeeforum.dao;

import de.hsfl.group.e.javeeeforum.model.Category;

import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

public class CategoryDao implements Dao<Category> {

    private EntityManager manager;

    public CategoryDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Category> getAll() {
        Query query = manager.createQuery("SELECT e FROM Category e", Category.class);
        return query.getResultList();
    }

    @Override
    public List<Category> getListByQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Category getById(Long id) {
        return manager.find(Category.class, id);
    }

    @Override
    public Category getElementByQuery(Query query) {
        return (Category) query.getSingleResult();
    }

    @Override
    public void addElement(Category e) {
        executeTransaction(manager -> manager.persist(e));
    }

    @Override
    public void updateElement(Category e) {
        executeTransaction(manager -> manager.merge(e));
    }

    @Override
    public void removeElement(Category e) {
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
