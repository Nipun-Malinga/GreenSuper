package org.example.greensuper.servlets.admin.product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.greensuper.dao.CategoryDao;
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
    CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter writer = resp.getWriter();
        FileHandling handling = new FileHandling();
        Product product = new Product();
        Image image = new Image();
        String uploadPath = "D:\\University\\Projects\\Java\\Practices\\GreenSuper\\src\\main\\webapp\\uploadedImages\\product";

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

                System.out.println(productName + "\n" + description + "\n" + price + "\n" + quantity + "\n" + categoryId);

                String imageName = handling.getFileName(productImage);

                product.setProductName(productName);
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setInStock(isInStock);
                product.setCategoryId(categoryId);

                image.setImageName(imageName);

                if(productDao.addProduct(product, image) && handling.moveFile(uploadPath, productImage)) {
                    writer.write("productAddedSuccessfully");
                } else {
                    writer.write("failedToAddProduct");
                }
                break;
            case "update":
                String updated_product_name = req.getParameter("productName");
                String updated_description = req.getParameter("description");
                int updated_price = Integer.parseInt(req.getParameter("price"));
                int updated_quantity = Integer.parseInt(req.getParameter("quantity"));
                Part updated_image = req.getPart("image");

                String update_image_name = handling.getFileName(updated_image);

                product.setProductName(updated_product_name);
                product.setDescription(updated_description);
                product.setPrice(updated_price);
                product.setQuantity(updated_quantity);
                product.setImageName(update_image_name);

                if(productDao.updateProduct(product) && handling.moveFile(uploadPath, updated_image)) {
                    writer.write("productUpdated");
                } else {
                    writer.write("productFailedToUpdate");
                }
                break;
            case "delete":
                int deleteProductID = Integer.parseInt(req.getParameter("productId"));

                product.setProductId(deleteProductID);

                if(productDao.removeProduct(product)) {
                    writer.write("productDeleted");
                } else {
                    writer.write("failedToDeleteProduct");
                }
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("category", categoryDao.fetchAllCategories());
        resp.sendRedirect("productManagement.jsp");
    }

}
