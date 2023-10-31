/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import db.DBManager;
import db.Shop;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MACIEJ
 */
@WebServlet(name = "MyShops", urlPatterns = {"/MyShops"})
public class MyShops extends HttpServlet 
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

        //HttpSession session = req.getSession();
        int id = Integer.parseInt(req.getParameter("idUser"));
        Shop s = new Shop();

        try 
        {
            s = dbManager.getShopOwner(id);
          //  session.setAttribute("Shop", s);
            response.sendRedirect("shop.jsp");
            
            return;
        } 
        catch (SQLException ex) 
        {
            Logger.getLogger(LoadShop.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
