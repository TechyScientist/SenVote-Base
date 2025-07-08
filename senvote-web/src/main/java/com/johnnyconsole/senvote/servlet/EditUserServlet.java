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

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {

    @EJB
    private UserDaoLocal userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("senvote-edit-user-submit") != null) {
            String username = request.getParameter("username"),
                    name = request.getParameter("name"),
                    password = request.getParameter("password"),
                    confirm_password = request.getParameter("confirm-password");

            int access = Integer.parseInt(request.getParameter("accessLevel"));
            boolean accountActive = Integer.parseInt(request.getParameter("active")) == 1;

            User user = userDao.getUser(username);
            user.name = name;
            user.accessLevel = access;
            user.accountActive = accountActive;

            if (!password.isEmpty()) {
                if (password.equals(confirm_password)) {
                    user.setPassword(BCrypt.withDefaults().hashToString(12, password.toCharArray()));
                } else {
                    response.sendRedirect("edit.jsp?edit=user&error=409 (Conflict)&message=Passwords do not match");
                }
            }
            userDao.saveUser(user);
            response.sendRedirect("edit.jsp?edit=user&saved=" + username);
        }
        else {
            response.sendRedirect("edit.jsp?edit=user&error=401 (Unauthorized)&message=You must access this page with the edit user form.");
        }
    }
}
