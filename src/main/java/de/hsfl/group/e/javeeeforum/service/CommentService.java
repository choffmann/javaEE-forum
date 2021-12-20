package de.hsfl.group.e.javeeeforum.service;

import de.hsfl.group.e.javeeeforum.dao.AnswerDao;
import de.hsfl.group.e.javeeeforum.dao.CommentDao;
import de.hsfl.group.e.javeeeforum.dao.CreatorDao;
import de.hsfl.group.e.javeeeforum.dto.CommentDto;
import de.hsfl.group.e.javeeeforum.model.Answer;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.util.List;

@Path("/threads/{threadId}/answers/{answerId}/comments")
public class CommentService {
    @Context
    private UriInfo uriInfo;

    @PathParam("threadId")
    long threadId;

    @PathParam("answerId")
    long answerID;

    @Inject
    AnswerDao answerDao;

    @Inject
    CreatorDao creatorDao;

    @Inject
    CommentDao commentDao;


    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<CommentDto> getAll() {
        Answer answer = answerDao.getByIdFromThread(threadId, answerID);

        if (answer == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The answer was not found").build());

        return CommentDto.fromModelList(commentDao.getAllFromAnswer(answer.getId()));
    }
}