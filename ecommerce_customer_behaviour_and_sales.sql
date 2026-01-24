-- Revenue & Order KPIs
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(order_value), 2) AS total_revenue,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(basket_size), 2) AS avg_basket_size
FROM transactions;

-- Revenue by Product Category
SELECT
    product_category,
    ROUND(SUM(total_amount), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(AVG(basket_size), 2) AS avg_basket_size
FROM transactions
GROUP BY product_category
ORDER BY revenue DESC;

-- Customer Segmentation (High vs Low Value)
SELECT
    customer_id,
    total_orders,
    total_spend,
    avg_order_value,
    last_purchase_date,
    CASE
        WHEN total_spend > 5000 AND total_orders > 5 THEN 'High Value Loyal'
        WHEN total_orders = 1 THEN 'One-Time Buyer'
        ELSE 'Regular'
    END AS customer_segment
FROM customers;

-- Basket Size & Upsell Opportunity
SELECT
    product_category,
    ROUND(AVG(basket_size), 2) AS avg_basket_size,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    COUNT(DISTINCT order_id) AS total_orders
FROM transactions
GROUP BY product_category
ORDER BY avg_basket_size DESC;


-- Device & Conversion Behavior
SELECT
    device_type,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(pages_viewed), 2) AS avg_pages_viewed
FROM transactions
GROUP BY device_type;

-- Returning vs New Customers
SELECT
    is_returning_customer,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(AVG(order_value), 2) AS avg_order_value,
    ROUND(AVG(basket_size), 2) AS avg_basket_size
FROM transactions
GROUP BY is_returning_customer;

-- Delivery Time vs Customer Satisfaction
SELECT
    delivery_time_days,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    COUNT(*) AS orders
FROM transactions
GROUP BY delivery_time_days
ORDER BY delivery_time_days;

-- Frequency of purchase
WITH purchase_gaps AS (
    SELECT
        customer_id,
        date,
        LAG(date) OVER (
            PARTITION BY customer_id
            ORDER BY date
        ) AS previous_purchase_date
    FROM transactions
)
SELECT
    customer_id,
    ROUND(AVG(date - previous_purchase_date), 2) AS avg_days_between_purchases
FROM purchase_gaps
WHERE previous_purchase_date IS NOT NULL
GROUP BY customer_id;

-- RFM ANALYSIS
SELECT
    customer_id,
    total_orders,
    total_spend,
    avg_order_value,
    last_purchase_date,
    NTILE(4) OVER (ORDER BY last_purchase_date DESC) AS recency_score,
    NTILE(4) OVER (ORDER BY total_orders) AS frequency_score,
    NTILE(4) OVER (ORDER BY total_spend) AS monetary_score
FROM customers;

-- MARKETING INSIGHTS — HIGH INTENT, LOW CONVERSION
SELECT
    customer_id,
    ROUND(AVG(session_duration_minutes), 2) AS avg_session_time,
    ROUND(AVG(pages_viewed), 2) AS avg_pages_viewed,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM transactions
GROUP BY customer_id
HAVING AVG(pages_viewed) > 10
   AND AVG(total_amount) < 500;

-- ACQUISITION ANALYSIS — FIRST PURCHASE QUALITY
WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(date) AS first_purchase_date
    FROM transactions
    GROUP BY customer_id
)
SELECT
    t.product_category,
    ROUND(AVG(t.total_amount), 2) AS avg_first_order_value
FROM transactions t
JOIN first_purchase f
  ON t.customer_id = f.customer_id
 AND t.date = f.first_purchase_date
GROUP BY t.product_category
ORDER BY avg_first_order_value DESC;

-- MARKET-BASED ANALYSIS — CITY STRATEGY
SELECT
    city,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(AVG(quantity), 2) AS avg_items_per_order
FROM transactions
GROUP BY city
ORDER BY avg_order_value DESC;