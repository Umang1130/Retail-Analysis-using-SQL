CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name text not null,
    category VARCHAR(30) not null,
    price decimal(10,2) not null
);


CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name text not null,
    city VARCHAR(30) not null,
    signup_date DATE
);


CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY not null,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT not null,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);