package de.hsfl.group.e.javeeeforum.dto;

import de.hsfl.group.e.javeeeforum.model.Answer;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class AnswerDto {
    private Long id;
    private Date createdAt;
    private Date modifiedAt;
    private String text;

    private CreatorDto creator;
    private ThreadDto thread;
    private List<CommentDto> comments;

    public AnswerDto() {
    }

    public AnswerDto(Long id, Date createdAt, Date modifiedAt, String text) {
        this.id = id;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.text = text;
    }

    public static AnswerDto fromModel(Answer model) {
        AnswerDto dto = new AnswerDto(model.getId(), model.getCreatedAt(), model.getModifiedAt(), model.getText());
        dto.setCreator(CreatorDto.fromModel(model.getCreator()));
        dto.setComments(CommentDto.fromModelList(model.getComment()));
        return dto;
    }

    public static List<AnswerDto> fromModelList(List<Answer> modelList) {
        List<AnswerDto> dtoList = new LinkedList<>();
        for (Answer model : modelList) {
            dtoList.add(AnswerDto.fromModel(model));
        }
        return dtoList;
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
