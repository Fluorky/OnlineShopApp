package servlets;

import db.DBManager;
import db.Product;
import db.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoadProducts", urlPatterns = {"/LoadProducts"})
public class LoadProducts extends HttpServlet 
{

    private DBManager dbManager;

    @Override
    public void init() throws ServletException 
    {
        dbManager = (DBManager) super.getServletContext().getAttribute("dbmanager");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException 
    {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        String nazwaProduktu = (String) req.getParameter("nazwaProduktu");
        String categoria = (String) req.getParameter("categoria");
        boolean dalistaproductss = Boolean.parseBoolean(req.getParameter("dalistaproductss"));
        String address = req.getParameter("address");
        if (dalistaproductss & address.equals("")) 
        {
            address = (String) session.getAttribute("addressSalvato");
        }
        double cenna = Double.parseDouble(req.getParameter("price"));
        int rate = Integer.parseInt(req.getParameter("rate"));
       // int stock = Integer.parseInt(req.getParameter("stocki"));
        session.setAttribute("addressSalvato", address);
        String address1 = address.split(",")[0];
        String address2 = "";
        if (address.split(",").length > 1) 
        {
            address2 = address.split(",")[1].trim();
        }
        

        try {
            List<Product> products = dbManager.getProducts(nazwaProduktu, categoria, user);
            List<Product> productsFiltered = new ArrayList();
            for (Product p : products) 
            {
                if ((p.getPrice() <= cenna || cenna == 0.0) && (p.getAvg_rate() == rate || rate == 0) && ((p.getShop().getAddress().toLowerCase().contains(address1.toLowerCase())) || (p.getShop().getAddress().toLowerCase().contains(address2.toLowerCase())))) 
                {
                    productsFiltered.add(p);
                }
            }
            req.setAttribute("nazwaProduktu", nazwaProduktu);
            req.setAttribute("categoria", categoria);
         //   req.setAttribute("stocki", stock);
            if (!productsFiltered.isEmpty()) 
            {
                session.setAttribute("productss", productsFiltered);
                RequestDispatcher rd = req.getRequestDispatcher("/listaPRODUCTSS.jsp");
                rd.forward(req, response);
            } 
            else 
            {
                session.setAttribute("dangerMessage", "Nie znaleziono produktu, ktory spe;nia kryteria wyszukiwania");
                session.removeAttribute("productss");
                RequestDispatcher rd = req.getRequestDispatcher("/listaPRODUCTSSEmpty.jsp");
                rd.forward(req, response);

            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(LoadProducts.class.getName()).log(Level.SEVERE, ex.toString(), ex);
        }
    }
}
