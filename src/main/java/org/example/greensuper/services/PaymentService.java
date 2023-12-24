package org.example.greensuper.services;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import java.util.ArrayList;
import java.util.List;

public class PaymentService {
    private static final String MODE = "sandbox";

    public static APIContext getAPIContext() {
        return new APIContext(PaypalConfig.Client_ID, PaypalConfig.Client_Secret, MODE);
    }

    public static Payment createPayment(double total, String currency, String method, String intent, String description,
                                        String cancelUrl, String successUrl) throws PayPalRESTException {
        Amount amount = new Amount();
        amount.setCurrency(currency);
        amount.setTotal(String.format("%.2f", total));

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription(description);

        List<Transaction> transactions = new ArrayList<>();
        transactions.add(transaction);

        Payer payer = new Payer();
        payer.setPaymentMethod(method);

        Payment payment = new Payment();
        payment.setIntent(intent);
        payment.setPayer(payer);
        payment.setTransactions(transactions);
        payment.setRedirectUrls(new RedirectUrls().setCancelUrl(cancelUrl).setReturnUrl(successUrl));

        return payment.create(getAPIContext());
    }

    public static Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
        Payment payment = new Payment().setId(paymentId);
        PaymentExecution paymentExecution = new PaymentExecution().setPayerId(payerId);
        return payment.execute(getAPIContext(), paymentExecution);
    }

}
