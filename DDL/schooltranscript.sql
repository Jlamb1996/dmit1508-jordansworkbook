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
Surname			varchar(50) not null,
DateofBirth		varchar(50) not null,
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
Hours		tinyint not null,
Active		bit 
constraint DF_courses_Active
default (1)    not null,
Cost		money not null









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
Status			char(3) not null,

--table level definition for composite primary keys

constraint pk_StudentCourses_StudentID_CourseNumber
primary key (StudentID, CourseNumber) 



)




Insert into Students (StudentID,GivenName, Surname,DateOfBirth,Enrolled)
values ('1','Jordan','Lamb','19960401 2:00 pm', 1),
		('2', 'Avril','Lamb', '19980820 5:00 am', 66)

select * from Students






				
				





