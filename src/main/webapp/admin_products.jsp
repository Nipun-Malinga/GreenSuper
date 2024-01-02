<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="java.util.List" %>
<%@ include file="admin/admin_includes/header.jsp"%>
<%@ include file="admin/admin_includes/navbar.jsp"%>

<%
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

  if(session.getAttribute("adminAuth") == null) {
    response.sendRedirect("./admin_login.jsp");
  }

  ProductDao productDao = new ProductDao();
  List<Product> productList = productDao.getAllProducts();
%>

<section class="dashboard">
  <div class="top">
    <i class="uil uil-bars sidebar-toggle"></i>

    <div class="search-box">
      <i class="uil uil-search"></i>
      <input type="text" placeholder="Search here..." />
    </div>
  </div>
  <br /><br /><br /><br />

  <main class="table">
    <section class="table__header">
      <h1>Products</h1>
      <ul class="nav-links">
        <a href="admin_add_product.jsp">
          <i class="uil uil-plus-circle"></i>
          <span class="link-name">Add Product</span>
        </a>
      </ul>
    </section>
    <section class="table__body">
      <table>
        <thead>
        <tr>
          <th>Product ID</th>
          <th>Product Name</th>
          <th>Product Image</th>
          <th>Category</th>
          <th>product Quantity</th>
          <th>price</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
          if(productList != null) {
            for(var product : productList) {
        %>
        <tr>
          <td><%=product.getProductId()%></td>
          <td><%=product.getProductName()%></td>
          <td><img src="./uploadedImages/product/<%=product.getImageName()%>" alt="" /></td>
          <%System.out.printf(product.getImageName());%>
          <td><%=product.getCategoryName()%></td>
          <td><%=product.getQuantity()%></td>
          <td><strong><%=product.getPrice()%></strong></td>
          <td><a href="./admin_manage_product.jsp?productId=<%=product.getProductId()%>">Manage</a> </td>
        </tr>
        <%
            }
          } else {
        %>

        <% } %>

        </tbody>
      </table>
    </section>
  </main>
</section>
<script src="./js/script.js"></script>

<%@ include file="admin/admin_includes/end.jsp"%>

