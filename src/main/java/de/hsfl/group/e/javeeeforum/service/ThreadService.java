package de.hsfl.group.e.javeeeforum.service;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import de.hsfl.group.e.javeeeforum.dao.*;
import de.hsfl.group.e.javeeeforum.dto.CategoryDto;
import de.hsfl.group.e.javeeeforum.dto.TagDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import de.hsfl.group.e.javeeeforum.model.Category;
import de.hsfl.group.e.javeeeforum.model.Creator;
import de.hsfl.group.e.javeeeforum.model.Tag;
import de.hsfl.group.e.javeeeforum.model.Thread;

import java.net.URI;
import java.util.*;

@Path("/threads")
public class ThreadService {

    @Context
    private UriInfo uriInfo;

    @Inject
    ThreadDao threadDao;

    @Inject
    CreatorDao creatorDao;

    @Inject
    CategoryDao categoryDao;

    @Inject
    TagDao tagDao;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ThreadDto> getAll(@QueryParam("category") Long categoryID, @QueryParam("creator") Long creatorID) {
        List<Thread> threads;
        if (creatorID != null)
            threads = threadDao.getAllByCreator(categoryID);
        else if (categoryID != null)
            threads = threadDao.getAllByCategory(categoryID);
        else
            threads = threadDao.getAll();

        return ThreadDto.fromModelList(threads);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createThread(ThreadDto threadDto, @QueryParam("creator") Long creatorID) {
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(500).entity("The user was not found").build());

        List<Category> categories = new LinkedList<>();
        for (CategoryDto cdto : threadDto.getCategories()) {
            Category category = categoryDao.getById(cdto.getId());
            if (category == null)
                throw new WebApplicationException(
                        Response.status(500).entity("The category was not found").build());
            categories.add(category);
        }

        List<Tag> tags = new LinkedList<>();
        for (TagDto tdto : threadDto.getTags()) {
            if (tdto.getTag() != null) {
                Tag tag = new Tag();
                tag.setTag(tdto.getTag());
                tagDao.addElement(tag);
                tags.add(tag);
            }
        }

        Thread thread = new Thread();
        thread.setCreator(creator);
        thread.setTitle(threadDto.getTitle());
        thread.setText(threadDto.getText());
        thread.setCategories(categories);
        thread.setTags(tags);
        thread.setCreatedAt(Calendar.getInstance().getTime());
        thread.setModifiedAt(Calendar.getInstance().getTime());

        threadDao.addElement(thread);
        URI location = uriInfo.getAbsolutePathBuilder()
                .path("" + thread.getId()).build();
        return Response.created(location).build();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ThreadDto getThread(@PathParam("id") long id) {
        return ThreadDto.fromModel(threadDao.getById(id));
    }

    @PUT
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public ThreadDto updateThread(@PathParam("id") long id, @QueryParam("creator") Long creatorID, ThreadDto threadDto) {
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(500).entity("The user was not found").build());
        Thread thread = threadDao.getById(id);

        if (thread == null)
            throw new WebApplicationException(
                    Response.status(500).entity("The thread was not found").build());

        if (!creator.isAdmin() || thread.getCreator().getId().equals(creatorID))
            throw new WebApplicationException(
                    Response.status(401).entity("You are not permitted to do that").build());

        if (threadDto.getTitle() != null)
            thread.setTitle(threadDto.getTitle());

        if (threadDto.getText() != null)
            thread.setText(threadDto.getText());

        thread.setModifiedAt(Calendar.getInstance().getTime());

        threadDao.updateElement(thread);
        return ThreadDto.fromModel(thread);
    }

}