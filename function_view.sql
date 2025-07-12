-- use computer_shop;
-- CREATE FUNCTION count_feedback_by_product(pid VARCHAR(50))
-- RETURNS INTEGER AS $$
-- DECLARE
--     feedback_count INTEGER;
-- BEGIN
--     SELECT COUNT(feedback_id)
--     INTO feedback_count
--     FROM ProductFeedback
--     WHERE product_code = pid;
-- 
--     RETURN feedback_count;
-- END;
-- $$ LANGUAGE plpgsql;
-- 
-- 
-- CREATE OR REPLACE VIEW show_product_discount AS
-- SELECT
--     pp.product_code,
--     p.promotion_id,
--     p.discount_type,
--     p.discount_value
-- FROM
--     ProductPromotion AS pp
-- JOIN
--     Promotion AS p ON p.promotion_id = pp.promotion_id;
-- CREATE OR REPLACE VIEW productFeedbackDataAVG AS
-- SELECT
--     product_code,
--     ROUND(AVG(rating), 1) AS rating,
--     count_feedback_by_product(product_code) AS feedback_count
-- FROM
--     ProductFeedback
-- GROUP BY
--     product_code;
-- 
-- CREATE OR REPLACE VIEW productShowInformation AS
-- SELECT
--     p.product_code,
--     p.name,
--     p.image_path,
--     p.price,
--     p.description,
--     b.name AS brand_name, 
--     p.category_id,
--     c.title AS category_title,
--     p.type_id,
--     tp.name AS type_product,
--     spd.discount_type,
--     spd.discount_value,
--     pf.rating AS average_rating,
--     pf.feedback_count
-- FROM
--     product AS p
-- JOIN
--     category AS c ON c.category_id = p.category_id
-- JOIN
--     typeproduct AS tp ON tp.type_id = p.type_id
-- JOIN
--     brand AS b ON b.id = p.brand_id 
-- LEFT JOIN 
--     show_product_discount AS spd ON spd.product_code = p.product_code
-- LEFT JOIN 
--     productFeedbackDataAVG AS pf ON pf.product_code = p.product_code;
-- 
-- CREATE OR REPLACE VIEW customerFeedbackForProduct AS
-- SELECT
--     pf.feedback_id,
--     pf.product_code,
--     pf.feedback_date,
--     pf.rating,
--     pf.comment,
--     c.name AS customer_name,
--     c.profile_img_path
-- FROM
--     productfeedback AS pf
-- JOIN
--     customer c ON c.customer_id = pf.customer_id;
-- 

USE computer_shop;
-- Drop the function if it exists (MySQL requires this before re-creating)
-- DROP FUNCTION IF EXISTS countFeedbackByProduct;

-- MySQL function version of count_feedback_by_product
DELIMITER //
CREATE FUNCTION countFeedbackByProduct(pid VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE feedback_count INT;

    SELECT COUNT(feedback_id)
    INTO feedback_count
    FROM ProductFeedback
    WHERE product_code = pid;

    RETURN feedback_count;
END;
//
DELIMITER ;

DELIMITER //

-- Drop the function if it already exists to avoid errors on recreation
-- DROP FUNCTION IF EXISTS calculateOrderTotal;

CREATE FUNCTION calculateOrderTotal(p_order_id INT)
RETURNS DECIMAL(12, 2) 
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12, 2);

    SELECT SUM(qty * price_at_purchase)
    INTO v_total
    FROM orderitem
    WHERE order_id = p_order_id;

    RETURN IFNULL(v_total, 0.00);

END //

DELIMITER ;


-- Drop and recreate the view for product discounts
-- DROP VIEW IF EXISTS show_product_discount;
CREATE VIEW show_product_discount AS
SELECT
    pp.product_code,
    p.promotion_id,
    p.discount_type,
    p.discount_value
FROM
    ProductPromotion AS pp
JOIN
    Promotion AS p ON p.promotion_id = pp.promotion_id;

-- Drop and recreate the view for feedback averages
-- DROP VIEW IF EXISTS productFeedbackDataAVG;
CREATE VIEW productFeedbackDataAVG AS
SELECT
    product_code,
    ROUND(AVG(rating), 1) AS rating,
    countFeedbackByProduct(product_code) AS feedback_count
FROM
    ProductFeedback
GROUP BY
    product_code;

-- Drop and recreate the view for full product display
-- DROP VIEW IF EXISTS productShowInformation;
CREATE VIEW productShowInformation AS
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

-- Drop and recreate the view for customer feedback display
-- DROP VIEW IF EXISTS customerFeedbackForProduct;
CREATE VIEW customerFeedbackForProduct AS
SELECT
    pf.feedback_id,
    pf.product_code,
    pf.feedback_date,
    pf.rating,
    pf.comment,
    c.name AS customer_name,
    c.profile_img_path
FROM
    ProductFeedback AS pf
JOIN
    customer AS c ON c.customer_id = pf.customer_id;


