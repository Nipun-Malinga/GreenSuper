CREATE DATABASE green_super_database;
USE green_super_database;

-- Customer Side Tables
CREATE TABLE customer (
                          customer_id INT NOT NULL AUTO_INCREMENT,
                          first_name VARCHAR(255) NOT NULL,
                          last_name VARCHAR(255) NOT NULL,
                          email VARCHAR(255) NOT NULL,
                          phone_number VARCHAR(20),
                          PRIMARY KEY (customer_id)
);

CREATE TABLE customer_address (
                                  address_id INT NOT NULL AUTO_INCREMENT,
                                  customer_id INT,
                                  city VARCHAR(255) NOT NULL,
                                  street VARCHAR(255) NOT NULL,
                                  home_number VARCHAR(255) NOT NULL,
                                  FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
                                  PRIMARY KEY(address_id)
);

CREATE TABLE customer_passwords (
                                    password_id INT NOT NULL AUTO_INCREMENT,
                                    customer_id INT,
                                    hashed_password VARCHAR(255) NOT NULL,
                                    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
                                    PRIMARY KEY (password_id)
);

CREATE TABLE customer_feedback (
                                   feedback_id INT NOT NULL AUTO_INCREMENT,
                                   customer_id INT,
                                   bill_id INT,
                                   feedback TEXT,
                                   feedback_date DATE,
                                   FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
                                   PRIMARY KEY (feedback_id)
);

-- Shop Side

-- Products
CREATE TABLE images (
                        image_id INT NOT NULL AUTO_INCREMENT,
                        image_name VARCHAR(255),
                        PRIMARY KEY (image_id)
);

CREATE TABLE category (
                          category_id INT NOT NULL AUTO_INCREMENT,
                          category_type VARCHAR(255),
                          image_id INT,
                          FOREIGN KEY (image_id) REFERENCES images (image_id),
                          PRIMARY KEY (category_id)
);

CREATE TABLE product (
                         product_id INT NOT NULL AUTO_INCREMENT,
                         category_id INT,
                         product_name VARCHAR(255) NOT NULL,
                         description TEXT,
                         price double(10, 2),
                         quantity INT NOT NULL,
                         is_in_stock boolean,
                         image_id INT,
                         FOREIGN KEY (category_id) REFERENCES category (category_id),
                         FOREIGN KEY (image_id) REFERENCES images (image_id),
                         PRIMARY KEY (product_id)
);

-- Cart

CREATE TABLE cart (
                      cart_id INT NOT NULL AUTO_INCREMENT,
                      customer_id INT,
                      total_price double(10, 2) NOT NULL,
                      PRIMARY KEY (cart_id)
);

CREATE TABLE cart_item (
                           cart_item_id INT NOT NULL AUTO_INCREMENT,
                           cart_id INT,
                           product_id INT,
                           bought_quantity INT,
                           FOREIGN KEY (cart_id) REFERENCES cart (cart_id),
                           FOREIGN KEY (product_id) REFERENCES product (product_id),
                           PRIMARY KEY (cart_item_id)
);

-- Bill

CREATE TABle bill (
                      bill_id INT NOT NULL AUTO_INCREMENT,
                      cart_id INT,
                      payment_status VARCHAR(255),
                      FOREIGN KEY (cart_id) REFERENCES cart (cart_id),
                      PRIMARY KEY (bill_id)
);

CREATE TABLE payment (
                         payment_id INT AUTO_INCREMENT NOT NULL,
                         transaction_id VARCHAR(50),
                         bill_id INT,
                         payment_date DATE,
                         amount DOUBLE(10, 2),
                         FOREIGN KEY (bill_id) REFERENCES bill (bill_id),
                         PRIMARY KEY (payment_id)
);