-- Création des tables
DROP TABLE transactions CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;

CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    region VARCHAR2(50)
);

CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    category VARCHAR2(50)
);

CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES customers(customer_id),
    product_id NUMBER REFERENCES products(product_id),
    sale_date DATE,
    amount NUMBER(12,2)
);
-- data.sql
-- Insérer quelques données de test

-- Clients
INSERT INTO customers VALUES (1001, 'John Doe', 'Kigali');  
INSERT INTO customers VALUES (1002, 'Alice Smith', 'Huye');
INSERT INTO customers VALUES (1003, 'Eric Brown', 'Musanze');
INSERT INTO customers VALUES (1004, 'Marie Uwimana', 'Kigali');
INSERT INTO customers VALUES (1005, 'Samuel Habimana', 'Huye');

-- Produits
INSERT INTO products VALUES (2001, 'Coffee Beans', 'Beverages');
INSERT INTO products VALUES (2002, 'Tea Pack', 'Beverages');
INSERT INTO products VALUES (2003, 'Biscuits', 'Snacks');
INSERT INTO products VALUES (2004, 'Rice Bag', 'Food');
INSERT INTO products VALUES (2005, 'Juice Bottle', 'Beverages');

-- Transactions
INSERT INTO transactions VALUES (3001, 1001, 2001, DATE '2024-01-15', 25000);
INSERT INTO transactions VALUES (3002, 1002, 2003, DATE '2024-01-20', 15000);
INSERT INTO transactions VALUES (3003, 1003, 2004, DATE '2024-02-05', 30000);
INSERT INTO transactions VALUES (3004, 1001, 2002, DATE '2024-02-10', 12000);
INSERT INTO transactions VALUES (3005, 1004, 2005, DATE '2024-03-12', 18000);
INSERT INTO transactions VALUES (3006, 1005, 2001, DATE '2024-03-18', 22000);
INSERT INTO transactions VALUES (3007, 1002, 2004, DATE '2024-04-02', 28000);
INSERT INTO transactions VALUES (3008, 1003, 2002, DATE '2024-04-15', 15000);
INSERT INTO transactions VALUES (3009, 1004, 2003, DATE '2024-05-09', 17000);
INSERT INTO transactions VALUES (3010, 1005, 2005, DATE '2024-06-11', 24000);
