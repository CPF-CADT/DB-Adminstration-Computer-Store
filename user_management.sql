USE computer_shop;

CREATE ROLE IF NOT EXISTS 'database_admin';
CREATE ROLE IF NOT EXISTS 'lead_developer';
CREATE ROLE IF NOT EXISTS 'senior_backend_developer';
CREATE ROLE IF NOT EXISTS 'devops_engineer';
CREATE ROLE IF NOT EXISTS 'junior_backend_developer';
CREATE ROLE IF NOT EXISTS 'qa_validation_engineer';
CREATE ROLE IF NOT EXISTS 'data_analyst';

GRANT ALL PRIVILEGES ON `computer_shop`.* TO 'database_admin' WITH GRANT OPTION;

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER ON `computer_shop`.* TO 'lead_developer';

GRANT SELECT, INSERT, UPDATE, DELETE ON `computer_shop`.* TO 'senior_backend_developer';

GRANT SELECT, ALTER ON `computer_shop`.* TO 'devops_engineer';

GRANT SELECT, INSERT, UPDATE ON `computer_shop`.`product` TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON `computer_shop`.`category` TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON `computer_shop`.`typeproduct` TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON `computer_shop`.`brand` TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON `computer_shop`.`cartitem` TO 'junior_backend_developer';
GRANT SELECT, INSERT, UPDATE ON `computer_shop`.`orderitem` TO 'junior_backend_developer';

GRANT SELECT ON `computer_shop`.* TO 'qa_validation_engineer';

GRANT SELECT ON `computer_shop`.* TO 'data_analyst';



CREATE USER IF NOT EXISTS 'sok_dara'@'localhost' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'sat_panha'@'localhost' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'phy_vathanak'@'localhost' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'choun_rathanak'@'localhost' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'cheng_chanpanha'@'localhost' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'chhun_sivheng'@'localhost' IDENTIFIED BY 'CADT_SE_G3';
CREATE USER IF NOT EXISTS 'lim_lyheang'@'localhost' IDENTIFIED BY 'CADT_SE_G3';


GRANT 'database_admin' TO 'sok_dara'@'localhost';
GRANT 'lead_developer' TO 'sat_panha'@'localhost';
GRANT 'senior_backend_developer' TO 'phy_vathanak'@'localhost';
GRANT 'devops_engineer' TO 'choun_rathanak'@'localhost';
GRANT 'junior_backend_developer' TO 'cheng_chanpanha'@'localhost';
GRANT 'qa_validation_engineer' TO 'chhun_sivheng'@'localhost';
GRANT 'data_analyst' TO 'lim_lyheang'@'localhost';

FLUSH PRIVILEGES;