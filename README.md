
Masai_Course_Capstone_Project_Meenakshi/
├── README.md
├── Analysis/
│   ├── clean_and_eda.py
From Task 1 - 5 Conclusion
*Reconciliation Note*
The total order value reconciled post clean up in python **(₹ 97358.30)** is different from the total value calculated in the SQL **(₹ 99860.20)** with a difference of value as **₹ 2501.90**. The difference is an attributable post data clean up by removal by 5 Duplicate Rows with rating & discount imputation having no effect on the final result. Current Data provided without any missing or incorrect data will help us on hypothesis and analysis for Reporting.

│   └── generate_narrative.py
│   └── visualize.py
├── Data/
│   ├── DATA_CUSTOMERS.csv
│   ├── DATA_PRODUCTS.csv
│   ├── DATA_ORDERS.csv
│   └── orders_clean.csv
├── Narrator/
│   ├── generate_narrative.py
│   └── findings.json
├── Sql/
│   ├── schema.sql
│   ├── seed_data.sql
│   └── reports.sql
└── Visualizations/
    ├── return_rate_by_payment.png
    ├── monthly_revenue_trend.png
    └── cod_return_rate_by_segment.png

# Mamaearth Returns & Growth Intelligence Pipeline 
Hypothesis Testing and Key Findings
This section documents the hypotheses explored during the Python analysis, the observed results, and the business implications. The findings describe patterns in this dataset; they do not establish causation or guarantee that the same patterns will hold for all orders.
Hypothesis 1: COD orders have a higher return rate than CARD or UPI orders
Hypothesis: Orders using payment_method = COD have a higher returned rate than orders using CARD or UPI.
Verdict: Supported by the data.
The analysis found that 44.4% of COD orders were returned, a higher rate than CARD and UPI. This suggests COD orders may require closer return-risk monitoring. Further investigation could help identify operational or customer factors associated with this difference.
Business implication: Monitor COD return performance and evaluate targeted interventions before changing payment policies.
Hypothesis 2: Higher discounts are associated with a lower return rate
Hypothesis: Higher discount_pct is associated with a lower return rate (returned).
Verdict: Not supported by the correlation analysis.
The correlation between discount_pct and returned was negligible in the analysis. The results do not show a meaningful linear relationship between discount percentage and returns, so the hypothesis that higher discounts reduce returns is not supported by this measure.
Business implication: Do not rely on discounts alone as a return-reduction strategy. Evaluate discounts against margin, conversion, and return outcomes together.
Hypothesis 3: Orders with higher ratings have a lower return rate
Hypothesis: Orders with higher rating have a lower returned rate.
Verdict: Not conclusively supported.
Return rates varied across rating groups and did not consistently decrease as ratings increased. For example, the analysis reported a 39.1% return rate for 2-star orders and 16.7% for 4-star orders. The pattern was not monotonic, so the data does not establish that higher ratings consistently correspond to fewer returns.
Business implication: Review rating and return patterns together with product category, order details, and customer feedback rather than treating ratings as a standalone return predictor.
Hypothesis 4: Higher-value COD orders have a higher return rate
Hypothesis: Higher-value COD orders have a higher return rate than lower-value COD orders.
Verdict: Supported descriptively, with a small-sample caveat.
The COD order-value groups showed the following return rates:
COD order-value group	Orders	Returned orders	Return rate
Low Value	18	6	33.3%
Medium Value	18	6	33.3%
High Value	18	12	66.7%


High-value COD orders had a higher observed return rate than the low- and medium-value groups. Each group contained only 18 orders, so this pattern should be validated with more data before being treated as a stable business rule.
Business implication: Consider closer monitoring or a pilot intervention for high-value COD orders, then measure whether it reduces returns without harming conversion.
Hypothesis 5: High-value COD orders in Tier 2 cities have a higher return rate than other COD order-value segments
Hypothesis: The combination of COD payment, high order value, and Tier 2 city is associated with a higher return rate than other COD order-value segments.
Verdict: Supported descriptively; further validation is needed.
City tier	COD order-value group	Orders	Returned orders	Return rate
Tier 1	Low Value	10	4	40.0%
Tier 1	Medium Value	12	3	25.0%
Tier 1	High Value	10	5	50.0%
Tier 2	Low Value	8	2	25.0%
Tier 2	Medium Value	6	3	50.0%
Tier 2	High Value	8	7	87.5%


The highest observed rate was for high-value COD orders in Tier 2 cities: 7 returns out of 8 orders (87.5%). This segment is small, so the percentage may be sensitive to a small number of orders. The result is an association in this dataset, not evidence that city tier or payment method causes returns.
Business implication: Prioritize this segment for further investigation and test targeted return-prevention measures before making broad policy changes.
Overall conclusion
The strongest descriptive signal in this analysis is the higher return rate for COD orders, especially high-value COD orders in Tier 2 cities. Discount percentage showed negligible correlation with returns, while the relationship between ratings and returns was not consistent. These findings can guide further investigation, but they should be validated with additional data and monitored over time before being used as firm business rules.
Data preparation and revenue reconciliation
The raw dataset contained 180 orders. Five duplicate rows were removed using the selected natural-key fields, leaving 175 orders for the cleaned analysis.
- Raw revenue benchmark from Part 1 SQL: ₹99,860.20
- Cleaned revenue after duplicate removal and cleaning: ₹97,358.30
- Difference associated with the removed duplicate rows: ₹2,501.90
The reconciliation explains why the cleaned Python revenue differs from the raw SQL total. The comparison depends on the duplicate-identification rule used in the cleaning process.
Notes and limitations
- The findings are descriptive and do not establish causation.
- The Tier 2 high-value COD segment contains only eight orders.
- Correlation measures linear association and does not rule out other types of relationships.
- Results should be rechecked if the source data, cleaning logic, or duplicate-identification rule changes.
