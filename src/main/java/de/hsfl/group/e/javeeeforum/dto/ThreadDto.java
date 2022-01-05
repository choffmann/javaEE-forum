package de.hsfl.group.e.javeeeforum.dto;

import de.hsfl.group.e.javeeeforum.model.Answer;
import de.hsfl.group.e.javeeeforum.model.Tag;
import de.hsfl.group.e.javeeeforum.model.Thread;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class ThreadDto {
    private Long id;
    private String title;
    private Date createdAt;
    private Date modifiedAt;
    private String text;

    private CategoryDto category;
    private List<String> tags;
    private List<Long> answers;
    private CreatorDto creator;

    public ThreadDto() {
    }

    public ThreadDto(Long id, String title, Date createdAt, Date modifiedAt, String text) {
        this.id = id;
        this.title = title;
        this.createdAt = createdAt;
        this.modifiedAt = modifiedAt;
        this.text = text;
    }

    public static ThreadDto fromModel(Thread model) {
        ThreadDto dto = new ThreadDto(model.getId(), model.getTitle(), model.getCreatedAt(), model.getModifiedAt(), model.getText());
        dto.setCreator(CreatorDto.fromModel(model.getCreator()));
        dto.setCategory(CategoryDto.fromModel(model.getCategory()));

        List<String> tags = new LinkedList<>();
        for (Tag tag : model.getTags())
            tags.add(tag.getTag());

        dto.setTags(tags);

        List<Long> answers = new LinkedList<>();
        for (Answer answer : model.getAnswer())
            answers.add(answer.getId());

        dto.setAnswers(answers);
        return dto;
    }

    public static List<ThreadDto> fromModelList(List<Thread> modelList) {
        List<ThreadDto> dtoList = new LinkedList<>();
        for (Thread model : modelList) {
            dtoList.add(fromModel(model));
        }
        return dtoList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public List<String> getTags() {
        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public CategoryDto getCategory() {
        return category;
    }

    public void setCategory(CategoryDto category) {
        this.category = category;
    }

    public List<Long> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Long> answers) {
        this.answers = answers;
    }

    public CreatorDto getCreator() {
        return creator;
    }

    public void setCreator(CreatorDto creator) {
        this.creator = creator;
    }
}
