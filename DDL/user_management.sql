USE computer_shop;
INSERT INTO roles (role_name) VALUES 
('database_admin'),
('lead_developer'),
('senior_backend_developer'),
('devops_engineer'),
('junior_backend_developer'),
('qa_validation_engineer'),
('data_analyst');

CREATE ROLE  'database_admin';
CREATE ROLE  'lead_developer';
CREATE ROLE  'senior_backend_developer';
CREATE ROLE  'devops_engineer';
CREATE ROLE  'junior_backend_developer';
CREATE ROLE  'qa_validation_engineer';
CREATE ROLE  'data_analyst';


GRANT ALL PRIVILEGES ON computer_shop.* TO 'database_admin' WITH GRANT OPTION;

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER ON computer_shop.* TO 'lead_developer';

GRANT SELECT, INSERT, UPDATE, DELETE ON computer_shop.* TO 'senior_backend_developer';

GRANT SELECT, ALTER ON computer_shop.* TO 'devops_engineer';

GRANT SELECT, INSERT, UPDATE ON computer_shop.product TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON computer_shop.category TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON computer_shop.typeproduct TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON computer_shop.brand TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON computer_shop.cartitem TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON computer_shop.orderitem TO 'junior_backend_developer';

GRANT SELECT ON computer_shop.* TO 'qa_validation_engineer';

GRANT SELECT ON computer_shop.* TO 'data_analyst';


CREATE USER IF NOT EXISTS 'sok_dara'@'%' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'sat_panha'@'%' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'phy_vathanak'@'%' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'choun_rathanak'@'%' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'cheng_chanpanha'@'%' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'chhun_sivheng'@'%' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'lim_lyheang'@'%' IDENTIFIED BY 'CADT_SE_G3';


SET DEFAULT ROLE 'database_admin' TO 'sok_dara'@'%';
SET DEFAULT ROLE 'lead_developer' TO 'sat_panha'@'%';
SET DEFAULT ROLE 'senior_backend_developer' TO 'phy_vathanak'@'%';
SET DEFAULT ROLE 'devops_engineer' TO 'choun_rathanak'@'%';
SET DEFAULT ROLE 'junior_backend_developer' TO 'cheng_chanpanha'@'%';
SET DEFAULT ROLE 'qa_validation_engineer' TO 'chhun_sivheng'@'%';
SET DEFAULT ROLE 'data_analyst' TO 'lim_lyheang'@'%';
FLUSH PRIVILEGES;
-- 
-- select * from paymenttransaction p where status ='Completed';
-- select * from orders limit 100 OFFSET 100;
-- 
-- 
-- use computer_shop;
-- desc Students;
-- 
-- select * from product limit 10;
-- create database computer_shop_db2;
-- use computer_shop_db2;
-- select count(*) from orderitem;
-- 
-- 
-- SELECT table_schema AS "Database",
--        ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)"
-- FROM information_schema.tables
-- WHERE table_schema = 'computer_shop_db2'
-- GROUP BY table_schema;