<%@ page import="org.example.greensuper.dao.Bill_InfoDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Order" %>
<%@ include file="admin/admin_includes/header.jsp" %>
<%@ include file="admin/admin_includes/navbar.jsp" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    }

    Bill_InfoDao billInfoDao = new Bill_InfoDao();
    List<Order> orderList = billInfoDao.getAllOrderDetails();
%>

<section class="dashboard">
    <%@ include file="admin/admin_includes/topbar.jsp" %>

    <main class="p-4 sm:p-8">
        <h1 class="text-2xl font-bold">Orders</h1>
        <div class="card mt-6 overflow-x-auto">
            <table class="table-base">
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
                    <td class="font-medium text-slate-900">#<%=order.getBillId()%></td>
                    <td><%=order.getCustomerId()%></td>
                    <td class="whitespace-nowrap"><%=order.getDate()%></td>
                    <td><strong class="text-slate-900"><%=order.getBillTotal()%></strong></td>
                    <td><span class="rounded-full bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-700"><%=order.getStatus()%></span></td>
                </tr>
                <%      }
                    }
                %>
                </tbody>
            </table>
        </div>
    </main>
</section>

<%@ include file="admin/admin_includes/end.jsp" %>
