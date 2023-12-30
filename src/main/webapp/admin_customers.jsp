<%@ page import="org.example.greensuper.models.Customer" %>
<%@ page import="org.example.greensuper.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ include file="admin/admin_includes/header.jsp"%>
<%@ include file="admin/admin_includes/navbar.jsp"%>

<%
    UserDao userDao = new UserDao();
    List<Customer> customerList = userDao.fetchAllCustomers();
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
            <h1>Customers</h1>
        </section>
        <section class="table__body">
            <table>
                <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Customer Name</th>
                    <th>Address</th>
                    <th>Email Address</th>
                    <th>Phone Number</th>
                </tr>
                <%
                    if(customerList != null) {
                        for (var customer : customerList) {
                %>
                <tr>
                    <td><%=customer.getCustomerId()%></td>
                    <td><%=customer.getFirstName() + " " + customer.getLastName()%></td>
                    <td><%=customer.getHomeNumber() + " " + customer.getStreetName() + " " + customer.getCity()%></td>
                    <td><%=customer.getEmail()%></td>
                    <td><%=customer.getPhoneNumber()%></td>
                </tr>

                <%
                        }
                    }
                %>

                </thead>
            </table>
        </section>
    </main>
</section>

<%@ include file="admin/admin_includes/end.jsp"%>
