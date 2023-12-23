package org.example.greensuper.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.Category;

import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    ProductDao productDao = new ProductDao();
    Category category = new Category();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if(req.getParameter("categoryId") != null) {
            category.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));

            session.setAttribute("product", productDao.fetchProducts(category));
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("product.jsp");
            requestDispatcher.forward(req, resp);
        }
    }
}
