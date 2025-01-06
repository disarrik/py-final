CREATE TABLE Users (
 user_id INT AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 email VARCHAR(100) NOT NULL UNIQUE,
 phone VARCHAR(20),
 registration_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 loyalty_status VARCHAR(20)
);

CREATE TABLE Products (
 product_id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 description TEXT,
 category_id INT NOT NULL,
 price DECIMAL(10, 2) NOT NULL,
 stock_quantity INT NOT NULL DEFAULT 0,
 creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Orders (
 order_id INT AUTO_INCREMENT PRIMARY KEY,
 user_id INT NOT NULL,
 order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 total_amount DECIMAL(10, 2) NOT NULL,
 status VARCHAR(20) NOT NULL DEFAULT 'Pending',
 delivery_date TIMESTAMP
);

CREATE TABLE OrderDetails (
 order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
 order_id INT NOT NULL,
 product_id INT NOT NULL,
 quantity INT NOT NULL,
 price_per_unit DECIMAL(10, 2) NOT NULL,
 total_price DECIMAL(10, 2) NOT NULL DEFAULT (price_per_unit * quantity)
);

CREATE TABLE ProductCategories (
 category_id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(50) NOT NULL,
 parent_category_id INT DEFAULT NULL
);

CREATE TABLE UserTotal (
    user_id INT NOT NULL PRIMARY KEY,
    total_orders INT,
    total_purchased DECIMAL(10, 2),
    favourite_category_id INT
);