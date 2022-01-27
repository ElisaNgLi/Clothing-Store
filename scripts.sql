-- DDL SCRIPTS
DROP TABLE SHIPMENTLINE; 
DROP TABLE SHIPMENT; 
DROP TABLE ORDERLINE;
DROP TABLE INVENTORY; 
DROP TABLE PRODUCTS; 
DROP TABLE PAYMENT; 
DROP TABLE ORDERS; 
DROP TABLE ORDERSOURCE;
DROP TABLE CATEGORIES; 
DROP TABLE COLOR;
DROP TABLE CUSTOMERS; 
 
CREATE TABLE customers( 
customerNumber 	NUMBER(10), 
firstname 		VARCHAR2(30) NOT NULL, 
lastname 		VARCHAR2(30) NOT NULL, 
middlename 	            VARCHAR2(30), 
dateofbirth 		DATE NOT NULL, 
streetAddress 	            VARCHAR2(30) NOT NULL, 
city			VARCHAR2(30) NOT NULL, 
province 		VARCHAR2(2) NOT NULL, 
postalCode 		VARCHAR2(7) NOT NULL, 
phoneNumber 	            NUMBER(10) NOT NULL, 
userID		            VARCHAR2(30) CONSTRAINT cus_userID_uk UNIQUE NOT NULL, 
password 		VARCHAR2(30) NOT NULL, 
emailAddress  	VARCHAR2(30) CONSTRAINT cus_email_uk UNIQUE 
); 
 
 
CREATE TABLE color( 
colorCode 		Number(10), 
color 			VARCHAR2(20) CONSTRAINT ColorDesc_uk UNIQUE
 ); 
 

CREATE TABLE categories( 
CategoryID 		       Number(5), 
Description 		       VARCHAR2(100) Constraint CatDesc_ck CHECK(Description IN  ('Women','Men','Children','Outdoor Gear','Leisure')), 
CONSTRAINT CatDesc_uk UNIQUE(Description)
); 
 

CREATE TABLE ordersource( 
ordersourceID            NUMBER(5), 
title	                       VARCHAR2(30), 
description                 VARCHAR2(50) CONSTRAINT ordSorce_desc_uk UNIQUE 
); 
 

CREATE TABLE orders ( 
orderNumber               	NUMBER(5), 
orderDate                 		DATE NOT NULL, 
orderSourceID             	NUMBER(5) NOT NULL, 
customerNumber       		NUMBER(10) NOT NULL
); 
 
  
CREATE TABLE payment (  
paymentNumber              		NUMBER(10), 
payDate                    			DATE NOT NULL, 
paymentMethod              		VARCHAR2(13) NOT NULL, 
totalAmount                		NUMBER(10,2) NOT NULL, 
orderNumber                		NUMBER(5) NOT NULL,  
CONSTRAINT paymentMethod_ck CHECK (paymentMethod IN ('CH', 'CC')), 
CONSTRAINT totalAmount_ck CHECK (totalAmount > =0)
); 
 
 
CREATE TABLE products( 
productCode 		NUMBER(10), 
description 		VARCHAR2(100) CONSTRAINT product_desc_uk UNIQUE, 
categoryID 		NUMBER(10) 
); 
 
 
CREATE TABLE inventory( 
inventoryNumber     	NUMBER(10), 
productCode	   	NUMBER(10) NOT NULL, 
colorCode              	NUMBER(10) NOT NULL,  
invSize                  	VARCHAR2(3) CONSTRAINT inv_size_ck CHECK(invSize IN ('S', 'M', 'L', 'XL', 'XXL')),  
price 			NUMBER(6, 2) NOT NULL CONSTRAINT inv_price_ck CHECK(price <= 
 9999.99), 
quantityOnHand 	NUMBER(5) NOT NULL CONSTRAINT inv_qoh_ck CHECK 
(quantityOnHand>=0), 
CONSTRAINT inv_prod_color_size_uk UNIQUE(productCode, colorCode, invSize) 
); 
 
 
CREATE TABLE orderLine( 
orderNumber                           NUMBER(5), 
itemNumber                             NUMBER(5), 
quantity                                    NUMBER(5)   NOT NULL  CONSTRAINT Quantity_ck CHECK(quantity>0), 
inventoryNumber                     NUMBER(10) NOT NULL 
);
 
  
CREATE TABLE shipment (  
shipmentID               	NUMBER(5),
expectedDate             	DATE, 
orderNumber              	NUMBER(5)
); 
 
 
CREATE TABLE shipmentLine ( 
shipmentID                        	NUMBER(5), 
inventoryNumber        	NUMBER(10),  
quantityShipped           	NUMBER(5) NOT NULL,  
dateReceived             		DATE,  
CONSTRAINT qtyshiped_ck check (quantityShipped > 0)
);

-- PK and FK constraints 
ALTER TABLE customers  
ADD CONSTRAINT cus_cusNum_pk PRIMARY KEY(customerNumber);  
 
ALTER TABLE color 
ADD CONSTRAINT color_colorCode_pk PRIMARY KEY(colorCode);  
 
