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
DROP FUNCTION IF EXISTS count_feedback_by_product;

-- MySQL function version of count_feedback_by_product
DELIMITER //
CREATE FUNCTION count_feedback_by_product(pid VARCHAR(50))
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
DROP FUNCTION IF EXISTS calculate_order_total;

CREATE FUNCTION calculate_order_total(p_order_id INT)
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
DROP VIEW IF EXISTS show_product_discount;
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
CREATE VIEW productFeedbackDataAVG AS
SELECT
    product_code,
    ROUND(AVG(rating), 1) AS rating,
    count_feedback_by_product(product_code) AS feedback_count
FROM
    ProductFeedback
GROUP BY
    product_code;

-- Drop and recreate the view for full product display
DROP VIEW IF EXISTS productShowInformation;
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
DROP VIEW IF EXISTS customerFeedbackForProduct;
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
select * from product limit 1;



select * from productshowinformation p where p.name like "%hardware%" order by p.price DESC;

select * from category c;

delete from productsupplier ;

drop database computer_shop;
create database computer_shop;
use computer_shop;
select count(*) from product;



