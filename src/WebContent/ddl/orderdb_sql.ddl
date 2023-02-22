CREATE DATABASE orders;
go;

USE orders;
go;

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Hand Tools');
INSERT INTO category(categoryName) VALUES ('Pumps');
INSERT INTO category(categoryName) VALUES ('Fuel');
INSERT INTO category(categoryName) VALUES ('Power Tools');
INSERT INTO category(categoryName) VALUES ('Consumables');
INSERT INTO category(categoryName) VALUES ('PPE');
INSERT INTO category(categoryName) VALUES ('Footwear');
INSERT INTO category(categoryName) VALUES ('Essentials');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pulaski', 1, 'Good for diggin',65.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Shovel',1,'Good for leanin',45.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fallers Axe',1,'Only used to pound wedges',51.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fire rake',1,'Dont bother',80.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mark III',2,'65lbs of raw power - straps broken for sure',4000.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Striker',2,'Cute pump for IA crews',2500.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Floto',2,'Cool idea, will never be used',3345.95);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Husqvarna 365',4,'Bread and butter power head',1200.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('20L Jerry',3,'1 20L Jerry Can',33.33);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('10L Jerry',3,'1 10L Jerry Can',15.15);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Jet A',3,'1 drum Jet A Fuel',430.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hard Hat',6,'1 Hard Hat',21.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Safety Glasses',6,'1 pair non tinted',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Electrial Tape',5,'6 rolls',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Flagging Tape - Pink',5,'6 rolls',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Scarpa Fuego',7,'Mountain Style boots',420.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Nicks',7,'Hot shot wanna-be heeled boots',650.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dakota Standard',7,'Classic rookie boots, big mistake',95.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Haix Chainsaw Boots',7,'Heroes wear Haix',525.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Copenhagen Wintergreen',8,'1 Log your buddy picked up stateside',100.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Odens Extreme',8,'1 log swedish snus - healthy alternative',123.32);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Baby Wipes',8,'1 package',15.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pit Vipers',8,'1 pair - pairs well with mullet',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Medicated Foot Powder',8,'1 bottle - not just for feet',9.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bug net',8,'Single item for export to Northern Alberta',1.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Jack''s New England Clam Chowder',8,'12 - 12 oz cans',9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Singaporean Hokkien Fried Mee',8,'32 - 1 kg pkgs.',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Louisiana Fiery Hot Pepper Sauce',8,'32 - 8 oz bottles',21.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Laughing Lumberjack Lager',8,'24 - 12 oz bottles',14.00);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 65);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 45);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 51.50);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 80);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 4000);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 2500);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 3345.95);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 1200);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 33.33);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 15.15);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Mackenzie', 'Kudrenecky', 'random_email@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Hinton', 'AB', 'T7V 1C1', 'Canada', 'mac' , 'mac');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Tanner', 'Dyck', 'tanner@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Kamloops', 'BC', 'T7V 2B3', 'Canada', 'tanner' , 'tanner');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Blake', 'Ablitt', 'blacke@charity.org', '333-444-5555', '333 Central Crescent', 'Kamloops', 'BC', '33333', 'Canada', 'blake' , 'blake');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Logan', 'Gilroy', 'logan@doe.com', '250-807-2222', '444 Dover Lane', 'Kamloops', 'BC', 'V1V 2X9', 'Canada', 'logan' , 'logan');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Ramon', 'Lawrence', 'ramon@doe.com', '250-807-2221', '446 Dover Lane', 'Kelowna', 'BC', 'V1V 2X7', 'Canada', 'ramon' , 'ramon');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE product SET productImageURL = 'img/1.jpg' WHERE productId = 1;
UPDATE product SET productImageURL = 'img/2.jpg' WHERE productId = 2;
UPDATE product SET productImageURL = 'img/3.jpg' WHERE productId = 3;
UPDATE product SET productImageURL = 'img/4.jpg' WHERE productId = 4;
UPDATE product SET productImageURL = 'img/5.jpg' WHERE productId = 5;
UPDATE product SET productImageURL = 'img/6.jpg' WHERE productId = 6;
UPDATE product SET productImageURL = 'img/7.jpg' WHERE productId = 7;
UPDATE product SET productImageURL = 'img/8.jpg' WHERE productId = 8;
UPDATE product SET productImageURL = 'img/9.jpg' WHERE productId = 9;
UPDATE product SET productImageURL = 'img/10.jpg' WHERE productId = 10;
UPDATE product SET productImageURL = 'img/11.jpg' WHERE productId = 11;
UPDATE product SET productImageURL = 'img/12.jpg' WHERE productId = 12;
UPDATE product SET productImageURL = 'img/13.jpg' WHERE productId = 13;
UPDATE product SET productImageURL = 'img/14.jpg' WHERE productId = 14;
UPDATE product SET productImageURL = 'img/15.jpg' WHERE productId = 15;
UPDATE product SET productImageURL = 'img/16.jpg' WHERE productId = 16;
UPDATE product SET productImageURL = 'img/17.jpg' WHERE productId = 17;
UPDATE product SET productImageURL = 'img/18.jpg' WHERE productId = 18;
UPDATE product SET productImageURL = 'img/19.jpg' WHERE productId = 19;
UPDATE product SET productImageURL = 'img/20.jpg' WHERE productId = 20;
UPDATE product SET productImageURL = 'img/21.jpg' WHERE productId = 21;
UPDATE product SET productImageURL = 'img/22.jpg' WHERE productId = 22;
UPDATE product SET productImageURL = 'img/23.jpg' WHERE productId = 23;
UPDATE product SET productImageURL = 'img/24.jpg' WHERE productId = 24;
UPDATE product SET productImageURL = 'img/25.jpg' WHERE productId = 25;

INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (5, '2022-12-08 12:00:00', 1, 1, 'this thing is sharp');
INSERT INTO review (reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (4, '2022-12-03 11:00:00', 1, 1, 'I use this everyday, has never let me down');