ALTER TABLE categories 
ADD CONSTRAINT cat_categoryID_pk PRIMARY KEY (categoryID);  
 
ALTER TABLE ordersource  
ADD CONSTRAINT odrSource_odrSourceID_pk PRIMARY KEY(orderSourceID);  
 
ALTER TABLE orders  
ADD CONSTRAINT ord_orderNumber_pk   PRIMARY KEY (orderNumber);  
 
ALTER TABLE orders   
ADD CONSTRAINT ord_orderSourceID_Fk FOREIGN KEY (orderSourceID)   
REFERENCES ordersource (orderSourceID);  
 
ALTER TABLE orders   
ADD CONSTRAINT ord_customerNumber_Fk   FOREIGN KEY (customerNumber)   
REFERENCES customers (customerNumber);   
 
ALTER TABLE payment   
ADD CONSTRAINT pay_paymentNumber_pk PRIMARY KEY (Paymentnumber);  
 
ALTER TABLE payment   
ADD CONSTRAINT pay_orderNumber_fk   FOREIGN KEY (orderNumber)   
REFERENCES orders (orderNumber);  
 
ALTER TABLE products  
ADD CONSTRAINT prod_prodCode_pk PRIMARY KEY(productCode);  
  
ALTER TABLE products  
ADD CONSTRAINT prod_cat_fk FOREIGN KEY(categoryID) 
REFERENCES categories(categoryID);  
 
ALTER TABLE inventory  
ADD CONSTRAINT inventory_invNum_pk PRIMARY KEY(inventoryNumber);  
 
ALTER TABLE inventory  
ADD CONSTRAINT inventory_prodCode_fk FOREIGN KEY(productCode) 
REFERENCES products(productCode);  
 
ALTER TABLE inventory   
ADD CONSTRAINT inventory_colorCode_fk FOREIGN KEY(colorCode)
REFERENCES color(colorCode);  
 
ALTER TABLE orderLine 
ADD CONSTRAINT ordLine_OrNum_ItemNum_pk PRIMARY KEY(orderNumber, itemNumber); 
 
ALTER TABLE orderLine 
ADD CONSTRAINT ordLineE_OrdNumLine_fk FOREIGN KEY (orderNumber) 
REFERENCES orders(orderNumber); 
 
ALTER TABLE orderLine 
ADD CONSTRAINT ordLine_InvNumber_fk FOREIGN KEY (inventoryNumber) 
REFERENCES inventory(inventoryNumber); 
 
ALTER TABLE shipment   
ADD CONSTRAINT shipmentID_pk  PRIMARY KEY (shipmentID);  
 
ALTER TABLE shipment  
ADD CONSTRAINT ship_orderNumber_fk FOREIGN KEY (orderNumber)   
REFERENCES orders (orderNumber);  
 
ALTER TABLE shipmentLine   
ADD CONSTRAINT shipLine_shipID_invNum_pk PRIMARY KEY (ShipmentID, inventoryNumber);  
 
ALTER TABLE ShipmentLine  
ADD CONSTRAINT shipLine_shipmentID_fk   FOREIGN KEY (shipmentID)      
REFERENCES shipment (shipmentID);  
 
ALTER TABLE shipmentline  
ADD CONSTRAINT shipLine_inventoryNumber_fk   FOREIGN KEY (InventoryNumber) 
REFERENCES inventory (inventoryNumber);

--DML Scripts

ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR'; 
 
  
INSERT INTO customers   
VALUES (1000000000, 'John', 'Snow', 'Sam', '11-NOV-1993', '350 Saint Paul East', 'Toronto', 'ON','M1M 1M1', 1112223333, 'jSnow', 'password', 'jSnow@gmail.com');  
 
  
INSERT INTO customers   
VALUES (1000000001, 'Kelly','Smith', 'Joshua', '03-MAR-1990', '120 Saint Paul East', 'Toronto', 'ON','M3M 1M1', 1112225553, 'kSmith', 'pwrd1234', 'kSmith@gmail.com');  
 
 
INSERT INTO customers   
VALUES (1000000002, 'Reynold', 'Han', 'John', '04-MAY-1999', '250 Saint Paul East', 'Toronto', 'ON','M1M 3M1', 1125432133, 'rHan', 'passwrd235', 'rHan@gmail.com');  
 
 
INSERT INTO color  
VALUES(1, 'Red');  
 
  
INSERT INTO color
VALUES(2, 'Blue');  
 
  
INSERT INTO color  
VALUES(3, 'Purple');  
 
 
INSERT INTO categories 
VALUES (1, 'Women');   
 

INSERT INTO categories 
VALUES (2, 'Men');   
 
 
INSERT INTO categories 
VALUES (3, 'Children');  
 
   
INSERT INTO categories 
VALUES (4, 'Outdoor Gear');  
 
  
 
INSERT INTO categories 
VALUES (5, 'Leisure');  
 
  
INSERT INTO ordersource  
VALUES(1, 'Summer 2020', 'Summer 2020 catalog');  
 

