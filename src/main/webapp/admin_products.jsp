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
  <%@ include file="admin/admin_includes/topbar.jsp"%>

  <main class="p-4 sm:p-8">
    <div class="flex flex-wrap items-center justify-between gap-4">
      <h1 class="text-2xl font-bold">Products</h1>
      <a href="admin_add_product.jsp" class="btn btn-primary"><i class="uil uil-plus-circle text-lg"></i> Add Product</a>
    </div>
    <div class="card mt-6 overflow-x-auto">
      <table class="table-base">
        <thead>
        <tr>
          <th>Product ID</th>
          <th>Product Name</th>
          <th>Product Image</th>
          <th>Category</th>
          <th>Product Quantity</th>
          <th>Price</th>
          <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
          if(productList != null) {
            for(var product : productList) {
        %>
        <tr>
          <td class="text-slate-500">#<%=product.getProductId()%></td>
          <td class="font-medium text-slate-900"><%=product.getProductName()%></td>
          <td><img src="./uploadedImages/product/<%=product.getImageName()%>" alt="" class="size-12 rounded-lg object-cover" /></td>
          <%System.out.printf(product.getImageName());%>
          <td><span class="rounded-full bg-brand-50 px-2.5 py-1 text-xs font-medium text-brand-700"><%=product.getCategoryName()%></span></td>
          <td><%=product.getQuantity()%></td>
          <td><strong class="text-slate-900"><%=product.getPrice()%></strong></td>
          <td><a href="./admin_manage_product.jsp?productId=<%=product.getProductId()%>" class="btn btn-outline px-3 py-1.5">Manage</a> </td>
        </tr>
        <%
            }
          } else {
        %>

        <% } %>

        </tbody>
      </table>
    </div>
  </main>
</section>

<%@ include file="admin/admin_includes/end.jsp"%>
