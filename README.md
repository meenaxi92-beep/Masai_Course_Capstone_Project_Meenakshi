# Mamaearth Returns & Growth Intelligence Pipeline

## Project Overview

The **Mamaearth Returns & Growth Intelligence Pipeline** is an end-to-end data analytics project designed to investigate e-commerce returns, reconcile revenue figures, identify payment-related return patterns, and generate actionable business recommendations.

The project combines SQL-based data preparation and reporting, Python-based data cleaning and exploratory data analysis (EDA), data visualisation, and Generative AI-assisted narrative generation. The objective is to transform raw order data into reliable findings that can support better return-risk monitoring and business decision-making.

## Business Problem

High product-return rates can affect revenue reporting, operational efficiency, and customer experience. Understanding how returns vary by payment method, order value, customer rating, and city tier can help a business identify segments that deserve further investigation.

This project addresses the following questions:

a. Does Cash on Delivery (COD) have a higher return rate than digital payment methods?
b. Are higher discounts associated with fewer returns?
c. Do customer ratings show a consistent relationship with returns?
d. Do higher-value COD orders have higher return rates?
e. Is the return rate particularly high for high-value COD orders in Tier 2 cities?

## Project Objectives

1. Create and query a relational database using SQL.
2. Clean and validate the raw order data using Python.
3. Identify duplicate records, missing values, and potential quantity outliers.
4. Analyze revenue, payment methods, customer ratings, and return patterns.
5. Test business hypotheses using descriptive statistics and correlation analysis.
6. Create visualisations to communicate the main findings.
7. Use Generative AI to convert analytical findings into a structured business narrative.

## Technology Stack

- **SQL / MySQL:** Database schema, data preparation, and reporting queries.
- **Python:** Data cleaning, analysis, and reconciliation.
- **Pandas:** Data manipulation and analysis.
- **Matplotlib and Seaborn:** Data visualisation.
- **Generative AI:** Structured narrative generation from analytical findings.
- **GitHub:** Version control and project documentation.
- **Google Colab:** Development and experimentation environment.

## Project Structure

```
Masai_Course_Capstone_Project_Meenakshi/
│
├── README.md
│
├── Analysis/
│   ├── clean_and_eda.py
│   ├── visualize.py
│   └── generate_narrative.py
│
├── Data/
│   ├── DATA_CUSTOMERS.csv
│   ├── DATA_PRODUCTS.csv
│   ├── DATA_ORDERS.csv
│   └── orders_clean.csv
│
├── Narrator/
│   ├── generate_narrative.py
│   └── findings.json
│
├── Sql/
│   ├── schema.sql
│   ├── seed_data.sql
│   └── reports.sql
│
└── Visualisations/
    ├── return_rate_by_payment.png
    ├── monthly_revenue_trend.png
    └── cod_return_rate_by_segment.png
```

*Note: Confirm that the listed files and visualisation filenames match the actual repository. If the two narrative scripts serve the same purpose, consider consolidating them to avoid duplication.*

## Analytical Workflow

### Part 1: SQL — Database Creation and Reporting

The SQL component creates the database tables, loads the data, and calculates order-level and revenue metrics including:

- Total order count and total revenue.
- Average order value.
- Handling of missing ratings using `COUNT(*)` versus `COUNT(rating)`.
- Reporting queries used as a baseline for comparison with Python results.

### Part 2: Python — Data Cleaning and Exploratory Analysis

The Python pipeline prepares the data for reliable analysis which includes:

- Loading customer, product, and order datasets.
- Standardizing payment-method labels.
- Identifying and removing five duplicate order records.
- Filling missing discount values with zero and missing ratings with the median rating.
- Calculating order values and reconciling revenue.
- Detecting potential quantity outliers using the interquartile range (IQR) method.
- Analyzing return patterns across payment methods, ratings, order-value groups, and city tiers.

The cleaned dataset contains **175 orders**, compared with 180 raw orders.

### Part 3: Data Visualisation

The project uses visualisations to make important patterns easier to interpret:

