package com.johnnyconsole.senvote.servlet;

import com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteDivisionServlet")
public class DeleteDivisionServlet extends HttpServlet {

    @EJB
    private DivisionItemDaoLocal divisionDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("senvote-delete-division-submit") != null) {
            int id = Integer.parseInt(request.getParameter("division"));

            divisionDao.removeDivisionItem(divisionDao.byId(id));
            response.sendRedirect("delete-division.jsp?deleted=" + id);
        }
        else {
            response.sendRedirect("delete-division.jsp?error=401 (Unauthorized)&message=You must access this page with the delete division form.");
        }
    }
}
