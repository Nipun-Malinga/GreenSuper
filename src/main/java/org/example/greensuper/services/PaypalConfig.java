package org.example.greensuper.services;

public class PaypalConfig {
    public static final String Client_ID = System.getenv("PAYPAL_CLIENT_ID");
    public static final String Client_Secret = System.getenv("PAYPAL_CLIENT_SECRET");
    public static final String MODE = System.getenv("PAYMENT_MODE");
}