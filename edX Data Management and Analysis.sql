-- 

-- ALY6030 - Assignment 4
-- Submit the completed sql file with your submissions. 
-- Do not change the format of this sql file. Each part should be completed in the 
-- designated area as indicated in this file. 


-- edX Database:

-- ---------------------------------------------------------------------------
-- PART 1:
-- ---------------------------------------------------------------------------
-- 1.  Database creation: Complete Question 1 in the spapce below:

-- a. Createe database edX
DROP DATABASE IF EXISTS `edX`;
CREATE DATABASE  IF NOT EXISTS `edX`;
USE `edX`;

-- b. Create table 'temp'
DROP TABLE IF EXISTS `temp`;
CREATE TABLE `temp` (
  `course_id` varchar(255),
  `course_short_title` varchar(255),
  `course_long_title` varchar(255),
  `userid_DI` varchar(255),
  `registered` int,
  `viewed` int,
  `explored` int,
  `certified` int,
  `country` varchar(255),
  `loe` varchar(255),
  `yob` int,
  `age` int,
  `gender` varchar(255),
  `grade` int,
  `nevents` int,
  `ndays_act` int DEFAULT NULL,
  `nplay_video` int DEFAULT NULL,
  `nchapters` int DEFAULT NULL,
  `nforum_posts` int DEFAULT NULL,
  `roles` int DEFAULT NULL,
  `incomplete_flag` int DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- c. Use “LOAD DATA LOCAL INFILE” query to dump data from csv to the 'temp' table.
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = true;

LOAD DATA LOCAL INFILE 'C:/Users/Scott/Desktop/ALY6030_Assignment4_Breckwoldt_W/edX_data.csv' 
INTO TABLE temp
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

 select * from temp;

-- ---------------------------------------------------------------------------
-- 2.  Complete Question 2 in the space below:
-- 2.a: add 3 new columns to the temp table according to the names and orderings specified in the word document. 

 ALTER TABLE temp
 ADD institution varchar(255) NULL
 AFTER course_id,
 ADD course varchar(255) NULL
 AFTER institution,
 ADD term varchar(255) NULL
 AFTER course;
 
 select * from temp;
  -- 2.b: Dump data to populate the newly created columns. 
 
 DROP TABLE IF EXISTS temp2;
 Create table temp2 as 
 select distinct(course_id) as course_id,
 LEFT(course_id, position('/' in course_id)-1) as institution,
 RIGHT(course_id, char_length(course_id) - position('/' in course_id)) as course_term
 from temp;
 
  select * from temp2;
 
 Drop table if exists temp3;
 create table temp3 
 select course_id, course_term,
 LEFT(course_term, position('/' in course_term)-1) as course,
 RIGHT(course_term, char_length(course_term) - position('/' in course_term)) as term
 from temp2;
 
 select * from temp3;
 
 select * from temp2;
 
Drop table if exists temp4;
create table temp4
select a.course_id, institution, course, term
FROM temp2 as a
JOIN temp3 as b
ON a.course_id = b.course_id;

select * from temp4;

update temp a
join temp4 b
on a.course_id = b.course_id
set a.institution=b.institution,
a.course = b.course,
a.term = b.term
where a.course_id=b.course_id;

select * from temp;
 
 select distinct(institution) from temp;
 
 select distinct(course) from temp;
 
 select distinct(term) from temp;
 
 select distinct(course_id) from temp;
-- ---------------------------------------------------------------------------
-- 4.  Database creation: In the space below, create all the tables of your edX database according 
--     to the ERD given in the word document (including all necessary key assignments).  
--  Complete Question 4 in the spapce below:
-- a) create tables 

   drop table if exists course_users;
   create table course_users
   select course_id,
   userid_DI,
   registered,
   viewed,
   explored,
   certified,
   grade
   from temp;
   
   select * from course_users;
   
   drop table if exists courses; 
   create table courses
   select distinct(course_id) as course_id,
   course as course_number,
   term as course_term,
   course_long_title,
   institution
   from temp;
   
   select* from courses;
   
   ALTER table courses
   Add Primary key (course_id);
   
   drop table if exists institutions;
   create table institutions
   select distinct institution
   from temp;
   
