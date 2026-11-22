<%@ page import="org.example.greensuper.models.Feedback" %>
<%@ page import="org.example.greensuper.dao.UserDao" %>
<%@ page import="org.example.greensuper.dao.CartDao" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    }

    UserDao userDao = new UserDao();
    CartDao cartDao = new CartDao();

    List<Feedback> feedbackList = userDao.getAllCustomerFeedbacks();
%>

<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>

<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>

    <div class="dash-content space-y-8 p-4 sm:p-8">
        <div class="overview">
            <h1 class="flex items-center gap-2 text-2xl font-bold">
                <i class="uil uil-tachometer-fast-alt text-brand-600"></i> Dashboard
            </h1>

            <div class="boxes mt-6 grid gap-4 sm:grid-cols-3">
                <div class="card flex items-center gap-4 p-5">
                    <span class="grid size-12 place-items-center rounded-xl bg-brand-50 text-2xl text-brand-600"><i class="uil uil-users-alt"></i></span>
                    <div><p class="text-sm text-slate-500">Users</p><p class="text-2xl font-bold text-slate-900"><%=userDao.getUserCount()%></p></div>
                </div>
                <div class="card flex items-center gap-4 p-5">
                    <span class="grid size-12 place-items-center rounded-xl bg-amber-50 text-2xl text-amber-600"><i class="uil uil-usd-circle"></i></span>
                    <div><p class="text-sm text-slate-500">Sales</p><p class="text-2xl font-bold text-slate-900">Rs.<%=cartDao.getAllSalesAmount()%></p></div>
                </div>
                <div class="card flex items-center gap-4 p-5">
                    <span class="grid size-12 place-items-center rounded-xl bg-sky-50 text-2xl text-sky-600"><i class="uil uil-share"></i></span>
                    <div><p class="text-sm text-slate-500">Completed Orders</p><p class="text-2xl font-bold text-slate-900"><%=cartDao.getAllCompletedOrders()%></p></div>
                </div>
            </div>
        </div>

        <div class="activity card overflow-hidden">
            <h2 class="flex items-center gap-2 border-b border-slate-100 px-5 py-4 text-lg font-semibold">
                <i class="uil uil-clock-three text-brand-600"></i> Customer Feedbacks
            </h2>
            <div class="overflow-x-auto">
                <table class="table-base">
                    <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Bill ID</th>
                        <th>Date</th>
                        <th>Feedback</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(var feedback: feedbackList) {
                    %>
                    <tr>
                        <td class="font-medium text-slate-900"><%=feedback.getCustomer_name()%></td>
                        <td><%=feedback.getBill_id()%></td>
                        <td class="whitespace-nowrap"><%=feedback.getFeedback__date()%></td>
                        <td class="max-w-md"><%=feedback.getFeedback()%></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>
