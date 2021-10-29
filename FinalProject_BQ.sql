
-- Name:  Brad Quinton
-- Class: IT-111 
-- Abstract: Final Project (Jobs/Workers/Customers)
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
--						 
-- --------------------------------------------------------------------------------

-- Drop Table Statements

IF OBJECT_ID ('TJobMaterials')						IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID ('TJobWorkers')						IS NOT NULL DROP TABLE TJobWorkers
IF OBJECT_ID ('TWorkerSkills')						IS NOT NULL DROP TABLE TWorkerSkills
IF OBJECT_ID ('TMaterials')							IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID ('TJobs')								IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID ('TSkills')							IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID ('TWorkers')							IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID ('TVendors')							IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TStatuses')							IS NOT NULL DROP TABLE TStatuses
IF OBJECT_ID ('TCustomers')							IS NOT NULL DROP TABLE TCustomers


-- --------------------------------------------------------------------------------
--	Step #1 : Create tables
-- --------------------------------------------------------------------------------

CREATE TABLE TCustomers
(
	  intCustomerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(50)			NOT NULL
	 ,strLastName						VARCHAR(50)			NOT NULL
	 ,strAddress						VARCHAR(50)			NOT NULL
	 ,strCity							VARCHAR(50)			NOT NULL
	 ,strState							VARCHAR(50)			NOT NULL
	 ,strZip							VARCHAR(50)			NOT NULL
	 ,strPhoneNumber					VARCHAR(50)			NOT NULL
	 ,CONSTRAINT TCustomers_PK			PRIMARY KEY ( intCustomerID )
)



CREATE TABLE TStatuses
(
	 intStatusID						INTEGER				NOT NULL
	,strStatus							VARCHAR(50)			NOT NULL
	,CONSTRAINT TStatuses_PK			PRIMARY KEY ( intStatusID )
)



CREATE TABLE TVendors
(
	 intVendorID						INTEGER				NOT NULL
	,strVendorName						VARCHAR(50)			NOT NULL
	,strAddress							VARCHAR(50)			NOT NULL
	,strCity							VARCHAR(50)			NOT NULL
	,strState							VARCHAR(50)			NOT NULL
	,strZip								VARCHAR(50)			NOT NULL
	,strPhoneNumber						VARCHAR(50)			NOT NULL
	,CONSTRAINT TVendors_PK				PRIMARY KEY ( intVendorID )
)



CREATE TABLE TWorkers
(
	  intWorkerID						INTEGER				NOT NULL
	 ,strFirstName						VARCHAR(50)			NOT NULL
	 ,strLastName						VARCHAR(50)			NOT NULL
	 ,strAddress						VARCHAR(50)			NOT NULL
	 ,strCity							VARCHAR(50)			NOT NULL
	 ,strState							VARCHAR(50)			NOT NULL
	 ,strZip							VARCHAR(50)			NOT NULL
	 ,strPhoneNumber					VARCHAR(50)			NOT NULL
	 ,dtmHireDate						DATETIME			NOT NULL
	 ,monHourlyRate						MONEY				NOT NULL
	 ,CONSTRAINT TWorkers_PK			PRIMARY KEY ( intWorkerID )
)



CREATE TABLE TSkills
(
	 intSkillID							INTEGER				NOT NULL
	,strSkill							VARCHAR(50)			NOT NULL
	,strDescription						VARCHAR(100)		NOT NULL
	,CONSTRAINT TSkills_PK				PRIMARY KEY ( intSkillID )
)



CREATE TABLE TJobs
(
	 intJobID							INTEGER				NOT NULL
	,intCustomerID						INTEGER				NOT NULL
	,intStatusID						INTEGER				NOT NULL
	,dtmStartDate						DATETIME			NOT NULL
	,dtmEndDate							DATETIME			
	,strJobDesc							VARCHAR(2000)		NOT NULL
	,CONSTRAINT TJobs_PK				PRIMARY KEY ( intJobID )
)



CREATE TABLE TMaterials
(
	 intMaterialID						INTEGER				NOT NULL
	,strDescription						VARCHAR(100)		NOT NULL
	,monCost							MONEY				NOT NULL
	,intVendorID						INTEGER				NOT NULL
	,CONSTRAINT TMaterials_PK			PRIMARY KEY ( intMaterialID )
)



CREATE TABLE TWorkerSkills
(
	 intWorkerSkillID					INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intSkillID							INTEGER				NOT NULL
	,CONSTRAINT	TWorkerSkills_PK		PRIMARY KEY ( intWorkerSkillID )
)



CREATE TABLE TJobWorkers
(
	 intJobWorkerID						INTEGER				NOT NULL
	,intJobID							INTEGER				NOT NULL
	,intWorkerID						INTEGER				NOT NULL
	,intHoursWorked						INTEGER				NOT NULL
	,CONSTRAINT TJobWorkers_PK	PRIMARY KEY ( intJobWorkerID )
)



