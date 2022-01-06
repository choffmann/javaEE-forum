package de.hsfl.group.e.javaeeforum.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@NamedQuery(name = "Tag.findAll", query = "SELECT w FROM Tag w")
public class Tag implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String tag;

    @ManyToMany(mappedBy = "tags")
    private List<Thread> thread;

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

    public List<Thread> getThread() {
        return thread;
    }

    public void setThread(List<Thread> thread) {
        this.thread = thread;
    }
}
