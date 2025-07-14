
USE computer_shop;
-- select * from product_stock_alerts;
-- select * from product;
-- 1. View: customer_order_summary
-- Description: Summarizes total number of orders and total amount spent by each customer.
CREATE VIEW customerOrderSummary AS
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
CREATE VIEW productSalesPerformance AS
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
CREATE VIEW staffPerformance AS
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
CREATE VIEW paymentMethodUsage AS
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
CREATE VIEW promotionEffectiveness AS
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
CREATE VIEW customerFeedbackInsights AS
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
CREATE VIEW topSellingCategories AS
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
CREATE VIEW pendingOrdersDetails AS
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
CREATE VIEW supplierPerformance AS
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
CREATE VIEW productStockAlerts AS
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



    -- fixing view perfoment
    CREATE OR REPLACE VIEW staffPerformance AS
WITH StaffInventoryProducts AS (
    SELECT
        il.staff_id,
        il.product_code,
        COUNT(il.log_id) as inventory_updates_for_product
    FROM inventorylog il
    JOIN staff s ON il.staff_id = s.staff_id
    WHERE s.is_active = TRUE
    GROUP BY il.staff_id, il.product_code
),
ProductSalesMetrics AS (
    SELECT
        oi.product_code,
        SUM(oi.qty * oi.price_at_purchase) AS total_value,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM orderitem oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status IN ('Delivered', 'Processing')
    GROUP BY oi.product_code
)
SELECT
    s.staff_id,
    s.name AS staff_name,
    s.position,
    SUM(sip.inventory_updates_for_product) AS inventory_updates,
    COALESCE(SUM(psm.total_value), 0) AS total_order_value,
    COALESCE(SUM(psm.total_orders), 0) AS total_orders_handled
FROM staff s
LEFT JOIN StaffInventoryProducts sip ON s.staff_id = sip.staff_id
LEFT JOIN ProductSalesMetrics psm ON sip.product_code = psm.product_code
WHERE s.is_active = TRUE
GROUP BY s.staff_id, s.name, s.position;
-- The HAVING clause remains the same, but now operates on pre-aggregated data.

-- Check if there are any products sold in completed orders

select * from promotionEffectiveness;
CREATE OR REPLACE VIEW promotionEffectiveness AS
WITH SalesDuringPromotion AS (
    SELECT
        p.promotion_id,
        pp.product_code,
        SUM(oi.qty * oi.price_at_purchase) AS sales_value
    FROM
        promotion p
    JOIN productpromotion pp ON p.promotion_id = pp.promotion_id
    JOIN orderitem oi ON pp.product_code = oi.product_code
    JOIN orders o ON oi.order_id = o.order_id
    WHERE
        o.order_date BETWEEN p.start_date AND p.end_date
        AND o.order_status = 'Delivered'
    GROUP BY
        p.promotion_id,
        pp.product_code
)
SELECT
    p.promotion_id,
    p.title AS promotion_title,
    p.discount_type,
    p.discount_value,
    COUNT(DISTINCT sdp.product_code) AS products_with_sales,
    COALESCE(SUM(sdp.sales_value), 0) AS total_sales_under_promotion
FROM
    promotion p
LEFT JOIN SalesDuringPromotion sdp ON p.promotion_id = sdp.promotion_id
WHERE
    p.start_date <= CURRENT_TIMESTAMP AND p.end_date >= CURRENT_TIMESTAMP
GROUP BY
    p.promotion_id,
    p.title,
    p.discount_type,
    p.discount_value;



-- Make promotion with ID 1 active for the next month
UPDATE promotion
SET start_date = NOW() - INTERVAL 1 DAY, end_date = NOW() + INTERVAL 1 MONTH
WHERE promotion_id = 1;

CREATE OR REPLACE VIEW detailedOrderInformation AS
WITH OrderMetrics AS (
    -- First, calculate total amount and items for each order
    SELECT
        order_id,
        SUM(qty * price_at_purchase) AS total_amount,
        SUM(qty) AS total_items
    FROM
        orderitem
    GROUP BY
        order_id
)
SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    c.customer_id,
    c.name AS customer_name,
    c.phone_number AS customer_phone,
    a.address_id,
    CONCAT_WS(', ', a.street_line, a.commune, a.district, a.province) AS shipping_address,
    om.total_amount,
    om.total_items
FROM
    orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN address a ON o.address_id = a.address_id
LEFT JOIN OrderMetrics om ON o.order_id = om.order_id;