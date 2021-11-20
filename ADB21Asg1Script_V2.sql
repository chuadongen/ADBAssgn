/**-----------------------------------------------**/
/**  ADB ASSIGNMENT 1 OCT 2021, SEMESTER 2 & 4    **/
/**             Motorbike Rental System           **/
/**						                          **/
/**   Database Script for creating simplified	  **/
/**  		database tables and data.             **/
/**		                                          **/
/** IMPORTANT: Do not modify the table defintions.**/
/**  But you may add new tables and sample data.  **/
/**-----------------------------------------------**/

/**=========== Create Database =================**/

--CREATE DATABASE MBikeRental
--GO
--test
USE MBikeRental
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='BikeRental' AND TYPE='U')
DROP TABLE BikeRental
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='Motorbike' AND TYPE='U')
DROP TABLE Motorbike
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='BikeStation' AND TYPE='U')
DROP TABLE BikeStation
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='BikeCategory' AND TYPE='U')
DROP TABLE BikeCategory
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME='Member' AND TYPE='U')
DROP TABLE Member
GO

/**=========== Create Tables =================**/

/**====== Table: Member ======**/ 
CREATE TABLE Member (
	mem_id CHAR(6) NOT NULL,
	mem_nric CHAR(9) NOT NULL,
	mem_name VARCHAR(50) NOT NULL,
	mem_dob SMALLDATETIME NOT NULL,
	mem_address VARCHAR(100) NOT NULL,
	mem_contact VARCHAR(15) NOT NULL,
	mem_email VARCHAR(50) NOT NULL,
	mem_licence_class VARCHAR(2) NOT NULL,
	mem_join_date SMALLDATETIME NOT NULL,
	mem_status VARCHAR(15) NOT NULL,
	mem_status_effective_date SMALLDATETIME NOT NULL,
	CONSTRAINT PK_Member PRIMARY KEY  NONCLUSTERED (mem_id)
) 
GO

/**====== Table: PickupStation ======**/ 
CREATE TABLE BikeStation (
	stat_id CHAR(3) NOT NULL,
	stat_address VARCHAR(100) NOT NULL,
	stat_zone VARCHAR(7) NOT NULL,
	CONSTRAINT PK_PickupStation PRIMARY KEY  NONCLUSTERED (stat_id)
) 
GO

/**====== Table: BikeCategory ======**/ 
CREATE TABLE BikeCategory (
	cat_id CHAR(2) NOT NULL,
	cat_engine_cc VARCHAR(25) NOT NULL,
	cat_licence_class CHAR(2) NOT NULL,
	cat_rental_rate SMALLMONEY NOT NULL,
	cat_distance_rate SMALLMONEY NOT NULL,
	cat_late_penalty_rate SMALLMONEY NOT NULL,
	CONSTRAINT PK_BikeCategory PRIMARY KEY  NONCLUSTERED (cat_id)
) 
GO

/**====== Table: Motorbike ======**/ 
CREATE TABLE Motorbike (
	bike_id CHAR(5) NOT NULL,
	bike_plate_number VARCHAR(8) UNIQUE NOT NULL,
	bike_brand VARCHAR(15) NOT NULL,
	bike_model VARCHAR(20) NOT NULL,
	bike_engine_cc DECIMAL(5,1) NOT NULL,
	bike_status VARCHAR(15) NOT NULL,
	bike_category CHAR(2),
	bike_station CHAR(3),
	CONSTRAINT PK_Motorbike PRIMARY KEY  NONCLUSTERED (bike_id),
	CONSTRAINT FK_Motorbike_Category FOREIGN KEY (bike_category) REFERENCES BikeCategory (cat_id),
	CONSTRAINT FK_Motorbike_Station FOREIGN KEY (bike_station) REFERENCES BikeStation (stat_id)
) 
GO

/**====== Table: BikeRental ======**/ 
CREATE TABLE BikeRental (
	rent_id INT IDENTITY (1,1) NOT NULL,
	rent_start_date SMALLDATETIME NOT NULL,
	rent_duration TINYINT NOT NULL,
	rent_return_date SMALLDATETIME NOT NULL,
	rent_extra_km TINYINT NOT NULL,
	rent_total_cost SMALLMONEY NOT NULL,
	rent_memberid CHAR(6) NOT NULL,
	rent_bikeid CHAR(5) NOT NULL,
	CONSTRAINT PK_BikeRental PRIMARY KEY  NONCLUSTERED (rent_id),
	CONSTRAINT FK_BikeRental_memberid FOREIGN KEY (rent_memberid) REFERENCES Member (mem_id),
	CONSTRAINT FK_BikeRental_bikeid FOREIGN KEY (rent_bikeid) REFERENCES Motorbike (bike_id) 
) 
GO

/**  Create Sample Data  **/

