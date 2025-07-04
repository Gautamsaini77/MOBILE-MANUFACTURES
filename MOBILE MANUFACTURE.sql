select TOP 1 * from DIM_CUSTOMER
select TOP 1 * from DIM_DATE
select TOP 1 * from DIM_LOCATION
select TOP 1 * from DIM_MANUFACTURER
select TOP 1 * from DIM_MODEL
select TOP 1 * from FACT_TRANSACTIONS


--Q1--BEGIN

SELECT  DISTINCT A.State FROM DIM_LOCATION AS A
INNER JOIN  FACT_TRANSACTIONS AS B
ON A.IDLocation = B.IDLocation
WHERE YEAR (B.DATE)> '2005'

--Q1--END


--Q2--BEGIN
SELECT DISTINCT TOP 1 A.State,SUM(B.Quantity)AS QTY_ FROM DIM_LOCATION AS A
INNER JOIN  FACT_TRANSACTIONS AS B
ON A.IDLocation = B.IDLocation
INNER JOIN DIM_MODEL AS C
ON B.IDModel = C.IDModel
INNER JOIN DIM_MANUFACTURER  AS D
ON C.IDManufacturer = D.IDManufacturer
WHERE A.Country = 'US' AND  D.Manufacturer_Name = 'SAMSUNG'
GROUP BY A.State
ORDER BY  QTY_ DESC

--Q2--END


--Q3--BEGIN
SELECT A.Model_Name,COUNT(A.IDModel) AS TOTAL_TRANSACTIONS,C.ZipCode,C.State FROM DIM_MODEL AS A
INNER JOIN FACT_TRANSACTIONS AS B
ON A.IDModel = B.IDModel
INNER JOIN DIM_LOCATION AS C
ON B.IDLocation = C.IDLocation
GROUP BY A.Model_Name,C.ZipCode,C.State

--Q3--END

--Q4--BEGIN
SELECT top 1 Model_Name,Unit_price FROM DIM_MODEL AS A
order by a.Unit_price

--Q4--END

--Q5--Begin 

select B.Model_Name ,AVG(B.Unit_price)AS AVG_PRICE from DIM_MANUFACTURER as a
inner join DIM_MODEL as b 
on a.IDManufacturer = b.IDManufacturer
inner join FACT_TRANSACTIONS as c
on b.IDModel = c.IDModel
WHERE A.Manufacturer_Name IN

       (select  top 5 a.Manufacturer_Name from DIM_MANUFACTURER as a
       inner join DIM_MODEL as b 
       on a.IDManufacturer = b.IDManufacturer
       inner join FACT_TRANSACTIONS as c
       on b.IDModel = c.IDModel
       group by a.Manufacturer_Name
       order by SUM(C.Quantity) DESC)

 GROUP BY B.Model_Name
 ORDER BY AVG_PRICE



--Q6--Begin 

SELECT A.Customer_Name,AVG(B.TotalPrice) AS TOTAL_AMT FROM DIM_CUSTOMER AS A
INNER JOIN FACT_TRANSACTIONS AS B
ON A.IDCustomer = B.IDCustomer
WHERE YEAR(B.Date) = '2009'
GROUP BY  A.Customer_Name
HAVING AVG(B.TotalPrice) > 500 

--Q6--END

