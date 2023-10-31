package servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "InvalidSession", urlPatterns = {"/InvalidSession"})
public class InvalidSession extends HttpServlet 
{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
       throws ServletException, IOException 
    {
        HttpSession session = req.getSession(false);
        
        if (session != null)
        {
         
            session.invalidate();
        }

        req.setAttribute("infoMessage", "Sesja zostala pomyslnie uniewazniona");

        RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
        rd.forward(req, resp);

    }
}
