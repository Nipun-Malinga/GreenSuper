package org.example.greensuper.servlets.admin.category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.greensuper.dao.CategoryDao;
import org.example.greensuper.models.Category;
import org.example.greensuper.models.Image;
import org.example.greensuper.utils.FileHandling;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/categoryManagement")
@MultipartConfig
public class CategoryManagementServlet extends HttpServlet {
    CategoryDao categoryDao = new CategoryDao();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter writer = resp.getWriter();
        FileHandling handling = new FileHandling();
        Category category = new Category();
        Image image = new Image();

        String operation = req.getParameter("operation");

        switch (operation) {
            case "add":
                String newCategory = req.getParameter("category");
                Part categoryImage = req.getPart("image");

                String imageName = handling.getFileName(categoryImage);
                String uploadPath = "D:\\University\\Projects\\Java\\Practices\\GreenSuper\\src\\main\\webapp\\uploadedImages\\category";

                category.setCategoryType(newCategory);

                image.setImageName(imageName);

                if(categoryDao.addCategory(category, image) && handling.moveFile(uploadPath, categoryImage)) {
                    writer.write("categoryAddedSuccessfully");
                } else {
                    writer.write("failedToAddCategory");
                }
                break;
            case "update":
                break;
            case "delete":
                int categoryId = Integer.parseInt(req.getParameter("categoryId"));

                System.out.println(operation);
                System.out.println(categoryId);
                category.setCategoryId(categoryId);

                if(categoryDao.removeCategory(category)) {
                    writer.write("categoryDeleted");
                    resp.sendRedirect("admin_categories.jsp");
                } else {
                    writer.write("failedToDeleteCategory");
                    System.out.println("Failed to delete category");
                }
                break;
        }
    }

}
