<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
   <head>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
      <link rel="stylesheet" type="text/css" href="./css/style.css">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Profil użytkownika</title>
   </head>
   <body>
      <%@ include file="menu.jsp" %>
      <div class="col-md-8 col-md-offset-2">
         <h2>Profil użytkownika ${user.role} </h2>
         <table class="table table-bordered table-responsive">
            <thead>
               <tr>
                  <th>Email</th>
                  <td>${user.email}</td>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <th>Imie</th>
                  <td>${user.firstName}</td>
               </tr>
               <tr>
                  <th>Nazwisko</th>
                  <td>${user.lastName}</td>
               </tr>
            </tbody>
         </table>
      </div>
   </body>
</html>
