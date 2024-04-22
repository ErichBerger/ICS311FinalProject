drop database if exists store;
drop user if exists 'store_admin'@'localhost';

create database store;
create user 'store_admin'@'localhost' identified by '123';

grant all privileges on store . * to 'store_admin'@'localhost';
use store;


create table Vendor (
    vendor_number int,
    name varchar(20),
    contact_name varchar(20),
    address varchar(50),
    primary key (vendor_number)
);

create table Wine (
    stock_number int,
    barcode int,
    name varchar(40),
    price double(10, 2),
    avg_cost double(10, 2),
    inv int,
    min_qty int,
    region varchar(20),
    varietal varchar(20),
    primary key (stock_number)
);

create table Customer (
    customer_number int,
    fname varchar(20),
    lname varchar(20),
    phone varchar(20),
    address varchar(50),
    birthday date,
    email varchar (30),
    primary key (customer_number)
);

create table Cart (
    cart_number int,
    created_date date,
    fulfilled_date date,
    discount int,
    customer_number int,
    primary key (cart_number),
    foreign key (customer_number) references Customer(customer_number)
);
create table CartLine (
    cart_number int,
    stock_number int,
    qty int,
    price double(10, 2),
    foreign key (cart_number) references Cart(cart_number),
    foreign key (stock_number) references Wine(stock_number),
    primary key (cart_number, stock_number)
);

create table Invoice (
    invoice_number int,
    received_date date,
    vendor_number int,
    primary key (invoice_number),
    foreign key (vendor_number) references Vendor(vendor_number)
);

create table InvoiceLine (
    invoice_number int,
    stock_number int,
    qty int,
    unit_price double(10, 2),
    primary key(invoice_number, stock_number),
    foreign key (invoice_number) references Invoice(invoice_number),
    foreign key (stock_number) references Wine(stock_number)
);

create table WineOrder (
    order_number int,
    sent_date date,
    fulfilled_date date,
    vendor_number int,
    primary key (order_number),
    foreign key (vendor_number) references Vendor(vendor_number)
);

create table WineOrderLine (
    order_number int,
    stock_number int,
    qty int,
    primary key ( order_number, stock_number),
    foreign key (order_number) references WineOrder(order_number),
    foreign key (stock_number) references Wine(stock_number)
);

/* Populate database */
insert into Vendor (vendor_number, name, contact_name, address) values 
    (1, 'Libation Project', 'Simon Villarreal', '1991 Happy Hollow Road, Laurinburg, NC 28352'),
    (2, 'New France', 'Donna Valdez', '4120 Burton Avenue, Memphis, TN 38110'),
    (3, 'Wine Co.', 'Corey Montgomery', '3393 Round Table Drive, Hamilton, OH 45011'),
    (4, 'Lompian', 'Ramond Sanchez', '2872 Smithfield Avenue, Pampa, TX 79065'),
    (5, 'Vinocopia', 'Lori Bell', '2972 Bottom Lane, Barker, NY 14012'),
    (6, 'Maverick', 'Ellen Field', '2644 Armory Road, Wilmingotn, NC 28412');

insert into Wine (stock_number, barcode, name, price, avg_cost, inv, min_qty, region, varietal) values
    (1, 3495, 'Kind Stranger Cab', 19.99, 13.33, 6, 4, 'Washington', 'Cabernet Sauvignon'),
    (2, 8390, 'Villa degli Olmi Prosecco', 11.99, 6.99, 22, 12, 'Italy', 'Sparkling'),
    (3, 3800, 'Oddero Barolo', 54.00, 34.00, 2, 1, 'Italy', 'Nebbiolo'),
    (4, 9582, 'Wiley Gamay', 27.99, 17.99, 2, 4, 'California', 'Gamay'),
    (5, 6529, 'Chte Beaurenard CDP', 35.99, 25.99, 1, 12, 'France', 'Cabernet Sauvignon');

insert into Customer (customer_number, fname, lname, phone, address, birthday, email) values
    (1, 'Gerald', 'Dickinson', '407-988-5555', '3223 Spring Street, Talyorville, IL 62568', '1977-05-02', 'gdickonson@hotmail.com'),
    (2, 'Ivan', 'Stanley', '786-280-3655', '854 Ridenour Street, Miami, FL 33128', '1982-09-13', 'IvanMStanley@teleworm.us'),
    (3, 'Lisa', 'Lindenberg', '706-431-2058', '776 Limer Street, Atlanta, GA 30303', '1956-11-23', 'LisaL@jourrapide.com'),
    (4, 'Katherine', 'Reese', '719-489-2437',  '567 River Road, Rye, CO, 81069', '1993-12-27', 'KJReese@rhyta.com'),
    (5, 'William', 'Orozco', '262-368-4104', '3296 Oakridge Farm Lane, West Allis, WI 53227', '1965-09-3' ,'WilliamOOrozco@teleworm.us');

insert into Cart (cart_number, created_date, fulfilled_date, discount, customer_number) values
    (3, '2023-11-22', '2023-11-24', 0, 3),
    (1, '2023-07-08', '2023-07-09', 0, 3),
    (2, '2024-02-23', '2024-04-01', 10, 2),
    (4, NULL, NULL, 0, 4),
    (5, '2024-04-07', NULL, 0, 5)
;

insert into CartLine (cart_number, stock_number, qty, price) values
    (3, 5, 10, 35.99),
    (3, 2, 2, 11.99),
    (4, 1, 3, 19.99),
    (2, 3, 1, 46.10),
    (1, 5, 3, 35.99),
    (5, 4, 2, 27.99),
    (4, 2, 5, 11.99),
    (1, 2, 2, 11.99) 
;

insert into Invoice (invoice_number, received_date, vendor_number) values
    (1, '2024-03-02', 4),
    (2, '2024-01-01', 3),
    (3, '2023-09-22', 2),
    (4, '2024-04-02', 4),
    (5, '2024-01-23', 5)
;

insert into InvoiceLine (invoice_number, stock_number, qty, unit_price) values
    (4, 3, 36, 8.99),
    (1, 2, 4, 6.99),
    (2, 1, 6, 6.88),
    (4, 4, 7, 21.67),
    (5, 3, 6, 7.99),
    (4, 2, 4, 6.99),
    (1, 3, 12, 9.99),
    (3, 5, 2, 33.33)
    ;
insert into WineOrder (order_number, sent_date, fulfilled_date, vendor_number) values
    (1, '2023-11-23', '2023-11-30', 1),
    (2, '2023-12-01', '2023-12-02', 3),
    (3, '2024-01-01', '2024-01-07', 5),
    (4, NULL, NULL, 5),
    (5, '2024-04-02', NULL, 5)
;

insert into WineOrderLine (order_number, stock_number, qty) values 
    (2, 4, 4),
    (2, 5, 6),
    (1, 2, 8),
    (5, 1, 12),
    (4, 2, 36),
    (3, 3, 2)
;

/* View: Customer spending at the store */
create view Spending_by_Customer as
select Customer.customer_number as customer_number,
    concat(Customer.fname, ' ', Customer.lname) as customer_name,
    Result1.sales as sales
from Customer inner join (
    select Cart.customer_number as customer_number, sum(CartLine.qty * CartLine.price) as sales
    from Cart inner join CartLine on Cart.cart_number = CartLine.cart_number
    group by Cart.customer_number
    ) as Result1 
    on Customer.customer_number = Result1.customer_number; 

