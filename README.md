# goit-rdb-hw-02
Проектування баз даних з використанням семантичних моделей

This repository contains the completed homework for Topic 2:  
✅ Normalization to 1NF → 2NF → 3NF  
✅ ER Diagram (ERD)  
✅ SQL schema creation (DDL)  

---

## 📌 Initial Table (not normalized)

| Номер_замовлення | Назва_товару_і_кількість | Адреса_клієнта | Дата_замовлення | Клієнт |
|---:|---|---|---|---|
| 101 | Лептоп: 3, Мишка: 2 | Хрещатик 1 | 2023-03-15 | Мельник |
| 102 | Принтер: 1 | Басейна 2 | 2023-03-16 | Шевченко |
| 103 | Мишка: 4 | Комп’ютерна 3 | 2023-03-17 | Коваленко |

---

# ✅ Step 1 — 1NF (First Normal Form)

### ✅ 1NF requirements:
- Each field contains **atomic values**
- No lists / repeating groups inside a column

### ✅ Table in 1NF: `Orders_1NF`

| Номер_замовлення | Дата_замовлення | Клієнт | Адреса_клієнта | Назва_товару | Кількість |
|---:|---|---|---|---|---:|
| 101 | 2023-03-15 | Мельник | Хрещатик 1 | Лептоп | 3 |
| 101 | 2023-03-15 | Мельник | Хрещатик 1 | Мишка | 2 |
| 102 | 2023-03-16 | Шевченко | Басейна 2 | Принтер | 1 |
| 103 | 2023-03-17 | Коваленко | Комп’ютерна 3 | Мишка | 4 |

---

# ✅ Step 2 — 2NF (Second Normal Form)

### ✅ 2NF requirements:
- Table must already be in 1NF
- No **partial dependency** on part of a composite key

### ✅ Result: two tables in 2NF

---

## Table 2NF #1 — `Orders_2NF`

| Номер_замовлення (PK) | Дата_замовлення | Клієнт | Адреса_клієнта |
|---:|---|---|---|
| 101 | 2023-03-15 | Мельник | Хрещатик 1 |
| 102 | 2023-03-16 | Шевченко | Басейна 2 |
| 103 | 2023-03-17 | Коваленко | Комп’ютерна 3 |

---

## Table 2NF #2 — `OrderItems_2NF`

| Номер_замовлення (FK) | Назва_товару | Кількість |
|---:|---|---:|
| 101 | Лептоп | 3 |
| 101 | Мишка | 2 |
| 102 | Принтер | 1 |
| 103 | Мишка | 4 |

Primary key for `OrderItems_2NF`:  
✅ `(Номер_замовлення, Назва_товару)`

---

# ✅ Step 3 — 3NF (Third Normal Form)

### ✅ 3NF requirements:
- Database must already be in 2NF
- No **transitive dependency** (non-key attributes must not depend on other non-key attributes)

### ✅ Final tables in 3NF

---

## Table 3NF #1 — `Clients`

| client_id (PK) | client_name | client_address |
|---:|---|---|
| 1 | Мельник | Хрещатик 1 |
| 2 | Шевченко | Басейна 2 |
| 3 | Коваленко | Комп’ютерна 3 |

---

## Table 3NF #2 — `Orders`

| order_id (PK) | order_date | client_id (FK) |
|---:|---|---:|
| 101 | 2023-03-15 | 1 |
| 102 | 2023-03-16 | 2 |
| 103 | 2023-03-17 | 3 |

---

## Table 3NF #3 — `Products`

| product_id (PK) | product_name |
|---:|---|
| 1 | Лептоп |
| 2 | Мишка |
| 3 | Принтер |

---

## Table 3NF #4 — `OrderItems`

| order_id (FK) | product_id (FK) | quantity |
|---:|---:|---:|
| 101 | 1 | 3 |
| 101 | 2 | 2 |
| 102 | 3 | 1 |
| 103 | 2 | 4 |

Primary key:  
✅ `(order_id, product_id)`

---

# ✅ ER Diagram (Mermaid)

```mermaid
erDiagram

    CLIENTS ||--o{ ORDERS : "places"
    ORDERS ||--o{ ORDER_ITEMS : "contains"
    PRODUCTS ||--o{ ORDER_ITEMS : "included in"

    CLIENTS {
        int client_id PK
        varchar client_name
        varchar client_address
    }

    ORDERS {
        int order_id PK
        date order_date
        int client_id FK
    }

    PRODUCTS {
        int product_id PK
        varchar product_name
    }

    ORDER_ITEMS {
        int order_id PK, FK
        int product_id PK, FK
        int quantity
    }



✅ SQL Schema
The SQL script for creating all tables is available here:
📌 schema.sql


✅ Screenshots
All required screenshots are stored in screenshots/ folder:
p1_1NF.png — Table in 1NF
p2_2NF.png — Two tables in 2NF
p3_3NF.png — Final set of tables in 3NF
p4_ERD.png — ER Diagram (screenshot)
p5_workbench_schema.png — Database schema in MySQL Workbench