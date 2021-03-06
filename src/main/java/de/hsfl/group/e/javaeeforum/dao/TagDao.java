package de.hsfl.group.e.javaeeforum.dao;

import de.hsfl.group.e.javaeeforum.model.Tag;

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.*;
import java.util.List;
import java.util.function.Consumer;

@ApplicationScoped
public class TagDao implements Dao<Tag> {

    private EntityManager manager;

    public TagDao() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("javaEE-forum");
        manager = factory.createEntityManager();
    }

    @Override
    public List<Tag> getAll() {
        Query query = manager.createQuery("SELECT e FROM Tag e", Tag.class);
        return query.getResultList();
    }

    @Override
    public List<Tag> getListByQuery(Query query) {
        return query.getResultList();
    }

    @Override
    public Tag getById(Long id) {
        return manager.find(Tag.class, id);
    }

    public Tag getByName(String text) {
        Query query = manager.createQuery("SELECT e FROM Tag e WHERE lower(e.tag) = '" + text.toLowerCase() + "'", Tag.class);
        return (Tag) query.getSingleResult();
    }

    @Override
    public Tag getElementByQuery(Query query) {
        return (Tag) query.getSingleResult();
    }

    @Override
    public void addElement(Tag e) {
        executeTransaction(manager -> manager.persist(e));
    }

    @Override
    public void updateElement(Tag e) {
        executeTransaction(manager -> manager.merge(e));
    }

    @Override
    public void removeElement(Tag e) {
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
