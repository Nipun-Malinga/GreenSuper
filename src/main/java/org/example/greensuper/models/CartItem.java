package org.example.greensuper.models;

public class CartItem {
    private int cartItemId;
    private int cartId;
    private int productId;
    private String productName;
    private double price;
    private int quantity;
    private int boughtQuantity;
    private String imageName;

    public CartItem() {
    }

    public CartItem(int cartItemId, int cartId, int productId, String productName, double price, int quantity, int boughtQuantity, String imageName) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.boughtQuantity = boughtQuantity;
        this.imageName = imageName;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setBoughtQuantity(int boughtQuantity) {
        this.boughtQuantity = boughtQuantity;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public int getCartId() {
        return cartId;
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getBoughtQuantity() {
        return boughtQuantity;
    }

    public String getImageName() {
        return imageName;
    }
}
