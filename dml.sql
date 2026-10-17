USE eCommerce;
select * from customers;

 -- update the quantity of the products
 
UPDATE products
SET stock_quantity=50 
WHERE product_id=1;

-- update all products
 
UPDATE products
SET is_active=FALSE
WHERE product_id>0;


-- increment and decrement of data

UPDATE products
SET price= price+100
WHERE product_id>0;

UPDATE products
SET price=price-100
WHERE product_id=3;

-- delete the data
DELETE FROM products
WHERE product_id=7;



