package de.hsfl.group.e.javeeeforum.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@NamedQuery(name = "Creator.findAll", query = "SELECT w FROM Creator w")
public class Creator implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue
    private Long id;
    private String username;
    private String email;
    private String password;
    @Column(name = "is_admin")
    private boolean isAdmin;
    private int score;

    @ManyToMany(mappedBy = "creatorComment")
    private Set<Comment> comment;

    @OneToMany(mappedBy = "creator")
    private Set<AnswerCreator> validation;

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

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public void setComment(Set<Comment> comment) {
        this.comment = comment;
    }

    public Set<Comment> getComment() {
        return comment;
    }

    public Set<AnswerCreator> getValidation() {
        return validation;
    }

    public void setValidation(Set<AnswerCreator> validation) {
        this.validation = validation;
    }
}
