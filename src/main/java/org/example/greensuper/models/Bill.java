package org.example.greensuper.models;

public class Bill {
    private int billId;

    public Bill() {

    }

    public Bill(int billId) {
        this.billId = billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getBillId() {
        return billId;
    }
}
