package de.hsfl.group.e.javeeeforum.model;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import java.io.Serializable;

@Embeddable
public class AnswerCreatorKey implements Serializable {
    @Column(name = "answer_id")
    private Long answerId;

    @Column(name = "creator_id")
    private Long creatorId;

    public Long getAnswerId() {
        return answerId;
    }

    public void setAnswerId(Long answerId) {
        this.answerId = answerId;
    }

    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }
}
