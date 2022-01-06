package de.hsfl.group.e.javaeeforum;

import de.hsfl.group.e.javaeeforum.dto.CreatorDto;


import javax.enterprise.context.SessionScoped;
import java.io.Serializable;

@SessionScoped
public class UserData implements Serializable {
    private CreatorDto creatorDto;

    public UserData() {
    }

    public CreatorDto getCreatorDto() {
        return creatorDto;
    }

    public void setCreatorDto(CreatorDto creatorDto) {
        this.creatorDto = creatorDto;
    }
}
