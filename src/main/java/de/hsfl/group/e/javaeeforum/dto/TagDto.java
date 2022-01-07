package de.hsfl.group.e.javaeeforum.dto;

import de.hsfl.group.e.javaeeforum.model.Tag;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

public class TagDto implements Comparable<TagDto> {
    private Long id;
    private String tag;

    public TagDto() {
    }

    public TagDto(Long id, String tag) {
        this.id = id;
        this.tag = tag;
    }

    public static TagDto fromModel(Tag model) {
        return new TagDto(model.getId(), model.getTag());
    }

    public static List<TagDto> fromModelList(List<Tag> modelList) {
        List<TagDto> dtoList = new LinkedList<>();
        for (Tag model : modelList)
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

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    @Override
    public int compareTo(TagDto other) {
        if (getId() == null || other.getId() == null) {
            return 0;
        }
        return getId().compareTo(other.getId());
    }
}
