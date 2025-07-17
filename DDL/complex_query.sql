
USE computer_shop;
-- 1. View: customer_order_summary
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



UPDATE promotion
SET start_date = NOW() - INTERVAL 1 DAY, end_date = NOW() + INTERVAL 1 MONTH
WHERE promotion_id = 1;
-- # 10
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

CREATE OR REPLACE VIEW productShowInformation AS
SELECT
    p.product_code,
    p.name,
    p.image_path,
    p.price,
    p.description,
    b.name AS brand_name, 
    p.category_id,
    c.title AS category_title,
    p.type_id,
    tp.name AS type_product,
    spd.discount_type,
    spd.discount_value,
    pf.rating AS average_rating,
    pf.feedback_count
FROM
    product AS p
JOIN
    category AS c ON c.category_id = p.category_id
JOIN
    typeproduct AS tp ON tp.type_id = p.type_id
JOIN
    brand AS b ON b.id = p.brand_id 
LEFT JOIN 
    show_product_discount AS spd ON spd.product_code = p.product_code
LEFT JOIN 
    productFeedbackDataAVG AS pf ON pf.product_code = p.product_code;