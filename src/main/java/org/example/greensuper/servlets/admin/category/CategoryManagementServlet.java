package org.example.greensuper.servlets.admin.category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.greensuper.dao.CategoryDao;
import org.example.greensuper.dao.AlreadyExistsException;
import org.example.greensuper.dao.ImageDao;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.Category;
import org.example.greensuper.models.Image;
import org.example.greensuper.models.Product;
import org.example.greensuper.utils.FileHandling;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/categoryManagement")
@MultipartConfig
public class CategoryManagementServlet extends HttpServlet {
    CategoryDao categoryDao = new CategoryDao();
    ProductDao productDao = new ProductDao();
    ImageDao imageDao = new ImageDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if(session.getAttribute("adminAuth") != null) {
            PrintWriter writer = resp.getWriter();
            FileHandling handling = new FileHandling();
            Category category = new Category();
            Image image = new Image();

            String uploadPath = System.getenv("IMAGE_UPLOAD_PATH") + "/category";
            String operation = req.getParameter("operation");

            switch (operation) {
                case "add":
                    String newCategory = req.getParameter("category");
                    Part categoryImage = req.getPart("image");

                    category.setCategoryType(newCategory == null ? null : newCategory.trim());

                    // Save the image as "<category name>.<ext>" both in the DB and in the upload folder.
                    String imageName = handling.buildFileName(category.getCategoryType(), categoryImage);
                    image.setImageName(imageName);

                    try {
                        // Rows first: the duplicate-name check must run before the file is written,
                        // otherwise a duplicate would overwrite the existing category's image.
                        int newCategoryId = categoryDao.addCategory(category, image);
                        if (handling.moveFile(uploadPath, categoryImage, imageName)) {
                            writer.write("categoryAddedSuccessfully");
                        } else {
                            // Don't leave a category pointing at an image file that doesn't exist.
                            category.setCategoryId(newCategoryId);
                            categoryDao.removeCategory(category);
                            writer.write("failedToAddCategory");
                        }
                    } catch (AlreadyExistsException e) {
                        // admin_forms.js routes this token to admin_failed.jsp
                        writer.write("categoryAlreadyExists");
                    }
                    break;
                case "update":
                    int update_categoryId = Integer.parseInt(req.getParameter("categoryId"));
                    String update_categoryName = req.getParameter("categoryName");
                    Part update_image = req.getPart("category-image");

                    category.setCategoryId(update_categoryId);
                    category.setCategoryType(update_categoryName);

                    if (handling.isFileSelected(update_image)) {
                        String update_imageName = handling.buildFileName(update_categoryName, update_image);
                        category.setImageName(update_imageName);

                        if (categoryDao.updateCategory(category) && handling.moveFile(uploadPath, update_image, update_imageName)) {
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

                    // Read the image names before the rows are deleted.
                    String categoryImageName = categoryDao.getCategory(categoryId).getImageName();
                    List<Product> categoryProducts = productDao.getProducts(category);

                    if (categoryDao.removeCategory(category)) {
                        deleteUnusedImage(uploadPath, categoryImageName, handling);
                        String productUploadPath = System.getenv("IMAGE_UPLOAD_PATH") + "/product";
                        for (Product categoryProduct : categoryProducts) {
                            deleteUnusedImage(productUploadPath, categoryProduct.getImageName(), handling);
                        }
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

    // Removes the file unless another image row still points at the same file name.
    private void deleteUnusedImage(String path, String imageName, FileHandling handling) {
        if (imageName != null && !imageDao.isImageInUse(imageName)) {
            handling.deleteFile(path, imageName);
        }
    }
}
