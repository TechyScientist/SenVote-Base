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

@WebServlet("/AddDivisionServlet")
public class AddDivisionServlet extends HttpServlet {

    @EJB
    private DivisionItemDaoLocal divisionDao;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("dashboard.jsp?error=415 (Media Unsupported)&message=GET request not supported");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            if (request.getParameter("senvote-add-division-submit") != null) {
                String title = request.getParameter("title"),
                        type = request.getParameter("type"),
                        text = request.getParameter("text"),
                        start = request.getParameter("start"),
                        end = request.getParameter("end");

                LocalDateTime ldStart = LocalDateTime.parse(start),
                        ldEnd = LocalDateTime.parse(end);

                if (ldStart.isAfter(ldEnd)) {
                    response.sendRedirect("add-division.jsp?error=409 (Conflict)&message=The start date for this division is after its end date.");
                    return;
                }

                DivisionItem item = new DivisionItem(type, title, text, Timestamp.valueOf(ldStart), Timestamp.valueOf(ldEnd));
                divisionDao.addDivisionItem(item);
                response.sendRedirect("add-division.jsp?added=true&id=" + item.id + "&title=" + title);

            } else {
                response.sendRedirect("add-division.jsp?error=401 (Unauthorized)&message=You must access this page with the add user form.");
            }
        } catch (Exception ex) {
            response.sendRedirect("add-division.jsp?error=500 (Internal Error)&message=" + ex.getMessage());
        }
    }
}
