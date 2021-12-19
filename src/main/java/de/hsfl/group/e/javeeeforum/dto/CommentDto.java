package de.hsfl.group.e.javeeeforum.dto;

import java.util.Date;

public class CommentDto {
    private Long id;
    private Date createdAt;
    private Date modifiedAt;
    private String text;

    private CreatorDto creatorDto;
    private AnswerDto answer;

    public CommentDto() {}

    public CommentDto(Long id, Date createdAt, Date modifiedAt, String text) {
        this.id = id;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.text = text;
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

    public CreatorDto getCreatorDto() {
        return creatorDto;
    }

    public void setCreatorDto(CreatorDto creatorDto) {
        this.creatorDto = creatorDto;
    }

    public AnswerDto getAnswer() {
        return answer;
    }

    public void setAnswer(AnswerDto answer) {
        this.answer = answer;
    }
}
