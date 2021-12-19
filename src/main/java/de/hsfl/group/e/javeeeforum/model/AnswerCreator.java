package de.hsfl.group.e.javeeeforum.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@NamedQuery(name = "AnswerCreator.findAll", query = "SELECT w FROM AnswerCreator w")
public class AnswerCreator implements Serializable {
    @EmbeddedId
    AnswerCreatorKey id;

    @ManyToOne
    @MapsId("creatorId")
    @JoinColumn(name = "creator_id")
    private Creator creator;

    @ManyToOne
    @MapsId("answerId")
    @JoinColumn(name = "answer_id")
    private Answer answer;

    private boolean validation;


    public AnswerCreatorKey getId() {
        return id;
    }

    public void setId(AnswerCreatorKey id) {
        this.id = id;
    }

    public Creator getCreator() {
        return creator;
    }

    public void setCreator(Creator creator) {
        this.creator = creator;
    }

    public Answer getAnswer() {
        return answer;
    }

    public void setAnswer(Answer answer) {
        this.answer = answer;
    }

    public boolean isValidation() {
        return validation;
    }

    public void setValidation(boolean validation) {
        this.validation = validation;
    }
}