CREATE TABLE TJobMaterials
(
	 intJobMaterialID					INTEGER				NOT NULL
	,intJobID							INTEGER				NOT NULL
	,intMaterialID						INTEGER				NOT NULL
	,intQuantity						INTEGER				NOT NULL
	,CONSTRAINT TJobMaterials_PK PRIMARY KEY ( intJobMaterialID )
)


-- --------------------------------------------------------------------------------
--	Step #2 : Create relationships. Foreign Keys.
-- --------------------------------------------------------------------------------
--		Child						Parent					Column
--      -----						------					---------
--	1	TJobs						TCustomers				intCustomerID
--  2   TJobs						TStatuses				intStatusID
--  3   TJobMaterials				TJobs					intJobID
--  4   TJobWorkers					TJobs					intJobID
--  5   TJobMaterials				TMaterials				intMaterialID
--  6   TJobWorkers					TWorkers				intWorkerID
--  7   TMaterials					TVendors				intVendorID
--  8   TWorkerSkills				TWorkers				intWorkerID
--  9   TWorkerSkills				TSkills					intSkillID


--ALTER TABLE <Child Table> ADD CONSTRAINT <Child Table>_<Parent Table>_FK1
--FOREIGN KEY ( <Child column> ) REFERENCES <Parent Table> ( <Parent column> )


-- 1
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK1
FOREIGN KEY (intCustomerID) REFERENCES TCustomers (intCustomerID) ON DELETE CASCADE

-- 2
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TStatuses_FK1
FOREIGN KEY (intStatusID) REFERENCES TStatuses (intStatusID) ON DELETE CASCADE

-- 3
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK1
FOREIGN KEY (intJobID) REFERENCES TJobs (intJobID) ON DELETE CASCADE

-- 4
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TJobs_FK1
FOREIGN KEY (intJobID) REFERENCES TJobs (intJobID) ON DELETE CASCADE

-- 5
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK1
FOREIGN KEY (intMaterialID) REFERENCES TMaterials (intMaterialID) ON DELETE CASCADE

-- 6
ALTER TABLE TJobWorkers ADD CONSTRAINT TJobWorkers_TWorkers_FK1
FOREIGN KEY (intWorkerID) REFERENCES TWorkers (intWorkerID) ON DELETE CASCADE

-- 7
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK1
FOREIGN KEY (intVendorID) REFERENCES TVendors (intVendorID) ON DELETE CASCADE

-- 8
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TWorkers_FK1
FOREIGN KEY (intWorkerID) REFERENCES TWorkers (intWorkerID) ON DELETE CASCADE

-- 9
ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkerSkills_TSkills_FK1
FOREIGN KEY (intSkillID) REFERENCES TSkills (intSkillID) ON DELETE CASCADE



-- --------------------------------------------------------------------------------
--	Step #3 : Add Sample Data - INSERTS
-- --------------------------------------------------------------------------------


INSERT INTO TCustomers (intCustomerID, strFirstName, strLastName, strAddress, strCity, strState, strZip, strPhoneNumber)
VALUES				 (1, 'Frasier', 'Crane', '820 Main Street', 'Cincinnati', 'OH', '45222', '(513) 223-4591')
					,(2, 'Niles', 'Crane', '220 Main Street', 'Cincinnati', 'OH', '45123', '(513) 891-3030')
					,(3, 'Martin', 'Crane', '4581 Aspen Boulevard', 'Cincinnati', 'OH', '45232', '(513) 218-8278')
					,(4, 'Daphne', 'Moon', '9187 Madison Avenue', 'Austin', 'TX', '78751', '(512) 429-1897')
					,(5, 'Roz', 'Doyle', '30128 Main Street', 'Dayton', 'OH', '48291', '(787) 201-3872')
					,(6, 'Dave', 'Foley', '42 Roller Street', 'Dayton', 'OH', '49112', '(425) 281-8917')
					,(7, 'Bruce', 'McCulloch', '297 Beach Lane', 'Monument', 'CO', '80111', '(313) 423-9178')
					,(8, 'Kevin', 'McDonald', '909 Cauchy Street', 'Los Angeles', 'CA', '90210', '(987) 878-1283')
					,(9, 'Mark', 'McKinney', '1973 Washington Avenue', 'Seattle', 'WA', '78018', '(287) 287-9287')
					,(10, 'Scott', 'Thompson', '1108 Gordon Boulevard', 'Cincinnati', 'OH', '45201', '(513) 218-7878')



INSERT INTO TStatuses (intStatusID, strStatus)
VALUES				 (1, 'Open')
					,(2, 'In Process')
					,(3, 'Complete')



