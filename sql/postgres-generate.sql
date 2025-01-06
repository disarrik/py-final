-- 1. Таблица Users
CREATE TABLE Users (
 user_id SERIAL PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 email VARCHAR(100) NOT NULL UNIQUE,
 phone VARCHAR(20),
 registration_date TIMESTAMP NOT NULL DEFAULT NOW(),
 loyalty_status VARCHAR(20)
);

-- 2. Таблица Products
CREATE TABLE Products (
 product_id SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 description TEXT,
 category_id INTEGER NOT NULL,
 price DECIMAL(10, 2) NOT NULL,
 stock_quantity INTEGER NOT NULL DEFAULT 0,
 creation_date TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 3. Таблица Orders
CREATE TABLE Orders (
 order_id SERIAL PRIMARY KEY,
 user_id INTEGER NOT NULL,
 order_date TIMESTAMP NOT NULL DEFAULT NOW(),
 total_amount DECIMAL(10, 2) NOT NULL,
 status VARCHAR(20) NOT NULL DEFAULT 'Pending',
 delivery_date TIMESTAMP
);

-- 4. Таблица OrderDetails
CREATE TABLE OrderDetails (
 order_detail_id SERIAL PRIMARY KEY,
 order_id INTEGER NOT NULL,
 product_id INTEGER NOT NULL,
 quantity INTEGER NOT NULL,
 price_per_unit DECIMAL(10, 2) NOT NULL,
 total_price DECIMAL(10, 2) NOT NULL DEFAULT 0
);

-- 5. Таблица ProductCategories
CREATE TABLE ProductCategories (
 category_id SERIAL PRIMARY KEY,
 name VARCHAR(50) NOT NULL,
 parent_category_id INTEGER DEFAULT NULL
);

-- Расстановка Foreign Keys
ALTER TABLE Orders ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES Users(user_id);

ALTER TABLE OrderDetails ADD CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES Orders(order_id);
ALTER TABLE OrderDetails ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES Products(product_id);

ALTER TABLE Products ADD CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES ProductCategories(category_id);


-- 1. Вставляем данные в таблицу Users
INSERT INTO Users (first_name, last_name, email, phone, loyalty_status) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', 'Gold'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', 'Silver');

-- 5. Вставляем данные в таблицу ProductCategories
INSERT INTO ProductCategories (name, parent_category_id) VALUES
('Category 1', NULL),
('Category 2', 1),
('Category 3', 1);

-- 2. Вставляем данные в таблицу Products
INSERT INTO Products (name, description, category_id, price, stock_quantity) VALUES
('Product A', 'Description for Product A', 1, 100.00, 10),
('Product B', 'Description for Product B', 2, 50.00, 20);

-- 3. Вставляем данные в таблицу Orders
INSERT INTO Orders (user_id, order_date, total_amount, status) VALUES
(1, '2023-01-01 10:00:00', 150.00, 'Pending'),
(2, '2023-01-02 12:00:00', 75.00, 'Completed');

-- 4. Вставляем данные в таблицу OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity, price_per_unit, total_price) VALUES
(1, 1, 2, 50.00, 100.00),
(1, 2, 3, 25.00, 75.00),
(2, 1, 1, 50.00, 50.00);
