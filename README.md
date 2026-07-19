                                         # Swiggy_project_sql1

![swiggy logo](https://github.com/stej07033/Swiggy_project_sql1/blob/main/swiggy_logo.png)

🎯 Project Objectives
 * Analyze Swiggy restaurant data using PostgreSQL.
 * Practice basic and advanced SQL queries.
 * Explore restaurant ratings, prices, and delivery times.
 * Generate business insights from restaurant data.
 * Improve SQL problem-solving and analytical skills.

## 📂 Dataset(https://www.kaggle.com/code/aryantiwari123/netflix-movies-and-tv-shows)
The dataset contains restaurant information such as:
- Restaurant ID
- Restaurant Name
- Area
- City
- Price
- Average Ratings
- Total Ratings
- Food Type
- Address
- Delivery Time

## 🛠️ Technologies Used
- PostgreSQL
- SQL
- CSV Dataset
- pgAdmin 4
  
## Solutions(https://github.com/stej07033/Swiggy_project_sql1/blob/main/swiggy_project.sql)

## Schema

--- Swiggy Project

```sql
CREATE TABLE swiggy (
    id INT,
    area VARCHAR(100),
    city VARCHAR(100),
    restaurant VARCHAR(255),
    price INT,
    avg_ratings DECIMAL(3,1),
    total_ratings VARCHAR(50),
    food_type TEXT,
    address VARCHAR(255),
    delivery_time INT
);
```

```sql
select * from swiggy;
```

--- (1) SELECT
--- 1)Display the top 10 highest-rated restaurants from Bangalore.

```sql
select * from swiggy
where city = 'Bangalore'
order by avg_ratings desc
limit 10;
```

--- 2)Find all restaurants whose name starts with 'S' and ends with 'a'.

```sql
select * from swiggy
where restaurant like 'S%a';
```

--- 3)Display restaurant names, city, and price.

```sql
select restaurant,
         city,
		 price
	from swiggy;
```
	
--- 4)Find restaurants whose price is between ₹200 and ₹500 but are not located in Koramangala.

```sql
select * from swiggy
where price between 200 and 500
 and area <> 'koramangala';
```

--- 5)Display every third record from the table based on Restaurant ID.

```sql
select *
from
(
  select *,
     row_number() over(order by id) as  rn
	from swiggy
)t
where rn % 3 = 0;
```

--- (2) WHERE
--- 1)Find restaurants with ratings greater than 4.5 and price less than ₹300.

```sql
select * from 
swiggy
where avg_ratings > 4.5
 and price < 300;
```
 
--- 2)Display restaurants that belong to either Bangalore or Hyderabad but not Chennai.

```sql
select * from
swiggy
where city = 'Bangalore'
or city = 'Hyderabad';
```

--- 3)Find restaurants whose cuisine contains the word "Biryani".

```sql
select * from
swiggy
where food_type like '%Biryani%';
```

--- 4)Display restaurants where rating is NULL or price is NULL.

```sql
select * from
swiggy 
where total_ratings is null
or price is null;
```

--- 5)Find restaurants whose delivery time is greater than 45 minutes.

```sql
select * from
swiggy
where delivery_time > 45;
```

--- (3) ORDER BY 
--- 1)Display restaurants sorted by rating (highest first) and then price (lowest first).

```sql
select * from swiggy
order by total_ratings desc,price asc;
```

--- 2)Find the five cheapest restaurants in every city.

```sql
select *
from
(
 select *,
	row_number() over(partition by city order by price asc) as rn
	from swiggy
)t
where rn <= 5;
```

--- 3)Display restaurants ordered by cuisine alphabetically and rating descending.

```sql
select *
from swiggy
order by food_type asc,total_ratings desc;
```

--- 4)Sort restaurants by delivery time ascending and rating descending.

```sql
select *
from swiggy
order by delivery_time asc,total_ratings desc;
```

--- 5)Display the most expensive restaurant in each city.

```sql
select *
from
(
   select *,
   row_number() over(partition by city order by price desc) as rnk
   from swiggy
)t
where rnk = 1;
```

--- (4) LIMIT/OFFSET 
--- 1)Display the second highest-rated restaurant.

```sql
select * from
swiggy
order by total_ratings
limit 1 offset 1;
```

--- 2)Find restaurants ranked from 21 to 30 based on price.

```sql
select * from
swiggy
order by price asc
limit 10 offset 20;
```

--- 3)Display the last five restaurants added.

```sql
select *
from swiggy
order by id desc
limit 5;
```

--- 4)Find the third cheapest restaurant in Hyderabad.

```sql
select * from
swiggy
where city = 'Hyderabad'
order by price asc
limit 1
offset 2;
```

--- 5)Display records 11–20 sorted by rating.

```sql
select * from
swiggy 
order by total_ratings
limit 10
offset 10;
```

--- (5) Aggregate Functions 
--- 1)Find the average restaurant rating in each city.

```sql
select city,
  avg(avg_ratings) as average_ratings
from swiggy
group by city;
```

--- 2)Find the maximum price for every cuisine.

```sql
select food_type,
  max(price) as high_food
from swiggy
group by food_type;
```

--- 3)Calculate the total revenue assuming each restaurant received 100 orders.

```sql
select  sum(price * 100) as total_revenue
from swiggy;
```

--- 4)Find the minimum delivery time for every area.

```sql
select area,
   min(delivery_time) as min_delivery_time
from swiggy
group by area;
```

--- 5)Count restaurants with ratings above 4.5.