INSERT INTO TVendors (intVendorID, strVendorName, strAddress, strCity, strState, strZip, strPhoneNumber)
VALUES				 (1, 'Home Depot', '331 Main Street', 'Cincinnati', 'OH', '45218', '(513) 787-9987')
					,(2, 'Lowes', '8774 Main Street', 'Cincinnati', 'OH', '45897', '(513) 378-9917')
					,(3, 'Home Outlet', '78 Adams Boulevard', 'Middletown', 'OH', '44781', '(513) 778-1728')
					,(4, 'Fischer Homes Builder', '7873 Lincoln Street', 'Cleveland', 'OH', '58178', '(787) 907-9278')
					,(5, 'Ace Hardware', '372 Jefferson Street', 'Lexington', 'KY', '61878', '(297) 227-8887')
					,(6, 'Woods Hardware', '871  Polk Avenue', 'Cincinnati', 'OH', '45198', '(513) 878-2828')
					,(7, 'Fastenal', '8717 Geronimo Street', 'Cincinnati', 'OH', '45223', '(513) 712-1778')



INSERT INTO TWorkers (intWorkerID, strFirstName, strLastName, strAddress, strCity, strState, strZip, strPhoneNumber, dtmHireDate, monHourlyRate)
VALUES				 (1, 'Ben', 'Matlock', '2078 Van Buren Street', 'Cincinnati', 'OH', '45297', '(513) 987-1129', '1/5/1972', 32.00)
					,(2, 'Michelle', 'Thomas', '7828 Roosevelt Lane', 'Cincinnati', 'OH', '45221', '(513) 286-5872', '4/18/2003', 64.00)
					,(3, 'Julie', 'March', '1872 Crown Street', 'Chicago', 'IL', '60652', '(817) 787-3828', '5/10/2001', 48.00)
					,(4, 'Conrad', 'McMasters', '372 Grover Street Apt C', 'Muncie', 'IN', '47302', '(765) 289-5400', '10/25/2020', 25.00)
					,(5, 'Tyler', 'Hudson', '89 Applewood Place', 'Albany', 'IN', '45920', '(765) 777-2871', '11/25/2020', 35.00)



INSERT INTO TSkills (intSkillID, strSkill, strDescription)
VALUES				 (1, 'Handyman', 'Performs a range of maintenance duties.')
					,(2, 'Plumber', 'Installs, repairs, maintains pipe systems.') 
					,(3, 'Electrician', 'Installs, repairs, maintains electrical systems.')
					,(4, 'Drywall Installer', 'Installs, applies, fastens drywall panels to framework of building.')
					,(5, 'Installer II', 'Installs doors, windows, cabinets, joists, etc.')
					,(6, 'Tiler', 'Lays tile on floors and walls, both exterior and interior.')
					,(7, 'Roofer', 'Repairs, replaces, and installs roofs on residential and commercial buildings.')
					,(8, 'Carpet Layer', 'Lays floor coverings, installs carpet on walls and ceilings, measures rooms and draws up specs.')
					,(9, 'Painter', 'Washes walls, repairs holes, removes old paint, mixes and matches, and applies paints.')
					,(10, 'Concrete Pourer', 'Mixes and pours concrete, builds molds for foundations, driveways, and sidewalks.')
					,(11, 'Landscaper', 'Performs groundskeeping, plants flowers and shrubs and trees, designs flower beds.')



INSERT INTO TJobs (intJobID, intCustomerID, intStatusID, dtmStartDate, dtmEndDate, strJobDesc)
VALUES				 (1, 1, 1, '8/19/2020', NULL, 'Complete rehaul of detached backyard shed.')
					,(2, 2, 3, '7/16/1999', '8/14/1999', 'Complete rewiring of car garage.')
					,(3, 3, 1, '11/18/2020', NULL, 'Repaint kitchen and install faux shiplap backsplash with peel and stick flooring.')
					,(4, 1, 2, '10/31/2020', '11/5/2020', 'Install new bathroom cabinets and floor tile.')
					,(5, 1, 3, '4/28/2004', '5/16/2004', 'Install new roof and gutter system on residential home.')
					,(6, 1, 3, '1/15/1990', '6/10/1991', 'Build residential home from ground up, based on owner and architect specs.')
					,(7, 7, 1, '11/30/2020', NULL, 'Overhaul and replace residential driveway.')
					,(8, 8, 3, '2/28/1965', '3/30/1965', 'Painting of outdoor residential building and backyard shed.')
					,(9, 9, 2, '3/25/2019', '4/15/2019', 'Install dryer vent, install ceiling fan, fix dishwasher door latch, fix master bedroom door hinges.')
					,(10, 10, 3, '6/1/2015', '7/2/2015', 'Build front porch on residential home.')
					,(11, 1, 3, '4/22/2013', '4/23/2013', 'Roto rooter master bathroom toilet, replace toilet flapper.')
					,(12, 6, 3, '9/10/2005', '9/18/2005', 'Install new carpeting in entire residential condominium.')
					,(13, 3, 1, '11/18/2020', NULL, 'Install new shower in master bathroom, install floor and wall tile.')
					,(14, 4, 3, '5/13/1984', '5/14/1984', 'Install GFIs in kitchen outlets.')
					,(15, 5, 2, '4/10/2020', '4/15/2020', 'Design flower bed and install bushes and flowers.')



