# jobTrackingSystemDatabase
Job-tracking system designed in MS Visio and implemented in SQL Server Management Studio for IT 111 (Database Design) course at Cincinnati State

IT-111 Database Design and SQL 1
FINAL PROJECT
Instructions: 
You are to create a database, primary keys, foreign keys, inserts, updates, and other SQL Select statements based on the script provided. 
The complete project will be the entire database consisting of primary keys foreign keys, and all SQL statements to insert, alter, create, update, and select. 
Submit the document under “Submit Final Project here” link in the Final Project folder.


Grading: 
For the final project, significant points will be deducted if the script runs with errors! 

Points will be awarded as follows: 

19	Coding Standards. Script is well documented, readable, and follows naming conventions.      
20 	Database design. This includes primary keys, foreign keys, and all other items listed above.
10 	Data Quality. All tables have data. There is enough variation to thoroughly test the SQL     
51	Remaining SQL steps.
Use books, old homework assignments, the internet and videos for reference materials but you are expected to do the work on your own. This is not a group assignment. 
I would suggest using the resources provided all semester. If you have questions about the instructions or the requirements email me. 
 
Project Description: 
Design a database for a simple job tracking system and complete the specified SQL statements to update, delete, and query the database.  A job is basically a service provided.
For example, a service of a plumber, an electrician, or a heating and cooling technician.  
The final solution should be submitted as a single Script file created in SQL Server. Be sure to test your script file before submitting it. 

Project Steps:

1. Database Design 
1.1. Design and create a database in third normal form based on the following requirements: 
•	Each Job is for a specific customer and there can be more than one job per customer. 
•	The name and address must be tracked for each customer. 
•	Each job is described by up to 2000 characters.  
•	Each job has a status of ‘open, ‘in process’, or ‘complete’. 
•	Each job has a start date and end date. 
•	Multiple materials can be used on each job. 
•	Multiple quantities of the same material can be used on each job. 
•	Materials can be used on multiple jobs. 
•	Each material is purchased by the company via a Vendor at a fixed cost per unit. 
•	Each Vendor of the materials must be tracked with the vendor name and address 
•	The number of hours worked by each worker on each job must be tracked. 
•	The name, hire date, and hourly rate, and skills must be tracked for each worker. 
•	Workers can have more than one skill. 

2. Add Data 
2.1. Populate each table with test data. Make sure that you have sufficient data to test all indicated Updates, Deletes, and Queries. 
3.	Update and Deletes (2 points each) 
3.1. Create SQL to update the address for a specific customer. Include a select statement before and after the update. 
3.2. Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year. Include a select before and after the update. Make sure 
that you have data so that some rows are updated and others are not. 
3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. Include a select before and after the statement(s). 
4.	Queries (3 points each) 
4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, Customer ID and name, and the start date. Order by the Job ID. 
4.2	 Write a query to list all complete jobs for a specific customer and the materials used on each job. Include the quantity, unit cost, and total cost for each material 
on each job. Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job and 1 in process job. At least one of the 
complete jobs should have multiple materials. If needed, go back to your inserts and add data. 
4.3	 This step should use the same customer as in step 4.2. Write a query to list the total cost for all materials for each completed job for the customer. Use the data
returned in step 4.2 to validate your results. 
4.4	 Write a query to list all jobs that have work entered for them. Include the job ID, job description, and job status description. List the total hours worked for each
job with the lowest, highest, and average hourly rate. Make sure that your data includes at least one job that does not have hours logged. This job should not be included
in the query. Order by highest to lowest average hourly rate. 
4.5	 Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. Order by Material ID. 
4.6	 Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. Include the Worker ID and name, number of hours worked, and 
number of jobs that they worked on. Order by Worker ID. 
4.7	Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. Order by Customer ID. Make sure that you have at
least three customers on 'Main Street' each with different house numbers. Make sure that you also have customers that are not on 'Main Street'. 
4.8 Write a query to list completed jobs that started and ended in the same month. List Job, Job Status, Start Date and End Date. 
4.9 Create a query to list workers that worked on three or more jobs for the same customer. 
4.10 Create a query to list all workers and their total # of skills. Make sure that you have workers that have multiple skills and that you have at least 1 worker with
no skills. The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 
4.11 Write a query to list the total Charge to the customer for each job. Calculate the total charge to the customer as the total cost of materials + total Labor costs + 30%
Profit. 
4.12 Write a query that totals what is owed to each vendor for a particular job. 

Tips: 
•	Get started early. The due dates cannot be extended. 
•	Test your script as you go. It is much easier than trying to test everything at the end. For example, write a CREATE command and test it. Then, write the next CREATE 
and test it, etc...   Also…it might be wise to create a new database for this. 
•	Clearly identify foreign key relationships using the table listing the child, parent and column. Think carefully about which table is the parent and which is the child 
and whether it is a 1 to 1, 1 to many, or many to many relationship. This will help you create foreign keys and determine the order for some of the SQL statements. Sometimes
drawing a picture of the tables can help with this. 
•	Add some data initially and then add additional data as you complete steps 4.1 through 4.12. As you complete each step think about what data you need in the tables to
thoroughly test the SQL. 
•	If you execute your SQL and are not getting the results that you want, try testing the SQL in parts. For example, if you have a sub-query, test just that portion of the 
SQL to make sure it is returning the correct results. If you are joining 4 tables, start by joining 2. Once that works properly, add a third table, etc... 

