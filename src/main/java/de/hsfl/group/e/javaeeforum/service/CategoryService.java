package de.hsfl.group.e.javaeeforum.service;

import de.hsfl.group.e.javaeeforum.dao.CategoryDao;
import de.hsfl.group.e.javaeeforum.dao.CreatorDao;
import de.hsfl.group.e.javaeeforum.dto.CategoryDto;
import de.hsfl.group.e.javaeeforum.model.Category;
import de.hsfl.group.e.javaeeforum.model.Creator;

import javax.inject.Inject;
import javax.persistence.NoResultException;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.net.URI;
import java.util.List;

@Path("/categories")
public class CategoryService {

    @Context
    private UriInfo uriInfo;

    @Inject
    CategoryDao categoryDao;

    @Inject
    CreatorDao creatorDao;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<CategoryDto> getAll() {
        return CategoryDto.fromModelList(categoryDao.getAll());
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createCategory(CategoryDto categoryDto, @QueryParam("creatorid") Long creatorID) {
        if (creatorID == null)
            throw new WebApplicationException(
                    Response.status(401).entity("Not authenticated").build());
        Creator creator = creatorDao.getById(creatorID);
        if (creator == null || !creator.isAdmin())
            throw new WebApplicationException(
                    Response.status(404).entity("Not authenticated").build());

        try {
            categoryDao.getByName(categoryDto.getText());
            throw new WebApplicationException(
                    Response.status(400).entity("Category already exists").build());
        }
        catch (NoResultException e) {
            Category category = new Category();
            category.setText(categoryDto.getText());

            categoryDao.addElement(category);
            URI location = uriInfo.getAbsolutePathBuilder()
                    .path("" + category.getId()).build();
            return Response.created(location).build();
        }
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public CategoryDto getCategory(@PathParam("id") long id) {
        Category category = categoryDao.getById(id);
        if (category == null)
            throw new WebApplicationException(
                    Response.status(404).entity("Not found").build());
        return CategoryDto.fromModel(category);
    }

}