INSERT INTO TMaterials (intMaterialID, strDescription, monCost, intVendorID)
VALUES				 (1, 'Nails', 2.99, 1)
					,(2, 'Paint', 15.00, 2)
					,(3, 'Concrete', 25.00, 3)
					,(4, 'Bushes', 59.99, 2)
					,(5, 'Splash tile', 3.50, 4)
					,(6, 'Electrical wiring', 2.65, 5)
					,(7, 'Roofing shingles', 15.85, 6)
					,(8, 'Mulch', 4.25, 1)
					,(9, 'Electrical tape', 1.00, 7)
					,(10, 'Lumber', 9.87, 4)
					,(11, 'Joist brackets', 3.00, 5)
					,(12, 'Screws', 0.50, 6)
					,(13, 'Paintbrush', 1.50, 7)
					,(14, 'Wire caps', 0.25, 1)
					,(15, 'Quikrete', 5.70, 2)
					,(16, 'Painters tape', 3.80, 3)
					,(17, 'Cabinets', 119.00, 4)
					,(18, 'Cabinet knobs', 14.00, 5)
					,(19, 'Gutters', 290.00, 6)
					,(20, 'Gutter spouts', 9.00, 7)
					,(21, 'String', 1.75, 1)
					,(22, 'Dryer vent', 15.00, 2)
					,(23, 'Ceiling fan', 350.00, 3)
					,(24, 'Dishwasher door latch', 3.50, 4)
					,(25, 'Door hinges', 8.00, 5)
					,(26, 'Toilet flapper', 18.00, 6)
					,(27, 'Carpet', 29.00, 3)
					,(28, 'Carpet tack', 14.00, 3)
					,(29, 'Carpet pads', 10.00, 3)
					,(30, 'Shower door', 52.00, 7)
					,(31, 'Shower faucet', 22.00, 1)
					,(32, 'Showerhead', 48.00, 2)
					,(33, 'Shower frame', 100.00, 3)
					,(34, 'GFI', 12.00, 4)
					,(35, 'Flowers', 6.00, 1)
					,(36, 'Tube of caulk', 4.00, 2)
					,(37, 'Venetian Blinds set', 45.00, 2)



INSERT INTO TWorkerSkills (intWorkerSkillID, intWorkerID, intSkillID)
VALUES				 (1, 1, 1)
					,(2, 2, 2)
					,(3, 3, 3)
					,(4, 4, 4)
					,(5, 4, 5)
					,(6, 1, 6)
					,(7, 2, 7)
					,(8, 3, 8)
					,(9, 4, 9)
					,(10, 3, 10)
					,(11, 1, 11)



INSERT INTO TJobWorkers (intJobWorkerID, intJobID, intWorkerID, intHoursWorked)
VALUES				 (1, 1, 4, 10)
					,(2, 1, 5, 28)
					,(3, 1, 2, 15)
					,(4, 1, 4, 5)
					,(5, 1, 5, 7)
					,(6, 2, 3, 0)
					,(7, 3, 5, 30)
					,(8, 3, 1, 12)
					,(9, 4, 5, 9)
					,(10, 4, 1, 18)
					,(11, 5, 2, 95)
					,(12, 6, 1, 562)
					,(13, 6, 2, 827)
					,(14, 6, 3, 1025)
					,(15, 6, 4, 2025)
					,(16, 6, 5, 354)
					,(17, 7, 5, 17)
					,(18, 8, 4, 4)
					,(19, 9, 1, 11)
					,(20, 10, 4, 6)
					,(21, 10, 5, 3)
					,(22, 10, 2, 8)
					,(23, 10, 4, 4)
					,(24, 10, 5, 8)
					,(25, 11, 2, 3)
					,(26, 12, 3, 10)
					,(27, 13, 2, 5)
					,(28, 13, 4, 2)
					,(29, 13, 1, 2)
					,(30, 14, 3, 3)
					,(31, 15, 1, 16)


					
