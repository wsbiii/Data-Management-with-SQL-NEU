use acme_ids_beds;

select count(distinct ims_org_id), count(ims_org_id)
from bed_fact;

select count(distinct ims_org_id), count(ims_org_id)
from business;

#Step 4a hospitals with bed_id = 4 or 15
SELECT business_name, bed_id
FROM business AS a
JOIN bed_fact AS b
ON a.ims_org_id = b.ims_org_id
WHERE b.bed_id IN (4, 15)
;

#Step 4a 1 License Beds (or)

SELECT business_name, license_beds
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
ORDER By license_beds DESC limit 10;

#Step 4a 2: Census beds (or)
SELECT business_name, census_beds
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
ORDER By census_beds DESC limit 10;

#Step 4a 3: Staffed Beds (Or)
SELECT business_name, staffed_beds
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
ORDER By census_beds DESC limit 10;

#Step 5a 1: License Beds (And)

SELECT business_name, license_beds, bed_id
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
GROUP BY b.ims_org_id
HAVING COUNT(*) = 2
ORDER By license_beds DESC limit 10;


SELECT business_name, sum(license_beds)
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
GROUP BY b.ims_org_id
HAVING COUNT(*) = 2
ORDER By sum(license_beds) DESC limit 10;

#Step 5a 2: Census Beds (And)

SELECT business_name, census_beds, bed_id
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
GROUP BY b.ims_org_id
HAVING COUNT(*) = 2
ORDER By census_beds DESC limit 10;


SELECT business_name, sum(census_beds)
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
GROUP BY b.ims_org_id
HAVING COUNT(*) = 2
ORDER By sum(census_beds) DESC limit 10;


#Step 5a 3

SELECT business_name, staffed_beds, bed_id
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
GROUP BY b.ims_org_id
HAVING COUNT(*) = 2
ORDER By staffed_beds DESC limit 10;


SELECT business_name, sum(staffed_beds)
FROM bed_fact AS a
JOIN business AS b
ON a.ims_org_id = b.ims_org_id
WHERE a.bed_id =  4
OR a.bed_id = 15
GROUP BY b.ims_org_id
HAVING COUNT(*) = 2
ORDER By sum(staffed_beds) DESC limit 10;
