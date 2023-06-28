CREATE DATABASE library;
use library;

CREATE table branch(branch_no INT PRIMARY KEY , manager_id INT , branch_adress VARCHAR(30), contact_no VARCHAR(30));

insert into branch values 
(101,1,'kannur','9995642527'),
(102,2,'kozhikode','8281104927'),
(103,3,'palakad','1237654892'),
(104,4,'kollam','6282601671'),
(105,5,'trivandrum','1246835678');

select * from branch ;

CREATE TABLE employee(emp_id INT PRIMARY KEY,emp_name VARCHAR(30),position varchar(30),salary VARCHAR(30));
INSERT INTO employee VALUES
(1,'sarang','HR','30000'),
(2,'remanan','sales','14000'),
(3,'anjana','consultant','20000'),
(4,'sreerag','library assistant','18000'),
(5,'aparna','clerk','17000');

SELECT * from employee;

CREATE TABLE customer(customer_id INT PRIMARY KEY,customer_name VARCHAR(30),customer_address VARCHAR(30),reg_date DATE);
INSERT INTO customer VALUES
(10,'alexander','mumbai','2021-04-10'),
(11,'benjamin','chennai','2022-08-04'),
(12,'paublin','delhi','2019-12-12'),
(13,'pablo','pondicherry','2022-10-01'),
(14,'lucy','mysuru','2023-01-10');
SELECT * FROM customer;

CREATE TABLE Books(ISBN VARCHAR(30) PRIMARY KEY ,Book_title VARCHAR(30),category VARCHAR(30),rental_price DECIMAL(5,2),
status VARCHAR(30),author VARCHAR(30),publisher VARCHAR(30));

INSERT INTO Books VALUES
('24223','Quantitative aptitude','maths',30.00,'yes','agarwal','mc'),
('24224','The orgin of species','biology',25.00,'no','darwin','ba'),
('24225','The indian economy','economy',20.00,'yes','sanjiv','ll'),
('24226','Organic chemistry','chemistry',27.00,'yes','jonathan','kk'),
('24227','The last mughal','history',35.00,'no','william','pp');

SELECT * FROM Books ;

CREATE TABLE issuestatus(issue_id INT PRIMARY KEY,issued_cust INT, issued_book_name VARCHAR(30),issue_date DATE,ISBN_book VARCHAR(30),
FOREIGN KEY(issued_cust) REFERENCES customer(customer_id) on DELETE CASCADE,
FOREIGN KEY(ISBN_book) REFERENCES Books(ISBN) on DELETE CASCADE);

INSERT INTO issuestatus VALUES
(1,10,'Quantitative aptitude','2022-05-11','24223'),
(2,11,'The orgin of species','2022-10-10','24224'),
(3,12,'The indian economy','2020-12-12','24225'),
(4,13,'Organic chemistry','2023-09-01','24226'),
(5,14,'The last mughal','2023-02-11','24227');

select * FROM issuestatus;

CREATE TABLE returnstatus(return_id INT PRIMARY KEY , return_cust INT, return_book_name varchar(30),return_date DATE,ISBN_book2 VARCHAR(30),
FOREIGN KEY(return_cust) REFERENCES customer(customer_id) on DELETE CASCADE,
FOREIGN KEY(ISBN_book2) REFERENCES Books(ISBN) on DELETE CASCADE );

insert into returnstatus VALUES
(1,10,'Quantitative aptitude', '2022-06-12','24223'),
(2,11,'The orgin of species','2022-11-05','24224'),
(3,12,'The indian economy','2021-01-03','24225'),
(4,13,'Organic chemistry','2023-10-01','24226'),
(5,14,'The last mughal','2023-04-03','24227');

SELECT * from returnstatus;

-- 1) Retrieve the book title, category, and rental price of all available books
SELECT Book_title,category,rental_price FROM books WHERE status = 'yes';

-- 2)List the employee names and their respective salaries in descending order of salary.
SELECT emp_name,salary from employee ORDER BY salary DESC;

-- 3)Retrieve the book titles and the corresponding customers who have issued those books.
select b.Book_title, c.customer_name from issuestatus i join Books b on i.ISBN_Book = b.ISBN
join customer c on i.issued_cust = c.customer_id;

-- 4)Display the total count of books in each category. 
SELECT category , count(*) as book_count from Books GROUP BY category;

-- 5)Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT emp_name , position from employee WHERE salary >'50000';

-- 6)  List the customer names who registered before 2022-01-01 and have not issued any books yet.  
SELECT customer_name FROM customer where reg_date < 2022-01-01 AND customer_id NOT IN(SELECT
issued_cust FROM issuestatus) ;

-- 7)  Display the branch numbers and the total count of employees in each branch
SELECT branch.branch_no, count(employee.emp_id)as total_emp from branch
LEFT JOIN employee on branch.manager_id = employee.emp_id GROUP BY
branch.branch_no;

-- 8) Display the names of customers who have issued books in the month of June 2023
select c.customer_name from customer c
join issuestatus i on c.Customer_id = i.issued_cust
where month(i.issue_Date) = 6 and year(i.issue_Date) = 2023;

-- 9) Retrieve book_title from book table containing history.
SELECT book_title FROM Books WHERE category = 'history' ;

-- 10) Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
select position, count(*) as total_emp from employee group by position having count(*) < 5;





