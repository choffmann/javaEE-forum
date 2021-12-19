package de.hsfl.group.e.javeeeforum.dto;

public class TagDto {
    private Long id;
    private String tag;

    public TagDto() {}

    public TagDto(Long id, String tag) {
        this.id = id;
        this.tag = tag;
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
}
