--create tables 

CREATE TABLE COMPANIES(
    company_id VARCHAR2(5) PRIMARY KEY,
    company VARCHAR2(50),
    Headquarters_phone_number VARCHAR2 (20)
);

CREATE TABLE CUSTOMERS(
    customer_id VARCHAR2(5) PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email_address VARCHAR2(100),
    number_of_complaints NUMBER
);

CREATE TABLE ITEMS(
    items_code VARCHAR2(5) PRIMARY KEY,
    item VARCHAR2(100),
    unit_price_rm NUMBER(10,2),
    company_id VARCHAR2(5),
    company VARCHAR2(50),
    headquarters_phone VARCHAR2(20),
    FOREIGN KEY (company_id) REFERENCES COMPANIES(company_id)
);

CREATE TABLE SALES(
    purchase_number NUMBER PRIMARY KEY,
    date_of_purchase DATE,
    customer_id VARCHAR2(5),
    item_code VARCHAR2(5),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(customer_id),
    FOREIGN KEY (item_code) REFERENCES ITEMS (items_code)
);
    
--insert values

--COMPANIES
INSERT INTO COMPANIES VALUES
('CO1','TechNova', '+1-212-555-0181');
INSERT INTO COMPANIES VALUES
('CO2','KeyWorks', '+1-305-555-0222');
INSERT INTO COMPANIES VALUES
('CO3','ConnectIT', '+1-646-555-0456');

--CUSTOMERS
INSERT INTO CUSTOMERS VALUES
('C001','Alice','Johnson','alice.johnson@email.com',1);
INSERT INTO CUSTOMERS VALUES
('C002','Brian','Smith','brian.smith@email.com',0);
INSERT INTO CUSTOMERS VALUES
('C003','Clara','Nguyen','clara.nguyen@email.com',2);

--ITEMS
INSERT INTO ITEMS VALUES
('I101','Wireless Mouse',25.99,'CO1','TechNova','+1-212-555-0181');
INSERT INTO ITEMS VALUES
('I102','Mechanical Keyboard',79.50,'CO2','KeyWorks','+1-305-555-0222');
INSERT INTO ITEMS VALUES
('I103','Noise Cancelling Headphones',149.00,'CO1','TechNova','+1-212-555-0181');

--SALES
INSERT INTO SALES VALUES
(1001, TO_DATE('02-OCT-2025','DD-MON-YYYY'),'C001','I101');
INSERT INTO SALES VALUES
(1002, TO_DATE('05-OCT-2025','DD-MON-YYYY'),'C002','I102');
INSERT INTO SALES VALUES
(1003, TO_DATE('06-OCT-2025','DD-MON-YYYY'),'C003','I103');
INSERT INTO SALES VALUES
(1004, TO_DATE('09-OCT-2025','DD-MON-YYYY'),'C001','I103');

--constraint for unique email
ALTER TABLE CUSTOMERS
ADD CONSTRAINT unique_email UNIQUE (email_address);

--constraint for number of complaints cannot negative
ALTER TABLE CUSTOMERS
ADD CONSTRAINT chk_complaints CHECK (number_of_complaints >= 0);

--find total revenue
SELECT SUM(I.unit_price_rm) AS total_revenue
FROM SALES S
JOIN ITEMS I ON S.item_code = I.items_code;

--display customer details for customers who hv made at least one purchase
SELECT DISTINCT C.*
FROM CUSTOMERS C
JOIN SALES S ON C.customer_id = S.customer_id;

--customers who purchased from technova (last name, first name)
SELECT C.last_name, C.first_name
FROM CUSTOMERS C
JOIN SALES S ON C.customer_id = S.customer_id
JOIN ITEMS I ON S.item_code = I.items_code
JOIN COMPANIES CO ON I.company_id = CO.company_id
WHERE CO.company = 'TechNova';


