package de.hsfl.group.e.javeeeforum.dto;

import de.hsfl.group.e.javeeeforum.model.Creator;

import java.util.LinkedList;
import java.util.List;

public class CreatorDto {
    private Long id;
    private String username;
    private String email;
    private String password;
    private boolean isAdmin;

    private List<CommentDto> comments;
    private List<AnswerDto> answers;
    private List<ThreadDto> threads;

    public CreatorDto() {
    }

    public CreatorDto(Long id, String username, String email, String password, boolean isAdmin) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    public static CreatorDto fromModel(Creator model) {
        return new CreatorDto(model.getId(), model.getUsername(), model.getEmail(), model.getPassword(), model.isAdmin());
    }

    public static List<CreatorDto> fromModelList(List<Creator> modelList) {
        List<CreatorDto> dtoList = new LinkedList<>();
        for (Creator model : modelList)
            dtoList.add(CreatorDto.fromModel(model));
        return dtoList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public List<CommentDto> getComments() {
        return comments;
    }

    public void setComments(List<CommentDto> comments) {
        this.comments = comments;
    }

    public List<AnswerDto> getAnswers() {
        return answers;
    }

    public void setAnswers(List<AnswerDto> answers) {
        this.answers = answers;
    }

    public List<ThreadDto> getThreads() {
        return threads;
    }

    public void setThreads(List<ThreadDto> threads) {
        this.threads = threads;
    }
}
