--- Swiggy Project

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

select * from swiggy;

--- (1) SELECT
--- 1)Display the top 10 highest-rated restaurants from Bangalore.

select * from swiggy
where city = 'Bangalore'
order by avg_ratings desc
limit 10;

--- 2)Find all restaurants whose name starts with 'S' and ends with 'a'.

select * from swiggy
where restaurant like 'S%a';

--- 3)Display restaurant names, city, and price.

select restaurant,
         city,
		 price
	from swiggy;
	
--- 4)Find restaurants whose price is between ₹200 and ₹500 but are not located in Koramangala.

select * from swiggy
where price between 200 and 500
 and area <> 'koramangala';

--- 5)Display every third record from the table based on Restaurant ID.

select * from
(
   select *,
     row_number() over(order by id) as  rn
	from swiggy
)t
where rn % 3 = 0;

--- (2) WHERE
--- 1)Find restaurants with ratings greater than 4.5 and price less than ₹300.

select * from 
swiggy
where avg_ratings > 4.5
 and price < 300;
 
--- 2)Display restaurants that belong to either Bangalore or Hyderabad but not Chennai.

select * from
swiggy
where city = 'Bangalore'
or city = 'Hyderabad';

--- 3)Find restaurants whose cuisine contains the word "Biryani".

select * from
swiggy
where food_type like '%Biryani%';

--- 4)Display restaurants where rating is NULL or price is NULL.

select * from
swiggy 
where total_ratings is null
or price is null;

--- 5)Find restaurants whose delivery time is greater than 45 minutes.

select * from
swiggy
where delivery_time > 45;

--- (3) ORDER BY 
--- 1)Display restaurants sorted by rating (highest first) and then price (lowest first).

select * from swiggy
order by total_ratings desc,price asc;

--- 2)Find the five cheapest restaurants in every city.

select *
from
(
    select *,
	row_number() over(partition by city order by price asc) as rn
	from swiggy
)t
where rn <= 5;

--- 3)Display restaurants ordered by cuisine alphabetically and rating descending.

select *
from swiggy
order by food_type asc,total_ratings desc;

--- 4)Sort restaurants by delivery time ascending and rating descending.

select *
from swiggy
order by delivery_time asc,total_ratings desc;

--- 5)Display the most expensive restaurant in each city.

select *
from
(
   select *,
   row_number() over(partition by city order by price desc) as rnk
   from swiggy
)t
where rnk = 1;

--- (4) LIMIT/OFFSET 
--- 1)Display the second highest-rated restaurant.

select * from
swiggy
order by total_ratings
limit 1 offset 1;

--- 2)Find restaurants ranked from 21 to 30 based on price.

select * from
swiggy
order by price asc
limit 10 offset 20;

--- 3)Display the last five restaurants added.

select *
from swiggy
order by id desc
limit 5;

--- 4)Find the third cheapest restaurant in Hyderabad.

select * from
swiggy
where city = 'Hyderabad'
order by price asc
limit 1
offset 2;

--- 5)Display records 11–20 sorted by rating.

select * from
swiggy 
order by total_ratings
limit 10
offset 10;

--- (5) Aggregate Functions 
--- 1)Find the average restaurant rating in each city.

select city,
  avg(avg_ratings) as average_ratings
from swiggy
group by city;

--- 2)Find the maximum price for every cuisine.

select food_type,
  max(price) as high_food
from swiggy
group by food_type;

--- 3)Calculate the total revenue assuming each restaurant received 100 orders.

select  sum(price * 100) as total_revenue
from swiggy;

--- 4)Find the minimum delivery time for every area.

select area,
   min(delivery_time) as min_delivery_time
from swiggy
group by area;

--- 5)Count restaurants with ratings above 4.5.

select count(*) as total_restaurants
from swiggy
where avg_ratings > 4.5;

--- (6) GROUP BY 
--- 1)Count restaurants in each city.

select city,
   count(restaurant) as total_hotels
from swiggy
group by city;

--- 2)Find the average price for every cuisine.

select food_type,
   avg(price) as avg_food_price
 from swiggy
 group by food_type;
 
--- 3)Display the highest-rated restaurant in every city.

select city,
     max(avg_ratings) as high_rating
from swiggy
group by city;

--- 4)Count restaurants grouped by rating.

select total_ratings,
      count(*) as toatl_restaurants
from swiggy
group by total_ratings;

--- 5)Find total restaurants in each delivery area.

select area,
      count(*) as toatl_restaurants
from swiggy
group by area;

--- 7) HAVING 
--- 1)Display cities having more than 50 restaurants.

select city,
    count(*) as total_restaurants
from swiggy
group by city
having count(*) > 50;

--- 2)Find cuisines whose average rating is greater than 4.2.

select food_type,
    count(avg_ratings) as total_avg_ratings
from swiggy
group by food_type
having count(*) > 4.2;

--- 3)Display areas having more than 20 restaurants.

select area,
   count(restaurant) as total_restaurants
from swiggy
group by area
having count(restaurant) > 20;

--- 4)Find ratings that occur more than 15 times.

select total_ratings,
    count(*) as total_ratings
from swiggy
group by total_ratings
having count(*) > 15;
     
--- 5)Display cities where the average restaurant price exceeds ₹200.

select city,
   avg(price) as avg_price
from swiggy
group by city
having avg(price) > 200;

--- (8)String Functions 
--- 1)Display restaurant names in uppercase with their character length.

select restaurant,
     upper(restaurant) as uppercase_resta,
	 length(restaurant) as total_len
from swiggy;
	 
--- 2)Find restaurants whose name length is greater than 20.

select *
from swiggy
where length(restaurant) > 20;

--- 3)Extract the first five characters of every restaurant name.

select restaurant,
      left(restaurant,5) as first_five
from swiggy;

--- 4)Replace the word "Hotel" with "Restaurant" in restaurant names.

select restaurant,
        replace(restaurant,'Hotel','Restaurant') as new_name
from swiggy;

--- 5)Display the last three characters of every cuisine.

select food_type,
      right(food_type,3) as last_three
from swiggy;

--- (9) CASE Statement 
--- 1)Categorize ratings as Excellent, Good, Average, or Poor.

select restaurant,
       avg_ratings,
	 case
	 when avg_ratings >= 4.5 then 'Excellent'
	 when avg_ratings >= 3.8 then  'Good'
	 when avg_ratings >= 3.5 then   'Average'
	 else 'Poor'
end as rating_category
from swiggy;

--- 2)Display "Expensive" or "Affordable" based on price.

select restaurant,
       price,
	   case 
	   when price > 500 then 'Expensive'
	   else 'Affordable'
	 end as price_category
from swiggy;

--- 3)Show delivery status as Fast, Medium, or Slow.

select restaurant,
       delivery_time,
	   case
	   when delivery_time <= 30 then 'Fast'
	   when delivery_time <= 45 then 'Medium'
	   else 'Slow'
	 end as delivery_status
from swiggy;

--- 4)Categorize restaurants by price.

select restaurant,
       price,
	   case
	   when price >= 800 then 'High Orders'
	   when price >= 500 then 'Medium Orders'
	   else 'Low Orders'
	end as total_ratings
from swiggy;

--- 5)Display discounts based on rating

select restaurant,
       avg_ratings,
	   case
	   when avg_ratings >= 4.5 then '20% discount'
	   when avg_ratings >= 4.0 then '15% discount'
	   when avg_ratings > 3.5 then '10% discount'
	   else 'No discount'
end as discount
from swiggy;





