CREATE DATABASE online_book_publishing_sales_platform;

use online_book_publishing_sales_platform;

CREATE TABLE Publisher(
PublisherID INT primary key,
Name varchar(100) not null,
ContactDetails varchar(255)
);


create table Book(
BookID int primary key,
Tittle varchar(200) not null,
ISBN varchar(20) not null,
Edition int not null,
PublicationYear int,
Price decimal(10,2),
PublisherID int,
foreign key (PublisherID) references Publisher(PublisherID)
);

create table Genre (
GenreID int primary key,
GenreName varchar(100) not null
);

create table BookGenre(
BookID int,
GenreID int,
primary key(BookID,GenreID),
foreign key(BookID) references Book(BookID),
foreign key(GenreID) references Genre(GenreID)
);

create table  Author(
AuthorID int primary key,
Name varchar(100) not null,
Biography Text
);


create table BookAuthor(
BookID int,
AuthorID int,
primary key (BookID, AuthorID),
foreign key (BookId) references Book(BookID),
foreign key (AuthorID) references Author(AuthorID)
);

create table Customer(
CustomerID int primary key,
Name varchar(100) not null
);

CREATE TABLE ADDRESS (
    AddressID INT PRIMARY KEY,
    CustomerID INT,
    STREET VARCHAR(100),
    CITY VARCHAR(100),
    STATE VARCHAR(100),
    COUNTRY VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Wishlist (
    CustomerID INT,
    BookID INT,
    PRIMARY KEY (CustomerID, BookID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

CREATE TABLE Orderr (
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    PaymentDetails VARCHAR(255),
    ShippingStatus VARCHAR(50),
    ShippingAddressID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Address(AddressID)
);

CREATE TABLE Order_Book (
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT NOT NULL,
    ItemDiscount DECIMAL(5,2),
    FOREIGN KEY (OrderID) REFERENCES Orderr(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

INSERT INTO Publisher (PublisherID, Name, ContactDetails) VALUES
(1, 'Penguin Random House India', 'Gurugram, Haryana, contact@penguinindia.in'),
(2, 'HarperCollins India', 'Noida, UP, info@harpercollins.co.in'),
(3, 'Rupa Publications', 'New Delhi, support@rupapublications.com'),
(4, 'Jaico Publishing House', 'Mumbai, Maharashtra, jaico@jaicobooks.com'),
(5, 'Aleph Book Company', 'New Delhi, info@alephbookcompany.com');


INSERT INTO Genre (GenreID, GenreName) VALUES
(1, 'Fiction'),
(2, 'Non-Fiction'),
(3, 'Mythology'),
(4, 'Self-Help'),
(5, 'Biography'),
(6, 'Mystery');

INSERT INTO Author (AuthorID, Name, Biography) VALUES
(1, 'Arundhati Roy', 'Acclaimed author of The God of Small Things, based in New Delhi.'),
(2, 'Chetan Bhagat', 'Best-selling author known for accessible storytelling, lives in Mumbai.'),
(3, 'Amish Tripathi', 'Author of the Shiva Trilogy, blends mythology with fiction.'),
(4, 'Jhumpa Lahiri', 'Pulitzer Prize winner, known for her poignant narratives.'),
(5, 'Robin Sharma', 'Renowned for The Monk Who Sold His Ferrari, leadership expert.');

INSERT INTO Book (BookID, Tittle, ISBN, Edition, PublicationYear, Price, PublisherID) VALUES
(1, 'The God of Small Things', '978-0143028574', 1, 1997, 499.00, 1),
(2, 'Five Point Someone', '978-8129104595', 2, 2004, 299.00, 3),
(3, 'The Immortals of Meluha', '978-9380658742', 1, 2010, 350.00, 4),
(4, 'The Interpreter of Maladies', '978-0395927205', 1, 1999, 450.00, 2),
(5, 'The Monk Who Sold His Ferrari', '978-8179921623', 3, 1999, 399.00, 4),
(6, 'The White Tiger', '978-8172238476', 1, 2008, 425.00, 2);

INSERT INTO Customer (CustomerID, Name) VALUES
(1, 'Rahul Sharma'),
(2, 'Priya Gupta'),
(3, 'Anjali Verma'),
(4, 'Vikram Singh'),
(5, 'Sneha Patel');


INSERT INTO BookAuthor (BookID, AuthorID) VALUES
(1, 1), -- The God of Small Things by Arundhati Roy
(2, 2), -- Five Point Someone by Chetan Bhagat
(3, 3), -- The Immortals of Meluha by Amish Tripathi
(4, 4), -- The Interpreter of Maladies by Jhumpa Lahiri
(5, 5), -- The Monk Who Sold His Ferrari by Robin Sharma
(6, 4); -- The White Tiger by Jhumpa Lahiri

INSERT INTO BookGenre (BookID, GenreID) VALUES
(1, 1), -- The God of Small Things: Fiction
(2, 1), -- Five Point Someone: Fiction
(3, 3), -- The Immortals of Meluha: Mythology
(4, 1), -- The Interpreter of Maladies: Fiction
(5, 4), -- The Monk Who Sold His Ferrari: Self-Help
(6, 1), -- The White Tiger: Fiction
(6, 6); -- The White Tiger: Mystery

ALTER TABLE Orderr
ADD BookID INT NOT NULL,
ADD FOREIGN KEY (BookID) REFERENCES Book(BookID);




INSERT INTO ADDRESS (AddressID, CustomerID, STREET, CITY, STATE, COUNTRY) VALUES
(1, 1, '123 Green St', 'Delhi', 'Delhi', 'India'),
(2, 2, '456 Blue Rd', 'Mumbai', 'Maharashtra', 'India'),
(3, 3, '789 Red Ave', 'Hyderabad', 'Telangana', 'India'),
(4, 4, '321 Yellow Blvd', 'Bangalore', 'Karnataka', 'India'),
(5, 5, '654 Purple Ln', 'Ahmedabad', 'Gujarat', 'India');


INSERT INTO Orderr (OrderID, OrderDate, CustomerID, PaymentDetails, ShippingStatus, ShippingAddressID, BookID) VALUES
(101, '2025-06-01', 1, 'Paid via UPI', 'Shipped', 1, 1),
(102, '2025-06-03', 2, 'COD', 'Processing', 2, 2),
(103, '2025-06-05', 3, 'Credit Card', 'Delivered', 3, 3),
(104, '2025-06-06', 4, 'Debit Card', 'Pending', 4, 5),
(105, '2025-06-08', 5, 'Net Banking', 'Cancelled', 5, 6);


INSERT INTO Order_Book (OrderItemID, OrderID, BookID, Quantity, ItemDiscount) VALUES
(1, 101, 1, 1, 0.00),
(2, 102, 2, 2, 10.00),
(3, 103, 3, 1, 0.00),
(4, 104, 5, 1, 5.00),
(5, 105, 6, 1, 0.00);


