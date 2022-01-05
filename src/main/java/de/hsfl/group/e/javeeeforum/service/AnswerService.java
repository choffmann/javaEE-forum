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
    public Response createAnswer(String text, @QueryParam("creatorid") Long creatorID) {
        Thread thread = threadDao.getById(threadId);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID); //
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());

        Answer answer = new Answer();
        answer.setCreator(creator);
        answer.setText(text);
        answer.setThread(thread);

        answer.setCreatedAt(Calendar.getInstance().getTime());
        answer.setModifiedAt(Calendar.getInstance().getTime());

        answerDao.addElement(answer);
        thread.getAnswer().add(answer);

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
        Answer answer = answerDao.getByIdFromThread(thread.getId(), answerId);
        if (answer == null)
            throw new WebApplicationException(
                    Response.status(404).entity("Not found").build());
        return AnswerDto.fromModel(answer);
    }

    @PUT
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public AnswerDto updateAnswer(@PathParam("id") long answerId, @QueryParam("creatorid") Long creatorID, AnswerDto answerDto) {
        Thread thread = threadDao.getById(threadId);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());

        Answer answer = answerDao.getByIdFromThread(thread.getId(), answerId);

        if (answer == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The answer was not found").build());

        if (!creator.isAdmin() || answer.getCreator().getId().equals(creatorID))
            throw new WebApplicationException(
                    Response.status(401).entity("You are not permitted to do that").build());

        if (answerDto.getText() != null)
            answer.setText(answerDto.getText());

        answer.setModifiedAt(Calendar.getInstance().getTime());

        answerDao.updateElement(answer);
        return AnswerDto.fromModel(answer);
    }

    @DELETE
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public AnswerDto deleteAnswer(@PathParam("id") long answerId, @QueryParam("creatorid") Long creatorID) {
        Thread thread = threadDao.getById(threadId);
        if (thread == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The thread was not found").build());
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());

        Answer answer = answerDao.getByIdFromThread(thread.getId(), answerId);

        if (answer == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The answer was not found").build());

        if (!creator.isAdmin())
            throw new WebApplicationException(
                    Response.status(401).entity("You are not permitted to do that").build());

        AnswerDto resp = AnswerDto.fromModel(answer);
        answerDao.removeElement(answer);
        return resp;
    }
}