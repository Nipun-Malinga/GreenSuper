package org.example.greensuper.models;

import java.time.LocalDate;

public class Order {
    private int billId;
    private int customerId;
    private LocalDate date;
    private double billTotal;
    private String status;

    public Order() {

    }

    public Order(int billId, int customerId, LocalDate date, double billTotal, String status) {
        this.billId = billId;
        this.customerId = customerId;
        this.date = date;
        this.billTotal = billTotal;
        this.status = status;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public void setBillTotal(double billTotal) {
        this.billTotal = billTotal;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getBillId() {
        return billId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public LocalDate getDate() {
        return date;
    }

    public double getBillTotal() {
        return billTotal;
    }

    public String getStatus() {
        return status;
    }
}
