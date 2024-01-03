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
        HttpSession session = req.getSession();
        if(session.getAttribute("adminAuth") != null) {
            PrintWriter writer = resp.getWriter();
            FileHandling handling = new FileHandling();
            Category category = new Category();
            Image image = new Image();

            String uploadPath = "D:\\University\\Projects\\Java\\Practices\\GreenSuper\\src\\main\\webapp\\uploadedImages\\category";
            String operation = req.getParameter("operation");

            switch (operation) {
                case "add":
                    String newCategory = req.getParameter("category");
                    Part categoryImage = req.getPart("image");

                    String imageName = handling.getFileName(categoryImage);

                    category.setCategoryType(newCategory);
                    image.setImageName(imageName);

                    if (categoryDao.addCategory(category, image) && handling.moveFile(uploadPath, categoryImage)) {
                        writer.write("categoryAddedSuccessfully");
                    } else {
                        writer.write("failedToAddCategory");
                    }
                    break;
                case "update":
                    int update_categoryId = Integer.parseInt(req.getParameter("categoryId"));
                    String update_categoryName = req.getParameter("categoryName");
                    Part update_image = req.getPart("category-image");

                    category.setCategoryId(update_categoryId);
                    category.setCategoryType(update_categoryName);

                    if (handling.isFileSelected(update_image)) {
                        String update_imageName = handling.getFileName(update_image);
                        category.setImageName(update_imageName);

                        if (categoryDao.updateCategory(category) && handling.moveFile(uploadPath, update_image)) {
                            writer.write("categoryUpdated");
                        } else {
                            writer.write("failedToUpdateCategory");
                        }
                    } else {
                        String image_name = req.getParameter("category_imageName");
                        category.setImageName(image_name);
                        System.out.println("Ppp" + image_name);

                        if (categoryDao.updateCategory(category)) {
                            writer.write("categoryUpdated");
                        } else {
                            writer.write("failedToUpdateCategory");
                        }
                    }

                    break;
                case "delete":
                    int categoryId = Integer.parseInt(req.getParameter("categoryId"));

                    System.out.println(operation);
                    System.out.println(categoryId);
                    category.setCategoryId(categoryId);

                    if (categoryDao.removeCategory(category)) {
                        writer.write("categoryDeleted");
                        resp.sendRedirect("admin_categories.jsp");
                    } else {
                        writer.write("failedToDeleteCategory");
                        System.out.println("Failed to delete category");
                    }
                    break;
            }
        } else {
            resp.sendRedirect("./admin_login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("./admin_login.jsp");
    }
}
