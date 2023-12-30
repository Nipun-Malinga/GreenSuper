<%@ page import="org.example.greensuper.dao.Bill_InfoDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Order" %>
<%@ include file="admin/admin_includes/header.jsp" %>
<%@ include file="admin/admin_includes/navbar.jsp" %>

<%
    Bill_InfoDao billInfoDao = new Bill_InfoDao();
    List<Order> orderList = billInfoDao.getAllOrderDetails();
%>

<section class="dashboard">
    <div class="top">
        <i class="uil uil-bars sidebar-toggle"></i>

        <div class="search-box">
            <i class="uil uil-search"></i>
            <input type="text" placeholder="Search here...">
        </div>
    </div>

    <main class="table">
        <section class="table__header">
            <h1>Orders</h1>
        </section>
        <section class="table__body">
            <table>
                <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Customer ID</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Payment Status</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if(orderList != null) {
                        for (var order : orderList) {
                %>
                <tr>
                    <td><%=order.getBillId()%></td>
                    <td><%=order.getCustomerId()%></td>
                    <td><%=order.getDate()%></td>
                    <td><strong><%=order.getBillTotal()%></strong></td>
                    <td><%=order.getStatus()%></td>
                </tr>
                <%      }
                    }
                %>
                </tbody>
            </table>
        </section>
    </main>
</section>

<%@ include file="admin/admin_includes/end.jsp" %>
