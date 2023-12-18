package org.example.greensuper.models;

public class CartItem {
    private int cartItemId;
    private int cartId;
    private int productId;
    private int boughtQuantity;

    public CartItem() {
    }

    public CartItem(int cartItemId, int cartId, int productId, int boughtQuantity) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.productId = productId;
        this.boughtQuantity = boughtQuantity;
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

    public void setBoughtQuantity(int boughtQuantity) {
        this.boughtQuantity = boughtQuantity;
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

    public int getBoughtQuantity() {
        return boughtQuantity;
    }

}
