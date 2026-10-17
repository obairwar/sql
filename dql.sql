USE eCommerce;
 -- ' * ' MEANS ALL/EVERYTHING 
SELECT * FROM products; -- select all columns present in the product table


-- FETCH THE DESIGRED COLUMN FROM THE TABLE
SELECT
	product_id,
    product_name AS alias_Product_name  -- ALIAS
FROM products;
	

-- UNIQUE COUNTRY NAME
-- DISTINCT -> REMOVES THE DUBLICATES AND RETURNS THE UNIQUE NAMES

SELECT DISTINCT country from customers;



-- FILTERATION -----------------

SELECT * FROM products
WHERE price >=200;

-- PRODUCTS HAVING STOCK QUANTITY  >0 AND PRICE <150;

SELECT * FROM products
WHERE stock_quantity >0 AND price <150;


--  products having 0 stock quantity or price <150

SELECT * FROM products
WHERE stock_quantity =0 
	OR price <150;

-- products which are not active

SELECT * FROM products
WHERE NOT is_Active;

-- PRODUCTS HAVING PRICE >120 AND PRICE <200

SELECT * FROM products
WHERE price>120 AND price<200;

SELECT * FROM products
WHERE price BETWEEN 120 AND 200;  -- both end numbers are inclusive , the query is like >= and <=

-- product from electronics as well as books

SELECT* FROM products
WHERE category_id =1 
or category_id=3
or category_id=4;

 -- IN operator
 SELECT * FROM products
 WHERE product_id IN(1,3,4);  -- THIS QUERY IS SAME AS THE ABOVE ONE(OR,OR)
 
 -- PRODUCT HAVING PRODUCT NAME STARTING WITH "WIRELESS"
 -- EX: WIRELESS HEADPHONES, WIRELESS MOUSE
 
 SELECT * FROM products
 WHERE product_name LIKE 'WIRELESS%';  -- % WILDCARD ENTRY
 
 
 -- CUSTOMERS WHO DOES NOT HAVE PHONE NUMBERS
 SELECT * FROM customers
 WHERE phone IS NULL;
 
  -- COALESCE (value1,value2) :Substituting missing data with a default value, like  COALESCE(phone_number, 'No Phone')
 SELECT 
	first_name,
    last_name,
    COALESCE(phone,'phone number unavailable'),
    COALESCE(city,'No City')
FROM customers;


-- -----------------------------
-- sorting--------------

SELECT * FROM products
ORDER BY price ASC; -- ASC = ASCENDING , DESC = DESCENDING


-- product from cheap to expensive price for each category

SELECT * FROM products
ORDER BY category_id,price;

-- expensive to cheepest
SELECT * FROM products
ORDER BY category_id, price DESC;

-- category in dec order and price in ascending
SELECT * FROM products
ORDER BY category_id DESC ,price ASC;

--  TOP 5 most expensive products => LIMIT 
SELECT * FROM products
ORDER BY price DESC
LIMIT 5;


 -- PAGINATION
 SELECT * FROM products
 ORDER BY product_id
 limit 5
 OFFSET 5;  -- SKIP the first 5 results.  // OFFSET => Specifies the number of rows to skip from the beginning 
  -- OFFSET = (page-1) * limit
 