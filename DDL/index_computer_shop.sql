USE computer_shop;

-- ================================
-- DROP ALL NON-ESSENTIAL INDEXES
-- ================================
-- CUSTOMER
DROP INDEX idxCustomerPhoneNumber ON customer;
DROP INDEX idxCustomerID ON customer;
DROP INDEX idxCustomerAddressID ON customer;

-- PRODUCT
DROP INDEX idxProductName ON product;
DROP INDEX idxProducCode ON product;
DROP INDEX idxProductCode ON product;
DROP INDEX idxProductCategory ON product;
DROP INDEX idxProductCodeCategory ON product;

-- ORDERS
DROP INDEX idx_orders_customer_date ON orders;
DROP INDEX idxOrdersCustomerDate ON orders;
DROP INDEX idxOrdersStatus ON orders;
DROP INDEX idxOrdersCustomerAddress ON orders;

-- ORDERITEM
DROP INDEX idxOrderitemProductCodeQty ON orderitem;
DROP INDEX idxOrderitemProductCode ON orderitem;
DROP INDEX idxOrderitemOrderID ON orderitem;

-- PRODUCTFEEDBACK
DROP INDEX idx_productfeedback_product_date ON productfeedback;
DROP INDEX idxProductfeedbackProductDate ON productfeedback;
DROP INDEX idxProductFeedbackProduct ON productfeedback;
DROP INDEX idxProductFeedbackComposite ON productfeedback;

-- INVENTORYLOG
DROP INDEX idx_inventorylog_product_date ON inventorylog;
DROP INDEX idxInventoryProductDate ON inventorylog;

-- PAYMENTTRANSACTION
DROP INDEX idx_paymenttransaction ON paymenttransaction;
DROP INDEX idxPaymentTransactionOrderID ON paymenttransaction;

-- ADDRESS
DROP INDEX idxAddressID ON address;

-- ================================
-- CREATE OPTIMIZED INDEXES
-- ================================
-- CUSTOMER
CREATE INDEX idxCustomerPhoneNumber ON customer(phone_number);
CREATE INDEX idxCustomerID ON customer(customer_id);

-- PRODUCT
CREATE INDEX idxProductName ON product(name);
CREATE INDEX idxProductCode ON product(product_code);
CREATE INDEX idxProductCategory ON product(category_id);
CREATE INDEX idxProductCodeCategory ON product(product_code, category_id);

-- ORDERS
CREATE INDEX idxOrdersCustomerDate ON orders(customer_id, order_date);
CREATE INDEX idxOrdersStatus ON orders(order_status);
CREATE INDEX idxOrdersCustomerAddress ON orders(customer_id, address_id);
CREATE INDEX idx_orderitem_prod_qty_price ON orderitem(product_code, qty, price_at_purchase);

-- ORDERITEM
CREATE INDEX idxOrderitemOrderID ON orderitem(order_id);
CREATE INDEX idxOrderitemProductCode ON orderitem(product_code);

-- PRODUCTFEEDBACK
CREATE INDEX idxProductFeedbackDate ON productfeedback(product_code, feedback_date);
CREATE INDEX idxProductFeedbackComposite ON productfeedback(product_code, rating, customer_id);

-- INVENTORYLOG
CREATE INDEX idxInventoryProductDate ON inventorylog(product_code, change_date);

CREATE INDEX idx_paytrans_method_status_amount
ON paymenttransaction(pay_method_id, status, amount);

