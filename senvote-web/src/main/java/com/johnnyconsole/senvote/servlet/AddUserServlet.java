package com.johnnyconsole.senvote.servlet;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.senvote.persistence.User;
import com.johnnyconsole.senvote.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {

    @EJB
    private UserDaoLocal userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("senvote-add-user-submit") != null) {
            String username = request.getParameter("username"),
                    name = request.getParameter("name"),
                    password = request.getParameter("password"),
                    confirm_password = request.getParameter("confirm-password");

            int access = Integer.parseInt(request.getParameter("accessLevel"));
            boolean accountActive = Integer.parseInt(request.getParameter("active")) == 1;
            if (userDao.userExists(username)) {
                response.sendRedirect("add-user.jsp?error=409 (Conflict)&message=User \"" + username + "\" already exists");
            }

            if (password.equals(confirm_password)) {
                User user = new User(username, name,
                        BCrypt.withDefaults().hashToString(12, password.toCharArray()),
                        access, accountActive);

                userDao.addUser(user);
                response.sendRedirect("add-user.jsp?added=" + username);
            } else {
                response.sendRedirect("add-user.jsp?error=409 (Conflict)&message=Passwords do not match");
            }
        }
        else {
            response.sendRedirect("add-user.jsp?error=401 (Unauthorized)&message=You must access this page with the add user form.");
        }
    }
}