alter table institutions
add institution_id int not null auto_increment,
add constraint institutions_pk primary key (institution_id);

   select * from institutions;
   
select * from courses;

alter table courses 
add institution_id int;

update courses a
join institutions b
on a.institution=b.institution
set a.institution_id=b.institution_id
where a.institution=b.institution;

alter table courses
add constraint fk_institution_id
foreign key (institution_id) References institutions(institution_id),
drop institution;

select * from courses;
   
   drop table if exists users;
   create table users
   select distinct userid_DI,
   country,
   loe,
   yob,
   gender
   from temp;
   
   alter table users
add constraint users_pk primary key (userid_DI);

   select * from users;
   
   drop table if exists countries;
   create table countries
   select distinct country
   from temp;
   
   alter table countries
add country_id int not null auto_increment,
add constraint countries_pk primary key (country_id);
   
   select * from countries;
   
   drop table if exists LOE;
   create table LOE
   select distinct loe
   from temp;
   
      alter table LOE
add LOE_id int not null auto_increment,
add constraint LOE_pk primary key (LOE_ID);
   
   select * from LOE;
   
alter table users 
add country_id int,
add LOE_id int;

update users a
join countries b
on a.country=b.country
set a.country_id=b.country_id
where a.country=b.country;

alter table users
add constraint fk_country_id
foreign key (country_id) References countries(country_id),
drop country;
  
update users a
join LOE b
on a.loe=b.loe
set a.LOE_id=b.LOE_id
where a.loe=b.loe;

alter table users
add constraint fk_LOE_id
foreign key (LOE_id) References LOE(LOE_id),
drop loe;  

select * from users;

-- b) add indexes
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
-- ---------------------------------------------------------------------------
-- 8.  In the spapce below, remove the 'temp' table from your database. 
--     After this step, your database should only contain the 6 tables as shown in the ERD.
   
   drop table if exists temp;
   
   
   
   
   
-- ---------------------------------------------------------------------------
-- 9.  Use the "reverse engineering feature of Workbenck to create an ERD of your database. Insert an image of your ERD in the word document. 

-- ---------------------------------------------------------------------------
  
  
  
-- ---------------------------------------------------------------------------
-- PART 2:
-- ---------------------------------------------------------------------------
-- 1.  How many students were registered in MITx/6.00x in fall 2012 and Spring 2013 combined, whose grades were not zero or Null.   
     
     select * from courses;
     
     select * from course_users 
     where (course_id = 'MITx/6.00x/2012_Fall' OR
     course_id = 'MITx/6.00x/2013_Spring') AND grade>0;
     
     -- 1538
      
   
-- ---------------------------------------------------------------------------
-- 2.   List the countries with doctoral students, along with the number of doctoral enrollees corresponding to each 
--      country and their average grades (the average grade corresponding to each country). 
--      Exclude the grades that are either zero or Null, and Sort according to the number of enrollees in descending order. 
     
     select * from LOE;
     drop table if exists twoa;
     create table twoa
     select distinct(country_id)
     from users
     where LOE_id=5;
     
     select*from twoa;
     
     drop table if exists twob;
     create table twob
     select distinct(userid_DI),
     grade
	from course_users
    where grade>0 
    ;
    
    drop table if exists twoc;
    create table twoc
    select userid_DI,
    LOE_ID,
    country_id
    from users;
    
      drop table if exists twod;
     create table twod 
     select b.userid_DI,
     grade,
     LOE_id,
     country_id
     from twob a
     join twoc b
     on a.userid_DI=b.userid_DI
     where a.userid_DI=b.userid_DI;
     
     drop table if exists twoe;
     create table twoe
     select userid_DI,
     grade, 
     LOE_id,
     a.country_id,
     country
     from twod a
     join countries b
     on a.country_id=b.country_id
     where a.country_id=b.country_id AND LOE_id=5;
     
     select * from twoe;
     
     drop table if exists twoanswer;
     create table twoanswer
     SELECT avg(grade), COUNT(*) AS count, country
FROM twoe
GROUP BY country
ORDER BY count desc;