1. **Return Rate by Payment Method:** Compares return rates for COD, CARD, and UPI.
2. **Monthly Revenue Trend:** Shows monthly revenue after addressing the identified outlier-related distortion.
3. **COD Return Rate by Segment:** Compares return rates across city tiers and COD order-value groups.

### Part 4: Generative AI Narrative

The narrative component uses analytical findings to generate a structured business summary with three sections:

- **Situation:** Establishes the cleaned revenue baseline and analytical context.
- **Complication:** Highlights the revenue reconciliation difference and the observed concentration of returns.
- **Resolution:** Recommends a targeted pilot and further validation.

The generated narrative is intended to explain the analysis, not replace the underlying calculations or independent verification of results.

## Key Findings

### 1. Revenue Reconciliation

| Metric | Result |
|---|---:|
| Raw order count | 180 |
| Cleaned order count | 175 |
| Raw SQL revenue benchmark | ₹99,860.20 |
| Cleaned Python revenue | ₹97,358.30 |
| Revenue difference | ₹2,501.90 |

The cleaned revenue is ₹2,501.90 lower than the raw SQL benchmark. The difference is associated with the removal of five duplicate records under the selected duplicate-identification rule.

The reconciliation should be interpreted alongside the cleaning logic and the treatment of missing values. Duplicate removal is only justified when the records meet the chosen definition of a duplicate.

### 2. Return Rate by Payment Method

| Payment method | Return rate |
|---|---:|
| COD | 44.4% |
| CARD | 14.7% |
| UPI | 18.9% |

COD has the highest observed return rate among the three payment methods in this dataset. This makes COD a priority for further return-risk investigation.

### 3. Return Rate by COD Order Value

| Order-value group | Orders | Returned orders | Return rate |
|---|---:|---:|---:|
| Low Value | 18 | 6 | 33.3% |
| Medium Value | 18 | 6 | 33.3% |
| High Value | 18 | 12 | 66.7% |

High-value COD orders have twice the observed return rate of the low- and medium-value groups. These results are descriptive and should be validated with additional observations.

### 4. COD Return Rate by City Tier and Order Value

| City tier | Order-value group | Orders | Returned orders | Return rate |
|---|---|---:|---:|---:|
| Tier 1 | Low Value | 10 | 4 | 40.0% |
| Tier 1 | Medium Value | 12 | 3 | 25.0% |
| Tier 1 | High Value | 10 | 5 | 50.0% |
| Tier 2 | Low Value | 8 | 2 | 25.0% |
| Tier 2 | Medium Value | 6 | 3 | 50.0% |
| Tier 2 | High Value | 8 | 7 | 87.5% |

The highest observed rate is among high-value COD orders in Tier 2 cities: seven returns out of eight orders, or 87.5%.

**Important limitation:** This segment contains only eight orders. A small number of additional orders could materially change the percentage, so the result should not be treated as a stable prediction or proof of causation.

### 5. Monthly Revenue Trend

The analysis identified January 2026 revenue as being inflated by an outlier-related effect. After addressing this issue, March 2026 emerged as the peak month, with revenue of ₹20,318.90.

This illustrates why outlier investigation and data validation are important before using monthly revenue figures for business decisions.

## Hypothesis Testing and Business Implications

### Hypothesis 1: COD orders have a higher return rate than CARD or UPI orders

**Verdict: Supported by the observed data.**
COD has a 44.4% return rate, compared with 14.7% for CARD and 18.9% for UPI.

**Business implication:** Monitor COD returns closely and investigate operational or customer-related factors before changing payment policies.

### Hypothesis 2: Higher discounts are associated with a lower return rate

**Verdict: Not supported by the correlation analysis.**
The observed correlation between discount percentage and returns was negligible, approximately -0.09. This does not show a meaningful linear relationship in the analysed data.

**Business implication:** Do not rely on discounts alone to reduce returns. Evaluate discounts alongside conversion, margins, and return outcomes.

