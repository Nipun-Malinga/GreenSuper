package org.example.greensuper.servlets.admin.product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.greensuper.dao.AlreadyExistsException;
import org.example.greensuper.dao.ImageDao;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.Image;
import org.example.greensuper.models.Product;
import org.example.greensuper.utils.FileHandling;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/productManagement")
@MultipartConfig
public class ProductManagementServlet extends HttpServlet {
    ProductDao productDao = new ProductDao();
    ImageDao imageDao = new ImageDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if(session.getAttribute("adminAuth") != null) {
            PrintWriter writer = resp.getWriter();
            FileHandling handling = new FileHandling();
            Product product = new Product();
            Image image = new Image();
            String uploadPath = System.getenv("IMAGE_UPLOAD_PATH") + "/product";

            String operation = req.getParameter("operation");

            switch (operation) {
                case "add":
                    String productName = req.getParameter("product");
                    String description = req.getParameter("description");
                    double price = Double.parseDouble(req.getParameter("price"));
                    int quantity = Integer.parseInt(req.getParameter("quantity"));
                    int categoryId = Integer.parseInt(req.getParameter("category"));
                    Part productImage = req.getPart("image");

                    boolean isInStock = quantity > 0;

                    String imageName = handling.getFileName(productImage);

                    product.setProductName(productName == null ? null : productName.trim());
                    product.setDescription(description);
                    product.setPrice(price);
                    product.setQuantity(quantity);
                    product.setInStock(isInStock);
                    product.setCategoryId(categoryId);

                    image.setImageName(imageName);

                    try {
                        if (productDao.addProduct(product, image) && handling.moveFile(uploadPath, productImage)) {
                            writer.write("productAddedSuccessfully");
                        } else {
                            writer.write("failedToAddProduct");
                        }
                    } catch (AlreadyExistsException e) {
                        // admin_forms.js routes this token to admin_failed.jsp
                        writer.write("productAlreadyExists");
                    }
                    break;
                case "update":
                    int update_product_id = Integer.parseInt(req.getParameter("productId"));
                    String updated_product_name = req.getParameter("productName");
                    double updated_price = Double.parseDouble(req.getParameter("price"));
                    int update_categoryId = Integer.parseInt(req.getParameter("category"));
                    int updated_quantity = Integer.parseInt(req.getParameter("quantity"));
                    Part updated_image = req.getPart("image");
                    String updated_description = req.getParameter("description");

                    String update_image_name = handling.getFileName(updated_image);

                    product.setProductId(update_product_id);
                    product.setProductName(updated_product_name);
                    product.setPrice(updated_price);
                    product.setQuantity(updated_quantity);
                    product.setCategoryId(update_categoryId);
                    product.setImageName(update_image_name);
                    product.setDescription(updated_description);

                    if (handling.isFileSelected(updated_image)) {
                        if (productDao.updateProduct(product) && handling.moveFile(uploadPath, updated_image)) {
                            writer.write("productUpdated");
                        } else {
                            writer.write("productFailedToUpdate");
                        }
                    } else {
                        String current_image_name = req.getParameter("productImageName");
                        product.setImageName(current_image_name);

                        if (productDao.updateProduct(product)) {
                            writer.write("productUpdated");
                        } else {
                            writer.write("productFailedToUpdate");
                        }
                    }

                    break;
                case "delete":
                    int deleteProductID = Integer.parseInt(req.getParameter("productId"));

                    product.setProductId(deleteProductID);

                    // Read the image name before the row is deleted.
                    String productImageName = productDao.getSingleProduct(deleteProductID).getImageName();

                    if (productDao.removeProduct(product)) {
                        deleteUnusedImage(uploadPath, productImageName, handling);
                        writer.write("productDeleted");
                        resp.sendRedirect("admin_products.jsp");
                    } else {
                        writer.write("failedToDeleteProduct");
                    }
                    break;
            }
        } else {
            resp.sendRedirect("./admin_login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendRedirect("./admin_login.jsp");
    }

    // Removes the file unless another image row still points at the same file name.
    private void deleteUnusedImage(String path, String imageName, FileHandling handling) {
        if (imageName != null && !imageDao.isImageInUse(imageName)) {
            handling.deleteFile(path, imageName);
        }
    }
}
