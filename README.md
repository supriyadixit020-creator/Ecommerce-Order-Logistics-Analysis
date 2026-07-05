<div align="center">

# 📦 E-Commerce Order & Logistics Analysis
### *Where Does the Revenue Come From — And Why Does Delivery Sometimes Fail?*

[![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)](.)
[![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=flat-square&logo=microsoft-sql-server&logoColor=white)](.)
[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)](.)

`96,478 Orders` · `$13.2M Revenue Analyzed` · `5 Relational Tables Joined` · `2-Page Interactive Dashboard`

</div>

---

## 🧭 The Setup

Olist is a Brazilian e-commerce marketplace connecting small sellers to major online retail channels. Behind every order sits a chain of data — customer, items, payment, product, delivery — spread across **five separate tables**, exactly how a real production database is structured.

This project reconstructs that full order journey to answer three questions a regional operations lead would actually ask:

```
  📍 Where is the revenue concentrated — and is that a risk?
  🚚 Why do some deliveries succeed while others fail or run late?
  💳 How do customers actually pay, and what does that tell us?
```

---

## 🏗️ Why Five Tables Instead of One

Unlike a single flat spreadsheet, this dataset mirrors a **real relational database** — which meant the analysis had to be built the way production data actually works:

| Table | Role |
|---|---|
| `orders` | The backbone — status, purchase date, delivery dates |
| `order_items` | Price and product per line item |
| `customers` | Where the buyer is located |
| `products` | What category was sold |
| `payments` | How the order was paid for |

**SQL `INNER JOIN`s across all five tables** were required to answer even basic questions like *"which state generates the most revenue?"* — this is the first project in this portfolio to require multi-table relational logic instead of single-table aggregation.

---

## 🧹 Cleaning Notes

```python
✓ Converted 5 date columns in `orders` from text → datetime
✓ Engineered a new field: delivery_delay_days (actual − estimated date)
✓ Classified every order into Late / On-Time-Early / Not-Delivered
✓ Filled 610 missing product categories as "unknown"
✓ Dropped 3 metadata columns unrelated to business questions
✓ Verified zero remaining nulls across all 5 cleaned tables
```

---

## 📊 What the Joined Data Revealed

<div align="center">

| Total Orders | Total Revenue | Avg Order Value | Late Delivery Rate |
|:---:|:---:|:---:|:---:|
| **96,478** | **$13.22M** | **$119.98** | **6.77%** |

</div>

### 1. One state carries the business

```
São Paulo (SP)   ████████████████████████████████████████  $5.20M  (39%)
Rio de Janeiro    ████████                                   $1.82M  (14%)
Minas Gerais      ███████                                    $1.59M  (12%)
```
→ SP alone outproduces the next two states **combined**.

### 2. Late orders aren't cheap orders

| Delivery Outcome | Avg Order Value |
|---|:---:|
| 🔴 Not Delivered | **$151.08** |
| 🟠 Late | **$135.71** |
| 🟢 On-Time / Early | $118.87 |

→ Counterintuitively, the orders most likely to fail or run late are **worth more**, not less.

### 3. Delivery delay isn't evenly distributed

| State | Late Delivery Rate |
|---|:---:|
| 🔴 Maranhão (MA) | **16.73%** |
| Ceará (CE) | 13.17% |
| Bahia (BA) | 11.72% |
| *Company average* | *6.77%* |

→ MA's failure rate is **2.5x** the national average — a clear regional logistics gap.

### 4. Payment is a one-horse race

```
Credit Card  ████████████████████████████████████  73.9%  ($12.5M)
Boleto       ██████████                              19.0%  ($2.9M)
Voucher      ███                                       5.6%
Debit Card   █                                          1.5%
```

### 5. Revenue concentrates at the top of the catalog

The top 3 of 70+ categories — Health & Beauty, Watches & Gifts, and Bed/Bath/Table — generate **27% of total revenue**, with Watches & Gifts earning nearly as much as the #1 category from **half the order volume**, signaling a premium-pricing dynamic.

---

## 💡 Where the Business Should Act

| # | Action | Rationale |
|---|---|---|
| 1 | Diversify revenue beyond São Paulo | 39% single-state concentration is a structural risk |
| 2 | Prioritize logistics for high-value orders | These orders fail/delay more *and* matter more |
| 3 | Audit carrier routes into MA, CE, BA | 2-2.5x higher late rates than the national average |
| 4 | Harden the credit-card checkout path | 74% of all transactions flow through it |
| 5 | Dual-track catalog strategy | Premium expansion + volume promotion, by category type |

*Full root-cause breakdown and projected impact in [`Ecommerce_Business_Recommendations.txt`](./Ecommerce_Business_Recommendations.txt)*

---

## 🖥️ The Dashboard — Built as Two Pages, On Purpose

Rather than cramming every visual onto one screen, this dashboard is split deliberately:

**Page 1 — Overview:** the four numbers and two trends an executive needs in the first five seconds.
**Page 2 — Deep Dive:** category, geography, and delivery-delay detail for anyone who clicks through.

A navigation button connects them — the way a real internal reporting tool would work.

![E-Commerce Dashboard Overview](Ecommerce_dashboard_page1_preview.png)
![E-Commerce Dashboard Deep Dive](Ecommerce_dashboard_page2_preview.png)

---

## 🗂️ Repository Contents

```
Ecommerce-Order-Analysis/
│
├── olist_orders_dataset.csv              raw orders table
├── olist_order_items_dataset.csv         raw order items table
├── olist_customers_dataset.csv           raw customers table
├── olist_products_dataset.csv            raw products table
├── olist_order_payments_dataset.csv      raw payments table
├── orders_cleaned.csv                    cleaned orders (+ delivery_delay_days)
├── order_items_cleaned.csv               cleaned order items
├── customers_cleaned.csv                 cleaned customers
├── products_cleaned.csv                  cleaned products
├── payments_cleaned.csv                  cleaned payments
├── ecommerce_eda.ipynb                   Python cleaning + EDA notebook
├── ecommerce_modeling.sql                SQL queries (multi-table JOINs)
├── Ecommerce_Dashboard.pbix              Power BI dashboard (2 pages)
├── Ecommerce_dashboard_page1_preview.png Overview page screenshot
├── Ecommerce_dashboard_page2_preview.png Deep Dive page screenshot
├── Ecommerce_Business_Recommendations.txt insights & recommendations
└── README.md                             you are here
```

---

## 🛠️ Skills Demonstrated

`Multi-Table Data Cleaning` `Date Engineering` `SQL INNER JOINs` `Relational Data Modeling` `Statistical EDA` `Geographic Analysis` `DAX Measures` `Multi-Page Dashboard Design` `Page Navigation Actions` `Business Storytelling`

---

## 👩‍💻 About Me

**Supriya Dixit** — Aspiring Data Analyst
Connecting the dots between tables — and between data and decisions.

---

<div align="center">

⭐ **If this multi-table approach was useful to you, a star is appreciated!** ⭐

</div>
