
USE computer_shop;
-- select * from product_stock_alerts;
-- select * from product;
-- 1. View: customer_order_summary
-- Description: Summarizes total number of orders and total amount spent by each customer.
CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.phone_number,
    COUNT(o.order_id) AS total_orders,
    SUM(pt.amount) AS total_spent
FROM
    customer c
JOIN
    orders o ON c.customer_id = o.customer_id
LEFT JOIN
    paymenttransaction pt ON o.order_id = pt.order_id
GROUP BY
    c.customer_id, c.name, c.phone_number
ORDER BY
    total_spent DESC;

-- 2. View: product_sales_performance
-- Description: Shows total quantity sold and total revenue generated for each product.
CREATE VIEW product_sales_performance AS
SELECT
    p.product_code,
    p.name AS product_name,
    c.title AS category_name,
    b.name AS brand_name,
    SUM(oi.qty) AS total_quantity_sold,
    SUM(oi.qty * oi.price_at_purchase) AS total_revenue
FROM
    product p
JOIN
    orderitem oi ON p.product_code = oi.product_code
LEFT JOIN
    category c ON p.category_id = c.category_id
LEFT JOIN
    brand b ON p.brand_id = b.id
GROUP BY
    p.product_code, p.name, c.title, b.name
ORDER BY
    total_revenue DESC;
-- View 3: Active Staff Performance
-- Purpose: Shows staff managing orders, with total order value handled and number of orders, for active staff only.
CREATE VIEW staff_performance AS
SELECT 
    s.staff_id,
    s.name AS staff_name,
    s.position,
    COUNT(DISTINCT il.log_id) AS inventory_updates,
    COALESCE(SUM(oi.qty * oi.price_at_purchase), 0) AS total_order_value,
    COUNT(DISTINCT o.order_id) AS total_orders_handled
FROM staff s
LEFT JOIN inventorylog il ON s.staff_id = il.staff_id
LEFT JOIN orderitem oi ON il.product_code = oi.product_code
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.order_status IN ('Delivered', 'Processing')
WHERE s.is_active = TRUE
GROUP BY s.staff_id, s.name, s.position
HAVING total_orders_handled > 0;

-- View 4: Payment Method Usage
-- Purpose: Analyzes payment method usage, showing transaction counts and total amounts by method.
CREATE VIEW payment_method_usage AS
SELECT 
    pm.pay_method_id,
    pm.pay_method,
    pm.company_handle,
    COUNT(pt.transaction_id) AS transaction_count,
    COALESCE(SUM(pt.amount), 0) AS total_amount,
    COUNT(DISTINCT CASE WHEN pt.status = 'Completed' THEN pt.transaction_id END) AS completed_transactions
FROM paymentmethod pm
LEFT JOIN paymenttransaction pt ON pm.pay_method_id = pt.pay_method_id
WHERE pm.is_enable = TRUE
GROUP BY pm.pay_method_id, pm.pay_method, pm.company_handle
ORDER BY total_amount DESC;

-- View 5: Promotion Effectiveness
-- Purpose: Evaluates promotions by calculating total sales under each promotion and affected products.
CREATE VIEW promotion_effectiveness AS
SELECT 
    p.promotion_id,
    p.title AS promotion_title,
    p.discount_type,
    p.discount_value,
    COUNT(DISTINCT pp.product_code) AS products_affected,
    COALESCE(SUM(oi.qty * oi.price_at_purchase), 0) AS total_sales_under_promotion
FROM promotion p
LEFT JOIN productpromotion pp ON p.promotion_id = pp.promotion_id
LEFT JOIN orderitem oi ON pp.product_code = oi.product_code
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.order_status = 'Delivered'
WHERE p.start_date <= CURRENT_TIMESTAMP AND p.end_date >= CURRENT_TIMESTAMP
GROUP BY p.promotion_id, p.title, p.discount_type, p.discount_value;

-- View 6: Customer Feedback Insights
-- Purpose: Summarizes product feedback, including average rating and feedback count per product.
CREATE VIEW customer_feedback_insights AS
SELECT 
    p.product_code,
    p.name AS product_name,
    AVG(pf.rating) AS average_rating,
    COUNT(pf.feedback_id) AS feedback_count,
    COUNT(DISTINCT pf.customer_id) AS unique_customers
FROM product p
LEFT JOIN productfeedback pf ON p.product_code = pf.product_code
GROUP BY p.product_code, p.name
HAVING feedback_count > 0
ORDER BY average_rating DESC;

-- 7. View: top_selling_categories
-- Description: Identifies categories with the highest total sales revenue.
CREATE VIEW top_selling_categories AS
SELECT
    cat.category_id,
    cat.title AS category_name,
    SUM(oi.qty * oi.price_at_purchase) AS total_category_revenue
FROM
    category cat
JOIN
    product p ON cat.category_id = p.category_id
JOIN
    orderitem oi ON p.product_code = oi.product_code
GROUP BY
    cat.category_id, cat.title
ORDER BY
    total_category_revenue DESC;

-- 8. View: pending_orders_details
-- Description: Provides detailed information for all orders that are currently in 'Pending' status.
CREATE VIEW pending_orders_details AS
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.customer_id,
    c.name AS customer_name,
    c.phone_number AS customer_phone,
    a.street_line,
    a.commune,
    a.district,
    a.province
FROM
    orders o
JOIN
    customer c ON o.customer_id = c.customer_id
JOIN
    address a ON o.address_id = a.address_id
WHERE
    o.order_status = 'Pending';

-- View 9: Supplier Performance
-- Purpose: Evaluates suppliers by total products supplied and supply cost, with recent supply activity.
CREATE VIEW supplier_performance AS
SELECT 
    s.supplier_id,
    s.name AS supplier_name,
    s.type_supply,
    COUNT(ps.product_code) AS products_supplied,
    COALESCE(SUM(ps.supply_cost * ps.quantity), 0) AS total_supply_cost,
    MAX(ps.supply_date) AS last_supply_date
FROM supplier s
LEFT JOIN productsupplier ps ON s.supplier_id = ps.supplier_id
GROUP BY s.supplier_id, s.name, s.type_supply
HAVING products_supplied > 0
ORDER BY total_supply_cost DESC;

-- 10. View: product_stock_alerts
-- Description: Lists products with low stock quantity (less than 10) and their last restock date.
CREATE VIEW product_stock_alerts AS
SELECT
    p.product_code,
    p.name AS product_name,
    p.stock_quantity,
    p.last_restock_date,
    s.name AS supplier_name -- Adding supplier name for more context
FROM
    product p
LEFT JOIN
    productsupplier ps ON p.product_code = ps.product_code
LEFT JOIN
    supplier s ON ps.supplier_id = s.supplier_id
WHERE
    p.stock_quantity < 10
ORDER BY
    p.stock_quantity ASC, p.last_restock_date DESC;
