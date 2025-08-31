![Project Header](https://github.com/mayank1ahuja/da_airbnb_nyc/blob/c3b866fef33b6020132bdceec3dad51faccf128b/project%20images/project%20header.png)
<h2 align = "center">🗽🌇 New York City Airbnb Listings: Market Analysis & Insights 🏙️🗽</h2>




## 🏡 Project Overview

This repository presents an **end-to-end Python + SQL data analysis pipeline** applied to Airbnb listings data in New York City. The workflow begins with **data loading, cleaning, and preliminary exploration in Python**, transitions into **SQL-driven analytical queries**, and culminates in **visualizations and actionable insights** about the NYC Airbnb market.

The purpose of this project is to **demonstrate fluency in Python and SQL for analytics**, while producing a **portfolio-ready artifact that communicates analytical reasoning and professionalism**.

## 🏬 Problem Statement

New York City hosts one of the largest Airbnb markets globally, with thousands of listings distributed across multiple boroughs and neighborhoods. For **prospective hosts, renters, and analysts**, understanding **pricing trends, room type distributions, host behavior, and neighborhood activity** is crucial for decision-making.

The project addresses the question:  
**"How can we comprehensively analyze NYC Airbnb listings to uncover patterns in pricing, room types, availability, reviews, host activity, and neighborhood dynamics, producing actionable insights for hosts, renters, and market analysts?"**

![NYC MAP](https://github.com/mayank1ahuja/da_airbnb_nyc/blob/c3b866fef33b6020132bdceec3dad51faccf128b/project%20images/nyc-map.png)

## 🏤 Project Goals

1. Demonstrate analytical fluency in both Python (for data cleaning, exploration, and visualization) and SQL (for querying, aggregation, and business insights).
2. Produce actionable insights regarding NYC Airbnb listings: identifying popular neighborhoods, pricing trends, host activity, room type distribution, and demand patterns.
3. Create a portfolio-ready artifact that communicates professionalism, correctness, and a structured analytical workflow.

## 🏠 Dataset

- *Source:* [Kaggle](https://www.kaggle.com) 
- *Download:* [AB_NYC_2019.csv](https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data)

The dataset contains both categorical and numerical features, with missing values and outliers, which mirrors real-world analytical challenges.


## 🏢 Workflow

### 🏘️ Step 0: Loading Dependencies
```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```
---

### 🏘️ Step 1: Loading Data
```python
df = pd.read_csv('AB_NYC_2019.csv',
 encoding_errors = 'ignore',
 on_bad_lines = 'skip')
```
---

### 🏘️ Step 2: Initial Data Exploration
```python
df.head(3)
df.shape
df.info()
df.describe()
```
---

### 🏘️ Step 3: Data Cleaning
```python
#replacing the null value of 'last_review' and 'review_per_month' with 0
df['last_review'].fillna(0, inplace = True)
df['reviews_per_month'].fillna(0, inplace = True)

#replacing null values of 'name' and 'host_name'
df['name'].fillna('No Name', inplace = True)
df['host_name'].fillna('Unknown', inplace = True)

#changing the datatype of the 'last_review' column
df['last_review'] = pd.to_datetime(df['last_review'], errors = 'coerce')

df.to_csv('AB_NYC_2019_cleaned', index = False)
```
---

### 🏘️ Step 4: Exploratory Data Analysis


## 📊 Analysing Distribution
To understand the characteristics of NYC Airbnb listings, we start by examining the distributions of key numerical variables. Visualizing these distributions allows us to identify typical values, spotting patterns, and detecting extreme outliers.

1. Distribution of Prices 
To understand the pricing landscape of Airbnb listings in NYC, we examine the distribution of listing prices. This helps identify common price ranges as well as outliers.
```python
sns.histplot(df['price'])
plt.xlim(0, 2000)
plt.title('Distribution of Prices')
```
<p align="center">
  <img src = "https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/distribution%20of%20prices.png">
</p>

**Using the describe table we observe that:**
**- the average price comes out to be $152.72.**
**- the maximum price of an ABnB is $10,000, while**
**- the minimum price is $0.**
**The subsequent graph of the price column informs us that most of the ABnB are priced less that $500 hence the right-skewed graph.**

2. Distribution of the Number of Reviews
Next, we look at the number of reviews per listing to gauge host popularity and listing activity. This visualization highlights how frequently listings are being reviewed.
```python
sns.histplot(df['number_of_reviews'])
plt.xlim(0, 100)
plt.title('Distribution of the Number of Reviews')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/distribution%20of%20the%20number%20of%20reviews.png">
</p>

**Using the describe table we observe that the average reviews per month come out to be 23. Moreover, the graph indicates that majority of the listings have less than 20 reviews, with a few outliers having hundreds of reviews.**

3. Distribution of Reviews per Month
To further explore listing activity, we analyze reviews per month. This shows which listings are actively receiving feedback over time.
```python
sns.histplot(df['reviews_per_month'])
plt.xlim(0, 5)
plt.ylim(0, 5000)
plt.title('Distribution of Reviews per Month')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/distribution%20of%20reviews%20per%20month.png">
</p>

**Using the describe table we observe that the average reviews per month are only 1 in number. Moreover, the graph indicates that most of these listings don't get even a single review on a per month basis.**

4. Distribution of Availibility
Finally, we inspect availability throughout the year to understand how often listings are open for booking. This reveals patterns of seasonal or full-time availability.
```python
sns.histplot(df['availability_365'])
plt.title('Distribution of Availibility')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/distribution%20of%20availibility.png">
</p>

**Using the describe table we observe that the listings have an average availibility of 112 days, with 365 days being the maximum and 0 days being the minimum. The graph shows some peaks around 30 days, 90 days and 180 days, but most of these listings aren't available for even a single day.**


## 📊 Analysing Categorical Features
After examining numerical distributions, we now explore categorical aspects of the dataset. These visualizations help us understand how listings are distributed across room types and boroughs, which provides insight into host preferences and market trends.

1. Listings by room type
To understand which types of accommodations are most common on Airbnb in NYC, we analyze the number of listings by room type. This highlights the prevalence of entire homes, private rooms, and shared spaces.
```python
sns.countplot(df, x = 'room_type', hue = 'room_type', palette = 'Set1' )
plt.title('Number of Listings by Room Type')
plt.xlabel('Room Type')
plt.ylabel('Number of Listings')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/number%20of%20listings%20by%20room%20type.png">
</p>


2. Listings by neighbourhood group
Next, we look at how listings are distributed across the boroughs(neighbourhood groups). This shows which areas have the highest concentration of Airbnb listings and may indicate hotspots for travelers.
```python
sns.countplot(df, x = 'neighbourhood_group', hue = 'neighbourhood_group', palette = 'Set1')
plt.title('Number of Listings by Neighbourhood Group')
plt.xlabel('Neighbourhood Group')
plt.ylabel('Number of Listings')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/number%20of%20listings%20by%20neighbourhood%20group.png">
</p>

Using the graph, we interpret that Manhattan has the largest amount of listings, while Staten Island has the rarest of listings.


## 📊 Advanced Exploratory Visualizations
To gain deeper insights into the NYC Airbnb market, we now explore geographical patterns, cross-category distributions, and price trends. These visualizations provide a richer understanding of how listings vary by location, room type, and pricing.

1. Distribution of listings by latitude and longitude
We start with a geospatial scatter plot to visualize where listings are concentrated across the city. Coloring by borough (```neighbourhood_group```) highlights which areas have the highest density of Airbnb properties.
```python
sns.scatterplot(df, x = 'longitude', y = 'latitude', hue='neighbourhood_group', palette = 'Set1')
plt.title('Geographical Distribution of Airbnb Listings in NYC')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/geographical%20distribution%20of%20Airbnb%20listings%20in%20NYC.png">
</p>

2. Distribution of room type by neighbourhood group
Next, we examine how room types are distributed within each borough. This allows us to see, for example, which boroughs have more entire homes compared to private or shared rooms.
```python
sns.countplot(df, x = 'neighbourhood_group', hue = 'room_type', palette = 'Set2')
plt.title('Room Type Distribution by Borough')
plt.xlabel('Borough')
plt.ylabel('Number of Listings')
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/room%20type%20distribution%20by%20borough.png">
</p>

**As indiated by the graph, we can clearly deduce that Brooklyn has the highest number of Private rooms, while Manhattan has the largest amount of Entire home/apt as well as Shared rooms.**

3. Price distribution by room type
Finally, we explore pricing patterns across room types using a strip plot. This visualization highlights differences in pricing between entire homes, private rooms, and shared rooms, as well as extreme high-priced listings.
```python
sns.stripplot(df, x = 'room_type', y = 'price', hue = 'room_type', palette = 'husl')
plt.title('Price Distribution by Room Type')
plt.xlabel('Room Type')
plt.ylabel('Price')
plt.ylim(0, 1000)
```

<p align="center">
  <img src = "https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/price%20distribution%20by%20room%20type.png">
</p>

**Using the graph, we deduce that Entire home/apt room types tend to have higher prices with many clustered in the moderate price range and a few extreme outliers. Private rooms have moderate prices, generally lower than entire homes/apts. Shared rooms are the cheapest, with prices concentrated at the lower end.**

___

### 🏘️ Step 5: Connecting to PostgreSQL
```python
#importing psycopg2
import psycopg2
```

```python
#connecting to PostgreSQL
conn = psycopg2.connect(
    host = 'localhost',
    database = 'sql_project_p6',
    user = 'postgres',
    password = 'password'
)

cur = conn.cursor()
```

```python
#creating the table for listings
cur.execute("""
CREATE TABLE listings (
    id BIGINT PRIMARY KEY,
    name TEXT,
    host_id BIGINT,
    host_name TEXT,
    neighbourhood_group TEXT,
    neighbourhood TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    room_type TEXT,
    price NUMERIC,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month NUMERIC,
    calculated_host_listings_count INT,
    availability_365 INT
);
""")

conn.commit() 
```
___

### 🏘️ Step 6: SQL-Based EDA

1. Count of Listings per Borough
```sql
SELECT neighbourhood_group AS borough,
	   COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood_group
ORDER BY total_listings DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_1.png">
</p>

2. Average Price per Room Type
```sql
SELECT room_type,
	   ROUND(AVG(price), 2) AS avg_price
FROM listings
GROUP BY room_type
ORDER BY avg_price DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_2.png">
</p>

3. Top 5 Most Expensive Listings
```sql
SELECT id,
	   name,
	   neighbourhood_group,
	   price
FROM listings
ORDER BY price DESC
LIMIT 5;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_3.png">
</p>

4. Listings with More Than 100 Reviews
```sql
SELECT name,
	   neighbourhood_group,
	   number_of_reviews
FROM listings
WHERE number_of_reviews > 100
ORDER BY number_of_reviews DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_4.png">
</p>

5. Top 10 Busiest Hosts 
```sql
SELECT host_name,
	   COUNT(*) AS total_listings
FROM listings
GROUP BY host_name
ORDER BY total_listings DESC
limit 10;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_5.png">
</p>

6. Average Reviews per Month by Room Type
```sql
SELECT room_type,
	   ROUND(AVG(reviews_per_month),2) AS avg_reviews_per_month
FROM listings
GROUP BY room_type
ORDER BY avg_reviews_per_month DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_6.png">
</p>

7. Minimum, Maximum, and Average Price per Borough
```sql
SELECT neighbourhood_group AS borough,
       MIN(price) AS min_price,
       MAX(price) AS max_price,
       ROUND(AVG(price),2) AS avg_price
FROM listings
GROUP BY neighbourhood_group
ORDER BY avg_price DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_7.png">
</p>

8. Average Number of Reviews per Borough
```sql
SELECT neighbourhood_group AS borough,
       ROUND(AVG(number_of_reviews),2) AS avg_reviews
FROM listings
GROUP BY neighbourhood_group
ORDER BY avg_reviews DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_8.png">
</p>

9. Number of Listings with 0 Availability per Borough
```sql
SELECT neighbourhood_group AS borough,
       COUNT(*) AS unavailable_listings
FROM listings
WHERE availability_365 = 0
GROUP BY neighbourhood_group
ORDER BY unavailable_listings DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_9.png">
</p>

10. Average Minimum Nights per Room Type 
```sql
SELECT room_type, 
       ROUND(AVG(minimum_nights),2) AS avg_min_nights
FROM listings
GROUP BY room_type
ORDER BY avg_min_nights DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_10.png">
</p>

11. Top 10 Neighbourhoods with Most Listings
```sql
SELECT neighbourhood, 
	   COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 10;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_11.png">
</p>

12. Number of Listings with Zero Reviews per Room Type
```sql
SELECT room_type, 
	   COUNT(*) AS zero_review_listings
FROM listings
WHERE number_of_reviews = 0
GROUP BY room_type
ORDER BY zero_review_listings DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_12.png">
</p>

13. Average Reviews per Month v/s Room Type
```sql
SELECT room_type, 
       ROUND(AVG(reviews_per_month),2) AS avg_reviews_per_month
FROM listings
GROUP BY room_type
ORDER BY avg_reviews_per_month DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_13.png">
</p>

14. Hosts with More than 5 Listings
```sql
SELECT host_name, 
	   COUNT(*) AS total_listings
FROM listings
GROUP BY host_name
HAVING COUNT(*) > 5
ORDER BY total_listings DESC;
```

<p align="center">
  <img src="https://github.com/mayank1ahuja/da_airbnb_nyc/blob/56643370a6b2595502c5f85861619079ebbf72d7/queries/query_14.png">
</p>
---

### 🏘️ Step 7: Visualising SQL Queries
1. Query Number 5: Top 10 Busiest Hosts 
```sql
SELECT host_name,
	   COUNT(*) AS total_listings
FROM listings
GROUP BY host_name
ORDER BY total_listings DESC
limit 10;
```

![](https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/query_5.png)

2. Query Number 11: Top 10 Neighbourhoods with Most Listings
```sql
SELECT neighbourhood, 
	   COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 10;
```

![](https://github.com/mayank1ahuja/da_airbnb_nyc/blob/0b63ffa27cc7bc8337440d4e9d35cb20a2380c3f/plots/query_11.png)

## ✨ Key Results & Insights

1. **Geography & concentration:** Manhattan and Brooklyn account for the majority of listings; several neighborhoods show clear clustering and higher-than-average prices.
2. **Room type economics:** Entire homes/apartments make up the plurality of listings and command the highest average prices; private rooms and shared rooms are materially cheaper.
3. **Activity & reviews:** A large portion of listings register low or zero reviews per month — an indication of new or intermittently active hosts. A small subset of listings captures the majority of reviews and bookings.
4. **Hosts at scale:** A significant number of hosts manage multiple listings, suggesting professionalized management in specific neighborhoods.
5. **Outliers & data quality:** ```price```, ```minimum_nights```, and ```reviews_per_month``` contain outliers that meaningfully affect their averages.

## 📈 How the Project Answers the Problem Statement
1. **From raw data to signal:** Data cleaning addresses missingness and obvious input errors, producing a defensible dataset for inference.
2. **From signal to inference:** EDA and SQL queries quantify supply, price, and activity by borough, neighborhood, room type, and host.
3. **From inference to action:** The final recommendations translate analytical findings into practical tactics (pricing heuristics, neighborhood prioritization, host segmentation) that a host or analyst could implement.

## 🛠️ Requirements
- Python 3.8+
- Jupyter Notebook or Jupyter Lab
- Python Libraries: *pandas, numpy, seaborn, matplotlib*
- PostgreSQL (optional if you want to run SQL step locally)
- psycopg2 (if connecting Python to PostgreSQL)

## 📑 Limitations & Assumptions
1. **Occupancy proxy:** ```availability_365``` is used as a proxy for occupancy patterns; this is an approximation and subject to reservation/cancellation nuances.
2. **Reviews as demand signal:** ```reviews_per_month``` is an imperfect demand proxy (not every stay generates a review). This limitation is noted and conclusions are thus presented conservatively.

## 🌟 Acknowledgements
- *Dataset*: Kaggle — AB_NYC_2019.csv
- *Libraries*: pandas, seaborn, matplotlib, psycopg2
- *Database*: PostgreSQL
- *Tools*: pgAdmin4

Methodological inspiration from standard industry analytics workflows and open-source examples.

## 🗽 Author - *Mayank Ahuja*
This project is part of my portfolio, demonstrating Python and SQL skills applied to Airbnb listings in New York City, highlighting the ability to extract actionable insights from complex datasets.

![NYC](https://github.com/mayank1ahuja/da_airbnb_nyc/blob/c3b866fef33b6020132bdceec3dad51faccf128b/project%20images/nyc.png)