select * from twoanswer;

-- ---------------------------------------------------------------------------
-- 3.  How many German students were registered in courses that were offered by HARVARD in 2013? 
--     What was their average score in those courses (not including those whose grades were zero or Null)?
     
     select * from institutions;
     
     select*from countries;
     
         drop table if exists threea;
     create table threea
     select course_id,
     b.userid_DI, 
     country_id,
     grade
     from users a
     join course_users b
     on a.userid_DI=b.userid_DI
     where a.userid_DI=b.userid_DI AND country_id=24 AND grade>0;
     
     select * from threea;
     
     drop table if exists threeb;
     create table threeb
     select course_id from courses
     where institution_id=1;
     
     drop table if exists threec;
     create table threec
     select a.course_id,
     userid_DI,
     grade,
     country_id
     from threea a
     join threeb b
     on a.course_id=b.course_id
     where a.course_id=b.course_id     
     ;
     
     select* from threec;
     
     drop table if exists threeanswer;
     create table threeanswer
	SELECT avg(grade), COUNT(*) AS count, course_id
FROM threec
GROUP BY course_id
ORDER BY count desc;
      
select * from threeanswer;
 
-- ---------------------------------------------------------------------------
-- 4.	List all countries with students registered in a course offered by MIT in 2013, along with the average grade 
--      for each country. Exclude the grades that are either zero or Null, and order alphabetically according to the 
--      countries. Do not include the counties whose name contains “Unknown” or “Other” (or both).
     
     drop table if exists foura;
     create table foura
     select * from courses
     where institution_id=2 AND (course_term = '2013_Spring' OR course_term ='2013_Fall' OR course_term = '2013_Summer');
     
	drop table if exists fourb;
     create table fourb
     select a.course_id,
     grade,
     userid_DI
     from foura a
     join course_users b
     on a.course_id=b.course_id
     where a.course_id=b.course_id AND registered=1 AND grade>0;
     
     drop table if exists fourc;
     create table fourc
     select a.userid_DI,
     country_id,
     grade
     from fourb a
     join users b
     on a.userid_DI=b.userid_DI
     where a.userid_DI=b.userid_DI;
     
     select * from fourc;
     
     drop table if exists fourd;
     create table fourd
     select userid_DI,
     country,
     a.country_id,
     grade
     from fourc a
     join countries b
     on a.country_id = b.country_id
     where a.country_id = b.country_id AND a.country_id <> 2 AND a.country_id <> 3 AND a.country_id <> 4 AND a.country_id <> 7
     AND a.country_id <> 8 AND a.country_id <> 10 AND a.country_id <> 17 AND a.country_id <> 33;
     
     select * from fourd;
     
           drop table if exists fouranswer;
     create table fouranswer
	SELECT avg(grade), country
FROM fourd
GROUP BY country
ORDER BY country asc;
      
   select * from fouranswer;
 
-- ---------------------------------------------------------------------------
-- 5. What was the average grade in MITx/6.00x/2013_Spring for users whose countries were US, China, 
--    India, France, Brazil, or Japan? Exclude the grades that were zero or Null, 
--    and order according to the average grades.
     
  drop table if exists fiveaa;
  create table fiveaa
  select userid_DI,
  grade
  from course_users
  where course_id = 'MITx/6.00x/2013_Spring' AND grade>0;
     
  select * from fiveaa;   
     
     drop table if exists fivebb;
     create table fivebb
     select *
     from countries
     where country = 'Japan' OR country = 'United States' 
     OR country = 'China' OR country = 'India' OR country = 'France' OR country = 'Brazil';
     
     select * from fivebb;
     
     drop table if exists fivecc;
     create table fivecc
     select userid_DI,
     a.country_id, 
     country
     from fivebb a
     join users b
     where a.country_id=b.country_id;
      
   drop table if exists fivedd;
   create table fivedd
   select a.userid_DI,
   grade, 
   country
   from fivecc a
   join fiveaa b
   where a.userid_DI=b.userid_DI;
   
  drop table if exists fiveanswera;
  create table fiveanswera
  select avg(grade),
  country
  from fivedd
  group by country
  order by avg(grade) desc;
 
 select * from fiveanswera;
 
