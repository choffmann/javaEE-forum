package de.hsfl.group.e.javeeeforum.service;

import de.hsfl.group.e.javeeeforum.dao.AnswerDao;
import de.hsfl.group.e.javeeeforum.dao.CommentDao;
import de.hsfl.group.e.javeeeforum.dao.CreatorDao;
import de.hsfl.group.e.javeeeforum.dto.AnswerDto;
import de.hsfl.group.e.javeeeforum.dto.CommentDto;
import de.hsfl.group.e.javeeeforum.model.Answer;
import de.hsfl.group.e.javeeeforum.model.Comment;
import de.hsfl.group.e.javeeeforum.model.Creator;

import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.net.URI;
import java.util.Calendar;
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

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createComment(CommentDto answerDto, @QueryParam("creator") Long creatorID){
        Answer answer = answerDao.getByIdFromThread(threadId, answerID);

        if (answer == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The answer was not found").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());

        Comment comment = new Comment();
        comment.setCreator(creator);
        comment.setText(answerDto.getText());
        comment.setAnswer(answer);

        comment.setCreatedAt(Calendar.getInstance().getTime());
        comment.setModifiedAt(Calendar.getInstance().getTime());

        commentDao.addElement(comment);

        URI location = uriInfo.getAbsolutePathBuilder()
                .path("" + comment.getId()).build();
        return Response.created(location).build();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CommentDto getComment(@PathParam("id") long commentId){
        Answer answer = answerDao.getByIdFromThread(threadId, answerID);
        if (answer == null)
            throw new WebApplicationException(
                    Response.status(404).entity("The answer was not found").build());
        return CommentDto.fromModel(commentDao.getByIdFromAnswer(answerID, commentId));
    }

}