# **Startup_Funding_Analysis**
This project presents an end-to-end Data Analytics pipeline for analyzing startup funding trends in India using Python, MySQL, and Power BI. It involves data cleaning, transformation, storage in a relational database, and visual storytelling via a dynamic dashboard.

# Project Structure
startup_funding.csv: Raw dataset containing startup funding data

startup_funding_cln.csv: Cleaned and preprocessed dataset

startup_funding_analysis.ipynb / .py: Python script for data cleaning, transformation, and MySQL integration

startup_funding_dashboard.pbix: Power BI dashboard showcasing insights

README.md: Project documentation

# Objective
To analyze startup funding data by:

Identifying investment trends

Highlighting major investors, investment types, and industries

Understanding city-wise funding patterns

# 🛠️ Tools & Technologies Used
  * Task	Technology
  * Data Cleaning	Python (Pandas, NumPy)
  * Data Visualization	Power BI
  * Database Integration	MySQL, PyMySQL
  * Dashboard	Power BI Desktop
  * Dashboard Preview

# 📌 Key Features
  * Total Funding: $55 Billion
  * Total Startups Analyzed: 3016
  * Top Funded Cities: Bangalore, Mumbai, New Delhi
  * Top Industries: Consumer Internet, E-commerce, Technology
  * Popular Investment Types: Private Equity, Seed Funding
  * Investment Trend Analysis (2015–2020)

🔄 Data Pipeline Overview
  1. Data Cleaning & Preprocessing (Python):
    * Renamed inconsistent column headers
    * Removed uninformative Remarks column
    * Handled null values with forward fill, mean imputation, and random sampling for text fields
    * Standardized date and amount formats

  2. Data Export
    * Cleaned data was exported to startup_funding_cln.csv

  3. MySQL Integration
    * Used PyMySQL to:
      * Establish connection to local MySQL server
      * Create and insert cleaned data into startup_funding_cln table in the codeit database
      * Verified records using SQL queries

  4. Dashboarding in Power BI
    * Connected Power BI directly to MySQL (live connection, no file uploads)
    * Built interactive visuals:
      * Bar charts (Top cities, industries)
      * Line charts (Year-wise trends)
      * Pie charts (Investment types)
      * Maps (City-wise investor locations)

# ✅ How to Run the Project
  * Clone this repo or download the files
  * Ensure MySQL is installed and running locally
  * Update MySQL credentials in the script if needed

Run the Python script:

bash
Copy
Edit
python startup_funding_analysis.py
Open Power BI → Connect to MySQL → Load startup_funding_cln table → Refresh visuals

📌 Sample Query Used in MySQL
sql
Copy
Edit
SELECT city_location, SUM(amount_usd) as total_investment
FROM startup_funding_cln
GROUP BY city_location
ORDER BY total_investment DESC;
📈 Business Insights
Bangalore tops in both number of investors and total funding

Private Equity is the most common investment type (44.8%)

Consumer Internet is the most funded industry

2018 saw the highest spike in funding among all years

💡 Conclusion
This project demonstrates the complete workflow of a data analytics project — from raw data ingestion to real-time insights — and showcases how to transform unstructured data into meaningful business intelligence.
