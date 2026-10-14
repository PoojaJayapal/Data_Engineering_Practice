
USE retail_sales_db;

DELIMITER //

CREATE PROCEDURE CalculateDailySales(
    IN p_store_id INT,
    IN p_sale_date DATE
)
BEGIN
    SELECT
        st.store_id,
        st.store_name,
        s.sale_date,
        SUM(s.quantity * p.price * (1 - s.discount_percentage / 100))
            AS total_sales
    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id
    JOIN stores st
        ON s.store_id = st.store_id
    WHERE s.store_id = p_store_id
      AND s.sale_date = p_sale_date
    GROUP BY st.store_id, st.store_name, s.sale_date;
END //

DELIMITER ;

-- Test the stored procedure
CALL CalculateDailySales(1, '2026-10-01');