INSERT INTO TJobMaterials (intJobMaterialID, intJobID, intMaterialID, intQuantity)
VALUES				 (1, 1, 1, 50)
					,(2, 1, 2, 3)
					,(3, 1, 3, 5)
					,(4, 1, 6, 2)
					,(5, 1, 7, 28)
					,(6, 1, 10, 50)
					,(7, 1, 11, 26)
					,(8, 1, 12, 10)
					,(9, 1, 13, 3)
					,(10, 1, 14, 10)
					,(11, 1, 16, 2)
					,(12, 1, 21, 1)
					,(13, 1, 25, 6)
					,(14, 2, 1, 2)
					,(15, 2, 6, 3)
					,(16, 2, 9, 1)
					,(17, 2, 12, 2)
					,(18, 2, 14, 16)
					,(19, 2, 34, 5)
					,(20, 3, 2, 4)
					,(21, 3, 5, 20)
					,(22, 3, 13, 5)
					,(23, 3, 16, 2)
					,(24, 4, 5, 12)
					,(25, 4, 17, 3)
					,(26, 4, 18, 3)
					,(27, 5, 1, 20)
					,(28, 5, 7, 250)
					,(29, 5, 12, 20)
					,(30, 5, 19, 16)
					,(31, 5, 20, 5)
					,(32, 6, 1, 100)
					,(33, 6, 2, 50)
					,(34, 6, 3, 150)
					,(35, 6, 6, 60)
					,(36, 6, 7, 200)
					,(37, 6, 9, 4)
					,(38, 6, 10, 500)
					,(39, 6, 11, 300)
					,(40, 6, 12, 175)
					,(41, 6, 13, 10)
					,(42, 6, 14, 100)
					,(43, 6, 15, 20)
					,(44, 6, 16, 5)
					,(45, 6, 19, 18)
					,(46, 6, 20, 5)
					,(47, 6, 21, 2)
					,(48, 6, 25, 45)
					,(49, 6, 27, 75)
					,(50, 6, 28, 100)
					,(51, 6, 29, 75)
					,(52, 6, 34, 10)
					,(53, 7, 1, 3)
					,(54, 7, 3, 50)
					,(55, 7, 10, 25)
					,(56, 7, 12, 4)
					,(57, 7, 15, 10)
					,(58, 7, 21, 1)
					,(59, 8, 2, 40)
					,(60, 8, 13, 10)
					,(61, 8, 16, 6)
					,(62, 9, 6, 1)
					,(63, 9, 9, 1)
					,(64, 9, 12, 2)
					,(65, 9, 14, 20)
					,(66, 9, 22, 1)
					,(67, 9, 23, 1)
					,(68, 9, 24, 1)
					,(69, 9, 25, 3)
					,(70, 10, 1, 8)
					,(71, 10, 3, 12)
					,(72, 10, 7, 20)
					,(73, 10, 10, 100)
					,(74, 10, 11, 60)
					,(75, 10, 12, 15)
					,(76, 10, 19, 5)
					,(77, 10, 20, 1)
					,(78, 11, 26, 1)
					,(79, 12, 1, 30)
					,(80, 12, 27, 80)
					,(81, 12, 28, 65)
					,(82, 12, 29, 80)
					,(83, 13, 5, 40)
					,(84, 13, 12, 5)
					,(85, 13, 30, 1)
					,(86, 13, 31, 1)
					,(87, 13, 32, 1)
					,(88, 13, 33, 1)
					,(89, 14, 6, 1)
					,(90, 14, 9, 1)
					,(91, 14, 12, 1)
					,(92, 14, 14, 8)
					,(93, 14, 34, 3)
					,(94, 15, 4, 6)
					,(95, 15, 8, 30)
					,(96, 15, 35, 15)


-- --------------------------------------------------------------------------------
--	Step #4 : UPDATE and DELETE Data
-- --------------------------------------------------------------------------------			

--3.1. Create SQL to update the address for a specific customer. Include a select statement before and after the update. 

SELECT	 TCustomers.intCustomerID
		,TCustomers.strFirstName
		,TCustomers.strLastName
		,TCustomers.strAddress
		,TCustomers.strCity
		,TCustomers.strState
		,TCustomers.strZip
		,TCustomers.strPhoneNumber
FROM	TCustomers

UPDATE	TCustomers
SET		strCity = 'Dallas', strAddress = '7800 Mesquite Trail', strZip = '75223'
WHERE	intCustomerID = 4

SELECT	 TCustomers.intCustomerID
		,TCustomers.strFirstName
		,TCustomers.strLastName
		,TCustomers.strAddress
		,TCustomers.strCity
		,TCustomers.strState
		,TCustomers.strZip
		,TCustomers.strPhoneNumber
FROM	TCustomers


--3.2. Create SQL to increase the hourly rate by $2 for each worker that has been an employee for at least 1 year.
--Include a select before and after the update. Make sure that you have data so that some rows are updated and others are not.

SELECT	 TWorkers.intWorkerID
		,TWorkers.strFirstName
		,TWorkers.strLastName
		,TWorkers.strAddress
		,TWorkers.strCity
		,TWorkers.strState
		,TWorkers.strZip
		,TWorkers.strPhoneNumber
		,TWorkers.dtmHireDate
		,TWorkers.monHourlyRate
FROM	TWorkers

UPDATE	TWorkers
SET		monHourlyRate = monHourlyRate + 2
WHERE	dtmHireDate < '12/2/2019'

SELECT	 TWorkers.intWorkerID
		,TWorkers.strFirstName
		,TWorkers.strLastName
		,TWorkers.strAddress
		,TWorkers.strCity
		,TWorkers.strState
		,TWorkers.strZip
		,TWorkers.strPhoneNumber
		,TWorkers.dtmHireDate
		,TWorkers.monHourlyRate
FROM	TWorkers


