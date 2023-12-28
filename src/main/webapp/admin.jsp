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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="./css/admin/style.css">
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

    <title>Admin Dashboard Panel</title>
</head>
<body>
<nav>
    <div class="logo-name">
        <div class="logo-image">
            <img src="images/logo.png" alt="">
        </div>

        <span class="logo_name">Green Super</span>
    </div>

    <div class="menu-items">
        <ul class="nav-links">
            <li><a href="index.html">
                <i class="uil uil-estate"></i>
                <span class="link-name">Dashboard</span>
            </a></li>
            <li><a href="categories.html">
                <i class="uil uil-box"></i>
                <span class="link-name">Categories</span>
            </a></li>
            <li><a href="products.html">
                <i class="uil uil-pizza-slice"></i>
                <span class="link-name">Products</span>
            </a></li>
            <li><a href="customers.html">
                <i class="uil uil-user"></i>
                <span class="link-name">Customers</span>
            </a></li>
            <li><a href="orders.html">
                <i class="uil uil-transaction"></i>
                <span class="link-name">Orders</span>
            </a></li>
        </ul>

        <ul class="logout-mode">
            <li><a href="#">
                <i class="uil uil-signout"></i>
                <span class="link-name">Logout</span>
            </a></li>
        </ul>
    </div>
</nav>

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
                    <span class="data-title">Customer ID</span>
                    <%
                        for(var customer_id : feedbackList) {
                    %>
                        <span class="data-list"><%=customer_id.getCustomer_id()%></span>
                    <%
                        }
                    %>
                </div>
                <div class="data email">
                    <span class="data-title">Bill ID</span>
                    <span class="data-list">1</span>
                </div>
                <div class="data joined">
                    <span class="data-title">Date</span>
                    <span class="data-list">2022-02-12</span>

                </div>
                <div class="data type">
                    <span class="data-title">Feedback</span>

                </div>
            </div>
        </div>
    </div>
</section>

<script src="./js/script.js"></script>
</body>
</html>