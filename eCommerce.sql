CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

-- 1. CATEGORIES - product categories, the "parent" side of a one-to-many
-- relationship with products.
CREATE TABLE categories (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description   TEXT
);

-- 2. PRODUCTS - everything TechBazaar sells. Each belongs to exactly one
-- category (many-to-one via category_id).
CREATE TABLE products (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    category_id    INT NOT NULL,
    product_name   VARCHAR(100) NOT NULL,
    price          NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    is_active      BOOLEAN NOT NULL DEFAULT TRUE,   -- FALSE = discontinued, kept for order history
    created_at     DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 3. CUSTOMERS - people who buy from TechBazaar. referred_by is a
-- self-referencing FK, same idea as employees.manager_id above.
CREATE TABLE customers (
    customer_id    INT AUTO_INCREMENT PRIMARY KEY,
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    phone          VARCHAR(20),                     -- nullable: not every customer gives a phone number
    city           VARCHAR(50),                     -- nullable, on purpose (NULL-handling examples later)
    country        VARCHAR(50) NOT NULL DEFAULT 'USA',
    signup_date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    loyalty_points INT NOT NULL DEFAULT 0,
    referred_by    INT,
    FOREIGN KEY (referred_by) REFERENCES customers(customer_id)
);

-- 0. EMPLOYEES - staff members, with a self-referencing manager_id
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name  VARCHAR(50) NOT NULL,
    last_name   VARCHAR(50) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    manager_id  INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- 4. ORDERS - one row per customer order. employee_id is nullable:
-- customers can check out on the website with no sales rep involved.
CREATE TABLE orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT NOT NULL,
    employee_id   INT,   -- NULL = self-service web order
    order_date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    status        VARCHAR(20) NOT NULL DEFAULT 'pending'
                   CHECK (status IN ('pending', 'processing', 'completed', 'cancelled', 'refunded')),
    shipping_city VARCHAR(50),
    notes         TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 5. ORDER_ITEMS - the line items of an order: which products, how many,
-- and at what price. unit_price is a snapshot of the price AT THE TIME of
-- the order, since a product's catalog price can change afterwards.
-- ON DELETE CASCADE: delete an order, its line items go with it.
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    quantity      INT NOT NULL CHECK (quantity > 0),
    unit_price    NUMERIC(10, 2) NOT NULL CHECK (unit_price > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. PAYMENTS - money actually collected against an order. Not every
-- order has a payment yet (e.g. still 'pending').
CREATE TABLE payments (
    payment_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL,
    payment_date   DATE NOT NULL,
    amount         NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(20) NOT NULL
                   CHECK (payment_method IN ('credit_card', 'debit_card', 'paypal', 'bank_transfer', 'gift_card', 'upi')),
    status         VARCHAR(20) NOT NULL DEFAULT 'success'
                   CHECK (status IN ('success', 'failed', 'refunded')),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);




-- Relationships at a glance:
--   employees  (many) >─── (1) employees         [self: manager_id - already seeded above]
--   categories (1) ───< (many) products
--   customers  (1) ───< (many) orders
--   employees  (1) ───< (many) orders            [nullable FK: web orders have no rep]
--   orders     (1) ───< (many) order_items
--   products   (1) ───< (many) order_items
--   orders     (1) ───< (many) payments
--   customers  (many) >─── (1) customers         [self: referred_by]
-- order_items is a JUNCTION TABLE between orders and products - it sits
-- between them and carries its own data (quantity, unit_price), which is
-- exactly how a many-to-many relationship is modeled in SQL.