--3.3. Create SQL to delete a specific job that has associated work hours and materials assigned to it. Include a select before 
--and after the statement(s).

SELECT	 *
FROM		TJobs

DELETE FROM	TJobs
WHERE		intJobID IN 
				(SELECT intJobID FROM TJobMaterials WHERE intMaterialID IN 
				(SELECT intMaterialID FROM TMaterials WHERE strDescription = 'Ceiling fan'))

AND			intJobID IN
				(SELECT intJobID FROM TJobWorkers WHERE intHoursWorked = 11)
SELECT	 *
FROM		TJobs


--4.1	Write a query to list all jobs that are in process. Include the Job ID and Description, Customer ID and name, and the start date.
--Order by the Job ID. 

SELECT	 TJobs.intJobID
		,TJobs.strJobDesc
		,TJobs.intCustomerID
		,TJobs.dtmStartDate
		,TCustomers.strFirstName + ' ' + TCustomers.strLastName AS Name
		,TStatuses.strStatus

FROM TJobs
	 JOIN TCustomers
		 ON TJobs.intCustomerID = TCustomers.intCustomerID
	 JOIN TStatuses
		 ON TJobs.intStatusID = TStatuses.intStatusID

Where TStatuses.strStatus = 'In Process'
Order By TJobs.intJobID


--4.2	 Write a query to list all complete jobs for a specific customer and the materials used on each job. Include the quantity, 
--unit cost, and total cost for each material on each job. Order by Job ID and material ID. Note: Select a customer that has at 
--least 3 complete jobs and at least 1 open job and 1 in process job. At least one of the complete jobs should have multiple materials. 
--If needed, go back to your inserts and add data. 

SELECT	 TCustomers.strFirstName + ' ' + TCustomers.strLastName AS Name
		,TJobs.intJobID AS JobNumber
		,TMaterials.intMaterialID
		,TMaterials.strDescription
		,TStatuses.strStatus
		,TMaterials.monCost AS UnitCost
		,(TMaterials.monCost * TJobMaterials.intQuantity) AS TotalCostPerMaterial
		,(SUM(TJobMaterials.intQuantity)) AS TotalQuantityPerMaterial

FROM	TCustomers
			Join TJobs
				On TCustomers.intCustomerID = TJobs.intCustomerID
			Join TStatuses
				ON TStatuses.intStatusID = TJobs.intStatusID
			Join TJobMaterials
				ON TJobMaterials.intJobID = TJobs.intJobID
			Join TMaterials
				ON TMaterials.intMaterialID = TJobMaterials.intMaterialID


WHERE  TStatuses.strStatus = 'Complete' AND TCustomers.intCustomerID = 1
GROUP BY TCustomers.strFirstName, TCustomers.strLastName, TMaterials.monCost, TJobs.intJobID, TMaterials.intMaterialID
		 ,TMaterials.strDescription, TStatuses.strStatus, TJobMaterials.intQuantity
ORDER BY TJobs.intJobID, TMaterials.intMaterialID


--4.3  This step should use the same customer as in step 4.2. Write a query to list the total cost for all materials for each completed 
--job for the customer. Use the data returned in step 4.2 to validate your results.

SELECT	 TCustomers.strFirstName + ' ' + TCustomers.strLastName AS Name
		,TJobs.intJobID AS JobNumber
		,SUM(TMaterials.monCost * TJobMaterials.intQuantity) AS TotalCostForAllMaterialsPerJob

FROM	TCustomers
			Join TJobs
				On TCustomers.intCustomerID = TJobs.intCustomerID
			Join TStatuses
				ON TStatuses.intStatusID = TJobs.intStatusID
			Join TJobMaterials
				ON TJobMaterials.intJobID = TJobs.intJobID
			Join TMaterials
				ON TMaterials.intMaterialID = TJobMaterials.intMaterialID


WHERE  TStatuses.strStatus = 'Complete' AND TCustomers.intCustomerID = 1
GROUP BY TCustomers.strFirstName, TCustomers.strLastName, TJobs.intJobID
ORDER BY TJobs.intJobID, SUM(TMaterials.monCost * TJobMaterials.intQuantity)


--4.4  Write a query to list all jobs that have work entered for them. Include the job ID, job description, and job status description.
--List the total hours worked for each job with the lowest, highest, and average hourly rate. Make sure that your data includes at least one 
--job that does not have hours logged. This job should not be included in the query. Order by highest to lowest average hourly rate. 

SELECT	 TJobs.intJobID AS JobNumber
		,TJobs.strJobDesc AS JobDescription
		,TStatuses.strStatus AS JobStatus
		,SUM(TJobWorkers.intHoursWorked) AS TotalHours
		,MIN(TWorkers.monHourlyRate) AS MinTotalHourlyRate
		,MAX(TWorkers.monHourlyRate) AS MaxTotalHourlyRate
		,AVG(TWorkers.monHourlyRate) AS AvgTotalHourlyRate

