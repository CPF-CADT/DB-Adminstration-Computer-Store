USE computer_shop;
-- delete from customer where name = 'Alice Brown';
-- delete from staff where name = 'Tom Clark';
-- DELETE FROM paymentmethod 
-- WHERE pay_method = 'Credit Card';
-- DELETE FROM product 
-- WHERE name = 'Dell XPS 13';
-- DELETE FROM inventorylog 
-- WHERE product_code = 'PER001';
-- DELETE FROM orders 
-- WHERE order_status = 'Cancelled';
-- DELETE FROM orderitem 
-- WHERE product_code = 'ACC001';
-- DELETE FROM paymenttransaction 
-- WHERE status = 'Failed';
-- DELETE FROM productpromotion 
-- WHERE promotion_id = '2';
-- select * from inventorylog;
-- select * from customer;
-- select * from productpromotion;
-- select* from auditLog;
DELIMITER //

-- Trigger for customer table deletions
CREATE TRIGGER customerDelete
AFTER DELETE ON customer
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'customer',
        OLD.customer_id,
        'DELETE',
        CONCAT('name:', OLD.name, ', phone:', OLD.phone_number, ', is_verifyed:', OLD.is_verifyed)
    );
END //

-- Trigger for staff table deletions
CREATE TRIGGER staff_delete
AFTER DELETE ON staff
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'staff',
        OLD.staff_id,
        'DELETE',
        CONCAT('name:', OLD.name, ', salary:', OLD.salary, ', is_active:', OLD.is_active)
    );
END //

-- Trigger for paymentmethod table deletions
CREATE TRIGGER paymentmethodDelete
AFTER DELETE ON paymentmethod
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'paymentmethod',
        OLD.pay_method_id,
        'DELETE',
        CONCAT('pay_method:', OLD.pay_method, ', is_enable:', OLD.is_enable)
    );
END //

-- Trigger for product table deletions
CREATE TRIGGER productDelete
AFTER DELETE ON product
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'product',
        OLD.product_code,
        'DELETE',
        CONCAT('name:', OLD.name, ', price:', OLD.price, ', stock_quantity:', OLD.stock_quantity)
    );
END //

-- Trigger for inventorylog table deletions
CREATE TRIGGER inventorylogDelete
AFTER DELETE ON inventorylog
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'inventorylog',
        OLD.log_id,
        'DELETE',
        CONCAT('product_code:', OLD.product_code, ', quantity_change:', OLD.quantity_change)
    );
END //

-- Trigger for orders table deletions
CREATE TRIGGER ordersDelete
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'orders',
        OLD.order_id,
        'DELETE',
        CONCAT('customer_id:', OLD.customer_id, ', order_status:', OLD.order_status)
    );
END //

-- Trigger for orderitem table deletions
CREATE TRIGGER orderitemDelete
AFTER DELETE ON orderitem
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'orderitem',
        CONCAT(OLD.order_id, '-', OLD.product_code),
        'DELETE',
        CONCAT('order_id:', OLD.order_id, ', product_code:', OLD.product_code, ', qty:', OLD.qty)
    );
END //

-- Trigger for paymenttransaction table deletions
CREATE TRIGGER paymenttransactionDelete
AFTER DELETE ON paymenttransaction
FOR EACH ROW
BEGIN
    INSERT INTO auditLog (table_name, record_id, action, old_data)
    VALUES (
        'paymenttransaction',
        OLD.transaction_id,
        'DELETE',
        CONCAT('order_id:', OLD.order_id, ', status:', OLD.status, ', amount:', OLD.amount)
    );
END //

-- Trigger for productpromotion table deletions
CREATE TRIGGER productpromotionDelete
AFTER DELETE ON productpromotion
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, record_id, action, old_data)
    VALUES (
        'productpromotion',
        CONCAT(OLD.product_code, '-', OLD.promotion_id),
        'DELETE',
        CONCAT('product_code:', OLD.product_code, ', promotion_id:', OLD.promotion_id)
    );
END //

DELIMITER ;