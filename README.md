# SQL Practice

My SQL practice scripts, written while learning relational databases and MySQL. They are organised by statement type, plus two sample databases.

## Files

| File | Contents |
|---|---|
| `ddl.sql` | Data Definition Language: creating and altering tables and schemas |
| `dml.sql` | Data Manipulation Language: inserting, updating and deleting data |
| `dql.sql` | Data Query Language: `SELECT` queries |
| `college.sql` | Practice database: college |
| `eCommerce.sql` | Practice database: e-commerce |
| `SEED_DATA.sql` | Sample data to load into the tables |

## How to run
```bash
mysql -u root -p < college.sql
```
Or open a file in MySQL Workbench and run it.

For a fresh setup, run the schema file first, then `SEED_DATA.sql`.

## Purpose
Hands-on practice for database fundamentals: designing tables, modifying data and writing queries.
