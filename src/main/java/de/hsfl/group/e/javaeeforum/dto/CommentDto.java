package de.hsfl.group.e.javaeeforum.dto;

import de.hsfl.group.e.javaeeforum.model.Comment;

import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class CommentDto implements Comparable<CommentDto> {
    private Long id;
    private Date createdAt;
    private Date modifiedAt;
    private String text;

    private CreatorDto creator;
    private AnswerDto answer;

    public CommentDto() {
    }

    public CommentDto(Long id, Date createdAt, Date modifiedAt, String text) {
        this.id = id;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.text = text;
    }

    public static CommentDto fromModel(Comment model) {
        CommentDto dto = new CommentDto(model.getId(), model.getCreatedAt(), model.getModifiedAt(), model.getText());
        dto.setCreatorDto(CreatorDto.fromModel(model.getCreator()));
        return dto;
    }

    public static List<CommentDto> fromModelList(List<Comment> modelList) {
        List<CommentDto> dtoList = new LinkedList<>();
        for (Comment model : modelList)
            dtoList.add(fromModel(model));
        Collections.sort(dtoList);
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

    public CreatorDto getCreatorDto() {
        return creator;
    }

    public void setCreatorDto(CreatorDto creatorDto) {
        this.creator = creatorDto;
    }

    public AnswerDto getAnswer() {
        return answer;
    }

    public void setAnswer(AnswerDto answer) {
        this.answer = answer;
    }

    @Override
    public int compareTo(CommentDto other) {
        if (getId() == null || other.getId() == null) {
            return 0;
        }
        return getId().compareTo(other.getId());
    }
}