FROM	TJobs
			Join TStatuses
				On TJobs.intStatusID = TStatuses.intStatusID
			Join TJobWorkers
				ON TJobWorkers.intJobID = TJobs.intJobID
			Join TWorkers
				ON TWorkers.intWorkerID = TJobWorkers.intWorkerID
			
WHERE  TJobWorkers.intHoursWorked > 0
GROUP BY TJobs.intJobID, TJobs.strJobDesc, TStatuses.strStatus
ORDER BY TJobs.intJobID, SUM(TJobWorkers.intHoursWorked), MIN(TWorkers.monHourlyRate)
		,MAX(TWorkers.monHourlyRate)
		,AVG(TWorkers.monHourlyRate)


--4.5  Write a query that lists all materials that have not been used on any jobs. Include Material ID and Description. Order by Material ID.

SELECT	 TMaterials.intMaterialID AS MaterialID
		,TMaterials.strDescription AS MaterialDescription

FROM	TMaterials

WHERE  TMaterials.intMaterialID NOT IN (SELECT TJobMaterials.intMaterialID
											FROM TJobMaterials)

GROUP BY TMaterials.intMaterialID, TMaterials.strDescription
ORDER BY TMaterials.intMaterialID


--4.6	 Create a query that lists all workers that worked greater than 20 hours for all jobs that they worked on. 
--Include the Worker ID and name, number of hours worked, and number of jobs that they worked on. Order by Worker ID. 

SELECT	 TJobs.intJobID AS JobNumber
		,TWorkers.intWorkerID AS WorkerID
		,TWorkers.strFirstName + ' ' + TWorkers.strLastName AS Name
		,SUM(TJobWorkers.intHoursWorked) AS TotalHoursWorked
		,COUNT(TJobs.intJobID) AS JobCount

FROM	TJobs
			Join TJobWorkers
				On TJobs.intJobID = TJobWorkers.intJobID
			Join TWorkers
				ON TWorkers.intWorkerID = TJobWorkers.intWorkerID
			
WHERE TJobWorkers.intHoursWorked IN (SELECT TJobWorkers.intHoursWorked
								FROM TJobs
									Join TJobWorkers
										On TJobs.intJobID = TJobWorkers.intJobID
									Join TWorkers
										ON TWorkers.intWorkerID = TJobWorkers.intWorkerID			
								GROUP BY TJobs.intJobID, TJobWorkers.intHoursWorked
								HAVING SUM(TJobWorkers.intHoursWorked) > 20)

GROUP BY TJobs.intJobID, TWorkers.intWorkerID, TWorkers.strFirstName + ' ' + TWorkers.strLastName
ORDER BY TJobs.intJobID, TWorkers.intWorkerID


--4.7	Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. 
--Order by Customer ID. Make sure that you have at least three customers on 'Main Street' each with different house numbers. 
--Make sure that you also have customers that are not on 'Main Street'.

SELECT	 TCustomers.intCustomerID AS CustomerID
		,TCustomers.strFirstName + ' ' + TCustomers.strLastName AS Name
		,TCustomers.strAddress + ', ' + TCustomers.strCity + ', ' + TCustomers.strState + ' ' + TCustomers.strZip

FROM	TCustomers

WHERE TCustomers.strAddress LIKE '%Main Street%'
			

--4.8  Write a query to list completed jobs that started and ended in the same month. List Job, Job Status, Start Date and End Date.

SELECT	 TJobs.intJobID AS JobNumber
		,TStatuses.strStatus AS JobStatus
		,TJobs.strJobDesc AS JobDescription
		,TJobs.dtmStartDate
		,TJobs.dtmEndDate
FROM	TJobs 
			Join TStatuses
				On TJobs.intStatusID = TStatuses.intStatusID
			
WHERE  TStatuses.strStatus = 'Complete'


AND (MONTH(TJobs.dtmStartDate) = 01 AND MONTH(TJobs.dtmEndDate) = 01
		OR MONTH(TJobs.dtmStartDate) = 02 AND MONTH(TJobs.dtmEndDate) = 02
		OR MONTH(TJobs.dtmStartDate) = 03 AND MONTH(TJobs.dtmEndDate) = 03
		OR MONTH(TJobs.dtmStartDate) = 04 AND MONTH(TJobs.dtmEndDate) = 04
		OR MONTH(TJobs.dtmStartDate) = 05 AND MONTH(TJobs.dtmEndDate) = 05
		OR MONTH(TJobs.dtmStartDate) = 06 AND MONTH(TJobs.dtmEndDate) = 06
		OR MONTH(TJobs.dtmStartDate) = 07 AND MONTH(TJobs.dtmEndDate) = 07
		OR MONTH(TJobs.dtmStartDate) = 08 AND MONTH(TJobs.dtmEndDate) = 08
		OR MONTH(TJobs.dtmStartDate) = 09 AND MONTH(TJobs.dtmEndDate) = 09
		OR MONTH(TJobs.dtmStartDate) = 10 AND MONTH(TJobs.dtmEndDate) = 10
		OR MONTH(TJobs.dtmStartDate) = 11 AND MONTH(TJobs.dtmEndDate) = 11
		OR MONTH(TJobs.dtmStartDate) = 12 AND MONTH(TJobs.dtmEndDate) = 12)

