CREATE DATABASE green_super_database;
USE green_super_database;

-- Customer Side

CREATE TABLE customers (
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
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    PRIMARY KEY(address_id)
);

CREATE TABLE customer_passwords (
    password_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    hashed_password VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    PRIMARY KEY (password_id)
);

CREATE TABLE customer_feedbacks (
    feedback_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    bill_id INT,
    feedback TEXT,
    feedback_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL,
    PRIMARY KEY (feedback_id)
);

-- Products

CREATE TABLE images (
    image_id INT NOT NULL AUTO_INCREMENT,
    image_name VARCHAR(255),
    PRIMARY KEY (image_id)
);

CREATE TABLE categories (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_type VARCHAR(255),
    image_id INT,
    FOREIGN KEY (image_id) REFERENCES images (image_id),
    PRIMARY KEY (category_id)
);

CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT,
    category_id INT,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    price double(10, 2),
    quantity INT NOT NULL,
    is_in_stock boolean,
    image_id INT,
    FOREIGN KEY (category_id) REFERENCES categories (category_id) ON DELETE CASCADE,
    FOREIGN KEY (image_id) REFERENCES images (image_id),
    PRIMARY KEY (product_id)
);

-- Cart

CREATE TABLE carts (
    cart_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT,
    total_price double(10, 2) NOT NULL,
    PRIMARY KEY (cart_id)
);

CREATE TABLE cart_items (
    cart_item_id INT NOT NULL AUTO_INCREMENT,
    cart_id INT,
    product_id INT,
    bought_quantity INT,
    FOREIGN KEY (cart_id) REFERENCES carts (cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE CASCADE,
    PRIMARY KEY (cart_item_id)
);

-- Bill

CREATE TABLE bills (
    bill_id INT NOT NULL AUTO_INCREMENT,
    cart_id INT,
    payment_status VARCHAR(255),
    FOREIGN KEY (cart_id) REFERENCES carts (cart_id),
    PRIMARY KEY (bill_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT NOT NULL,
    transaction_id VARCHAR(50),
    bill_id INT,
    payment_date DATE,
    amount DOUBLE(10, 2),
    FOREIGN KEY (bill_id) REFERENCES bills (bill_id),
    PRIMARY KEY (payment_id)
);

-- Admin

CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT NOT NULL,
    admin_email VARCHAR(255) NOT NULL,
    admin_hashed_password VARCHAR(255) NOT NULL,
    PRIMARY KEY (admin_id)
);