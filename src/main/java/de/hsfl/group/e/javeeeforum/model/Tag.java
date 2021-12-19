package de.hsfl.group.e.javeeeforum.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@NamedQuery(name = "Tag.findAll", query = "SELECT w FROM Tag w")
public class Tag implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;
    private String tag;

    @ManyToMany(mappedBy = "threadTag")
    private Set<Thread> thread;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public Set<Thread> getThread() {
        return thread;
    }

    public void setThread(Set<Thread> thread) {
        this.thread = thread;
    }
}
