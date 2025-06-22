package com.johnnyconsole.senvote.servlet;

import com.johnnyconsole.senvote.persistence.interfaces.UserDaoLocal;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    @EJB
    private UserDaoLocal userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("senvote-delete-user-submit") != null) {
            String username = request.getParameter("user"),
                    sender = request.getParameter("sender");

            userDao.removeUser(userDao.getUser(username), sender);
            response.sendRedirect("delete-user.jsp?deleted=" + username);
        }
        else {
            response.sendRedirect("delete-user.jsp?error=401 (Unauthorized)&message=You must access this page with the add user form.");
        }
    }
}
