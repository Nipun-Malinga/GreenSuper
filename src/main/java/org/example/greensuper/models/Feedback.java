package org.example.greensuper.models;

import java.sql.Date;
import java.time.LocalDate;

public class Feedback {
    private int feedback_id;
    private int customer_id;
    private String customer_name;
    private int bill_id;
    private LocalDate feedback__date;
    private String feedback;

    public Feedback() {
    }

    public Feedback(int feedback_id, int customer_id, String customer_name, int bill_id, LocalDate feedback__date, String feedback) {
        this.feedback_id = feedback_id;
        this.customer_id = customer_id;
        this.customer_name = customer_name;
        this.bill_id = bill_id;
        this.feedback__date = feedback__date;
        this.feedback = feedback;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public void setBill_id(int bill_id) {
        this.bill_id = bill_id;
    }

    public void setFeedback__date(LocalDate feedback__date) {
        this.feedback__date = feedback__date;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public int getFeedback_id() {
        return feedback_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public int getBill_id() {
        return bill_id;
    }

    public LocalDate getFeedback__date() {
        return feedback__date;
    }

    public String getFeedback() {
        return feedback;
    }
}