### Hypothesis 3: Higher customer ratings are associated with a lower return rate

**Verdict: Not conclusively supported.**
Return rates did not consistently decrease as ratings increased. For example, the observed return rate was 39.1% for two-star orders and 16.7% for four-star orders.

**Business implication:** Examine ratings alongside product categories, order details, and customer feedback rather than treating ratings as a standalone return predictor.

### Hypothesis 4: Higher-value COD orders have a higher return rate

**Verdict: Supported descriptively.**
High value COD orders had a 66.7% return rate, compared with 33.3% for both low and medium value COD orders.

**Business implication:** Consider a measured pilot focused on high-value COD orders and track whether interventions reduces the return without negatively affecting conversion.

### Hypothesis 5: High-value COD orders in Tier 2 cities have an especially high return rate

**Verdict: Supported descriptively; further validation required.**
The observed return rate was 87.5%, based on seven returned orders out of eight.

**Business implication:** Prioritize this segment for further investigation. Test targeted interventions before implementing broad policy changes.

## Overall Conclusion

The strongest descriptive finding is the higher return rate associated with COD, particularly among high-value COD orders in Tier 2 cities. Discount percentage showed negligible correlation with returns, while the relationship between ratings and returns was inconsistent.

The revenue reconciliation also demonstrates the importance of documenting cleaning decisions and validating financial metrics before reporting them.

These findings can guide further investigation and controlled business experiments. They do not establish causation or guarantee that the same patterns will occur in future orders.

## Limitations

- The analysis uses a limited dataset of 180 raw orders and 175 cleaned orders.
- The high-value COD Tier 2 segment contains only eight orders.
- Correlation does not establish causation and may not capture nonlinear relationships.
- Results depend on the selected duplicate-identification and data-cleaning rules.
- Observed patterns should be revalidated as more data becomes available.
- Business interventions should be measured against defined outcomes before being adopted at scale.

## How to Run the Project

### Prerequisites

- Python 3 installed.
- MySQL installed if you want to run the SQL component.
- Git installed to clone the repository.

### 1. Clone the repository

```bash
git clone https://github.com/meenaxi92-beep/Masai_Course_Capstone_Project_Meenakshi.git
cd Masai_Course_Capstone_Project_Meenakshi
```

### 2. Create and activate a virtual environment

On macOS or Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install Python dependencies

Install the packages required by the scripts:

```bash
pip install pandas matplotlib seaborn google-genai
```

The `google-genai` package is needed only if the narrative script uses the Google Gen AI SDK. Check the imports in your final scripts and add any other required packages.

### 4. Run the SQL scripts

Open MySQL Workbench or your MySQL client and execute the SQL files in the appropriate order:

1. `Sql/schema.sql`
2. `Sql/seed_data.sql`
3. `Sql/reports.sql`

Ensure the database and file-loading configuration match your local environment.

### 5. Run the Python pipeline

After confirming that the scripts use project-relative paths and that the required input files are in `Data/`, run:

```bash
python Analysis/clean_and_eda.py
python Analysis/visualize.py
python Analysis/generate_narrative.py
```

Run these commands only after confirming that each script's inputs, outputs, and execution order match the current implementation. The cleaning script should generate the cleaned dataset and findings file expected by the downstream scripts.

### 6. Configure the optional AI narrative

If the narrative script uses the Google Gen AI API, set your API key as an environment variable before running it.

```bash
export GEMINI_API_KEY="your_api_key_here"
```

Never commit API keys or other secrets to GitHub. If no API key is configured, the script should use its offline fallback if that feature is implemented.

## Future Improvements

- Validate the findings against a larger dataset and additional time periods.
- Investigate why COD orders have a higher observed return rate.
- Examine return patterns by product category and other relevant customer or order attributes.
- Test targeted return-prevention interventions and measure their effect on returns and conversion.
- Automate data validation and revenue reconciliation checks.
- Add reproducible execution instructions, dependency versioning, and automated tests.

## Author

**Meenakshi Vyas**

*Data Analytics Capstone Project*