-- ---------------------------------------------------------------------------
-- 6.  What was the total number of people registered in each course offered? Display the courses 
--     according to the course long title and order by the number of registered students in each course. 
     
       drop table if exists sixa;
  create table sixa
  select count(*) as count,
  course_id
  from course_users
  where registered = 1
  group by course_id
  order by count desc
  ;
 
 select * from sixa;
 
     drop table if exists sixanswer;
     create table sixanswer
     select count, 
     a.course_id,
     course_long_title
     from sixa a
     join courses b
     on a.course_id = b.course_id
     where a.course_id=b.course_id;
     
     select * from sixanswer;
     

-- ---------------------------------------------------------------------------
-- 7. Find the list of courses that are hosted at HarvardX and have more than 10000 enrollees (i.e., registered)? 
--    Order these courses according to the number of enrollees from the largest to the smallest. 
     
     drop table if exists sevena;
     create table sevena
     select course_id, count(*) as count
     from course_users
     where registered = 1
     group by course_id
     order by count desc;
     
     
     select * from sevena
     where count>10000;
      

-- ---------------------------------------------------------------------------
-- 8.  What fraction of users view, explore, or certify in the content in each course once they have registered? 
--     Order the courses according to the fraction viewed – from the largest to the smallest.
     
     drop table if exists eighta;
     create table eighta
     select * from course_users
     where registered = 1;
     
     select course_id, avg(viewed), avg(explored), avg(certified)
     from eighta
     group by course_id
     order by avg(viewed) desc;
   
-- ---------------------------------------------------------------------------
-- 9. List Users who have registered for more than two courses?  Include the user's ID, age, country, 
--    level of education, and the number of courses registered. Order the list according to the 
--    number of courses that the user has registered in. 
     
     drop table if exists ninea;
     create table ninea
     select userid_DI, count(*) as count 
     from course_users
     group by userid_DI;
     
     drop table if exists nineb;
     create table nineb
     select * from ninea 
     where count>2;
     
     drop table if exists ninec;
     create table ninec
     select a.userid_DI,
     country,
     LOE_ID,
     yob
     from users a
     join countries b
     on a.country_id=b.country_id
     where a.country_id=b.country_id;
     
	drop table if exists nined;
     create table nined
     select a.userid_DI,
     country,
     loe,
     yob
     from ninec a
     join LOE b
     on a.LOE_id=b.LOE_id
     where a.LOE_id=b.LOE_id;
     
	drop table if exists nineanswer;
     create table nineanswer
     select a.userid_DI,
     country,
     loe,
     yob, 
     b.count
     from nined a
     join nineb b
     on a.userid_DI=b.userid_DI
     where a.userid_DI=b.userid_DI
     ;
     
     select * from nineanswer
     order by count desc;
      
   
 
  

-- ---------------------------------------------------------------------------
-- 10. Use your tables to determine how many doctoral users are there by country, ordered alphabetically 
--     by country name, and not including those whose 'country' is indicated to be 'unknown', 'Unknown/Other' or ‘Other’ .
     -- answer in question 2
     
     
     
     
     
     
     
     
       
     select * from LOE;
     drop table if exists twoa;
     create table twoa
     select distinct(country_id)
     from users
     where LOE_id=5;
     
     select*from twoa;
     
     drop table if exists twob;
     create table twob
     select distinct(userid_DI),
     grade
	from course_users
    where grade>0 
    ;
    
    drop table if exists twoc;
    create table twoc
    select userid_DI,
    LOE_ID,
    country_id
    from users;
    
      drop table if exists twod;
     create table twod 
     select b.userid_DI,
     grade,
     LOE_id,
     country_id
     from twob a
     join twoc b
     on a.userid_DI=b.userid_DI
     where a.userid_DI=b.userid_DI;
     
     drop table if exists twoe;
     create table twoe
     select userid_DI,
     grade, 
     LOE_id,
     a.country_id,
     country
     from twod a
     join countries b
     on a.country_id=b.country_id
     where a.country_id=b.country_id AND LOE_id=5 AND a.country_id <> 2 AND a.country_id <> 3 AND a.country_id <> 4 AND a.country_id <> 7
     AND a.country_id <> 8 AND a.country_id <> 10 AND a.country_id <> 17 AND a.country_id <> 33;
     
     select * from twoe;
     
     drop table if exists twoanswer;
     create table twoanswer
     SELECT avg(grade), COUNT(*) AS count, country
