<%@ page import="org.example.greensuper.models.Feedback" %>
<%@ page import="org.example.greensuper.dao.UserDao" %>
<%@ page import="org.example.greensuper.dao.CartDao" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    UserDao userDao = new UserDao();
    CartDao cartDao = new CartDao();

    List<Feedback> feedbackList = userDao.getAllCustomerFeedbacks();
%>

<%@ include file="admin/admin_includes/header.jsp"%>
<%@ include file="admin/admin_includes/navbar.jsp"%>

<section class="dashboard">
    <div class="top">
        <i class="uil uil-bars sidebar-toggle"></i>

        <div class="search-box">
            <i class="uil uil-search"></i>
            <input type="text" placeholder="Search here...">
        </div>
    </div>

    <div class="dash-content">
        <div class="overview">
            <div class="title">
                <i class="uil uil-tachometer-fast-alt"></i>
                <span class="text">Dashboard</span>
            </div>

            <div class="boxes">
                <div class="box box1">
                    <i class="uil uil-users-alt"></i>
                    <span class="text">Users</span>
                    <span class="number"><%=userDao.getUserCount()%></span>
                </div>
                <div class="box box2">
                    <i class="uil uil-usd-circle"></i>
                    <span class="text">Sales</span>
                    <span class="number">Rs.<%=cartDao.getAllSalesAmount()%></span>
                </div>
                <div class="box box3">
                    <i class="uil uil-share"></i>
                    <span class="text">Completed Orders</span>
                    <span class="number"><%=cartDao.getAllCompletedOrders()%></span>
                </div>
            </div>
        </div>

        <div class="activity">
            <div class="title">
                <i class="uil uil-clock-three"></i>
                <span class="text">Customer Feedbacks</span>
            </div>

            <div class="activity-data">
                <div class="data names">
                    <span class="data-title">Customer Name</span>
                    <%
                        for(var customer_name: feedbackList) {
                    %>
                        <span class="data-list"><%=customer_name.getCustomer_name()%></span>
                    <%
                        }
                    %>
                </div>
                <div class="data email">
                    <span class="data-title">Bill ID</span>
                    <%
                        for(var bill_id: feedbackList) {
                    %>
                    <span class="data-list"><%=bill_id.getCustomer_id()%></span>
                    <%
                        }
                    %>
                </div>
                <div class="data joined">
                    <span class="data-title">Date</span>
                    <%
                        for(var date: feedbackList) {
                    %>
                    <span class="data-list"><%=date.getFeedback__date()%></span>
                    <%
                        }
                    %>

                </div>
                <div class="data type">
                    <span class="data-title">Feedback</span>
                    <%
                        for(var feedback: feedbackList) {
                    %>
                    <span class="data-list"><%=feedback.getFeedback()%></span>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="admin/admin_includes/end.jsp"%>