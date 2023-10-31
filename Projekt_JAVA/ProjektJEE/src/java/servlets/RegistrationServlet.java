package servlets;

import db.DBManager;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/Registrazione"})
public class RegistrationServlet extends HttpServlet 
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

        HttpSession session = req.getSession();
        String email = req.getParameter("email");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String password1 = req.getParameter("password1");
        String password2 = req.getParameter("password2");


        if ("".equals(email) || "".equals(password1) || "".equals(password2) || "".equals(firstName) || "".equals(lastName)) 
        {
            session.setAttribute("dangerMessage", "Aby sie zarejestrowac musisz wypelnic wszystkie pola!");
            resp.sendRedirect("register.jsp");
            
            return;
        }

    
        if (!password1.equals(password2)) 
        {
            session.setAttribute("dangerMessage", "Wprowadzone hasla sa rozne!");
            resp.sendRedirect("register.jsp");
            return;
        }

        boolean esistente;
        try 
        {
            esistente = manager.newUser(email, firstName, lastName, password1);
        } 
        catch (SQLException ex) 
        {
            throw new ServletException(ex);
        }
   
        if (esistente) 
        {
           
            session.setAttribute("warningMessage", "Nazwa uzytkownika lub adres e-mail już zarejestrowany!");
            resp.sendRedirect("register.jsp");
        } 
        else 
        {
            req.getSession().setAttribute("successMessage", "Rejestracja potwierdzona");
            resp.sendRedirect("register.jsp");
        }
    }
}
