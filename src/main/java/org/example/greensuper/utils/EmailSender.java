package org.example.greensuper.utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Customer;

import java.util.List;
import java.util.Properties;
import java.time.LocalDate;

public class EmailSender {
    private final String senderEmail = "nipunmalinga11@gmail.com";
    Customer customer = new Customer();
    UserDao userDao = new UserDao();

    private double cartPrice;

    private Properties emailServer() {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", 587);

        return properties;
    }

    Session session = Session.getInstance(emailServer(), new Authenticator() {
        @Override
        protected PasswordAuthentication getPasswordAuthentication() {
            String password = "wmxsfdexhxzugetr";
            return new PasswordAuthentication(senderEmail, password);
        }
    });

    public void sendEmail(String reviverEmail, List<CartItem> cartItemList, double cartPrice) {
        customer = userDao.getCustomerDetails(reviverEmail);
        this.cartPrice = cartPrice;
        System.out.println(cartPrice);

        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(reviverEmail));

            String emailPart_02 = null;
            for (var item : cartItemList) {
                emailPart_02 += "                  <tr>\n" +
                        "                    <td class=\"item-col item\">\n" +
                        "                      <table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">\n" +
                        "                        <tr>\n" +
                        "                          <td class=\"product\">\n" +
                        "                            <span style=\"color: #4d4d4d; font-weight:bold;\">" + item.getProductName() + "</span> <br />\n" +
                        "                          </td>\n" +
                        "                        </tr>\n" +
                        "                      </table>\n" +
                        "                    </td>\n" +
                        "                    <td class=\"item-col quantity\">\n" +
                                                item.getBoughtQuantity() +
                        "                    </td>\n" +
                        "                    <td class=\"item-col\">\n" +
                                                item.getPrice() +
                        "                    </td>\n" +
                        "                  </tr>";
            }

            String massage = emailPart_01() + emailPart_02 + emailPart_03();

            message.setSubject("Green Super");

            message.setContent(massage, "text/html");
            Transport.send(message);

            System.out.println("Massage Send Successfully");

        } catch (MessagingException e) {
            System.out.println("Failed to end a massage");
            throw new RuntimeException(e);
        }
    }


