-- Tabel Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50)
);

-- Tabel MenuItems
CREATE TABLE menuitems (
    item_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

-- Tabel Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    table_number INT,
    employee_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Tabel OrderItem
CREATE TABLE orderitem (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menuitems(item_id)
);

-- Tabel Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Inserting to each Table
INSERT INTO employees (employee_id, first_name, last_name, position)
VALUES (1, 'John', 'Doe', 'Waiter');

INSERT INTO menuitems (item_id, name, description, price, category)
VALUES (1, 'Steak', 'Grilled sirloin steak', 25.99, 'Main Course');

INSERT INTO orders (order_id, table_number, employee_id, order_date, status)
VALUES (1, 5, 1, '2023-08-40', 'Pending');

INSERT INTO orderitem (order_item_id, order_id, item_id, quantity, subtotal)
VALUES (1, 1, 1, 2, 51.98);

INSERT INTO payments (payment_id, order_id, payment_date, total_amount)
VALUES (1, 1, '2023-08-04', 51.98);

-- Intructions
3. 
SELECT 
    orders.order_id,
    table_number,
    employee_id,
    order_date,
    status,
    CASE 
        WHEN orderitem.quantity > 100 THEN payments.total_amount * 0.95  -- 5% discount for quantity > 100
        ELSE payments.total_amount
    END AS discounted_total
FROM orders
JOIN payments ON orders.order_id = payments.order_id
JOIN orderitem ON orders.order_id = orderitem.order_id;

