/*
Filename: schooltranscript.sql
*Author: jordan lamb
Create database SchoolTranscript
*/

Create database SchoolTranscript

use SchoolTranscript
go


/* Drop tables */


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME ='Courses')
drop table Courses

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME ='Students')
drop table Students

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME ='StudentCourses')
drop table StudentCourses



/*------ Create Tables-----*/

create table Students

(
/* Column level and table level definitions
*/
StudentID		int 
constraint PK_Students_StudentID 
			Primary key			not null,
GivenName		varchar(50) not null,
Surname			varchar(50) 
constraint ck_Students_Surname
	--check (Surname LIKE '_%') 
	check (Surname LIKE '[a-z][a-z]%')  --like allows us to do a pattern match. Two letters plsu any other chars 
	not null,
DateofBirth		varchar(50) 
constraint ck_students_DateOfBirth
check (dateofbirth < GETDATE()) not null, 
Enrolled		bit			
constraint DF_Students_Enrolled
                      default(1)	not null

)




create table Courses
(

Number		varchar(10) 
constraint PK_Courses_Number
			Primary key			not null,
Name		varchar(50) not null,
Credits		decimal(3,1) 
constraint CK_Courses_Credits
check ( credits >0 and credits <=12) not null,
--      \        /     \       /  
--		boolean			boolean
--      \					/
--               boolean
Hours		tinyint 

constraint ck_Courses_Hours
check (hours >=15 and hours <=180) not null,
Active		bit 
constraint DF_courses_Active
default (1)    not null,
Cost		money 
constraint ck_courses_cost
check(cost >0) not null,









)



create table StudentCourses

(

StudentID		int  
constraint fk_StudentCourses_StudentID_Students_StudentID
foreign key references Students(StudentID)
							not null,
	
CourseNumber    varchar(10)	
constraint fk_StudentCourses_CourseNumber_Courses_Number
foreign key references Courses(Number) not null,
Year			tinyint not null,
Term			char(3) not null,
FinalMark		tinyint not null,
Status			char(3) 

constraint ck_StudentCourses_Status

check (Status = 'E' or Status = 'C' or Status = 'W')

constraint df_StudentCourses_Status

default ('E')


--table level definition for composite primary keys

constraint pk_StudentCourses_StudentID_CourseNumber
primary key (StudentID, CourseNumber) ,
constraint ck_StudentCourses_FinalMark_Status

check((status = 'C' and FinalMark is not null) OR (status in ('E', 'W') and FinalMark is null))



)




Insert into Students (StudentID,GivenName, Surname,DateOfBirth,Enrolled)
values ('1','Jordan','Lamb','19960401 2:00 pm', 1),
		('2', 'Avril','Lamb', '19980820 5:00 am', 66)

select * from Students


--Indexes--

-- for all foreign keys

Create nonclustered index IX_StudentCourses_studentID
on StudentCourses(StudentID)

create nonclustered index ix_studentcourses_CourseNumber
on studentcourses(coursenumber)

-- for other columns where searching may be improtant

create nonclustered index ix_students_surname
on students (surname)


-- alter table

alter table students
add PostalCode char(6) NULL
-- adding this as a nullable column because we dont have the postal codes for the students that already exist.--

go --  i have to break the above code as a batch from the follwoing


alter table students 
add constraint ck_students_postalcode

check (postalcode like '[a-z][0-9][a-z][0-9][a-z][0-9]')




				
				





