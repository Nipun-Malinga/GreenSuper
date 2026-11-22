<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    Failure page for admin product/category operations.
    Opened by js/admin_forms.js as admin_failed.jsp?event=<servlet response token>[&error=server]
    Only the known tokens below are accepted; anything else shows a generic message,
    so nothing from the URL is ever echoed into the page.
--%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
        if (true) return; // "if (true)" keeps javac from flagging the template code below as unreachable
    }

    String event = request.getParameter("event");
    boolean serverError = "server".equals(request.getParameter("error"));

    String title = "Something went wrong";
    String message = "The operation could not be completed.";
    String backUrl = "admin.jsp";
    String backLabel = "Back to Dashboard";
    String[] causes = {
            "The database could not be reached or rejected the change.",
            "Your admin session may have expired. Log in again and retry."
    };

    String[] productCauses = {
            "The database rejected the change (for example, a missing or invalid category).",
            "The product image could not be saved to the upload folder. Check that IMAGE_UPLOAD_PATH exists and is writable.",
    };
    String[] duplicateCauses = {
            "Names are compared without regard to upper/lower case or extra spaces.",
            "Use a different name, or edit the existing one instead."
    };
    String[] categoryCauses = {
            "The database rejected the change (for example, a duplicate or empty name).",
            "The category image could not be saved to the upload folder. Check that IMAGE_UPLOAD_PATH exists and is writable.",
    };

    if (event != null) {
        switch (event) {
            case "failedToAddProduct":
                title = "Couldn't add the product";
                message = "The new product was not saved.";
                backUrl = "admin_products.jsp"; backLabel = "Back to Products";
                causes = productCauses;
                break;
            case "productAlreadyExists":
                title = "Product already exists";
                message = "A product with this name is already in the selected category, so nothing was added.";
                backUrl = "admin_products.jsp"; backLabel = "Back to Products";
                causes = duplicateCauses;
                break;
            case "productFailedToUpdate":
                title = "Couldn't update the product";
                message = "Your changes to this product were not saved.";
                backUrl = "admin_products.jsp"; backLabel = "Back to Products";
                causes = productCauses;
                break;
            case "failedToDeleteProduct":
                title = "Couldn't delete the product";
                message = "The product is still in the catalog.";
                backUrl = "admin_products.jsp"; backLabel = "Back to Products";
                causes = new String[] {
                        "The product is still referenced by customer carts or past orders.",
                        "The database could not be reached."
                };
                break;
            case "failedToAddCategory":
                title = "Couldn't add the category";
                message = "The new category was not saved.";
                backUrl = "admin_categories.jsp"; backLabel = "Back to Categories";
                causes = categoryCauses;
                break;
            case "categoryAlreadyExists":
                title = "Category already exists";
                message = "A category with this name is already in the system, so nothing was added.";
                backUrl = "admin_categories.jsp"; backLabel = "Back to Categories";
                causes = duplicateCauses;
                break;
            case "failedToUpdateCategory":
                title = "Couldn't update the category";
                message = "Your changes to this category were not saved.";
                backUrl = "admin_categories.jsp"; backLabel = "Back to Categories";
                causes = categoryCauses;
                break;
            case "failedToDeleteCategory":
                title = "Couldn't delete the category";
                message = "The category and its products are still in the catalog.";
                backUrl = "admin_categories.jsp"; backLabel = "Back to Categories";
                causes = new String[] {
                        "Products in this category are still referenced by past orders.",
                        "The database could not be reached."
                };
                break;
            default:
                break;
        }
    }

    if (serverError) {
        causes = new String[] {
                "The server hit an unexpected error while processing the form.",
                "A field may contain an invalid value. Make sure a category is selected and price and quantity are numbers.",
                "If it keeps happening, check the Tomcat logs (catalina.out) for the stack trace."
        };
    }
%>
<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>

<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>

    <main class="grid place-items-center p-4 py-12 sm:p-8 sm:py-20">
        <div class="card w-full max-w-lg overflow-hidden">
            <div class="h-1.5 bg-red-500"></div>
            <div class="p-8 text-center">
                <span class="mx-auto grid size-16 place-items-center rounded-full bg-red-50 text-3xl text-red-600">
                    <i class="uil uil-exclamation-triangle"></i>
                </span>
                <h1 class="mt-5 text-2xl font-bold"><%= title %></h1>
                <p class="mt-2 text-slate-600"><%= message %></p>
                <% if (serverError) { %>
                <p class="mt-3 inline-block rounded-full bg-red-50 px-3 py-1 text-xs font-medium text-red-700">Server error</p>
                <% } %>
            </div>

            <div class="border-t border-slate-100 bg-slate-50 px-8 py-5">
                <p class="text-sm font-semibold text-slate-700">What might have caused this</p>
                <ul class="mt-2 list-disc space-y-1 pl-5 text-sm text-slate-600">
                    <% for (String cause : causes) { %>
                    <li><%= cause %></li>
                    <% } %>
                </ul>
            </div>

            <div class="flex flex-col gap-3 p-6 sm:flex-row">
                <button type="button" onclick="history.back()" class="btn btn-primary flex-1"><i class="uil uil-redo"></i> Try again</button>
                <a href="<%= backUrl %>" class="btn btn-outline flex-1"><%= backLabel %></a>
            </div>
        </div>
    </main>
</section>

<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>
