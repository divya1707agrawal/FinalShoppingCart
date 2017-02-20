<%@page import="com.niit.shoppingcart.controller.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
     <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
     <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Page</title>
</head>
<body>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
  <link rel="stylesheet" href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>" ">
 <script src="<c:url value='/resources/jquery/jquery.min.js'/>" ></script>
 <script src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>" ></script>
 <style>
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  </style>
  
  
   <style>
         .Search {
     position: absolute;
     top: 355px;
     left: 575px;
}

.Search input {
     height: 50px;
     width: 180pt;
}

        </style>
        
  </head>
  
<body onload="goforward()" style="background-color:rgb(128,128,128);color:white" >




<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script>
var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope, $http) {
  $http.post("cat")
  .then(function(response) {
      $scope.category = response.data;
  });
});
</script>


<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">ShoppingCart</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="aboutus">About Us</a></li>
      <li><a href="contactus">Contact Us</a></li> 
      
<%
String user=(String)session.getAttribute("user");
if(user==null)
{
	out.println("<li><a href='login'>Login</a></li>");
	   out.println("<li><a href=register>Register</a></li>"); 
}
%>

   
      <li> <sec:authorize access="hasRole('ROLE_ADMIN')"><a href="category">Add Category</a></sec:authorize></li>
      <li><sec:authorize access="hasRole('ROLE_ADMIN')"><a href="product?id=0">Add Product</a></sec:authorize></li>
      <li><sec:authorize access="hasRole('ROLE_ADMIN')"><a href="supplier1">Add Supplier</a></sec:authorize></li> 
       <li><sec:authorize access="hasRole('ROLE_ADMIN')"><a href="paymentConfirmed">payment confirmation</a></sec:authorize></li>
      <li><sec:authorize access="hasRole('ROLE_USER')"><a href="myCart/cart">View cart</a></sec:authorize></li>
      <li><sec:authorize access="hasRole('ROLE_USER')"><a href="logout">Logout</a></sec:authorize></li>
      <li><sec:authorize access="hasRole('ROLE_ADMIN')"><a href="logout">Logout</a></sec:authorize></li>
      
  </ul>
  </div>
  </nav>
  <br/><br/>
  <div>
 <form method="get" action="viewproduct" class="navbar-form navbar-left">
      <div class="form-group">
        <input type="text"  name="name" class="form-control" placeholder="Search">
        
     <!--   <div ng-repeat="x in products">
         <%for(int i=0;i<50;i++){ %>
          <li><a href="viewproduct?name={{x.products[<%=i%>].name }}">{{ x.products[<% out.println(i); %>].name }}</a></li>
          <%
         }
          %> </div> --> 
           
      </div>
    </form>
 </div>
 <br/>
 <br/>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">
      <div ng-app="myApp" ng-controller="myCtrl"> 
 <table> 
 <tr><td ng-repeat="x in category">
 <ul><li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="viewproduct?name={{ x.id }}">{{ x.name }} <span class="caret">
 </span>  </a>
 <ul class="dropdown-menu">
 <%for(int i=0;i<50;i++){ %>
 <li><a href="viewproduct?name={{x.products[<%=i%>].name }}">{{ x.products[<% out.println(i); %>].name }}</a></li>
         
         
         
          <%
 }
          %>
        </ul>
      </li></ul></td> </tr>
 </table>
</div>
</a>
    </div>
  </div>
</nav>
<img src='<c:url value='/resources/images/10.jpg' />'  alt="This is image" align="right" width="650" height="500">
<%
String name=(String)session.getAttribute("user");
if(name!=null)
{
out.println("<h2>Hello "+name+"</h2>");
}
%>

<%
Product p=(Product)request.getAttribute("product");
request.setAttribute("id", p.getId());
request.setAttribute("name", p.getName());
request.setAttribute("price",p.getPrice());
request.setAttribute("description",p.getDescription());
request.setAttribute("supplier",p.getSupplier_id());
request.setAttribute("stock",p.getStock());
request.setAttribute("category",p.getCategory_id());

%>

<c:url var="addAction" value="/manage_product1"></c:url>
<form:form action="manage_product1" commandName="editp" enctype="multipart/form-data" method="post">
<table>
<tr>
 <td><form:label path="id"><spring:message text="ID"/></form:label></td>
 <td><form:input path="id" type="text" value='${requestScope.id}' readonly="true" /></td></tr>
 <tr>
 <td><form:label path="name"><spring:message text="NAME"/></form:label></td>
  <td><form:input path="name" type="text" value="${requestScope.name}"/></td></tr>
 <tr>
 <td><form:label path="price"><spring:message text="PRICE"/></form:label></td>
 <td><form:input path="price" type="text" value="${requestScope.price}"/></td></tr>
 <tr>
 <td><form:label path="description"><spring:message text="DESCRIPTION"/></form:label></td>
 <td><form:input path="description" type="text" value="${requestScope.description}"/></td></tr>
 <tr>
 <td><form:label path="supplier_id"><spring:message text="SUPPLIER_ID"/></form:label></td>
 <td><form:input path="supplier_id" type="text" value="${requestScope.supplier}"/></td></tr>
 
 <td><form:label path="stock"><spring:message text="STOCK"/></form:label></td>
  <td><form:input path="stock" type="text" value="${requestScope.stock}"/></td></tr>
 <tr>
 <td><form:label path="category_id"><spring:message text="category_id"/></form:label></td>
  <td><form:input path="category_id" type="text" value="${requestScope.category}"/></td>
 </tr>
 </tr>
  <td colspan="2">
 <table border="0">
    <tr>
    <td>Pick file #1:</td>
    <td><input type="file" name="fileUpload" size="50" /></td>
    </tr>
 </table>
 </td>
 <tr>
 <td>
 <input type='submit' value='edit'/>
 </td>
 </tr>
 </table>
 </form:form>
  
  </body>
</html>