--Q7--Begin


   select  t.Model_Name from  ( select top 5 b.Model_Name, sum(c.Quantity) as total_qty from DIM_MANUFACTURER as a 
              inner join DIM_MODEL as b
              on a.IDManufacturer = b.IDManufacturer
              inner join FACT_TRANSACTIONS as c
              on b.IDModel = c.IDModel
              where year(c.Date) = '2008'
              group by b.Model_Name
              order by total_qty desc) as t

			  intersect

			  
   select  m.Model_Name from ( select top 5 b.Model_Name, sum(c.Quantity) as total_qty from DIM_MANUFACTURER as a 
              inner join DIM_MODEL as b
              on a.IDManufacturer = b.IDManufacturer
              inner join FACT_TRANSACTIONS as c
              on b.IDModel = c.IDModel
              where year(c.Date) = '2009'
              group by b.Model_Name
              order by total_qty desc) as m

			  
			  intersect

			  
   select  n.Model_Name from ( select top 5 b.Model_Name, sum(c.Quantity) as total_qty from DIM_MANUFACTURER as a 
              inner join DIM_MODEL as b
              on a.IDManufacturer = b.IDManufacturer
              inner join FACT_TRANSACTIONS as c
              on b.IDModel = c.IDModel
              where year(c.Date) = '2010'
              group by b.Model_Name
              order by total_qty desc) as n

---Q7-- END

--Q8--Begin 
SELECT * FROM 
              (SELECT TOP 1 * FROM
                             (select top 2 a.Manufacturer_Name ,SUM(C.TotalPrice)  AS TOTAL_SALES from DIM_MANUFACTURER as a
                              inner join DIM_MODEL as b 
                              on a.IDManufacturer = b.IDManufacturer
                              inner join FACT_TRANSACTIONS as c
                              on b.IDModel = c.IDModel
	                          WHERE YEAR(C.Date) = '2009'
                              group by a.Manufacturer_Name
	                          ORDER BY TOTAL_SALES DESC)AS T
							                                ORDER BY TOTAL_SALES) AS M

UNION ALL


SELECT * FROM
             (SELECT TOP 1 * FROM
                               (select top 2 a.Manufacturer_Name ,SUM(C.TotalPrice)  AS TOTAL_SALES from DIM_MANUFACTURER as a
                                inner join DIM_MODEL as b 
                                on a.IDManufacturer = b.IDManufacturer
                                inner join FACT_TRANSACTIONS as c
                                on b.IDModel = c.IDModel
	                            WHERE YEAR(C.Date) = '2010'
                                group by a.Manufacturer_Name
	                            ORDER BY TOTAL_SALES DESC) AS T

		                                                 ORDER BY TOTAL_SALES) A
--Q8--END

--Q9--Begin

 select  a.Manufacturer_Name  from DIM_MANUFACTURER as a
                              inner join DIM_MODEL as b 
                              on a.IDManufacturer = b.IDManufacturer
                              inner join FACT_TRANSACTIONS as c
                              on b.IDModel = c.IDModel
	                          WHERE YEAR(C.Date) = '2010'
                              group by a.Manufacturer_Name
                             
							 EXCEPT

select  a.Manufacturer_Name  from DIM_MANUFACTURER as a
                              inner join DIM_MODEL as b 
                              on a.IDManufacturer = b.IDManufacturer
                              inner join FACT_TRANSACTIONS as c
                              on b.IDModel = c.IDModel
	                          WHERE YEAR(C.Date) = '2009'
                              group by a.Manufacturer_Name

--Q9--END

--Q10--Begin


select *,((n.total_spend-n.lag_spend)/n.lag_spend)*100 as per_chng_spend from
              (
              select *,lag(m.total_spend,1) over(partition by m.IDCustomer order by m.year_) 
			  as lag_spend from 
                               (select t.IDCustomer,avg(a.TotalPrice) as avg_spend,avg(a.Quantity) as avg_qty,
                                  year(a.Date) as year_,sum(a.TotalPrice) as total_spend
								  from FACT_TRANSACTIONS as a
                                  inner join 
                                           (select top 10 a.IDCustomer from DIM_CUSTOMER as a
                                             inner join FACT_TRANSACTIONS as b
                                             on a.IDCustomer=b.IDCustomer
                                             group by a.IDCustomer
                                             order by sum(b.TotalPrice) desc) as t
                                  on a.IDCustomer=t.IDCustomer
                                  group by year(a.Date),t.IDCustomer) as m)as n


---Q10-- END









