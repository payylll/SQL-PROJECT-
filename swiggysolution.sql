CREATE DATABASE swiggy;
USE swiggy;
CREATE TABLE swiggy(
   restaurant_no   INTEGER  NOT NULL 
  ,restaurant_name VARCHAR(50) NOT NULL
  ,city            VARCHAR(9) NOT NULL
  ,address         VARCHAR(204)
  ,rating          NUMERIC(3,1) NOT NULL
  ,cost_per_person INTEGER 
  ,cuisine         VARCHAR(49) NOT NULL
  ,restaurant_link VARCHAR(136) NOT NULL
  ,menu_category   VARCHAR(66)
  ,item            VARCHAR(188)
  ,price           VARCHAR(12) NOT NULL
  ,veg_or_nonveg   VARCHAR(7)
);

#1 WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTRAURANTS?
 SELECT city, COUNT(DISTINCT restaurant_name) AS highest_no_of_restaurant
 FROM swiggy
 GROUP BY city
 ORDER BY highest_no_of_restaurant DESC
 LIMIT 1;

#2 HOW MANY RESTRAURANTS HAVE THE WORD "Pizza" IN THEIR NAME?
 select restaurant_name, count(distinct restaurant_name)
 as restaurant from swiggy 
 where restaurant_name like '%Pizza%'
 group by restaurant_name;

#3 WHAT IS THE MOST COMMON CUISINE AMONG THE RESTRAURANTS IN THE DATABASE?
 select cuisine, count(*) as cuisine_count 
 from swiggy group by cuisine
 order by cuisine_count desc limit 1;

#4 WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
 select city, avg(rating) as average_rating 
 from swiggy group by city
 order by average_rating desc;
 
#5 WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'Recommended' MENU CATEGORY FOR EACH RESTAURANT?
 select distinct restaurant_name, menu_category, max(price) 
 as highest_price from swiggy where menu_category = 'Recommended'
 group by restaurant_name, menu_category;

#6 FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE?
 select distinct restaurant_name as
 expensive_restaurants, cuisine, price from swiggy
 where cuisine  != 'Indian Cuisine' order by price desc limit 5;

#7 FIND THE 10 RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER?
 select distinct restaurant_name, avg(cost_per_person)
 as avgcostpp from swiggy where cost_per_person >(select avg(cost_per_person)
 from swiggy) group by restaurant_name order by avgcostpp desc LIMIT 10 ;

#8 RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.
 select distinct t1.restaurant_name, t1.city, t2.city 
 from swiggy t1 join swiggy t2 on t1.restaurant_name=t2.restaurant_name 
 and t1.city<>t2.city;

#9 WHICH RESTAURANTS OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?
 select distinct restaurant_name, menu_category, count(item) 
 as no_of_items from swiggy where menu_category = 'Main Course'
 group by restaurant_name order by no_of_items desc limit 1;

#10 LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGETARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME?
 select  distinct restaurant_name, 
 (count(case when veg_or_nonveg = 'Veg' then 1 end )*100
 / count(*)) as 100percentvegetarian from swiggy 
 group by restaurant_name having 100percentvegetarian  = 100.00 
 order by restaurant_name  ;

#11 WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
 select restaurant_name, avg(price)
 as lowest_average_price from swiggy 
 group by restaurant_name
 order by lowest_average_price limit 1;
 
#12 HOW MANY RESTRAUNTS HAVE RATING OVER 4.5?
 SELECT COUNT(distinct restaurant_name)
 as high_rating_restraunts from swiggy
 where rating >4.5; 

#13 WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGETARIAN FOOD?
 select distinct restaurant_name, 
 (count(case when veg_or_nonveg = 'Non-veg' then 1 end )*100
 / count(*)) as highest_non_vegetarian from swiggy 
 group by restaurant_name order by
 highest_non_vegetarian desc limit 1;

#14 WHICH TOP 5 RESTAURANTS PROVIDE HIGHEST NUMBER OF CATEGORIES?
 select distinct restaurant_name, count(distinct menu_category)
 as no_of_categories from swiggy group by restaurant_name
 order by no_of_categories desc limit 5;



