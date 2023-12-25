package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.CategoryDao;

import java.io.IOException;

@WebServlet("/mainView")
public class MainViewServlet extends HttpServlet {
    CategoryDao categoryDao = new CategoryDao();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("categories", categoryDao.fetchAllCategories());
        resp.sendRedirect("index.jsp");
    }
}
