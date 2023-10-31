
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
   <head>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Zglos blad</title>
   </head>
   <body>
      <%@ include file="menu.jsp" %>
      <div class="col-md-8 col-md-offset-2">
         <h2>Zglos blad dla produktu ${nazwaProduktu}</h2><br>
         <form method="POST" action="SendAnomaly">
            <input type="radio" name="anomaly" value="Produkt nie otrzymany">Produkt nie otrzymany<br><br>  
            <input type="radio" name="anomaly" value="Produkt uszkodzony">Produkt uszkodzony<br><br>  
            <input type="hidden" name="orderStatus" value="9">
            <input type="hidden" name="idOrder" value="${idOrder}">
            <input type="hidden" name="idProductt" value="${idProductt}">
            <input type = "submit" value="Send" class = "btn btn-default btn-lg"><br /> 
         </form> 
      </div>
   </body>
</html>