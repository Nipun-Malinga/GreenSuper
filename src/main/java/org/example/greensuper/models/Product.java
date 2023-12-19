package org.example.greensuper.models;

public class Product {
    private int productId;
    private int categoryId;
    private String productName;
    private String description;
    private double price;
    private int quantity;
    private boolean isInStock;
    private String imageName;

    public Product() {
    }

    public Product(int productId, int categoryId, String productName, String description, double price, int quantity, boolean isInStock, String imageName) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.isInStock = isInStock;
        this.imageName = imageName;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setInStock(boolean inStock) {
        isInStock = inStock;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public int getProductId() {
        return productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public boolean isInStock() {
        return isInStock;
    }

    public String getImageName() {
        return imageName;
    }
}
