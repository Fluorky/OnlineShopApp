<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" type="text/css" href="./css/cart.css">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
       <title>Koszyk</title>
   </head>
   <body>
      <%@ include file="menu.jsp" %>
      <br>
      <c:if test = "${(previousItems.size() == 0) or (previousItems == null)}">
      <center><h2>Brak produktow w koszyku</h2></center>
      </c:if>
      <c:if test = "${previousItems.size() > 0 }">
      <div class="container">
         <table id="cart" class="table table-hover table-condensed">
            <thead>
               <tr>
                  <th style = "width: 50%"> Produkt </th>
                  <th style = "width: 10%"> cenna </th>
                  <th style = "width: 8%"> Ilosc </th>
                  <th style = "width: 22%" class = "text-center"> Razem </th>
                  <th style = "width: 10%"> </th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items = "${previousItems}" var = "pr">
                  <tr>
                     <td data-th="Productt">
                        <div class="row">
                           <c:if test = "${pr.getPhotos().size() == 0}">
                              <div class="col-sm-2 hidden-xs"><img src="./data/img/No_Image_Available.jpg" alt="${pr.name}" class="img-responsive"/></div>
                              </c:if>
                              <c:if test = "${pr.getPhotos().size() != 0}">
                              <div class="col-sm-2 hidden-xs"><img src="./data/img/${pr.getPhotos().get(0).name}" alt="${pr.name}" class="img-responsive"/></div>
                              </c:if>
                           <div class="col-sm-10">
                              <h4 class="nomargin">${pr.name}</h4>                             
                              <span class="text-success"><strong><p>W magazynie</p></strong></span>
                           </div>
                        </div>
                     </td>
                     <td data-th="cenna"><fmt:formatNumber type = "number" maxFractionDigits = "2" pattern="0.00" value = "${pr.price} " ></fmt:formatNumber> PLN</td>
                        <td data-th="Quantityy">
                           <div class="panel panel-default">
                              <div class="panel-body"align="center">${pr.getQuantity()}</div>
                        </div>
                     </td>
                     <td data-th="Totale" class="text-center"><fmt:formatNumber type = "number" maxFractionDigits = "2" pattern="0.00" value = "${pr.price * pr.quantity} " ></fmt:formatNumber> PLN</td>
                        <td class="actions" data-th="">
                           <a href="UpdateProduct?idProductt=${pr.id}&button=minus" class="btn btn-info btn-sm" role="button"><i class="fa fa-minus"></i></a>
                        <a href="UpdateProduct?idProductt=${pr.id}&button=plus" class="btn btn-info btn-sm" role="button"><i class="fa fa-plus"></i></a>
                        <a href="UpdateProduct?idProductt=${pr.id}&button=trash" class="btn btn-danger btn-sm" role="button"><i class="fa fa-trash-o"></i></a>
                     </td>
                  </tr>
               </c:forEach> 
            </tbody>
            <tfoot>
               <tr class="visible-xs">
                  <td class="text-center"><strong>Total cart <fmt:formatNumber type = "number" maxFractionDigits = "2" pattern="0.00" value = "${total}" ></fmt:formatNumber> PLN</strong></td>
                  </tr>
                  <tr>
                     <td><a href="index.jsp" class="btn btn-warning"><i class="fa fa-angle-left"></i>Kontynuuj zakupy</a></td>
                     <td colspan="2" class="hidden-xs"></td>
                     <td class="hidden-xs text-center"><strong>Razem <fmt:formatNumber type = "number" maxFractionDigits = "2" pattern="0.00" value = "${total}" ></fmt:formatNumber> PLN</strong></td>
                     <td><a href="Checkout" class="btn btn-success btn-block">Platnosc <i class="fa fa-angle-right"></i></a></td>
                  </tr>
               </tfoot>
            </table>
         </div>
   </c:if>
</body>
</html>