FROM twoe
GROUP BY country
ORDER BY count desc;

select * from twoanswer;


-- ---------------------------------------------------------------------------
-- 11.  For each country, what was the average grade of users who were certified in a Harvard course? 
--      Do not include those whose 'country' is labeled as ''unknown', 'Unknown/Other' or ‘Other’ . 
--      Order according to the averages in descending order.
     
     drop table if exists elevena;
     create table elevena
     select course_id,
     institution_id
     from courses
     where institution_id=1;
     
     drop table if exists elevenb;
     create table elevenb
     select userid_DI,
     certified,
     grade
     from course_users a
     join elevena b
     on a.course_id=b.course_id
     where a.course_id=b.course_id and certified =1;
     
     drop table if exists elevenc;
     create table elevenc
     select userid_DI,
     a.country_id,
     country
     from users a
     join countries b
     on a.country_id = b.country_id
     where a.country_id = b.country_id AND a.country_id <> 2 AND a.country_id <> 3 AND a.country_id <> 4 AND a.country_id <> 7
     AND a.country_id <> 8 AND a.country_id <> 10 AND a.country_id <> 17 AND a.country_id <> 33;
     
     drop table if exists elevend;
     create table elevend
     select country,
     a.userid_DI, 
     grade
     from elevenb a
     join elevenc b
     on a.userid_DI=b.userid_DI;
     
     drop table if exists elevene;
     create table elevene
     select country,
     avg(grade) as grade
     from elevend
     group by country;
     
     select * from elevene
     order by grade desc;
-- ---------------------------------------------------------------------------
-- 12. Create a view with the following three columns:
--    a.	Column 1: A column of all the (unique) courses listed by the “course_long_tile”
--    b.	Column 2: For each course, list the country whose registered users had the highest average grade in that course. 
--          Do not include countries whose names contain “Unknown”, “Unknown/Other”, or “Other”. 
--          Also, do not include the users whose grades were either zero or Null.
--    c.	Column 3: The average score of the users corresponding to each country listed Column 2.
--    Ordering is optional for this table.
     drop view if exists `n`;
     
     CREATE VIEW `n` AS
     select distinct(course_long_title),
     country,
    avg(grade)
     from courses a
     join course_users b
     on a.course_id =b.course_id
     join users c
     on b.userid_DI=c.userid_DI
     join countries d 
     on c.country_id=d.country_id
     where a.course_id=b.course_id and grade>0 AND registered=1
     AND b.userid_DI=c.userid_DI AND c.country_id <> 2 AND c.country_id <> 3 AND c.country_id <> 4 AND c.country_id <> 7
     AND c.country_id <> 8 AND c.country_id <> 10 AND c.country_id <> 17 AND c.country_id <> 33 AND c.country_id=d.country_id
     group by course_long_title
     ;
     
	select * from n;
          
-- ---------------------------------------------------------------------------
     
     -- ---------------------------------------------------------------------------
-- 13.  Use your database tables with JOIN statements to retrieve the original “temp” table used in creating 
--       this database. Create it as a VIEW so that it will not take much memory space. 
	
   CREATE VIEW `m` AS 
   select a.course_id,
   course_long_title,
   a.userid_DI,
   registered,
   viewed,
   explored,
   certified,
   country,
   loe,
   yob,
   grade
   from course_users a 
   join courses b
   on a.course_id=b.course_id
   join users c 
   on a.userid_DI = c.userid_DI
   join LOE d
   on c.LOE_id=d.LOE_id
   join countries e
   on c.country_id=e.country_id
   where a.course_id=b.course_id AND a.userid_DI = c.userid_DI AND c.LOE_id=d.LOE_id AND c.country_id=e.country_id;

select * from m;
-- ---------------------------------------------------------------------------
     

