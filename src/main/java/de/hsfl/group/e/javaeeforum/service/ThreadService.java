package de.hsfl.group.e.javaeeforum.service;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import de.hsfl.group.e.javaeeforum.dao.*;
import de.hsfl.group.e.javaeeforum.dto.CategoryDto;
import de.hsfl.group.e.javaeeforum.dto.ThreadDto;
import de.hsfl.group.e.javaeeforum.model.Category;
import de.hsfl.group.e.javaeeforum.model.Creator;
import de.hsfl.group.e.javaeeforum.model.Tag;
import de.hsfl.group.e.javaeeforum.model.Thread;

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

    private Category getCategory(CategoryDto categoryDto) {
        Category category = categoryDao.getById(categoryDto.getId());
        if (category == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The category was not found").build());
        return category;
    }

    private List<Tag> getTagList(List<String> tagStrings) {
        List<Tag> tags = new LinkedList<>();
        for (String tagString : tagStrings) {
            if (tagString != null && !tagString.equals("")) {
                Tag tag = new Tag();
                tag.setTag(tagString);
                tagDao.addElement(tag);
                tags.add(tag);
            }
        }
        return tags;
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ThreadDto> getAll(@QueryParam("category") Long categoryID, @QueryParam("creatorid") Long creatorID, @QueryParam("searchText") String searchText) {
        List<Thread> threads;
        if (creatorID != null)
            threads = threadDao.getAllByCreator(creatorID);
        else if (categoryID != null)
            threads = threadDao.getAllByCategory(categoryID);
        else if (searchText != null)
            threads = threadDao.searchThread(searchText);
        else
            threads = threadDao.getAll();

        return ThreadDto.fromModelList(threads);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createThread(ThreadDto threadDto, @QueryParam("creatorid") Long creatorID) {
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(404).entity("user not found").build());

        Thread thread = new Thread();
        thread.setCreator(creator);
        thread.setTitle(threadDto.getTitle());
        thread.setText(threadDto.getText());
        thread.setCategory(getCategory(threadDto.getCategory()));
        thread.setTags(getTagList(threadDto.getTags()));
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
        Thread thread = threadDao.getById(id);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("Not found").build());
        return ThreadDto.fromModel(thread);
    }

    @PUT
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public ThreadDto updateThread(@PathParam("id") long id, @QueryParam("creatorid") Long creatorID, ThreadDto threadDto) {
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("user not found").build());
        Thread thread = threadDao.getById(id);

        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());

        if (!creator.isAdmin() || thread.getCreator().getId().equals(creatorID))
            throw new WebApplicationException(
                    Response.status(401).entity("You are not permitted to do that").build());

        if (threadDto.getTitle() != null)
            thread.setTitle(threadDto.getTitle());

        if (threadDto.getText() != null)
            thread.setText(threadDto.getText());

        if (threadDto.getCategory() != null)
            thread.setCategory(getCategory(threadDto.getCategory()));

        if (thread.getTags() != null)
            thread.setTags(thread.getTags());

        thread.setModifiedAt(Calendar.getInstance().getTime());

        threadDao.updateElement(thread);
        return ThreadDto.fromModel(thread);
    }

    @DELETE
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ThreadDto deleteThread(@PathParam("id") long id, @QueryParam("creatorid") Long creatorID) {
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null || !creator.isAdmin())
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Thread thread = threadDao.getById(id);

        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());
        ThreadDto resp = ThreadDto.fromModel(thread);
        threadDao.removeElement(thread);
        return resp;
    }
}