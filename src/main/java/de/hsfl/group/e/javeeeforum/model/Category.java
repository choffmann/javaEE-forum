package de.hsfl.group.e.javeeeforum.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@NamedQuery(name = "Category.findAll", query = "SELECT w FROM Category w")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String text;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
