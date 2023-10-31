package servlets;

import db.DBManager;
import db.Product;
import db.User;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
@MultipartConfig
public class UploadServlet extends HttpServlet 
{

    private DBManager manager;

    @Override
    public void init() throws ServletException 
    {

        this.manager = (DBManager) super.getServletContext().getAttribute("dbmanager");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession();

        Product Productt = (Product) session.getAttribute("currentProduct");
        User user = (User) session.getAttribute("user");

        Part filePart = request.getPart("file"); 
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 
        String[] parts = fileName.split("\\.");
        String extension = parts[1];
        if (extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png")) 
        {
            InputStream fileContent = filePart.getInputStream();
            String dirName = this.getServletContext().getRealPath("/");
            String newDir = dirName.replace("/build", "") + "data/img/userImg";

            boolean result = false;
            
            try 
            {
                result = manager.addPhoto(Productt.getId(), "idUser=" + (user.getId()) + "_" + fileName, user.getId(), user.getFirstName() + " " + user.getlastName());
            } 
            catch (SQLException ex) 
            {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (result) 
            {
                Files.copy(fileContent, Paths.get(newDir + "/idUser=" + (user.getId()) + "_" + fileName));
                session.setAttribute("successMessage", "Zdjecie zostalo wstawione pomyslnie!");
                response.sendRedirect("productt_page.jsp");
            } 
            else 
            {
                session.setAttribute("dangerMessage", "Wystapil problem z przesylaniem zdjecia!");
                response.sendRedirect("productt_page.jsp");
            }
        } 
        else 
        {
            session.setAttribute("dangerMessage", "Przyjmujemy tylko pliki w formacie .jpg lub .png!");
            response.sendRedirect("productt_page.jsp");
            return;
        }
    }

}
