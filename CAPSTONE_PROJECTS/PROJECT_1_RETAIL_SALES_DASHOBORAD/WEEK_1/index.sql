
USE retail_sales_db;

-- Index to search sales by product
CREATE INDEX idx_sales_product
ON sales(product_id);

-- Index to search sales by store
CREATE INDEX idx_sales_store
ON sales(store_id);

-- Index to search sales by date
CREATE INDEX idx_sales_date
ON sales(sale_date);

-- Index to search stores by region
CREATE INDEX idx_stores_region
ON stores(region);

-- Verify indexes
SHOW INDEX FROM sales;
SHOW INDEX FROM stores;
