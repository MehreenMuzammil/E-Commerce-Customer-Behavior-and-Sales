## Project Overview

This project is a **customer behaviour and sales analysis** of an e-commerce platform with 5,000 customers and 17,049 transactions. Using a multi-tool analytics pipeline, I explore what drives revenue, how customers segment by value and behaviour, where upsell opportunities exist, and what separates high-value loyal customers from one-time buyers.

> **Business Question:** *What drives revenue in this e-commerce platform, and how can customer behaviour data be used to improve retention, targeting, and upsell strategy?*

---

##  Tableau Dashboard

**[View Interactive Tableau Dashboard](https://public.tableau.com/views/E-CommerceCustomerBehaviorSalesAnalysis/CustomerRFMSegmentationRevenueInsightsRetailAnalytics?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python (pandas, numpy)** | Data cleaning, feature engineering & customer aggregation |
| **Anaconda Toolbox** | Python notebook environment |
| **PostgreSQL (pgAdmin 4)** | SQL analysis & querying |
| **Tableau Public** | Interactive dashboard & visualisation |

---

## Project Structure

```
E-Commerce-Customer-Behavior-and-Sales/
│
├── ecommerce_customer_behavior_dataset.ipynb   - Data cleaning & feature engineering
│
├── ecommerce_customer_behavior_dataset_v2.csv  - Original raw dataset
├── cleaned_transaction_data.csv                - Cleaned transaction-level data
├── customer_summary_data.csv                   - Aggregated customer-level data
│
├── ecommerce_customer_behaviour_and_sales.sql  - All SQL queries
├── Customer RFM Segmentation & Revenue Insights (Retail Analytics).jpg  - Dashboard screenshot
└── README.md
```

---

## Dataset

| Dataset | Source | Records |
|---|---|---|
| E-Commerce Customer Behavior & Sales | [Kaggle — umuttuygurr](https://www.kaggle.com/datasets/umuttuygurr/e-commerce-customer-behavior-and-sales-analysis-tr) | 17,049 transactions, 5,000 customers |

**Key columns:** Order ID, Customer ID, Date, Age, Gender, City, Product Category, Unit Price, Quantity, Discount Amount, Total Amount, Payment Method, Device Type, Session Duration, Pages Viewed, Is Returning Customer, Delivery Time, Customer Rating

---

## Goals & Analysis Performed

| # | Goal | Analysis Performed |
|---|---|---|
| 1 | Understand overall revenue performance | Revenue & order KPIs, avg order value, basket size |
| 2 | Identify top revenue-driving categories | Revenue by product category, first purchase category |
| 3 | Segment customers by value & behaviour | High Value Loyal vs Regular vs One-Time Buyer segmentation |
| 4 | Analyse returning vs new customer behaviour | Avg order value, basket size, customer count by type |
| 5 | Find upsell & add-on opportunities | Basket size vs order value by category |
| 6 | Understand device & payment preferences | Orders and AOV by device type and payment method |
| 7 | Map city-level performance | Avg order value and customer count by city |
| 8 | Identify high-intent low-conversion customers | Session + pages viewed vs spend analysis |
| 9 | Build RFM segmentation | Recency, Frequency, Monetary scoring with ntile quartiles |
| 10 | Measure delivery impact on satisfaction | Delivery time vs customer rating correlation |

---

## Project Roadmap

```
Phase 1 — Data Cleaning (Python)
    └── Raw CSV → Validated, cleaned transaction dataset
            
Phase 2 — Feature Engineering (Python)
    └── Added basket_size, order_value columns
    └── Built customer_summary aggregation table
            
Phase 3 — SQL Analysis (PostgreSQL / pgAdmin 4)
    └── 11 queries across revenue, segmentation, behaviour & geography
            
Phase 4 — Visualisation (Tableau Public)
    └── Interactive RFM segmentation & revenue insights dashboard
            
Phase 5 — Storytelling & Documentation
    └── Executive insights, recommendations, GitHub README
```

---

## Analysis & Key Findings

### 1. Revenue & Order KPIs
| Metric | Value |
|---|---|
| Total Orders | 17,049 |
| Total Customers | 5,000 |
| Total Revenue | **$21,779,052** |
| Avg Order Value | $1,277.44 |
| Avg Basket Size | 3.01 items |

> *Derived from Python feature engineering — `order_value` and `basket_size` columns calculated per order during data cleaning phase.*

---

### 2. Revenue by Product Category
| Category | Revenue | Orders |
|---|---|---|
| Electronics | $10,481,897 | 2,074 |
| Home & Garden | $4,023,903 | 2,060 |
| Sports | $3,205,086 | 2,248 |
| Fashion | $1,577,035 | 2,056 |
| Toys | $1,014,237 | 2,090 |
| Beauty | $694,437 | 2,212 |
| Food | $422,054 | 2,103 |
| Books | $360,399 | 2,206 |

**Electronics alone drives 48.1% of total revenue** despite having similar order counts to other categories — driven by high unit prices, not volume.

> *Source: SQL — Revenue by product category query using `SUM(total_amount)` grouped by `product_category`.*

---

### 3. Customer Segmentation
| Segment | Customers | Avg Spend | Avg Orders |
|---|---|---|---|
| High Value Loyal | 603 | $12,146.95 | 7.61 |
| Regular | 3,505 | $3,819.29 | 3.30 |
| One-Time Buyer | 892 | $1,197.12 | 1.00 |

**603 High Value Loyal customers (12% of base) average $12,146 spend each** — nearly 10x the one-time buyer average of $1,197.

> *Source: SQL — Customer segmentation query using CASE WHEN logic: High Value Loyal = total_spend > 5,000 AND total_orders > 5.*

---

### 4. Top 10% Revenue Contributors
- **500 customers** (top 10%) generated **$8,451,983** — **38.8% of total revenue**
- This confirms a strong Pareto effect in the customer base

> *Derived from Python analysis on `customer_summary_data.csv` — top 10% by `total_spend`.*

---

### 5. Returning vs New Customers
| Customer Type | Count | Avg Order Value | Avg Basket Size |
|---|---|---|---|
| Returning | 4,651 | $1,276.06 | 3.01 |
| New | 2,010 | $1,287.73 | 3.03 |

Interestingly, **new customers have a slightly higher avg order value ($1,287 vs $1,276)** — suggesting first-time buyers may be making larger considered purchases, while returning customers buy more frequently at slightly lower values.

> *Source: SQL — Returning vs new customers query grouped by `is_returning_customer`.*

---

### 6. Device & Payment Behaviour
| Device | Orders | Avg Order Value |
|---|---|---|
| Desktop | 5,845 | $1,310.77 |
| Mobile | 9,543 | $1,260.47 |
| Tablet | 1,661 | $1,257.63 |

**Mobile drives 56% of all orders** but Desktop users spend 4% more per order ($1,310 vs $1,260).

| Payment Method | Revenue | Avg Order Value |
|---|---|---|
| Credit Card | $9,069,714 | $1,333.59 |
| Debit Card | $5,152,182 | $1,192.36 |
| Digital Wallet | $4,191,842 | $1,279.56 |

**Credit Card is the highest value payment method** — credit card users average $1,333 per order vs $1,186 for Cash on Delivery.

> *Source: SQL — Device behavior query and payment method query.*

---

### 7. City Performance
| City | Customers | Avg Order Value |
|---|---|---|
| Bursa | 496 | $1,346.33 |
| Antalya | 374 | $1,333.54 |
| Gaziantep | 349 | $1,330.03 |
| Istanbul | 1,284 | $1,282.73 |
| Ankara | 735 | $1,260.30 |
| Adana | 378 | $1,140.51 |

**Istanbul has the most customers (1,284) but Bursa has the highest avg order value ($1,346)** — smaller cities may represent premium or underpenetrated markets.

> *Source: SQL — Market-based city analysis query grouped by `city`.*

---

### 8. High Intent, Low Conversion
- **379 customers** browse heavily (avg 11.32 pages viewed) but spend only **$275.80 on average**
- These are high-intent, low-conversion customers — a key retargeting opportunity

> *Source: SQL — Marketing insights query filtering customers with avg_pages_viewed > 10 AND avg_total_amount < 500.*

---

### 9. Delivery Time vs Customer Rating
- Ratings stay consistently between **3.76 and 3.92** regardless of delivery time (1–10 days)
- Fastest delivery (1 day) actually has the **lowest rating (3.76)** — suggesting delivery speed alone doesn't drive satisfaction

> *Source: SQL — Delivery time vs customer satisfaction query grouped by `delivery_time_days`.*

---

### 10. First Purchase Category
| Category | Avg First Order Value |
|---|---|
| Electronics | $4,979.53 |
| Home & Garden | $1,959.36 |
| Sports | $1,374.67 |
| Fashion | $753.24 |
| Books | $163.87 |

**Electronics dominates first purchases by value** — customers who start with Electronics spend nearly 3x more on their first order than Home & Garden buyers.

> *Source: SQL — Acquisition analysis query joining transactions with first purchase dates.*

---

## Executive Insights

**1. Electronics is the revenue engine — but it's concentrated risk.**
SQL revenue analysis shows Electronics drives 48.1% of total revenue ($10.4M of $21.7M) despite similar order volumes to other categories. This concentration is a strategic risk — diversifying revenue across Home & Garden and Sports should be a priority.

**2. The top 10% of customers drive 38.8% of revenue.**
Python analysis shows 500 customers generate $8.4M. Retaining these High Value Loyal customers through personalised offers and loyalty programmes is the single highest-ROI strategy available.

**3. New customers spend slightly more per order — but returning customers are more valuable long-term.**
SQL Q3 shows new customers average $1,287 per order vs $1,276 for returning — but the customer segmentation shows returning customers accumulate far more total spend ($12,146 for High Value Loyal). Acquisition matters, but retention is where the money is.

**4. Mobile is the dominant channel but Desktop converts higher.**
SQL device analysis shows Mobile accounts for 56% of orders but Desktop users spend 4% more per order. Optimising the mobile checkout experience could close this gap and significantly lift total revenue.

**5. 379 high-intent customers are being lost.**
SQL marketing insights query identifies 379 customers averaging 11+ pages viewed but spending only $275. These are warm leads — targeted discount nudges or cart abandonment emails could convert them into high-value buyers.

---

## Business Relevance

| Stakeholder | How This Analysis Helps |
|---|---|
| **Marketing Team** | RFM segmentation enables targeted campaigns — different messaging for High Value Loyal vs One-Time Buyers |
| **Product Team** | High-intent low-conversion data identifies UX friction points in the checkout funnel |
| **Sales & Category Managers** | Electronics revenue concentration highlights portfolio diversification opportunities |
| **Operations Team** | Delivery time vs rating analysis shows speed alone doesn't drive satisfaction — reliability matters more |
| **City/Regional Managers** | Bursa and Antalya outperform Istanbul on AOV — signals premium demand in secondary cities |

---

## Key Takeaways

| # | Takeaway | Data Point |
|---|---|---|
| 1 | Electronics dominates revenue | 48.1% of total revenue ($10.4M of $21.7M) |
| 2 | Top 10% customers drive 38.8% of revenue | 500 customers generated $8.4M |
| 3 | High Value Loyal customers spend 10x more | $12,146 avg vs $1,197 for one-time buyers |
| 4 | Mobile drives volume, Desktop drives value | 56% of orders on Mobile, but Desktop AOV is 4% higher |
| 5 | Credit Card is the highest value payment method | $1,333 avg vs $1,186 for Cash on Delivery |
| 6 | Bursa outperforms Istanbul on order value | $1,346 vs $1,282 avg order value |
| 7 | 379 customers are high-intent but low-spend | 11+ pages viewed, only $275 avg spend |
| 8 | Delivery speed doesn't predict satisfaction | Ratings flat at 3.76–3.92 across 1–10 day delivery |

---

*This project was built as part of a data analytics portfolio to demonstrate end-to-end analytical skills across Python, SQL, and Tableau.*