/** Creating Records for Table Member **/
INSERT INTO Member VALUES ('M00001','S1111111A','Peter Chew','1971/01/01','Blk 111, Toa Payoh Ave 4, #01-111','9111111','peter@mymail.com.sg','2A','2021/01/01','Pending','2021/01/01')
INSERT INTO Member VALUES ('M00002','S2222222B','Betty Phua','1992/02/02','Blk 222, Queenstown Estate, #02-222','92222222','betty@yourmail.com.sg','2B', '2021/05/02','Active', '2021/05/02')
INSERT INTO Member VALUES ('M00003','S3333333C','Charlie Tan','1998/03/03','Blk 333, Ang Mo Kio Ave 2, #03-33','93333333','charlie@hismail.com.sg','2','2021/02/25','Active','2021/02/25')
INSERT INTO Member VALUES ('M00004','S4444444D','Darren Wang','1999/04/04','Blk 444, Hougang Central, #04-44','81111111','darren@mymail.com.sg','2B', '2021/07/03','Active', '2021/07/03')
INSERT INTO Member VALUES ('M00005','S5555555E','Evelyn Pang','1998/05/05','Blk 555, Clementi West Ave 5, #05-555','82222222','evelyn@yourmail.com.sg','2A','2021/09/04','Active','2021/09/04')
INSERT INTO Member VALUES ('M00006','S6666666F','Franky Foo','1980/06/06','Blk 666, Serangoon Central, #06-666','83333333','franky@hismail.com.sg','2','2021/07/06','Active','2021/07/06')
GO

/** Creating Records for Table BikeStation **/
INSERT INTO BikeStation VALUES ('S01','Ang Mo Kio','Central')
INSERT INTO BikeStation VALUES ('S02','Woodlands','North')
INSERT INTO BikeStation VALUES ('S03','Pasir Ris','East')
INSERT INTO BikeStation VALUES ('S04','Bukit Batok','West')
INSERT INTO BikeStation VALUES ('S05','Bukit Merah','South')
INSERT INTO BikeStation VALUES ('S06','Bedok','East')
INSERT INTO BikeStation VALUES ('S07','Clementi','West')
GO

/** Creating Records for Table BikeCategory **/
INSERT INTO BikeCategory VALUES ('C1','Below 200cc','2B',50,0.20,5)
INSERT INTO BikeCategory VALUES ('C2','Between 201cc and 400cc','2A',60,0.30,7)
INSERT INTO BikeCategory VALUES ('C3','Exceeding 400cc','2',80,0.40,10)
GO
	
/** Creating Records for Table Motorbike **/
INSERT INTO Motorbike VALUES ('B0001','FAA1111A','Honda','Phantom TA200',196.9,'Available','C1','S06')
INSERT INTO Motorbike VALUES ('B0002','FAB2222B','Yamaha','FZ16',153.0,'Available','C1','S03')
INSERT INTO Motorbike VALUES ('B0003','FAC3333C','Yamaha','MTM 850A',847.0,'Available','C3','S04')
INSERT INTO Motorbike VALUES ('B0004','FAD4444D','Honda','CB400',408.0,'Available','C3','S01')
INSERT INTO Motorbike VALUES ('B0005','FAE5555E','Yamaha ','Fino',115,'Available','C1','S02')
INSERT INTO Motorbike VALUES ('B0006','FAF6666F','Yamaha','MT03',321.0,'Not Available','C2','S02')
INSERT INTO Motorbike VALUES ('B0007','FAG7777G','BMW','G310R',313.0,'Available','C2','S05')
INSERT INTO Motorbike VALUES ('B0008','FAH8888H','Piaggio','MP3 125',124.0,'Available','C1','S02')
GO

/** Creating Records for Table BikeRental **/
INSERT INTO BikeRental VALUES ('2021/10/01 7:00:00 AM',1,'2021/10/01 5:00:00 PM',18,53.60,'M00005','B0005')
INSERT INTO BikeRental VALUES ('2021/12/12 8:00:00 AM',3,'2021/12/15 5:30:00 PM',55,487.00,'M00006','B0003')
INSERT INTO BikeRental VALUES ('2021/10/03 7:30:00 AM',1,'2021/10/03 6:30:00 PM',0,50.00,'M00002','B0001')
INSERT INTO BikeRental VALUES ('2021/09/08 8:00:00 AM',2,'2021/09/09 9:00:00 PM',50,120.00,'M00005','B0005')
INSERT INTO BikeRental VALUES ('2021/10/11 8:15:00 AM',2,'2021/10/12 5:00:00 PM',70,188.00,'M00003','B0004')
INSERT INTO BikeRental VALUES ('2021/10/11 8:30:00 AM',3,'2021/10/14 6:00:00 PM',65,360.50,'M00004','B0007')
INSERT INTO BikeRental VALUES ('2021/10/15 8:30:00 AM',2,'2021/10/15 8:00:00 PM',0,100.0,'M00002','B0001')
GO
