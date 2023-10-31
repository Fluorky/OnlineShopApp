package servlets;

import db.DBManager;
import db.User;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet 
{

    private DBManager manager;

    @Override
    public void init() throws ServletException 
    {
      
        this.manager = (DBManager) super.getServletContext().getAttribute("dbmanager");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
    {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        HttpSession session = req.getSession(true);
        User user;
        try 
        {
            user = manager.autenticazione(email, password);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
        if (user == null) 
        {
      
            session.setAttribute("dangerMessage", "Username/password nie istnieje!");
            resp.sendRedirect("login.jsp");

        }
        else 
        {
            session.setAttribute("user", user);
            session.setAttribute("infoMessage", "Witaj w sklepie, " + user.getFirstName()+ "!");
            resp.sendRedirect("index.jsp");
        }
    }

}
