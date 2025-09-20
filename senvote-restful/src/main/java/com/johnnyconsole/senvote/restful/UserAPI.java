package com.johnnyconsole.senvote.restful;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.senvote.persistence.User;
import com.johnnyconsole.senvote.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.enterprise.context.RequestScoped;
import javax.validation.constraints.NotEmpty;
import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

@Path("/user")
@RequestScoped
public class UserAPI {

    @EJB private UserDaoLocal userDao;

    @POST
    @Path("/signin")
    @Produces(APPLICATION_JSON)
    public Response signin(
            @NotEmpty @FormParam("username") String username,
            @NotEmpty @FormParam("password") String password) {
        String response = "{\n";
        try {
            User user = userDao.getUser(username);
            if (!userDao.userExists(username)) {
                response += "\t\"status\": 404,\n";
                response += "\t\"category\": \"Not Found\",\n";
                response += "\t\"message\": \"No SenVote record found for '" + username + "'\"\n";
            } else {
                if (user.verifyPassword(password)) {
                    response += "\t\"status\": 200,\n";
                    response += "\t\"user\": {\n";
                    response += "\t\t\"username\": \"" + username + "\",\n";
                    response += "\t\t\"name\": \"" + user.name + "\",\n";
                    response += "\t\t\"access\": " + user.accessLevel + ",\n";
                    response += "\t\t\"active\": " + user.accountActive + "\n";
                    response += "\t}\n";
                } else {
                    response += "\t\"status\": 401,\n";
                    response += "\t\"category\": \"Unauthorized\",\n";
                    response += "\t\"message\": \"Incorrect password\"\n";
                }
            }
        } catch(Exception e) {
            response += "\t\"status\": 400,\n";
            response += "\t\"category\": \"Bad Request\",\n";
            response += "\t\"message\": \"Missing or empty parameter\n";
        }
        return Response.ok(response + "}").build();
    }

    @POST
    @Path("/add")
    @Produces(APPLICATION_JSON)
    public Response add(@NotEmpty @FormParam("username") String username,
                        @NotEmpty @FormParam("name") String name,
                        @NotEmpty @FormParam("password") String password,
                        @NotEmpty @FormParam("confirm") String confirm,
                        @FormParam("access") int access,
                        @FormParam("active") boolean active,
                        @NotEmpty @FormParam("admin_username") String adminUsername) {

        String response = "{\n";
        try {
            if (userDao.userExists(adminUsername)) {
                User admin = userDao.getUser(adminUsername);
                if (admin.accessLevel == 1 && admin.accountActive) {
                    if (!userDao.userExists(username)) {
                        if (password.equals(confirm)) {
                            User user = new User(username, name,
                                    BCrypt.with(BCrypt.Version.VERSION_2A)
                                            .hashToString(12, password.toCharArray()), access, active);
                            userDao.addUser(user);
                            response += "\t\"status\": 200,\n";
                            response += "\t\"message\": \"User '" + username + "' added to SenVote successfully\"\n";
                        } else {
                            response += "\t\"status\": 409,\n";
                            response += "\t\"category\": \"Conflict\",\n";
                            response += "\t\"message\": \"Passwords do not match\"\n";
                        }
                    } else {
                        response += "\t\"status\": 409,\n";
                        response += "\t\"category\": \"Conflict\",\n";
                        response += "\t\"message\": \"An existing SenVote record was found for user '" + username + "'\"\n";
                    }
                } else {
                    response += "\t\"status\": 401,\n";
                    response += "\t\"category\": \"Unauthorized\",\n";
                    response += "\t\"message\": \"User '" + adminUsername + "' is not a SenVote Administrator, or their account is inactive\"\n";
                }
            } else {
                response += "\t\"status\": 404,\n";
                response += "\t\"category\": \"Not Found\",\n";
                response += "\t\"message\": \"No SenVote record found for '" + adminUsername + "'\"\n";
            }
        } catch(Exception e) {
            response += "\t\"status\": 400,\n";
            response += "\t\"category\": \"Bad Request\",\n";
            response += "\t\"message\": \"Missing or empty parameter\n";
        }
        return Response.ok(response + "}").build();
    }

    @GET
    @Path("/all-except-{except}")
    @Produces(APPLICATION_JSON)
    public Response all_except(@NotEmpty @PathParam("except") String except) {
        String response = "{\n\t\"users\": [\n";

        List<User> users = userDao.getUsersExcept(except);
        for (int i = 0; i < users.size(); i++) {
            if(i < users.size() - 1) response += "\t\t\"" + users.get(i).name + " (" + users.get(i).username + ")\",\n";
            else response += "\t\t\"" + users.get(i).name + " (" + users.get(i).username + ")\"\n\t]\n";
        }
        return Response.ok(response + "}").build();
    }

    @POST
    @Path("/delete")
    @Produces(APPLICATION_JSON)
    public Response delete(@NotEmpty @FormParam("username") String username,
                           @NotEmpty @FormParam("admin_username") String adminUsername) {

        String response = "{\n";
        try {
            if (userDao.userExists(adminUsername)) {
                User admin = userDao.getUser(adminUsername);
                if (admin.accessLevel == 1 && admin.accountActive) {
                    if (userDao.userExists(username)) {
                        userDao.removeUser(userDao.getUser(username), adminUsername);
                        response += "\t\"status\": 200,\n";
                        response += "\t\"message\": \"User '" + username + "' deleted from SenVote successfully\"\n";
                    } else {
                        response += "\t\"status\": 404,\n";
                        response += "\t\"category\": \"Not Found\",\n";
                        response += "\t\"message\": \"No SenVote record found for '" + username + "'\"\n";
                    }
                } else {
                    response += "\t\"status\": 401,\n";
                    response += "\t\"category\": \"Unauthorized\",\n";
                    response += "\t\"message\": \"User '" + adminUsername + "' is not a SenVote Administrator, or their account is inactive\"\n";
                }
            } else {
                response += "\t\"status\": 404,\n";
                response += "\t\"category\": \"Not Found\",\n";
                response += "\t\"message\": \"No SenVote record found for '" + adminUsername + "'\"\n";
            }
        } catch(Exception e) {
            response += "\t\"status\": 400,\n";
            response += "\t\"category\": \"Bad Request\",\n";
            response += "\t\"message\": \"Missing or empty parameter\n";
        }
        return Response.ok(response + "}").build();
    }
}
