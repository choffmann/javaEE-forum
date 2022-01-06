package de.hsfl.group.e.javaeeforum.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@NamedQuery(name = "Creator.findAll", query = "SELECT w FROM Creator w")
public class Creator implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String email;
    private String password;
    @Column(name = "is_admin")
    private boolean isAdmin;
    @Column(name = "is_deleted")
    private boolean isDeleted;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "creator", orphanRemoval = true)
    private List<Comment> comment;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "creator", orphanRemoval = true)
    private List<Answer> answers;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "creator", orphanRemoval = true)
    private List<Thread> thread;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public void setComment(List<Comment> comment) {
        this.comment = comment;
    }

    public List<Comment> getComment() {
        return comment;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public List<Thread> getThread() {
        return thread;
    }

    public void setThread(List<Thread> thread) {
        this.thread = thread;
    }
}
