package com.johnnyconsole.senvote.servlet;

import com.johnnyconsole.senvote.persistence.DivisionItem;
import com.johnnyconsole.senvote.persistence.interfaces.DivisionItemDaoLocal;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/EditDivisionServlet")
public class EditDivisionServlet extends HttpServlet {

    @EJB
    private DivisionItemDaoLocal divisionDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getParameter("senvote-edit-division-submit") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title"),
                    type = request.getParameter("type"),
                    text = request.getParameter("text");

            LocalDateTime start = LocalDateTime.parse(request.getParameter("start")),
                      end = LocalDateTime.parse(request.getParameter("end"));

            if (start.isAfter(end)) {
                response.sendRedirect("edit.jsp?edit=division&division=" + id + "&error=409 (Conflict)&message=The start date for this division is after its end date.");
                return;
            }

            DivisionItem divisionItem = divisionDao.byId(id);
            divisionItem.title = title;
            divisionItem.type = type;
            divisionItem.text = text;
            divisionItem.start = Timestamp.valueOf(start);
            divisionItem.end = Timestamp.valueOf(end);

            divisionDao.saveDivisionItem(divisionItem);

            response.sendRedirect("edit.jsp?edit=division&saved=" + id);
        }
        else {
            response.sendRedirect("edit.jsp?edit=division&error=401 (Unauthorized)&message=You must access this page with the edit division form.");
        }
    }
}
