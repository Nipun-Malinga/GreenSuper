package org.example.greensuper.models;

public class Feedback {
    private int feedback_id;
    private int customer_id;
    private String feedback;

    public Feedback() {
    }

    public Feedback(int feedback_id, int customer_id, String feedback) {
        this.feedback_id = feedback_id;
        this.customer_id = customer_id;
        this.feedback = feedback;
    }

    public void setFeedback_id(int feedback_id) {
        this.feedback_id = feedback_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
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

    public String getFeedback() {
        return feedback;
    }
}
