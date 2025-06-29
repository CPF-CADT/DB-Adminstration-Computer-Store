-- Enums remain unchanged
CREATE TYPE order_status_enum AS ENUM ('Pending', 'Processing', 'Delivered', 'Cancelled');
CREATE TYPE discount_enum AS ENUM ('Percentage', 'Fixed Amount');

-- ========================
-- CORE TABLES
-- ========================

CREATE TABLE customer (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) UNIQUE NOT NULL,
    registration_date TIMESTAMPTZ DEFAULT NOW(),
    login_date TIMESTAMPTZ,
    profile_img_path VARCHAR(255),
    password VARCHAR(255),
    is_verifyed BOOLEAN DEFAULT FALSE
);

CREATE TABLE staff (
    staff_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) UNIQUE NOT NULL,
    salary DECIMAL(10, 2),
    work_schedule TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date DATE,
    position VARCHAR(100),
    manager_id INT,
    CONSTRAINT fk_manager FOREIGN KEY(manager_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

CREATE TABLE category (
    category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE brand (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    logo_url VARCHAR(255),
    website VARCHAR(255),
    country VARCHAR(100)
);

CREATE TABLE supplier (
    supplier_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(50),
    type_supply VARCHAR(100),
    address TEXT,
    notes TEXT
);

CREATE TABLE promotion (
    promotion_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    discount_type discount_enum NOT NULL,
    discount_value DECIMAL(10, 2) NOT NULL,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL
);

CREATE TABLE paymentmethod (
    pay_method_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pay_method VARCHAR(100) UNIQUE NOT NULL,
    company_handle VARCHAR(100),
    is_enable BOOLEAN NOT NULL DEFAULT TRUE
);

-- ========================
-- TABLES WITH DEPENDENCIES
-- ========================

CREATE TABLE address (
    address_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    street_line VARCHAR(255), -- now allows NULL
    commune VARCHAR(100),
    district VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    google_map_link TEXT,
    CONSTRAINT fk_customer FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE typeproduct (
    type_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(255)
);

CREATE TABLE product (
    product_code VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    image_path VARCHAR(255),
    brand_id INT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    last_restock_date DATE,
    category_id INT,
    type_id INT,
    CONSTRAINT fk_category FOREIGN KEY(category_id) REFERENCES category(category_id) ON DELETE SET NULL,
    CONSTRAINT fk_type_id FOREIGN KEY(type_id) REFERENCES typeproduct(type_id),
    CONSTRAINT fk_brand FOREIGN KEY(brand_id) REFERENCES brand(id) ON DELETE SET NULL
);

CREATE TABLE productfeedback (
    feedback_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    product_code VARCHAR(50) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    feedback_date TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT fk_customer_feedback FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_feedback FOREIGN KEY(product_code) REFERENCES product(product_code) ON DELETE CASCADE
);

CREATE TABLE inventorylog (
    log_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_code VARCHAR(50) NOT NULL,
    staff_id INT,
    change_date TIMESTAMPTZ DEFAULT NOW(),
    change_type VARCHAR(50) NOT NULL,
    quantity_change INT NOT NULL,
    note TEXT,
    CONSTRAINT fk_product_inventory FOREIGN KEY(product_code) REFERENCES product(product_code) ON DELETE CASCADE,
    CONSTRAINT fk_staff_inventory FOREIGN KEY(staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

CREATE TABLE orders (
    order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    order_date TIMESTAMPTZ DEFAULT NOW(),
    order_status order_status_enum NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_order_customer FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE RESTRICT,
    CONSTRAINT fk_order_address FOREIGN KEY(address_id) REFERENCES address(address_id) ON DELETE RESTRICT
);

-- ========================
-- DETAIL / LINKING TABLES
-- ========================

CREATE TABLE orderitem (
    order_id INT NOT NULL,
    product_code VARCHAR(50) NOT NULL,
    qty INT NOT NULL CHECK (qty > 0),
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, product_code),
    CONSTRAINT fk_order_item_order FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_item_product FOREIGN KEY(product_code) REFERENCES product(product_code) ON DELETE RESTRICT
);

CREATE TABLE paymenttransaction (
    transaction_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT NOT NULL,
    pay_method_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    transaction_date TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT fk_payment_transaction_order FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_payment_transaction_method FOREIGN KEY(pay_method_id) REFERENCES paymentmethod(pay_method_id) ON DELETE RESTRICT
);

CREATE TABLE productsupplier (
    product_code VARCHAR(50) NOT NULL,
    supplier_id INT NOT NULL,
    supply_cost DECIMAL(10, 2),
    supply_date DATE,
    quantity INT,
    PRIMARY KEY (product_code, supplier_id),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY(product_code) REFERENCES product(product_code) ON DELETE CASCADE,
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY(supplier_id) REFERENCES supplier(supplier_id) ON DELETE CASCADE
);

CREATE TABLE productpromotion (
    product_code VARCHAR(50) NOT NULL,
    promotion_id INT NOT NULL,
    PRIMARY KEY (product_code, promotion_id),
    CONSTRAINT fk_product_promotion_product FOREIGN KEY(product_code) REFERENCES product(product_code) ON DELETE CASCADE,
    CONSTRAINT fk_product_promotion_promotion FOREIGN KEY(promotion_id) REFERENCES promotion(promotion_id) ON DELETE CASCADE
);

CREATE TABLE cartitem (
    cart_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    product_code VARCHAR(50) NOT NULL,
    qty INT NOT NULL CHECK (qty > 0),
    price_at_purchase NUMERIC(10, 2) NOT NULL,
    added_at TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_code) REFERENCES product(product_code) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE two_fa_token (
    tfa_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    code VARCHAR(255) NOT NULL,
    expire_at TIMESTAMP,
    is_used BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE ON UPDATE CASCADE
);
