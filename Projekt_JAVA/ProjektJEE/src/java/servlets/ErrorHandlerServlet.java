package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ErrorHandlerServlet", urlPatterns = {"/Error"})
public class ErrorHandlerServlet extends HttpServlet 
{

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        
            
           String message = "Ops! Wystapil blad. Sprobuj ponownie pozniej";
          
            Integer statusCode = (Integer)request.getAttribute("javax.servlet.error.status_code");
            
            if(statusCode != null && statusCode == 405)
            {
             message = "Nie mozesz uzyskac dostepu do zasobu, ktorego zadasz";             
            }
            
            if(statusCode != null && statusCode == 404)
            {
                message="Zadany zasob jest niedostepny";                
            }
            
            request.getSession().setAttribute("dangerMessage", message);
            response.sendRedirect("/ProjecJEE-Web-Project/index.jsp");
    }


}
