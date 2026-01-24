- Project Overview

This project analyzes e-commerce customer behaviour and transactions to uncover revenue drivers, customer segments, retention patterns and upsell opportunities using Python, SQL (PostgreSQL) and Tableau.
What makes it non-trivial is that it has separate customer-level and transaction-level modelling, true RFM segmentation, behavioural and monetary insights combined and executive ready Tableau dashboard.

- Dataset

Source
Kaggle – E-commerce Customer Behaviour Dataset
https://www.kaggle.com/datasets/umuttuygurr/e-commerce-customer-behavior-and-sales-analysis-tr

- Structure

Customers table: one row per customer (aggregated metrics)
Transactions table: multiple rows per customer (order-level data)

- Project Roadmap

1. Raw data ingestion
2. Data cleaning & validation (Python)
3. Customer-level aggregation
4. SQL-based business analysis
5. RFM segmentation
6. Tableau executive dashboard

- Goals & Analysis Performed

1. What drives total revenue?
2. Which customers contribute the most long-term value?
3. How does recency and frequency impact retention?
4. Where do upsell and add-on opportunities exist?
5. How do returning customers differ from new ones?
6. Which cities and categories perform best?

- Business Relevance

Each analysis directly maps to a business lever:
Analysis vs Business Use
KPIs - Revenue monitoring
RFM - Customer prioritization
Basket Size vs AOV - Upsell strategy
Returning vs New - Retention focus
City analysis - Market targeting

- Key Takeaways

1. A small segment of customers contributes a disproportionate share of revenue.
2. Returning customers generate significantly higher revenue than new customers.
3. Customers with higher basket sizes present strong add-on opportunities.
4. Certain cities show higher average order value, indicating premium demand.
5. High browsing behaviour does not always convert into high spend.

- TABLEAU DASHBOARD
https://public.tableau.com/views/E-CommerceCustomerBehaviorSalesAnalysis/CustomerRFMSegmentationRevenueInsightsRetailAnalytics?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
