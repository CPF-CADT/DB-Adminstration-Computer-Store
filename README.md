# Computer Shop E Commerce System

A robust and fully-featured database administration project designed for managing the operations of a computer shop.

## 📚 Table of Contents

- [Project Overview](#-project-overview)
- [Features](#-features)
- [Technologies Used](#-technologies-used)
- [Team Members](#-team-members)
- [Backup & Recovery](#-backup--recovery)
- [Performance & Optimization](#-performance--optimization)
- [Learning Outcomes](#-learning-outcomes)
- [References](#-references)

## 🧩 Project Overview

This project aims to build a scalable, secure, and high-performance Database System for a Computer Shop. It handles inventory, orders, payment tracking, user management, and integrates both backend logic and frontend interfaces for practical use.

## ✅ Features

- 🔐 **Role-Based Access Control (RBAC)**: Securely manage user privileges and access to different functionalities.
- 📦 **Order Management**: Comprehensive system for tracking products, and customer orders.
- **Stored Procedures, Triggers, and Views**: Utilize advanced database features for efficient data manipulation and reporting.
- **Performance Testing & Query Optimization**: Ensures high performance and responsiveness of the database system.
- **Automated Backup & Recovery System**: Robust system for data protection and disaster recovery.
- **Full Stack Web Application (React + Node.js)**: User-friendly web application for interacting with the database.

## 🛠 Technologies Used

- **MySQL 8.0+**: Core DBMS
- **Python**: Data generation scripts
- **Node.js + Express**: RESTful APIs
- **React.js**: Web dashboard
- **Windows Task Scheduler**: Automated backups
- **MySQLbinlog, mysqldump**: Backup utilities

## 👨‍💻 Team Members

| Name            |
| :-------------- |
| Cheng Chanpanha |
| Chhun Sivheng   |
| Choun Rathanak  |
| Lim Lyheang     |
| Sat Panha       |
| Phy Vathanak    |

## Backup & Recovery

- **Full Backup**: Weekly at 12 AM Sunday
- **Differential Backup**: 3x Daily
- **Incremental Backup**: Daily at 2 AM
- **Recovery Scenarios**: Crash, accidental delete, full failure
- **Tools used**: `mysqldump`, `mysqlbinlog`, custom Python scripts and node js

## Performance & Optimization

- Optimized complex SQL queries (joins, subqueries).
- Benchmarked using 10M+ row datasets.
- Reduced query time from minutes to seconds.

## Learning Outcomes

- Hosted and configured DB on LAN with access control.
- Designed & applied RBAC securely.
- Automated large-scale data generation with Python.
- Optimized slow SQL with smart indexing.
- Built backup strategies with real-world recovery cases.

## 🔗 References

- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Express.js Docs](https://expressjs.com/)
- [JWT Introduction](https://jwt.io/introduction/)
- [RBAC Best Practices](https://nvlpubs.nist.gov/nistpubs/srb/NIST.SP.800-162.pdf) (Example, link might need adjustment)
- [SQL Performance Tips](https://www.sqlshack.com/sql-query-performance-tuning-tips/) (Example, link might need adjustment)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
- [DigitalOcean MySQL Backup Guide](https://www.digitalocean.com/community/tutorials/how-to-back-up-your-mysql-databases-on-ubuntu-20-04) (Example, link might need adjustment)
