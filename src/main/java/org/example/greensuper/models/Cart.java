package org.example.greensuper.models;

public class Cart {
    private int cartId;
    private int customerId;
    private double totalPrice;

    public Cart() {
    }

    public Cart(int cartId, int customerId, double totalPrice) {
        this.cartId = cartId;
        this.customerId = customerId;
        this.totalPrice = totalPrice;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getCartId() {
        return cartId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
}
