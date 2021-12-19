package de.hsfl.group.e.javeeeforum.dto;

import java.util.Date;
import java.util.List;

public class AnswerDto {
    private Long id;
    private Date createdAt;
    private Date modifiedAt;
    private String text;
    private int score;

    private CreatorDto creator;
    private ThreadDto thread;
    private List<CommentDto> comments;

    public AnswerDto() {}

    public AnswerDto(Long id, Date createdAt, Date modifiedAt, String text, int score) {
        this.id = id;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.text = text;
        this.score = score;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(Date modifiedAt) {
        this.modifiedAt = modifiedAt;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public CreatorDto getCreator() {
        return creator;
    }

    public void setCreator(CreatorDto creator) {
        this.creator = creator;
    }

    public ThreadDto getThread() {
        return thread;
    }

    public void setThread(ThreadDto thread) {
        this.thread = thread;
    }

    public List<CommentDto> getComments() {
        return comments;
    }

    public void setComments(List<CommentDto> comments) {
        this.comments = comments;
    }
}
