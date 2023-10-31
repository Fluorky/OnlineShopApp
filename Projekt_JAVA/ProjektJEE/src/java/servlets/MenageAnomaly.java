package servlets;

import db.DBManager;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "MenageAnomaly", urlPatterns = {"/MenageAnomaly"})
public class MenageAnomaly extends HttpServlet 
{

   private DBManager manager;

    @Override
    public void init() throws ServletException 
    {

        this.manager = (DBManager) super.getServletContext().getAttribute("dbmanager");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException 
    {
        String nazwaProduktu = req.getParameter("nazwaProduktu");
        int idProductt = Integer.parseInt(req.getParameter("idProductt"));
        int idOrder = Integer.parseInt(req.getParameter("idOrder"));
        req.setAttribute("nazwaProduktu", nazwaProduktu);
        req.setAttribute("idProductt", idProductt);
        req.setAttribute("idOrder", idOrder);
        RequestDispatcher rd = req.getRequestDispatcher("/megage_Anomaly.jsp");
        rd.forward(req, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = req.getSession();
        int orderStatus = Integer.parseInt(req.getParameter("anomaly"));
        int idOrder = Integer.parseInt(req.getParameter("idOrder"));
        int idProductt = Integer.parseInt(req.getParameter("idProductt"));
        try 
        {
            manager.menageAnomaly(orderStatus, idOrder, idProductt);
            session.setAttribute("successMessage", "Anomaly gestita");
            response.sendRedirect("OrdersList");
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(SendAnomaly.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}