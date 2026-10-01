# 💰 Finance Loan Analysis – SQL Project

A practical **MySQL data analysis project** focused on exploring loan portfolio data and generating business-oriented insights using SQL.

The project analyzes loan amounts, revolving balances, payment behavior, loan status, geographic distribution, verification status, and home ownership using **CTEs, JOINs, aggregate functions, date conversion, GROUP BY, ORDER BY, and window functions**.

---

## 📌 Project Overview

Financial loan data contains multiple attributes related to borrowers, loan amounts, repayment activity, credit history, and borrower characteristics.

This project uses SQL to transform the raw loan data into analytical results that answer key business questions such as:

* How does the total loan amount change year by year?
* What is the total revolving balance for each grade and sub-grade?
* How does total payment differ by verification status?
* How does loan status vary by state and year?
* How does last payment activity differ across home ownership categories?

The project demonstrates how SQL can be used to extract meaningful information from relational loan data.

---

## 🎯 Business Objectives

The main objectives of this project are:

* Analyze yearly loan amount trends
* Analyze revolving balances by loan grade and sub-grade
* Compare total payments across verification statuses
* Analyze loan status by state and year
* Analyze last payment amounts by home ownership and year
* Practice SQL-based financial data analysis
* Generate structured datasets that can be used for reporting and visualization

---

## 📂 Dataset / Tables Used

The SQL project works with two tables:

### `finance_1`

Contains loan and financial information used in the analysis.

Examples of fields referenced in the SQL queries include:

* `issue_d`
* `loan_amnt`
* `grade`
* `sub_grade`
* `revol_bal`
* `id`

### `finance_2csv`

Contains additional borrower, payment, and loan-status information.

Fields referenced include:

* `id`
* `verification_status`
* `total_pymnt`
* `addr_state`
* `loan_status`
* `last_credit_pull_d`
* `home_ownership`
* `last_pymnt_amnt`

The two tables are joined using the common `id` field.

---

# 🔗 Data Relationship

The project combines information from the two finance tables using an **INNER JOIN**:

```sql
FROM finance_1 f1
INNER JOIN finance_2csv f2
    ON f1.id = f2.id
```

This relationship is used in multiple analyses, including grade/sub-grade analysis, verification-status payment analysis, state-wise loan analysis, and home-ownership analysis.

---

# 📊 SQL Analysis Performed

## 1️⃣ Year-wise Loan Amount

### Business Requirement

Analyze the total loan amount issued in each year.

### SQL Approach

The project converts the `issue_d` field into a date using `STR_TO_DATE()` and then extracts the year.

```sql
STR_TO_DATE(
    CONCAT('01-', TRIM(issue_d)),
    '%d-%b-%y'
)
```

The converted dates are then grouped by year and the loan amount is aggregated using `SUM()`.

```sql
SELECT
    YEAR(converted_date) AS Years,
    SUM(loan_amnt) AS LoanAmount
FROM formatted_date_table
GROUP BY YEAR(converted_date)
ORDER BY Years;
```

The analysis uses a **CTE (`WITH`)** to create the formatted date table before performing the aggregation.

### Business Value

This analysis provides a year-by-year view of the loan portfolio and helps identify changes in lending activity over time.

---

## 2️⃣ Grade & Sub-Grade Wise Revolving Balance

### Business Requirement

Analyze revolving balances across different borrower grades and sub-grades.

### SQL Approach

The project joins the two finance tables and calculates:

```sql
SUM(revol_bal)
```

grouped by:

```text
Grade
Sub-Grade
```

The result is ordered by grade and sub-grade.

### Example Output Structure

| Grade | Sub-Grade | Revolving Balance |
| ----- | --------- | ----------------: |
| A     | A1        |               ... |
| A     | A2        |               ... |
| B     | B1        |               ... |
| B     | B2        |               ... |

### Business Value

This analysis helps understand how revolving balances are distributed across different credit-grade segments.

---

## 3️⃣ Total Payment by Verification Status

### Business Requirement

Compare total payment amounts across different verification categories.

### SQL Approach

The query calculates:

