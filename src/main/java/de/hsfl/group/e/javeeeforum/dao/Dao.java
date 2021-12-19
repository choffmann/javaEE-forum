package de.hsfl.group.e.javeeeforum.dao;

import javax.persistence.Query;
import java.util.List;

public interface Dao<T> {
    List<T> getAll();
    List<T> getListOfQuery(Query query);
    T getById(Long id);
    T getElementOfQuery(Query query);
    void addElement(T e);
    void updateElement(T e);
    void removeElement(T e);

}
