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
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {

    @EJB
    private UserDaoLocal userDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("senvote-signin-submit") != null) {
            String username = request.getParameter("username"),
                    password = request.getParameter("password");

            User user = userDao.getUser(username);
            if(user != null) {
                if(BCrypt.verifyer().verify(password.toCharArray(), user.getPassword().toCharArray()).verified) {
                    request.getSession().setAttribute("user", user);
                    response.sendRedirect("dashboard.jsp");
                }
                else {
                    response.sendRedirect("index.jsp?error=401 (Unauthorized)&message=Incorrect password");
                }
            }
            else {
                response.sendRedirect("index.jsp?error=401 (Unauthorized)&message=No SenVote record found for \"" + username + "\"");
            }
        } else {
            response.sendRedirect("index.jsp?error=401 (Unauthorized)&message=You must access this page with the sign in form.");
        }
    }
}