```sql
ROUND(SUM(total_pymnt), 2)
```

and groups the result by:

```text
verification_status
```

The two finance tables are joined using `id`.

### Business Value

This analysis provides a comparison of payment amounts across borrower verification categories.

---

## 4️⃣ State-wise & Year-wise Loan Status

### Business Requirement

Analyze loan status across states and years using the last credit pull date.

### SQL Approach

The `last_credit_pull_d` field is converted into a date using `STR_TO_DATE()`.

```sql
STR_TO_DATE(
    CONCAT(TRIM(last_credit_pull_d), '-01'),
    '%y-%b-%d'
)
```

A CTE is then used to prepare the formatted date before selecting:

* State
* Year
* Loan Status

The final result is ordered by:

```text
State
Year
```

### Business Value

This analysis allows loan activity and loan status to be examined geographically and across time.

---

## 5️⃣ Home Ownership vs Last Payment Date Statistics

### Business Requirement

Analyze last payment amounts by home ownership and year.

### SQL Approach

This analysis uses a **window function**:

```sql
MAX(
    STR_TO_DATE(
        CONCAT(TRIM(last_credit_pull_d), '-01'),
        '%y-%b-%d'
    )
) OVER (
    PARTITION BY home_ownership
)
```

The query then groups the results by:

```text
home_ownership
Year
```

and calculates:

```sql
SUM(last_pymnt_amnt)
```

as the total last payment amount.

### Business Value

This analysis provides a view of payment activity across different home ownership categories and years.

---

# 🧠 SQL Concepts Demonstrated

This project demonstrates practical use of several important MySQL concepts.

### CTEs

The project uses `WITH` clauses to create temporary result sets for date transformation and subsequent analysis.

```sql
WITH formatted_date_table AS (...)
```

### INNER JOIN

Used to combine `finance_1` and `finance_2csv` using the common `id` field.

### Aggregate Functions

The project uses:

```text
SUM()
MAX()
ROUND()
```

### Date Functions

The project uses:

```text
STR_TO_DATE()
CONCAT()
TRIM()
YEAR()
```

### GROUP BY

Used to create grouped financial and loan-status summaries.

### ORDER BY

Used to arrange analytical results chronologically and alphabetically.

### Window Functions

The home ownership analysis uses:

```sql
MAX(...) OVER (PARTITION BY home_ownership)
```

to calculate the maximum converted date within each ownership category.

---

# 🛠 Tools & Technologies

* **MySQL**
* SQL
* CTEs
* INNER JOIN
* Aggregate Functions
* Window Functions
* Date Functions
* GROUP BY
* ORDER BY
* Financial Data Analysis

---

# 📈 Key Analysis Areas

| Analysis Area  | SQL Analysis                          |
| -------------- | ------------------------------------- |
| Loan Amount    | Year-wise loan amount                 |
| Credit Grades  | Grade and sub-grade revolving balance |
| Payments       | Total payment by verification status  |
| Loan Status    | State and year-wise loan status       |
| Geography      | State-wise loan analysis              |
| Home Ownership | Last payment statistics by ownership  |
| Time Analysis  | Year-based financial analysis         |

---

# 📚 Key Learnings

Through this project, I gained practical experience in:

* Writing SQL queries for financial data analysis
* Working with multiple relational tables
* Joining datasets using common keys
* Handling date fields stored in text formats
* Using CTEs for structured queries
* Applying aggregate functions to financial metrics
* Using `GROUP BY` and `ORDER BY`
* Applying window functions with `PARTITION BY`
* Translating business questions into SQL queries
* Creating analysis-ready datasets for reporting



---

# 📁 Project Structure

```text
Finance-SQL-Project/
│
├── Finance_project_sql.sql
└── README.md
```

---

# 👤 Author

**Humaira**

Data Analyst | SQL | Excel | Power BI | Data Analytics

---

## 📌 Project Note

This project was created for **learning, portfolio, and demonstration purposes**.

It demonstrates how SQL can be used to transform raw loan and financial data into structured analytical outputs that can support reporting, visualization, and business analysis.
