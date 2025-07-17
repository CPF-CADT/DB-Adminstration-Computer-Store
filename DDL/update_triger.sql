use computer_shop;
-- drop trigger staff_update;
-- select * from staff;

-- UPDATE paymentmethod 
-- SET is_enable = FALSE 
-- WHERE pay_method = 'Cash';
-- UPDATE product 
-- SET price = 749.99 
-- WHERE product_code = 'COMP001';
-- UPDATE inventorylog 
-- SET quantity_change = 10 
-- WHERE log_id = 3;
-- UPDATE orders 
-- SET order_status = 'Cancelled' 
-- WHERE order_id = 1;
-- UPDATE orderitem 
-- SET qty = 2 
-- WHERE order_id = 3 ;
-- UPDATE paymenttransaction 
-- SET status = 'Refunded', amount = 80.00 
-- WHERE order_id = 3 ;
-- UPDATE productpromotion 
-- SET promotion_id = 2 
-- WHERE product_code = 'PER001' AND promotion_id = 3;
-- select* from auditLog;
-- select * from customer ;
-- update customer set name= 'kon khmer' where customer_id =1;

DELIMITER //
create trigger customerUpdate
after update on customer
for each row 
begin
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'customer',
        old.customer_id,
        'UPDATE',
        CONCAT('name:', old.name, ', phone:', old.phone_number, ', is_verifyed:', old.is_verifyed),
        CONCAT('name:', new.name, ', phone:', new.phone_number, ', is_verifyed:', new.is_verifyed)
    );
end //
DELIMITER ;

DELIMITER //
create trigger staffUpdate
after update on staff
for each row
begin
    if new.is_active = true and new.salary < old.salary then
        signal sqlstate '45000' SET MESSAGE_TEXT = 'Cannot reduce salary for active staff';
    end if;
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'staff',
        old.staff_id,
        'UPDATE',
        CONCAT('name:', old.name, ', salary:', old.salary, ', is_active:', old.is_active),
        CONCAT('name:', new.name, ', salary:', new.salary, ', is_active:', new.is_active)
    );
end //
DELIMITER ;
-- here
DELIMITER //
create trigger paymentmethodUpdate
after update on paymentmethod
for each row
begin
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'paymentmethod',
        old.pay_method_id,
        'UPDATE',
        concat('pay_method:', old.pay_method, ', is_enable:', old.is_enable),
        concat('pay_method:', new.pay_method, ', is_enable:', new.is_enable)
    );
end //
DELIMITER ;

DELIMITER //
create trigger productUpdate
after update on product
for each row
begin
    if new.stock_quantity != old.stock_quantity then
        insert into inventorylog (product_code, staff_id, change_type, quantity_change, note)
        values (new.product_code, null, 'Update', new.stock_quantity - old.stock_quantity, 'Stock quantity updated via product table');
    end if;
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'product',
        old.product_code,
        'UPDATE',
        concat('name:', old.name, ', price:', old.price, ', stock_quantity:', old.stock_quantity),
        concat('name:', new.name, ', price:', new.price, ', stock_quantity:', new.stock_quantity)
    );
end //
DELIMITER ;

DELIMITER //
create trigger inventorylogUpdate
after update on inventorylog
for each row
begin
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'inventorylog',
        old.log_id,
        'UPDATE',
        concat('product_code:', old.product_code, ', quantity_change:', old.quantity_change),
        concat('product_code:', new.product_code, ', quantity_change:', new.quantity_change)
    );
end //
DELIMITER ;

DELIMITER //
create trigger ordersUpdate
after update on orders
for each row
begin
    if new.order_status = 'Cancelled' and old.order_status != 'Cancelled' then
        update paymenttransaction
        set status = 'Refunded'
        where order_id = new.order_id and status = 'Completed';
    end if;
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'orders',
        old.order_id,
        'UPDATE',
        concat('customer_id:', old.customer_id, ', order_status:', old.order_status),
        concat('customer_id:', new.customer_id, ', order_status:', new.order_status)
    );
end //
DELIMITER ;

DELIMITER //
create trigger orderitemUpdate
after update on orderitem
for each row
begin
    if new.qty != old.qty then
        update product
        set stock_quantity = stock_quantity - (new.qty - old.qty)
        where product_code = new.product_code;
        insert into inventorylog (product_code, staff_id, change_type, quantity_change, note)
        values (new.product_code, null, 'Order Update', -(new.qty - old.qty), 'Order quantity updated');
    end if;
end //
DELIMITER ;

DELIMITER //
create trigger paymenttransactionUpdate
after update on paymenttransaction
for each row
begin
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'paymenttransaction',
        old.transaction_id,
        'UPDATE',
        concat('order_id:', old.order_id, ', status:', old.status, ', amount:', old.amount),
        concat('order_id:', new.order_id, ', status:', new.status, ', amount:', new.amount)
    );
end //
DELIMITER ;

DELIMITER //
create trigger productpromotionUpdate
after update on productpromotion
for each row
begin
    insert into auditLog (table_name, record_id, action, old_data, new_data)
    values (
        'productpromotion',
        concat(old.product_code, '-', old.promotion_id),
        'UPDATE',
        concat('product_code:', old.product_code, ', promotion_id:', old.promotion_id),
        concat('product_code:', new.product_code, ', promotion_id:', new.promotion_id)
    );
end //
DELIMITER ;
select * from orders o ;
select * from paymentmethod p;