```sql
select count(*) as total_restaurants
from swiggy
where avg_ratings > 4.5;
```

--- (6) GROUP BY 
--- 1)Count restaurants in each city.

```sql
select city,
   count(restaurant) as total_hotels
from swiggy
group by city;
```

--- 2)Find the average price for every cuisine.

```sql
select food_type,
   avg(price) as avg_food_price
 from swiggy
 group by food_type;
```
 
--- 3)Display the highest-rated restaurant in every city.

```sql
select city,
     max(avg_ratings) as high_rating
from swiggy
group by city;
```

--- 4)Count restaurants grouped by rating.

```sql
select total_ratings,
      count(*) as toatl_restaurants
from swiggy
group by total_ratings;
```

--- 5)Find total restaurants in each delivery area.

```sql
select area,
      count(*) as toatl_restaurants
from swiggy
group by area;
```

--- 7) HAVING 
--- 1)Display cities having more than 50 restaurants.

```sql
select city,
    count(*) as total_restaurants
from swiggy
group by city
having count(*) > 50;
```

--- 2)Find cuisines whose average rating is greater than 4.2.

```sql
select food_type,
    count(avg_ratings) as total_avg_ratings
from swiggy
group by food_type
having count(*) > 4.2;
```

--- 3)Display areas having more than 20 restaurants.

```sql
select area,
   count(restaurant) as total_restaurants
from swiggy
group by area
having count(restaurant) > 20;
```

--- 4)Find ratings that occur more than 15 times.

```sql
select total_ratings,
    count(*) as total_ratings
from swiggy
group by total_ratings
having count(*) > 15;
```
     
--- 5)Display cities where the average restaurant price exceeds ₹200.

```sql
select city,
   avg(price) as avg_price
from swiggy
group by city
having avg(price) > 200;
```

--- (8)String Functions 
--- 1)Display restaurant names in uppercase with their character length.

```sql
select restaurant,
     upper(restaurant) as uppercase_resta,
	 length(restaurant) as total_len
from swiggy;
```
	 
--- 2)Find restaurants whose name length is greater than 20.

```sql
select *
from swiggy
where length(restaurant) > 20;
```

--- 3)Extract the first five characters of every restaurant name.

```sql
select restaurant,
      left(restaurant,5) as first_five
from swiggy;
```

--- 4)Replace the word "Hotel" with "Restaurant" in restaurant names.

```sql
select restaurant,
        replace(restaurant,'Hotel','Restaurant') as new_name
from swiggy;
```

--- 5)Display the last three characters of every cuisine.

```sql
select food_type,
      right(food_type,3) as last_three
from swiggy;
```

--- (9) CASE Statement 
--- 1)Categorize ratings as Excellent, Good, Average, or Poor.

```sql
select restaurant,
       avg_ratings,
	 case
	 when avg_ratings >= 4.5 then 'Excellent'
	 when avg_ratings >= 3.8 then  'Good'
	 when avg_ratings >= 3.5 then   'Average'
	 else 'Poor'
end as rating_category
from swiggy;
```

--- 2)Display "Expensive" or "Affordable" based on price.

```sql
select restaurant,
       price,
	   case 
	   when price > 500 then 'Expensive'
	   else 'Affordable'
	 end as price_category
from swiggy;
```

--- 3)Show delivery status as Fast, Medium, or Slow.

```sql
select restaurant,
       delivery_time,
	   case
	   when delivery_time <= 30 then 'Fast'
	   when delivery_time <= 45 then 'Medium'
	   else 'Slow'
	 end as delivery_status
from swiggy;
```

--- 4)Categorize restaurants by price.

```sql
select restaurant,
       price,
	   case
	   when price >= 800 then 'High Orders'
	   when price >= 500 then 'Medium Orders'
	   else 'Low Orders'
	end as total_ratings
from swiggy;
```

--- 5)Display discounts based on rating

```sql
select restaurant,
       avg_ratings,
	   case
	   when avg_ratings >= 4.5 then '20% discount'
	   when avg_ratings >= 4.0 then '15% discount'
	   when avg_ratings > 3.5 then '10% discount'
	   else 'No discount'
end as discount
from swiggy;
```

## 📊 SQL Concepts Covered
- SELECT Statements
- WHERE Clause
- ORDER BY
- LIMIT
- Aggregate Functions
- GROUP BY
- HAVING
- CASE Statements
- String Functions
- Business Analytics Queries

## 📈 Sample Analysis
- Top-rated restaurants
- Most expensive restaurants
- Fastest delivery restaurants
- Restaurants with highest ratings
- Average price by city
- Restaurant ranking using Window Functions
- Food category analysis
- Delivery time analysis
- Price segmentation
- Customer rating insights

## 📁 Repository Structure
```
Swiggy-SQL-Project/
│
├── swiggy_project.sql
├── swiggy_dataset.csv
└── README.md
```
## 🎯 Learning Outcomes

- Writing optimized SQL queries
- Performing business data analysis
- Using PostgreSQL for real-world datasets
- Understanding SQL Window Functions
- Practicing advanced SQL concepts

## 👩‍💻 Author

**SAI M**

 | Power bi | PostgreSQL | Python | MYsql | Aspiring Data Analyst

- 📂 GitHub: https://github.com/stej07033
- 💼 LinkedIn: https://www.linkedin.com/in/madanapalli-sai-19b835389
- 📄 Resume: https://drive.google.com/file/d/1XADghy4C0PWW03jkAkpOiRHkFuLIOXwR/view?usp=sharing








