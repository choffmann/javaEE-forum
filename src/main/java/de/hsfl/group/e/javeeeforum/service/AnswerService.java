package de.hsfl.group.e.javeeeforum.service;

import de.hsfl.group.e.javeeeforum.dao.AnswerDao;
import de.hsfl.group.e.javeeeforum.dao.ThreadDao;
import de.hsfl.group.e.javeeeforum.dto.AnswerDto;
import de.hsfl.group.e.javeeeforum.model.Thread;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/{threadId}/answer")
public class AnswerService {
    @PathParam("threadId")
    long threadId;

    @Inject
    ThreadDao threadDao;

    @Inject
    AnswerDao answerDao;

    Thread thread = threadDao.getById(threadId);

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<AnswerDto> getAll() {
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());

        return AnswerDto.fromModelList(answerDao.getAllFromThread(thread));
    }
}