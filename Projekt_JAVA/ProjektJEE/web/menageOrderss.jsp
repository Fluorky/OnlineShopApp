
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
   <head>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <title>Zarzadzaj zamowieniami</title>
   </head>
   <body>
      <%@ include file="menu.jsp" %>
      <div class="col-md-8 col-md-offset-2">
         <c:choose>
            <c:when test= "${orderss.size()!=0}"> 
               <c:choose>
                  <c:when test= "${user.getRole() == 'admin'}"> <h2>Zarzadzaj zamowieniami</h2> </c:when>
                  <c:otherwise> <h2>Twoje zamowienia</h2> </c:otherwise>
               </c:choose>
               <br>
               <c:forEach items="${orderss}" var="o">
                  <h3>Numer zamowienia:${o.id} dnia: ${o.date} <c:if test= "${user.getRole() == 'admin'}"> od: ${o.buyerName} </c:if></h3>
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
                              <c:if test= "${user.getRole() == 'admin'}"> <th>Zglos problem</th> </c:if>

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
                                 <c:if test= "${user.getRole() == 'admin'}"> <td>${od.getProblemDescription()}</td></c:if>
                                 <c:choose>
                                       <c:when test= "${(user.getRole() == 'admin') and (od.orderStatusNumber == 9)}"><td><a href="MenageAnomaly?nazwaProduktu=${od.productt.name}&idProductt=${od.productt.id}&idOrder=${o.id}" class="btn btn-danger" role="button">Zarzadzaj problemem</a></td> </c:when>
                                       <c:when test= "${(user.getRole() == 'admin') and (od.orderStatusNumber != 9)}"><td><a href="MenageAnomaly?nazwaProduktu=${od.productt.name}&idProductt=${od.productt.id}&idOrder=${o.id}" class="btn btn-danger disabled" role="button">Zarzadzono problemem</a></td> </c:when>
                                    <c:otherwise><td> <a href="SendAnomaly?nazwaProduktu=${od.productt.name}&idProductt=${od.productt.id}&idOrder=${o.id}" class="btn btn-danger" role="button">Zglos problem</a> </td></c:otherwise>
                                 </c:choose>
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
