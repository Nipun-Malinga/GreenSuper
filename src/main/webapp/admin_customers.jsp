<%@ page import="org.example.greensuper.models.Customer" %>
<%@ page import="org.example.greensuper.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ include file="admin/admin_includes/header.jsp"%>
<%@ include file="admin/admin_includes/navbar.jsp"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    }

    UserDao userDao = new UserDao();
    List<Customer> customerList = userDao.fetchAllCustomers();
%>
<section class="dashboard">
    <%@ include file="admin/admin_includes/topbar.jsp"%>

    <main class="p-4 sm:p-8">
        <h1 class="text-2xl font-bold">Customers</h1>
        <div class="card mt-6 overflow-x-auto">
            <table class="table-base">
                <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Customer Name</th>
                    <th>Address</th>
                    <th>Email Address</th>
                    <th>Phone Number</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if(customerList != null) {
                        for (var customer : customerList) {
                %>
                <tr>
                    <td class="text-slate-500">#<%=customer.getCustomerId()%></td>
                    <td class="font-medium text-slate-900"><%=customer.getFirstName() + " " + customer.getLastName()%></td>
                    <td><%=customer.getHomeNumber() + " " + customer.getStreetName() + " " + customer.getCity()%></td>
                    <td><%=customer.getEmail()%></td>
                    <td><%=customer.getPhoneNumber()%></td>
                </tr>

                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </main>
</section>

<%@ include file="admin/admin_includes/end.jsp"%>