GROUP BY TJobs.intJobID, TStatuses.strStatus, TJobs.strJobDesc, TJobs.dtmStartDate, TJobs.dtmEndDate



--4.9  Create a query to list workers that worked on three or more jobs for the same customer.
	
--SELECT	 TCustomers.intCustomerID AS CustomerID
--		,TCustomers.strFirstName + ' ' + TCustomers.strLastName AS CustomerName
--		,TWorkers.strFirstName + ' ' + TWorkers.strLastName AS WorkerName
--		,TWorkers.intWorkerID AS WorkerID
--		,TJobs.intJobID AS JobNumber
--		,TJobs.strJobDesc AS JobDescription

--FROM	TCustomers 
--			Join TJobs
--				On TJobs.intCustomerID = TCustomers.intCustomerID
--			Join TJobWorkers
--				On TJobWorkers.intJobID = TJobs.intJobID
--			Join TWorkers
--				On TWorkers.intWorkerID = TJobWorkers.intWorkerID
--HAVING COUNT(TCustomers.intCustomerID >= 3)	AND COUNT(TJobs.intJobID)		



--4.10  Create a query to list all workers and their total # of skills. Make sure that you have workers that have multiple skills and that 
--you have at least 1 worker with no skills. The worker with no skills should be included with a total number of skills = 0. Order by Worker ID. 

SELECT	 TWorkers.strFirstName + ' ' + TWorkers.strLastName AS WorkerName
		,TWorkers.intWorkerID AS WorkerID
		,TSkills.strDescription AS Skills
		,COUNT(TSkills.intSkillID) AS SkillsCount
		,CASE
			WHEN TWorkerSkills.intWorkerID = NULL AND TWorkerSkills.intWorkerID IS NOT NULL 
			THEN TWorkerSkills.intWorkerID
			END


FROM	TWorkers 
			Join TWorkerSkills
				On TWorkers.intWorkerID = TWorkerSkills.intWorkerID
			Join TSkills
				On TWorkerSkills.intSkillID = TSkills.intSkillID
			
GROUP BY TWorkers.strFirstName + ' ' + TWorkers.strLastName, TWorkers.intWorkerID, TSkills.strDescription, TWorkerSkills.intWorkerID
ORDER BY TWorkers.strFirstName + ' ' + TWorkers.strLastName, TWorkers.intWorkerID, TSkills.strDescription, TWorkerSkills.intWorkerID



--4.11 Write a query to list the total Charge to the customer for each job. Calculate the total charge to the customer as the total 
--cost of materials + total Labor costs + 30% Profit. 
 
SELECT	 TCustomers.intCustomerID AS CustomerID
		,TJobs.intJobID AS JobID
		,TCustomers.strFirstName + ' ' + TCustomers.strLastName AS CustomerName
		,(SUM(TMaterials.monCost + TWorkers.monHourlyRate * TJobWorkers.intHoursWorked) * 0.3) AS TotalCostToCustomerPerJob
		


FROM	TCustomers 
			Join TJobs
				On TJobs.intCustomerID = TCustomers.intCustomerID
			Join TJobWorkers
				On TJobWorkers.intJobID = TJobs.intJobID
			Join TWorkers
				On TWorkers.intWorkerID = TJobWorkers.intWorkerID
			Join TJobMaterials
				On TJobMaterials.intJobID = TJobs.intJobID
			Join TMaterials
				On TMaterials.intMaterialID = TJobMaterials.intMaterialID

GROUP BY TCustomers.intCustomerID, TJobs.intJobID, TCustomers.strFirstName + ' ' + TCustomers.strLastName
ORDER BY TJobs.intJobID, (SUM(TMaterials.monCost + TWorkers.monHourlyRate * TJobWorkers.intHoursWorked) * 0.3)


--4.12  Write a query that totals what is owed to each vendor for a particular job. 

SELECT	 TJobs.intJobID AS JobID
		,TVendors.intVendorID AS VendorID
		,SUM(TMaterials.monCost * TJobMaterials.intQuantity) AS TotalCostOfMaterialsOwedToEachVendor


FROM	TJobs 
			Join TJobMaterials
				On TJobs.intJobID = TJobMaterials.intJobID
			Join TMaterials
				On TMaterials.intMaterialID = TJobMaterials.intMaterialID
			Join TVendors
				On TVendors.intVendorID = TMaterials.intVendorID

WHERE TJobs.intJobID = 1

GROUP BY TJobs.intJobID, TJobs.intJobID, TVendors.intVendorID
ORDER BY TVendors.intVendorID, (SUM(TMaterials.monCost * TJobMaterials.intQuantity))


