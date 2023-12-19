package org.example.greensuper.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.Category;

import java.io.IOException;

@WebServlet("/productView")
public class ProductView extends HttpServlet {
    ProductDao productDao = new ProductDao();
    Category category = new Category();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(req.getParameter("categoryId") != null) {
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            String redirectUrl = "product.jsp?categoryId=" + categoryId;
            HttpSession session = req.getSession();
            category.setCategoryId(categoryId);
            session.setAttribute("product", productDao.fetchAllProducts(category));
            resp.getWriter().write(redirectUrl);
            System.out.println(categoryId);
        }
    }
}
