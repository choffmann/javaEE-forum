package de.hsfl.group.e.javeeeforum.service;

import de.hsfl.group.e.javeeeforum.dao.AnswerDao;
import de.hsfl.group.e.javeeeforum.dao.CreatorDao;
import de.hsfl.group.e.javeeeforum.dao.ThreadDao;
import de.hsfl.group.e.javeeeforum.dto.AnswerDto;
import de.hsfl.group.e.javeeeforum.model.Answer;
import de.hsfl.group.e.javeeeforum.model.Creator;
import de.hsfl.group.e.javeeeforum.model.Thread;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.net.URI;
import java.util.Calendar;
import java.util.List;

@Path("/threads/{threadId}/answers")
public class AnswerService {
    @Context
    private UriInfo uriInfo;

    @PathParam("threadId")
    long threadId;

    @Inject
    ThreadDao threadDao;

    @Inject
    AnswerDao answerDao;

    @Inject
    CreatorDao creatorDao;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<AnswerDto> getAll() {
        Thread thread = threadDao.getById(threadId);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());

        return AnswerDto.fromModelList(answerDao.getAllFromThread(thread));
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createAnswer(AnswerDto answerDto, @QueryParam("creator") Long creatorID) {
        Thread thread = threadDao.getById(threadId);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());

        Answer answer = new Answer();
        answer.setCreator(creator);
        answer.setScore(0);
        answer.setText(answerDto.getText());
        answer.setThread(thread);

        answer.setCreatedAt(Calendar.getInstance().getTime());
        answer.setModifiedAt(Calendar.getInstance().getTime());

        answerDao.addElement(answer);

        URI location = uriInfo.getAbsolutePathBuilder()
                .path("" + answer.getId()).build();
        return Response.created(location).build();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public AnswerDto getAnswer(@PathParam("id") long answerId) {
        Thread thread = threadDao.getById(threadId);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());
        return AnswerDto.fromModel(answerDao.getByIdFromThread(thread, answerId));
    }

}