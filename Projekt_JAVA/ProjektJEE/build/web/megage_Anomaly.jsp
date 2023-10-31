<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
   <head>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Zarzadzanie problemami</title>
   </head>
   <body>
      <%@ include file="menu.jsp" %>
      <div class="col-md-8 col-md-offset-2">
         <h2>Raport o anomaliach dla produktu:  ${nazwaProduktu}</h2><br>
         <form method="POST" action="MenageAnomaly">
            <input type="radio" name="anomaly" value="1"> Zwrot produktu<br><br>  
            <input type="radio" name="anomaly" value="2"> Ocen sklep negatywnie(obniz ocene o jedna gwiazdke)<br><br> 
            <input type="radio" name="anomaly" value="3"> Odrzuc zgloszenie<br><br>  
            <input type="hidden" name="idOrder" value="${idOrder}">
            <input type="hidden" name="idProductt" value="${idProductt}">
            <input type = "submit" value="Send" class = "btn btn-default btn-lg"><br /> 
         </form> 
      </div>
   </body>
</html>