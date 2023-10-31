package servlets;

import db.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoadProduct", urlPatterns = {"/LoadProduct"})
public class LoadProduct extends HttpServlet 
{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException 
    {

        HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idProductt"));
        List<Product> products = (List<Product>) session.getAttribute("productss");
        
        for (Product p : products) 
        {
            if (p.getId() == id) 
            {
                session.setAttribute("currentProduct", p);
                response.sendRedirect("productt_page.jsp");
                return;
            }
        }

        session.setAttribute("infoMessage", "Nie znaleziono produktu, ktory spelnia kryteria wyszukiwania");
        response.sendRedirect("index.jsp");
    }
}
