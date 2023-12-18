package org.example.greensuper.servlets.admin.category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
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
                    writer.write("productAddedSuccessfully");
                } else {
                    writer.write("failedToAddProduct");
                }
                break;
            case "update":
                break;
            case "delete":
                break;
            case "view":
                break;
        }
    }

}
