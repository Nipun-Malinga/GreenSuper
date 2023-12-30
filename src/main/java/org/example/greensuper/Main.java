package org.example.greensuper;

import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Feedback;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        UserDao userDao = new UserDao();
        List<Feedback> feedbackList = userDao.getAllCustomerFeedbacks();

        for(var feedback :  feedbackList) {
            System.out.println(feedback.getFeedback_id());
        }
    }
}