-- ========================
-- INDEXING STRATEGIES
-- ========================
USE computer_shop;
-- 1. Index on customer phone_number
-- Description: Improves lookup performance when searching for customers by their phone number.
-- The phone_number column is already UNIQUE, which implicitly creates an index, but explicitly
-- defining it can sometimes be beneficial for clarity or specific index types.
CREATE INDEX idxCustomerPhoneNumber ON customer (phone_number);

-- 2. Index on product name
-- Description: Speeds up queries that filter or order products by their name,
-- which is a common operation in e-commerce applications.
CREATE INDEX idxProductName ON product (name);

-- 3. Composite Index on orders (customer_id, order_date)
-- Description: Optimizes queries that retrieve orders for a specific customer,
-- especially when those orders are also filtered or sorted by date.
CREATE INDEX idxOrdersCustomerDate ON orders (customer_id, order_date);

-- 4. Composite Index on productfeedback (product_code, feedback_date)
-- Description: Enhances performance for queries that fetch feedback for a particular product,
-- often ordered by the feedback date.
CREATE INDEX idxProductfeedbackProductDate ON productfeedback (product_code, feedback_date);

-- 5. Composite Index on inventorylog (product_code, change_date)
-- Description: Accelerates queries that track inventory changes for a specific product,
-- particularly when analyzing changes over time.
CREATE INDEX idxInventorylogProductDate ON inventorylog (product_code, change_date);


create index idxPaymenttransaction on paymenttransaction(order_id);
create index idxOrderitem on orderitem(order_id);