INSERT INTO ordersource  
VALUES(2, 'Fall 2020', 'Fall 2020 catalog');  
  
 
INSERT INTO ordersource  
VALUES(3, 'Winter 2021', 'Winter 2021 catalog');  
 
  
 
INSERT INTO ORDERS 
VALUES (7839,'11-NOV-2020', 1, 1000000000);  
 
  
 
INSERT INTO ORDERS 
VALUES (7840,'01-MAY-2020', 3, 1000000002);  
 
 
INSERT INTO ORDERS 
VALUES (7782,'20-DEC-2020',2, 1000000001);  


INSERT INTO ORDERS 
VALUES (7843,'01-MAY-2008', 3, 1000000002);  
  
 
INSERT INTO PAYMENT (PAYMENTNUMBER, PAYDATE, PAYMENTMETHOD, TOTALAMOUNT, ORDERNUMBER) 
VALUES (10,'11-NOV-2020','CC', 118.90 , 7839);  
 
  
 
INSERT INTO PAYMENT (PAYMENTNUMBER, PAYDATE, PAYMENTMETHOD, TOTALAMOUNT, ORDERNUMBER) 
VALUES (20,'01-MAY-2020','CH', 1921.32, 7840);  
 
  
 
INSERT INTO PAYMENT (PAYMENTNUMBER, PAYDATE, PAYMENTMETHOD, TOTALAMOUNT, ORDERNUMBER) 
VALUES (30,'20-DEC-2020','CC', 19.90, 7782);  
 

INSERT INTO PAYMENT (PAYMENTNUMBER, PAYDATE, PAYMENTMETHOD, TOTALAMOUNT, ORDERNUMBER) 
VALUES (40,'20-DEC-2008','CH', 29.90, 7843);  
 
  
 
INSERT INTO products  
VALUES(21135, 'Blue pants', 3);  
 
   
INSERT INTO products  
VALUES(38291, 'Yellow skirt', 1);  
 
  
 
INSERT INTO products  
VALUES(092834, 'White shorts', 2);  
 
  
 
INSERT INTO inventory 
VALUES (123, 21135, 1, 'S', 29.99, 10);  
 
 
INSERT INTO inventory 
VALUES (127, 38291, 2, 'M', 19.99, 20);   
   
 
INSERT INTO inventory 
VALUES (138, 092834, 3,'XL', 50.23, 100);  
 
 
INSERT INTO inventory (inventoryNumber, productCode, colorCode, price, quantityOnHand) 
VALUES (128, 21135, 1, 10.99, 20);  
 
   
INSERT INTO orderline 
VALUES(7839, 1, 3, 123);  
 
  
 
INSERT INTO orderline 
VALUES(7840, 2, 5, 128);  
  
 
INSERT INTO orderline 
VALUES(7782, 1, 1, 127);  

 
INSERT INTO orderline 
VALUES(7843, 1, 10, 138);  
 
  
 
INSERT INTO SHIPMENT (SHIPMENTID, EXPECTEDDATE, ORDERNUMBER) 
VALUES (1009, '16-NOV-2020', 7839);  
 
  
 
INSERT INTO SHIPMENT (SHIPMENTID, EXPECTEDDATE, ORDERNUMBER) 
VALUES (1098, '08-MAY-2020', 7840);  
 
  
 
INSERT INTO SHIPMENT (SHIPMENTID, EXPECTEDDATE, ORDERNUMBER) 
VALUES (1290, '26-DEC-2020', 7782);  

 
INSERT INTO SHIPMENT (SHIPMENTID, EXPECTEDDATE, ORDERNUMBER) 
VALUES (1090, '26-DEC-2008', 7843);  
 
  
  
INSERT INTO SHIPMENTLINE  
VALUES (1009, 123, 1200, '01-JAN-2021');  
 
  

INSERT INTO SHIPMENTLINE  
VALUES (1098, 127, 140, '03-JAN-2021');  
 
  
 
INSERT INTO SHIPMENTLINE  
VALUES (1290, 138, 220, '05-JAN-2009');

 
INSERT INTO SHIPMENTLINE  
VALUES (1090, 128, 10, '05-MAY-2020');


COMMIT;


--DDL Scripts for views

CREATE OR REPLACE VIEW Cust_OrdDate_ProdQty_vu 
AS 
SELECT 	c.firstName || ' ' || c.lastName AS "FULL_NAME", o.orderNumber AS "ORDER_NUMBER", o.orderDate AS "ORDER_DATE", p.description AS "PROD_DESC", i.INVsize AS "Size", i.price AS  "Price", sl.dateReceived AS "DATE_SHIPPED", ol.quantity AS "QUANTITY_ORDERED" 
FROM	customers c   	
JOIN 		orders o 
ON		c.customerNumber= o.customerNumber 
JOIN		orderline ol 
ON		o.orderNumber = ol.orderNumber 
JOIN		inventory i 
ON		i.inventoryNumber = ol.inventoryNumber 
JOIN		productS p 
ON		p.productCode = I.productCode 
JOIN		shipmentline sl 
ON		sl.inventoryNumber = i.inventoryNumber;
