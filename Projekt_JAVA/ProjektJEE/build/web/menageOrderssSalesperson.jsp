<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
   <head>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Zarzadzaj zamowieniami - Sprzedawca </title>
   </head>
   <body>
      <%@ include file="menu.jsp" %>
      <div class="col-md-8 col-md-offset-2">
         <c:choose>
            <c:when test= "${orderssSalesperson.size()!=0}"> 
               <h2>Zarzadzaj zamowieniami - Sprzedawca</h2>
               <br>
                <c:forEach items="${orderssSalesperson}" var="o">
                  <h3>Numer zamowienia: ${o.id} z dnia ${o.date} od ${o.buyerName} </h3>
                  <div class="table-responsive"> 
                     <table class="table table-bordered">
                        <thead>
                           <tr>
                                 <th>Produkt</th>
                                 <th>Cena</th>
                                 <th>Ocena</th>
                                 <th> Razem </th>
                                 <th> Sklep </th>
                                 <th> Stan zamowienia </th>
                                 <th> Problem</th>

                           </tr>
                        </thead>
                        <tbody>
                           <c:forEach items="${o.getOrderDetails()}" var="od">
                              <tr>
                                 <td>${od.productt.name}<br></td>
                                 <td><fmt:formatNumber type = "number" maxFractionDigits = "2" pattern="0.00" value = "${od.productt.price}"></fmt:formatNumber> PLN</td>
                                 <td>${od.productt.quantity}</td>
                                 <td><fmt:formatNumber type = "number" maxFractionDigits = "2" pattern="0.00" value = "${od.productt.price*od.productt.quantity}"></fmt:formatNumber> PLN</td>
                                 <td>${od.productt.shop.name}</td>
                                 <td>${od.getOrderStatus()}</td>
                                 <td>${od.getProblemDescription()}</td>
                              </tr>
                           </c:forEach>
                        </tbody>
                     </table>
                  </div>
                </c:forEach>
            </c:when>
            <c:otherwise> <h2>Brak zamowien</h2> </c:otherwise>
         </c:choose>
      </div>
   </body>
</html>
