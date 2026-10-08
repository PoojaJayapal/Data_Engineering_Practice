CREATE DATABASE banking_db;
USE banking_db;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    account_type VARCHAR(30),
    balance DECIMAL(10,2),
    city VARCHAR(50)
);

INSERT INTO accounts VALUES
(101, 'Arun Kumar', 'Savings', 45000, 'Hyderabad'),
(102, 'Meera Shah', 'Current', 85000, 'Mumbai'),
(103, 'Ravi Reddy', 'Savings', 32000, 'Hyderabad'),
(104, 'Priya Nair', 'Savings', 67000, 'Bangalore'),
(105, 'Sameer Khan', 'Current', 120000, 'Pune'),
(106, 'Neha Gupta', 'Savings', 28000, 'Delhi'),
(107, 'Vikram Rao', 'Current', 95000, 'Hyderabad'),
(108, 'Anjali Singh', 'Savings', 54000, 'Mumbai');

SELECT * FROM accounts;
DELIMITER //
-- 1. Display all accounts
CREATE PROCEDURE GetAllAccounts()
BEGIN
    SELECT * FROM accounts;
END //

-- 2. Display only Savings accounts
CREATE PROCEDURE GetSavingsAccounts()
BEGIN
    SELECT * FROM accounts
    WHERE account_type = 'Savings';
END //

-- 3. Display accounts by city
CREATE PROCEDURE GetAccountsByCity(IN p_city VARCHAR(50))
BEGIN
    SELECT * FROM accounts
    WHERE city = p_city;
END //

-- 4. Display accounts with balance above a given amount
CREATE PROCEDURE GetAccountsAboveBalance(IN p_balance DECIMAL(10,2))
BEGIN
    SELECT * FROM accounts
    WHERE balance > p_balance;
END //

-- 5. Update balance
CREATE PROCEDURE UpdateAccountBalance(
    IN p_account_id INT,
    IN p_new_balance DECIMAL(10,2)
)
BEGIN
    UPDATE accounts
    SET balance = p_new_balance
    WHERE account_id = p_account_id;
END //

-- 6. Deposit
CREATE PROCEDURE DepositAmount(
    IN p_account_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_account_id;
END //

-- 7. Withdraw
CREATE PROCEDURE WithdrawAmount(
    IN p_account_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_account_id;
END //

-- 8. Delete an account
CREATE PROCEDURE DeleteAccount(IN p_account_id INT)
BEGIN
    DELETE FROM accounts
    WHERE account_id = p_account_id;
END //

DELIMITER ;

CALL GetAllAccounts();
CALL GetSavingsAccounts();
CALL GetAccountsByCity('Hyderabad');
CALL GetAccountsAboveBalance(50000);
CALL UpdateAccountBalance(101, 50000);
CALL DepositAmount(102, 5000);
CALL WithdrawAmount(103, 2000);
CALL DeleteAccount(106);
