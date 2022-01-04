package de.hsfl.group.e.javeeeforum.dto;

import de.hsfl.group.e.javeeeforum.model.Category;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

public class CategoryDto implements Serializable {
    private Long id;
    private String text;

    private List<ThreadDto> threads;

    public CategoryDto() {
    }

    public CategoryDto(Long id, String text) {
        this.id = id;
        this.text = text;
    }

    public static CategoryDto fromModel(Category model) {
        return new CategoryDto(model.getId(), model.getText());
    }

    public static List<CategoryDto> fromModelList(List<Category> modelList) {
        List<CategoryDto> dtoList = new LinkedList<>();
        for (Category model : modelList) {
            dtoList.add(CategoryDto.fromModel(model));
        }
        return dtoList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<ThreadDto> getThreads() {
        return threads;
    }

    public void setThreads(List<ThreadDto> threads) {
        this.threads = threads;
    }
}
