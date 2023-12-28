package org.example.greensuper.models;

import java.sql.Date;
import java.time.LocalDate;

public class Feedback {
    private int feedback_id;
    private int customer_id;
    private int bill_id;
    private String feedback;
    private LocalDate feedback__date;

    public Feedback() {
    }

    public Feedback(int feedback_id, int customer_id, String feedback, LocalDate feedback__date) {
        this.feedback_id = feedback_id;
        this.customer_id = customer_id;
//        this.bill_id = bill_id;
        this.feedback = feedback;
        this.feedback__date = feedback__date;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setBill_id(int bill_id) {
        this.bill_id = bill_id;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public void setFeedback__date(LocalDate feedback__date) {
        this.feedback__date = feedback__date;
    }

    public int getFeedback_id() {
        return feedback_id;
    }

    public int getBill_id() {
        return bill_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public String getFeedback() {
        return feedback;
    }

    public LocalDate getFeedback__date() {
        return feedback__date;
    }
}