//Main Email Content//
    private String emailPart_01() {
        LocalDate localDate = LocalDate.now();

        return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n" +
                "<head>\n" +
                "  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />\n" +
                "  <title>Oxygen Invoice</title>\n" +
                "\n" +
                "  <style type=\"text/css\">\n" +
                "    /* Take care of image borders and formatting, client hacks */\n" +
                "    img { max-width: 600px; outline: none; text-decoration: none; -ms-interpolation-mode: bicubic;}\n" +
                "    a img { border: none; }\n" +
                "    table { border-collapse: collapse !important;}\n" +
                "    #outlook a { padding:0; }\n" +
                "    .ReadMsgBody { width: 100%; }\n" +
                "    .ExternalClass { width: 100%; }\n" +
                "    .backgroundTable { margin: 0 auto; padding: 0; width: 100% !important; }\n" +
                "    table td { border-collapse: collapse; }\n" +
                "    .ExternalClass * { line-height: 115%; }\n" +
                "    .container-for-gmail-android { min-width: 600px; }\n" +
                "\n" +
                "\n" +
                "    /* General styling */\n" +
                "    * {\n" +
                "      font-family: Helvetica, Arial, sans-serif;\n" +
                "    }\n" +
                "\n" +
                "    body {\n" +
                "      -webkit-font-smoothing: antialiased;\n" +
                "      -webkit-text-size-adjust: none;\n" +
                "      width: 100% !important;\n" +
                "      margin: 0 !important;\n" +
                "      height: 100%;\n" +
                "      color: #676767;\n" +
                "    }\n" +
                "\n" +
                "    td {\n" +
                "      font-family: Helvetica, Arial, sans-serif;\n" +
                "      font-size: 14px;\n" +
                "      color: #777777;\n" +
                "      text-align: center;\n" +
                "      line-height: 21px;\n" +
                "    }\n" +
                "\n" +
                "    a {\n" +
                "      color: #676767;\n" +
                "      text-decoration: none !important;\n" +
                "    }\n" +
                "\n" +
                "    .pull-left {\n" +
                "      text-align: left;\n" +
                "    }\n" +
                "\n" +
                "    .pull-right {\n" +
                "      text-align: right;\n" +
                "    }\n" +
                "\n" +
                "    .header-lg,\n" +
                "    .header-md,\n" +
                "    .header-sm {\n" +
                "      font-size: 32px;\n" +
                "      font-weight: 700;\n" +
                "      line-height: normal;\n" +
                "      padding: 35px 0 0;\n" +
                "      color: #4d4d4d;\n" +
                "    }\n" +
                "\n" +
                "    .header-md {\n" +
                "      font-size: 24px;\n" +
                "    }\n" +
                "\n" +
                "    .header-sm {\n" +
                "      padding: 5px 0;\n" +
                "      font-size: 18px;\n" +
                "      line-height: 1.3;\n" +
                "    }\n" +
                "\n" +
                "    .content-padding {\n" +
                "      padding: 20px 0 5px;\n" +
                "    }\n" +
                "\n" +
                "    .mobile-header-padding-right {\n" +
                "      width: 290px;\n" +
                "      text-align: right;\n" +
                "      padding-left: 10px;\n" +
                "    }\n" +
                "\n" +
                "    .mobile-header-padding-left {\n" +
                "      width: 290px;\n" +
                "      text-align: left;\n" +
                "      padding-left: 10px;\n" +
                "    }\n" +
                "\n" +
                "    .free-text {\n" +
                "      width: 100% !important;\n" +
                "      padding: 10px 60px 0px;\n" +
                "    }\n" +
                "\n" +
                "    .button {\n" +
                "      padding: 30px 0;\n" +
                "    }\n" +
                "\n" +
                "    .mini-block {\n" +
                "      border: 1px solid #e5e5e5;\n" +
                "      border-radius: 5px;\n" +
                "      background-color: #ffffff;\n" +
                "      padding: 12px 15px 15px;\n" +
                "      text-align: left;\n" +
                "      width: 253px;\n" +
                "    }\n" +
                "\n" +
                "    .mini-container-left {\n" +
                "      width: 278px;\n" +
                "      padding: 10px 0 10px 15px;\n" +
                "    }\n" +
                "\n" +
                "    .mini-container-right {\n" +
                "      width: 278px;\n" +
                "      padding: 10px 14px 10px 15px;\n" +
                "    }\n" +
                "\n" +
                "    .product {\n" +
                "      text-align: left;\n" +
                "      vertical-align: top;\n" +
                "      width: 175px;\n" +
                "    }\n" +
                "\n" +
                "    .total-space {\n" +
                "      padding-bottom: 8px;\n" +
                "      display: inline-block;\n" +
                "    }\n" +
                "\n" +
                "    .item-table {\n" +
                "      padding: 50px 20px;\n" +
                "      width: 560px;\n" +
                "    }\n" +
                "\n" +
                "    .item {\n" +
                "      width: 300px;\n" +
                "    }\n" +
                "\n" +
                "    .mobile-hide-img {\n" +
                "      text-align: left;\n" +
                "      width: 125px;\n" +
                "    }\n" +
                "\n" +
                "    .mobile-hide-img img {\n" +
                "      border: 1px solid #e6e6e6;\n" +
                "      border-radius: 4px;\n" +
                "    }\n" +
                "\n" +
                "    .title-dark {\n" +
                "      text-align: left;\n" +
                "      border-bottom: 1px solid #cccccc;\n" +
                "      color: #4d4d4d;\n" +
                "      font-weight: 700;\n" +
                "      padding-bottom: 5px;\n" +
                "    }\n" +
                "\n" +
                "    .item-col {\n" +
                "      padding-top: 20px;\n" +
                "      text-align: left;\n" +
                "      vertical-align: top;\n" +
                "    }\n" +
                "\n" +
                "    .force-width-gmail {\n" +
                "      min-width:600px;\n" +
                "      height: 0px !important;\n" +
                "      line-height: 1px !important;\n" +
                "      font-size: 1px !important;\n" +
                "    }\n" +
                "\n" +
                "  </style>\n" +
                "\n" +
                "  <style type=\"text/css\" media=\"screen\">\n" +
                "    @import url(http://fonts.googleapis.com/css?family=Oxygen:400,700);\n" +
                "  </style>\n" +
                "\n" +
                "  <style type=\"text/css\" media=\"screen\">\n" +
                "    @media screen {\n" +
                "      /* Thanks Outlook 2013! */\n" +
                "      * {\n" +
                "        font-family: 'Oxygen', 'Helvetica Neue', 'Arial', 'sans-serif' !important;\n" +
                "      }\n" +
                "    }\n" +
                "  </style>\n" +
                "\n" +
                "  <style type=\"text/css\" media=\"only screen and (max-width: 480px)\">\n" +
                "    /* Mobile styles */\n" +
                "    @media only screen and (max-width: 480px) {\n" +
                "\n" +
                "      table[class*=\"container-for-gmail-android\"] {\n" +
                "        min-width: 290px !important;\n" +
                "        width: 100% !important;\n" +
                "      }\n" +
                "\n" +
                "      img[class=\"force-width-gmail\"] {\n" +
                "        display: none !important;\n" +
                "        width: 0 !important;\n" +
                "        height: 0 !important;\n" +
                "      }\n" +
                "\n" +
                "      table[class=\"w320\"] {\n" +
                "        width: 320px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class*=\"mobile-header-padding-left\"] {\n" +
                "        width: 160px !important;\n" +
                "        padding-left: 0 !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class*=\"mobile-header-padding-right\"] {\n" +
                "        width: 160px !important;\n" +
                "        padding-right: 0 !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class=\"header-lg\"] {\n" +
                "        font-size: 24px !important;\n" +
                "        padding-bottom: 5px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class=\"content-padding\"] {\n" +
                "        padding: 5px 0 5px !important;\n" +
                "      }\n" +
                "\n" +
                "       td[class=\"button\"] {\n" +
                "        padding: 5px 5px 30px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class*=\"free-text\"] {\n" +
                "        padding: 10px 18px 30px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class~=\"mobile-hide-img\"] {\n" +
                "        display: none !important;\n" +
                "        height: 0 !important;\n" +
                "        width: 0 !important;\n" +
                "        line-height: 0 !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class~=\"item\"] {\n" +
                "        width: 140px !important;\n" +
                "        vertical-align: top !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class~=\"quantity\"] {\n" +
                "        width: 50px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class~=\"price\"] {\n" +
                "        width: 90px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class=\"item-table\"] {\n" +
                "        padding: 30px 20px !important;\n" +
                "      }\n" +
                "\n" +
                "      td[class=\"mini-container-left\"],\n" +
                "      td[class=\"mini-container-right\"] {\n" +
                "        padding: 0 15px 15px !important;\n" +
                "        display: block !important;\n" +
                "        width: 290px !important;\n" +
                "      }\n" +
                "\n" +
                "    }\n" +
                "  </style>\n" +
                "</head>\n" +
                "\n" +
                "<body bgcolor=\"#f7f7f7\">\n" +
                "<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"container-for-gmail-android\" width=\"100%\">\n" +
                "  <tr>\n" +
                "    <td align=\"left\" valign=\"top\" width=\"100%\" style=\"background:repeat-x url(https://d1ergv6ync1qqr.cloudfront.net/4E687TRe69Ld95IDWyEg_bg_top_02.jpg) #ffffff;\">\n" +
                "      <center>\n" +
                "      <img src=\"https://d1ergv6ync1qqr.cloudfront.net/SBb2fQPrQ5ezxmqUTgCr_transparent.png\" class=\"force-width-gmail\">\n" +
                "        <table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" bgcolor=\"#ffffff\" background=\"https://d1ergv6ync1qqr.cloudfront.net/4E687TRe69Ld95IDWyEg_bg_top_02.jpg\" style=\"background-color:transparent\">\n" +
                "          <tr>\n" +
                "            <td width=\"100%\" height=\"80\" valign=\"top\" style=\"text-align: center; vertical-align:middle;\">\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </table>\n" +
                "      </center>\n" +
                "    </td>\n" +
                "  </tr>\n" +
                "  <tr>\n" +
                "    <td align=\"center\" valign=\"top\" width=\"100%\" style=\"background-color: #f7f7f7;\" class=\"content-padding\">\n" +
                "      <center>\n" +
                "        <table cellspacing=\"0\" cellpadding=\"0\" width=\"600\" class=\"w320\">\n" +
                "          <tr>\n" +
                "            <td class=\"header-lg\">\n" +
                "              Thank you for your order!\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "          <tr>\n" +
                "            <td class=\"w320\">\n" +
                "              <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n" +
                "                <tr>\n" +
                "                  <td class=\"mini-container-left\">\n" +
                "                    <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n" +
                "                      <tr>\n" +
                "                        <td class=\"mini-block-padding\">\n" +
                "                          <table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"border-collapse:separate !important;\">\n" +
                "                            <tr>\n" +
                "                              <td class=\"mini-block\">\n" +
                "                                <span class=\"header-sm\">Your Address</span><br />\n" +
                "                                " + customer.getHomeNumber() + "<br>" +
                "                                " + customer.getStreetName() + "<br>" +
                "                                " + customer.getCity() +
                "                              </td>\n" +
                "                            </tr>\n" +
                "                          </table>\n" +
                "                        </td>\n" +
                "                      </tr>\n" +
                "                    </table>\n" +
                "                  </td>\n" +
                "                  <td class=\"mini-container-right\">\n" +
                "                    <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n" +
                "                      <tr>\n" +
                "                        <td class=\"mini-block-padding\">\n" +
                "                          <table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" style=\"border-collapse:separate !important;\">\n" +
                "                            <tr>\n" +
                "                              <td class=\"mini-block\">\n" +
                "                                <span class=\"header-sm\">Date Ordered</span><br />\n" +
                "                                 "+ localDate +
                "                                <br />\n" +
                "                                <span class=\"header-sm\">Order</span> <br />\n" +
                "                                #12342\n" +
                "                              </td>\n" +
                "                            </tr>\n" +
                "                          </table>\n" +
                "                        </td>\n" +
                "                      </tr>\n" +
                "                    </table>\n" +
                "                  </td>\n" +
                "                </tr>\n" +
                "              </table>\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </table>\n" +
                "      </center>\n" +
                "    </td>\n" +
                "  </tr>\n" +
                "  <tr>\n" +
                "    <td align=\"center\" valign=\"top\" width=\"100%\" style=\"background-color: #ffffff;  border-top: 1px solid #e5e5e5; border-bottom: 1px solid #e5e5e5;\">\n" +
                "      <center>\n" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" width=\"600\" class=\"w320\">\n" +
                "            <tr>\n" +
                "              <td class=\"item-table\">\n" +
                "                <table cellspacing=\"0\" cellpadding=\"0\" width=\"100%\">\n" +
                "                  <tr>\n" +
                "                    <td class=\"title-dark\" width=\"300\">\n" +
                "                       Item\n" +
                "                    </td>\n" +
                "                    <td class=\"title-dark\" width=\"163\">\n" +
                "                      Qty\n" +
                "                    </td>\n" +
                "                    <td class=\"title-dark\" width=\"97\">\n" +
                "                      " + cartPrice + "\n" +
                "                    </td>\n" +
                "                  </tr>";
    }

    private String emailPart_03() {
        return "<tr>\n" +
                "                    <td class=\"item-col item mobile-row-padding\"></td>\n" +
                "                    <td class=\"item-col quantity\"></td>\n" +
                "                    <td class=\"item-col price\"></td>\n" +
                "                  </tr>\n" +
                "\n" +
                "\n" +
                "                  <tr>\n" +
                "                    <td class=\"item-col item\">\n" +
                "                    </td>\n" +
                "                    <td class=\"item-col quantity\" style=\"text-align:right; padding-right: 10px; border-top: 1px solid #cccccc;\">\n" +
                "                      <span class=\"total-space\" style=\"font-weight: bold; color: #4d4d4d\">Total</span>\n" +
                "                    </td>\n" +
                "                    <td class=\"item-col price\" style=\"text-align: left; border-top: 1px solid #cccccc;\">\n" +
                "                      <span class=\"total-space\" style=\"font-weight:bold; color: #4d4d4d\">" + cartPrice +"</span>\n" +
                "                    </td>\n" +
                "                  </tr>  \n" +
                "                </table>\n" +
                "              </td>\n" +
                "            </tr>\n" +
                "        </table>\n" +
                "      </center>\n" +
                "    </td>\n" +
                "  </tr>\n" +
                "  <tr>\n" +
                "    <td align=\"center\" valign=\"top\" width=\"100%\" style=\"background-color: #f7f7f7; height: 100px;\">\n" +
                "      <center>\n" +
                "        <table cellspacing=\"0\" cellpadding=\"0\" width=\"600\" class=\"w320\">\n" +
                "          <tr>\n" +
                "            <td style=\"padding: 25px 0 25px\">\n" +
                "              <strong>Green Super</strong><br />\n" +
                "              1234 Awesome St <br />\n" +
                "              Wonderland <br /><br />\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </table>\n" +
                "      </center>\n" +
                "    </td>\n" +
                "  </tr>\n" +
                "</table>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>";
    }
}
