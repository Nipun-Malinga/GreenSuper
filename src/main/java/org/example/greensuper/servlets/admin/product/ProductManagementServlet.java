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
                String uploadPath = "D:\\University\\Projects\\Java\\Practices\\GreenSuper\\src\\main\\webapp\\uploadedImages\\product";

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
                break;
            case "delete":
                break;
            case "view":
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.setAttribute("category", categoryDao.fetchAllCategories());
        resp.sendRedirect("productManagement.jsp");
    }

}
