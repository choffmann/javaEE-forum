package de.hsfl.group.e.javeeeforum.service;

import de.hsfl.group.e.javeeeforum.dao.CreatorDao;
import de.hsfl.group.e.javeeeforum.dto.CategoryDto;
import de.hsfl.group.e.javeeeforum.dto.CreatorDto;
import de.hsfl.group.e.javeeeforum.model.Creator;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/users")
public class UserService {

    @Inject
    CreatorDao creatorDao;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<CreatorDto> getAll(@QueryParam("creatorid") Long creatorID){
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null || !creator.isAdmin())
            throw new WebApplicationException(
                    Response.status(404).entity("Not authenticated").build());

        return CreatorDto.fromModelList(creatorDao.getAll());
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto getUser(@PathParam("id") long id){
        Creator creator = creatorDao.getById(id);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(404).entity("Not found").build());
        return CreatorDto.fromModel(creator);
    }

    @DELETE
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto deleteUser(@PathParam("id") long id, @QueryParam("creatorid") Long creatorID){
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null || !(creator.isAdmin() || creator.getId().equals(id)))
            throw new WebApplicationException(
                    Response.status(404).entity("Not authenticated").build());
        Creator creator_to_delete = creatorDao.getById(id);
        // creator_to_delete.setIsDeleted(true);
        creatorDao.updateElement(creator_to_delete);
        return CreatorDto.fromModel(creator);
    }

    @POST
    @Path("register")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto registerUser(CreatorDto creatorDto){
        Creator check = creatorDao.getByUsername(creatorDto.getUsername());
        if (check != null)
            throw new WebApplicationException(
                    Response.status(400).entity("user already exists").build());

        Creator creator = new Creator();
        creator.setAdmin(false);
        creator.setEmail(creatorDto.getEmail());
        creator.setPassword(creatorDto.getPassword());
        creator.setUsername(creatorDto.getUsername());
        creator.setScore(0);

        creatorDao.addElement(creator);
        return CreatorDto.fromModel(creator);
    }

    @POST
    @Path("login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto loginUser(CreatorDto creatorDto){
        Creator creator = creatorDao.getByUsername(creatorDto.getUsername());
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(404).entity("User not found").build());

        if (!creator.getPassword().equals(creatorDto.getPassword()))
            throw new WebApplicationException(
                    Response.status(401).entity("Password not correct").build());
        return CreatorDto.fromModel(creator);
    }
}