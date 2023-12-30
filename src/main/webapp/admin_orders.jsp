
<%@ include file="admin/admin_includes/header.jsp" %>
<%@ include file="admin/admin_includes/navbar.jsp" %>

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
                <tr>
                    <td>001</td>
                    <td>001</td>
                    <td>2023-01-02</td>
                    <td><strong>Rs.150.00</strong></td>
                    <td>Paid</td>
                </tr>
                </tbody>
            </table>
        </section>
    </main>
</section>

<%@ include file="admin/admin_includes/end.jsp" %>
