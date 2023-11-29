-- Exercise 1
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT 
);

INSERT INTO products (product_id, product_name, quantity)
VALUES
	(1, 'Product A', 100),
    (2, 'Product B', 150),
    (3, 'Product C', 200),
    (4, 'Product D', 50),
    (5, 'Product E', 300);

-- Exercise 2
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Marketing'),
(4, 'Information Technology'),
(5, 'Operations');

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    JoinDate DATE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, JoinDate, DepartmentID) VALUES
(1, 'John', 'Doe', 50000.00, '2010-05-15', 1),
(2, 'Jane', 'Smith', 60000.00, '2012-09-10', 2),
(3, 'Michael', 'Johnson', 75000.00, '2015-03-20', 3),
(4, 'Emily', 'Brown', 55000.00, '2018-11-05', 1),
(5, 'Robert', 'Davis', 80000.00, '2019-06-30', 4);

UPDATE employees
SET Salary = Salary * 1.10
WHERE DepartmentID IN (
    SELECT DepartmentID
    FROM departments
    WHERE DepartmentName = 'Engineering'
);

-- Exercise 3
CREATE TABLE order_items (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT fk_order_items_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    CONSTRAINT fk_orders_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES
(1, '2023-01-01', 101),
(2, '2023-01-02', 102),
(3, '2023-01-03', 103);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES
(101, 'John', 'Doe', 'john.doe@example.com'),
(102, 'Jane', 'Smith', 'jane.smith@example.com'),
(103, 'Michael', 'Johnson', 'michael.johnson@example.com');

INSERT INTO order_items (OrderItemID, OrderID, ProductName, Quantity, Price) VALUES
(1, 1, 'Product A', 2, 50.00),
(2, 1, 'Product B', 1, 30.00),
(3, 2, 'Product C', 3, 25.00),
(4, 3, 'Product D', 1, 40.00);

DELETE FROM order_items
WHERE Quantity = 0;

-- Exercise 4
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    marks INT
);

INSERT INTO students (student_id, student_name, marks)
SELECT 102, 'Jane Doe', 85
WHERE NOT EXISTS (
    SELECT 1
    FROM students
    WHERE student_name = 'John Doe'
);

-- Exercise 5
UPDATE orders
SET total_price = (
    SELECT SUM(total_price)
    FROM order_items
    WHERE order_items.OrderID = orders.OrderID
);

-- Exercise 6
ALTER TABLE employees
ADD is_deleted BOOLEAN DEFAULT false;

UPDATE employees
SET is_deleted = true
WHERE left_company = true;

-- Exercise 7
UPDATE products
SET unit_price = CASE 
    WHEN quantity > 100 THEN unit_price * 1.05 
    ELSE unit_price * 1.10
END;

-- Exercise 8
DELETE c1
FROM customers c1
JOIN customers c2
on c1.Email = c2.Email AND c1.CustomerID > c2.CustomerID;


