package de.hsfl.group.e.javeeeforum.service;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;

import de.hsfl.group.e.javeeeforum.dao.*;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import de.hsfl.group.e.javeeeforum.model.Thread;

import java.net.URI;
import java.util.List;

@Path("/threads")
public class ThreadService {

    @Context
    private UriInfo uriInfo;

    @Inject
    ThreadDao threadDao;

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

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ThreadDto getThread(@PathParam("id") long id) {
        return ThreadDto.fromModel(threadDao.getById(id));
    }



}