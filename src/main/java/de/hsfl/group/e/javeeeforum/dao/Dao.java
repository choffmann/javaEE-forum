package de.hsfl.group.e.javeeeforum.dao;

import javax.persistence.Query;
import java.util.List;

public interface Dao<T> {
    // Get all from Database
    List<T> getAll();

    // Get resultList by Query
    // z.B.: "SELECT e FROM Creator e WHERE e.id >= 6"
    List<T> getListOfQuery(Query query);

    // Get one Element by id
    T getById(Long id);

    // Get one Element by Query
    // z.B.: "SELECT e FROM Creator e WHERE e.username = 'mustermann'"
    T getElementOfQuery(Query query);

    // Add Element to Database
    void addElement(T e);

    // Update Element to Database
    void updateElement(T e);

    // Remove Element from Database
    void removeElement(T e);
}
