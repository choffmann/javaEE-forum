package de.hsfl.group.e.javeeeforum.service;

import de.hsfl.group.e.javeeeforum.dao.CreatorDao;
import de.hsfl.group.e.javeeeforum.dto.CategoryDto;
import de.hsfl.group.e.javeeeforum.dto.CreatorDto;
import de.hsfl.group.e.javeeeforum.model.Creator;

import javax.inject.Inject;
import javax.persistence.NoResultException;
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
    public List<CreatorDto> getAll(@QueryParam("creatorid") Long creatorID) {
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
    public CreatorDto getUser(@PathParam("id") long id) {
        Creator creator = creatorDao.getById(id);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not found").build());
        return CreatorDto.fromModel(creator);
    }

    @DELETE
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto deleteUser(@PathParam("id") long id, @QueryParam("creatorid") Long creatorID) {
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null || !(creator.isAdmin() || creator.getId().equals(id)))
            throw new WebApplicationException(
                    Response.status(404).entity("Not authenticated").build());
        Creator creator_to_delete = creatorDao.getById(id);
        if (creator_to_delete == null)
            throw new WebApplicationException(
                    Response.status(404).entity("not found or already deleted").build());
        creator_to_delete.setDeleted(true);
        creatorDao.updateElement(creator_to_delete);
        return CreatorDto.fromModel(creator);
    }

    @POST
    @Path("register")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto registerUser(CreatorDto creatorDto) {
        boolean already_exists;
        try {
            creatorDao.getByUsername(creatorDto.getUsername(), true);
            already_exists = true;
        } catch (NoResultException err) {
            already_exists = false;
        }

        if (already_exists)
            throw new WebApplicationException(
                    Response.status(400).entity("user already exists").build());

        Creator creator = new Creator();
        creator.setAdmin(false);
        creator.setEmail(creatorDto.getEmail());
        creator.setPassword(creatorDto.getPassword());
        creator.setUsername(creatorDto.getUsername());

        creatorDao.addElement(creator);
        return CreatorDto.fromModel(creator);
    }

    @POST
    @Path("login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public CreatorDto loginUser(CreatorDto creatorDto) {
        Creator creator;
        try {
            creator = creatorDao.getByUsername(creatorDto.getUsername(), false);
        } catch (NoResultException err) {
            throw new WebApplicationException(
                    Response.status(404).entity("User not found").build());
        }

        if (!creator.getPassword().equals(creatorDto.getPassword()))
            throw new WebApplicationException(
                    Response.status(401).entity("Password not correct").build());
        return CreatorDto.fromModel(creator);
    }
}