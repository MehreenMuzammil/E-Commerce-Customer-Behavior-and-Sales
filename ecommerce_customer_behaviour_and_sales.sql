-- revenue & order kpis
select
    count(distinct order_id) as total_orders,
    count(distinct customer_id) as total_customers,
    round(sum(order_value), 2) as total_revenue,
    round(avg(order_value), 2) as avg_order_value,
    round(avg(basket_size), 2) as avg_basket_size
from transactions;

-- revenue by product category
select
    product_category,
    round(sum(total_amount), 2) as revenue,
    count(distinct order_id) as orders,
    round(avg(basket_size), 2) as avg_basket_size
from transactions
group by product_category
order by revenue desc;

-- customer segmentation (high vs low value)
select
    customer_id,
    total_orders,
    total_spend,
    avg_order_value,
    last_purchase_date,
    case
        when total_spend > 5000 and total_orders > 5 then 'high value loyal'
        when total_orders = 1 then 'one-time buyer'
        else 'regular'
    end as customer_segment
from customers;

-- basket size & upsell opportunity
select
    product_category,
    round(avg(basket_size), 2) as avg_basket_size,
    round(avg(order_value), 2) as avg_order_value,
    count(distinct order_id) as total_orders
from transactions
group by product_category
order by avg_basket_size desc;

-- device & conversion behavior
select
    device_type,
    count(distinct order_id) as orders,
    round(avg(order_value), 2) as avg_order_value,
    round(avg(pages_viewed), 2) as avg_pages_viewed
from transactions
group by device_type;

-- returning vs new customers
select
    is_returning_customer,
    count(distinct customer_id) as customers,
    round(avg(order_value), 2) as avg_order_value,
    round(avg(basket_size), 2) as avg_basket_size
from transactions
group by is_returning_customer;

-- delivery time vs customer satisfaction
select
    delivery_time_days,
    round(avg(customer_rating), 2) as avg_rating,
    count(*) as orders
from transactions
group by delivery_time_days
order by delivery_time_days;

-- frequency of purchase
with purchase_gaps as (
    select
        customer_id,
        date,
        lag(date) over (
            partition by customer_id
            order by date
        ) as previous_purchase_date
    from transactions
)
select
    customer_id,
    round(avg(date - previous_purchase_date), 2) as avg_days_between_purchases
from purchase_gaps
where previous_purchase_date is not null
group by customer_id;

-- rfm analysis
select
    customer_id,
    total_orders,
    total_spend,
    avg_order_value,
    last_purchase_date,
    ntile(4) over (order by last_purchase_date desc) as recency_score,
    ntile(4) over (order by total_orders) as frequency_score,
    ntile(4) over (order by total_spend) as monetary_score
from customers;

-- marketing insights — high intent, low conversion
select
    customer_id,
    round(avg(session_duration_minutes), 2) as avg_session_time,
    round(avg(pages_viewed), 2) as avg_pages_viewed,
    round(avg(total_amount), 2) as avg_order_value
from transactions
group by customer_id
having avg(pages_viewed) > 10
   and avg(total_amount) < 500;

-- acquisition analysis — first purchase quality
with first_purchase as (
    select
        customer_id,
        min(date) as first_purchase_date
    from transactions
    group by customer_id
)
select
    t.product_category,
    round(avg(t.total_amount), 2) as avg_first_order_value
from transactions t
join first_purchase f
  on t.customer_id = f.customer_id
 and t.date = f.first_purchase_date
group by t.product_category
order by avg_first_order_value desc;

-- market-based analysis — city strategy
select
    city,
    count(distinct customer_id) as customer_count,
    round(avg(total_amount), 2) as avg_order_value,
    round(avg(quantity), 2) as avg_items_per_order
from transactions
group by city
order by avg_order_value desc;
