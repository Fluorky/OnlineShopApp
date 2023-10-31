package servlets;

import db.DBManager;
import db.Product;
import db.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "Checkout", urlPatterns = {"/Checkout"})
public class Checkout extends HttpServlet 
{

    private DBManager dbManager;

    @Override
    public void init() throws ServletException
    {
        dbManager = (DBManager) super.getServletContext().getAttribute("dbmanager");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) 
        {
            session.setAttribute("dangerMessage", "Musisz by zalogowany, aby dokonac zakupu");
            response.sendRedirect("index.jsp");
        } 
        else 
        {
            response.sendRedirect("checkout.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException 
    {

        HttpSession session = req.getSession();
        String nome = req.getParameter("name");
        String cardNumber = req.getParameter("cardNumber");
        String CVC = req.getParameter("CVC");
        String address = req.getParameter("address");
        String expiryMonth = req.getParameter("expiryMonth");
        String expiryYear = req.getParameter("expiryYear");

        if ("".equals(nome) || "".equals(cardNumber) || "".equals(address) || "".equals(CVC) || "YEAR".equals(expiryYear) || "Miesiac".equals(expiryMonth)) 
        {
            session.setAttribute("dangerMessage", "Aby sie zarejestrowac musisz wypelnic wszystkie pola!");
            response.sendRedirect("checkout.jsp");
            return;
        } 
        else 
        {
            cardNumber = cardNumber.replaceAll("[^0-9]+", "");

            if ((cardNumber.length() < 16) || (cardNumber.length() > 16))
            {
                session.setAttribute("dangerMessage", "Karta musi zawierac tylko cyfry i miec 16 cyfr!");
                response.sendRedirect("checkout.jsp");
                return;
            }
        }

        User user = (User) session.getAttribute("user");
        ArrayList<Product> previousItems = (ArrayList<Product>) session.getAttribute("previousItems");
        boolean OrdineResult = false;
        try 
        {
            OrdineResult = dbManager.newOrder(user.getId(), user.getFirstName() + " " + user.getlastName(), previousItems);
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(Checkout.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if (OrdineResult)
        {
            session.removeAttribute("previousItems");
            session.setAttribute("infoMessage", "Zamowienie zlozone pomyslnie");
            RequestDispatcher rd = req.getRequestDispatcher("/OrdersList");
            rd.forward(req, response);
        } 
        else 
        {
            session.setAttribute("dangerMessage", "Wystapil problem z zamowieniem");
            RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
            rd.forward(req, response);
        }

    }

}