create or replace view showDatabaseUser as
	select  u.`User`,u.Host from mysql.`user` u where u.`User` not in (select role_name from roles);

select * from showDatabaseUser;

use computer_shop;
show tables;


-- new function

-- Set a new delimiter for creating functions that contain semicolons.
DELIMITER $$

-- ===================================================================
-- 10 USEFUL FUNCTIONS WITH SUBQUERIES
-- ===================================================================

-- 1. Get the total amount a specific customer has spent across all their orders.
CREATE FUNCTION getCustomerTotalSpending(p_customer_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total_spending DECIMAL(10, 2);

    SELECT SUM(order_total) INTO total_spending
    FROM (
        -- Subquery: Calculates the total value for each order of the given customer.
        SELECT SUM(oi.qty * oi.price_at_purchase) AS order_total
        FROM orderitem oi
        WHERE oi.order_id IN (SELECT o.order_id FROM orders o WHERE o.customer_id = p_customer_id)
        GROUP BY oi.order_id
    ) AS customer_order_totals;

    RETURN IFNULL(total_spending, 0.00);
END$$





-- 4. Count the number of customers residing in a specific province.
CREATE FUNCTION countCustomersByProvince(p_province_name VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE customer_count INT;

    SELECT COUNT(DISTINCT customer_id) INTO customer_count
    FROM address
    WHERE province = p_province_name AND customer_id IN (
        -- Subquery: Ensures we only count valid customers from the customer table.
        SELECT customer_id FROM customer
    );

    RETURN customer_count;
END$$


-- 5. Check if a product has ever been ordered. Returns 1 for TRUE, 0 for FALSE.
CREATE FUNCTION hasProductBeenOrdered(p_product_code VARCHAR(50))
RETURNS BOOLEAN
DETERMINISTIC

BEGIN
    DECLARE has_been_ordered BOOLEAN;

    SELECT EXISTS (
        -- Subquery: Efficiently checks for the existence of the product in any order.
        SELECT 1
        FROM orderitem
        WHERE product_code = p_product_code
    ) INTO has_been_ordered;

    RETURN has_been_ordered;
END$$


-- 6. Calculate the average monetary value of all completed orders.
CREATE FUNCTION getAverageOrderValue()
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_value DECIMAL(10, 2);

    SELECT AVG(order_total) INTO avg_value
    FROM (
        -- Subquery: Calculates the total value for each individual order.
        SELECT SUM(oi.qty * oi.price_at_purchase) AS order_total
        FROM orderitem oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE o.order_status = 'Delivered'
        GROUP BY oi.order_id
    ) AS order_totals;

    RETURN IFNULL(avg_value, 0.00);
END$$


-- 7. Count the number of registered customers who have never placed an order.
CREATE FUNCTION countCustomersWithNoOrders()
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE inactive_customer_count INT;

    SELECT COUNT(*) INTO inactive_customer_count
    FROM customer
    WHERE customer_id NOT IN (
        -- Subquery: Gets a list of all customer IDs that have placed an order.
        SELECT DISTINCT customer_id FROM orders
    );

    RETURN inactive_customer_count;
END$$


-- 8. Get the date of the most recent order for a specific customer.
CREATE FUNCTION getLatestOrderDateForCustomer(p_customer_id INT)
RETURNS TIMESTAMP
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE last_order_date TIMESTAMP;

    SELECT order_date INTO last_order_date
    FROM orders
    WHERE customer_id = p_customer_id
    AND order_date = (
        -- Subquery: Finds the maximum (most recent) order date for that customer.
        SELECT MAX(order_date)
        FROM orders
        WHERE customer_id = p_customer_id
    );

    RETURN last_order_date;
END$$


-- 9. Count the total number of products within a specific category name.
CREATE FUNCTION countProductsByCategory(p_category_name VARCHAR(100))
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE product_count INT;

    SELECT COUNT(*) INTO product_count
    FROM product
    WHERE category_id = (
        -- Subquery: Finds the category_id from its title.
        SELECT category_id FROM category WHERE title = p_category_name
    );

    RETURN product_count;
END$$


-- 10. Get the average feedback rating for a given product.
CREATE FUNCTION getProductAverageRating(p_product_code VARCHAR(50))
RETURNS DECIMAL(3, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(3, 2);

    -- The SELECT statement itself acts as a subquery within the function logic.
    SELECT AVG(rating) INTO avg_rating
    FROM productfeedback
    WHERE product_code = p_product_code;

    RETURN IFNULL(avg_rating, 0.00);
END$$

-- Reset the delimiter back to the default.
DELIMITER ;
select * from product limit 1;



select * from productshowinformation p where p.name like "%hardware%" order by p.price DESC;

select * from category c;

delete from productsupplier ;

drop database computer_shop;
create database computer_shop;
use computer_shop;
select count(*) from product;
desc paymenttransaction;

select * from staff;


