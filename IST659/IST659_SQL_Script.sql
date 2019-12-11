CREATE TABLE Student
(
SUID VARCHAR(9) PRIMARY KEY,
StdFirstName VARCHAR(20) NOT NULL,
StdLastName VARCHAR(20) NOT NULL,
Program VARCHAR(30) NOT NULL,
YrAttending INT NOT NULL,
SemAttending VARCHAR(6) NOT NULL CHECK (SemAttending IN ('fall','spring','summer'))
)

CREATE TABLE Professor
(
ProfessorID VARCHAR(15) PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
Tittle VARCHAR(40) NOT NULL, 
Department VARCHAR(40) NOT NULL,
SUmailAddress VARCHAR(40) NOT NULL,
Office VARCHAR(40) NOT NULL,
ResumeLink VARCHAR(100) NULL,
WebsiteLink VARCHAR(100) NULL
)

CREATE TABLE UniqueCourse
(
UniqueCourseID INT IDENTITY (1,1) PRIMARY KEY,
CourseNumber VARCHAR(6) NOT NULL,
SectionNumber VARCHAR(4) NOT NULL,
AcademicYear INT NOT NULL,
Semester VARCHAR(6) NOT NULL CHECK (Semester IN ('fall','winter','spring','summer'))
)


CREATE TABLE CourseInfo 
(
CourseInfoID INT IDENTITY (1,1) PRIMARY KEY,
UniqueCourseID INT  NOT NULL,
CourseTittle VARCHAR(100) NOT NULL,
CourseTime VARCHAR(100) NOT NULL,
Location VARCHAR(20) NOT NULL,
CourseType VARCHAR(20) NOT NULL,
CONSTRAINT CourseInfo_FK FOREIGN KEY(UniqueCourseID) REFERENCES UniqueCourse(UniqueCourseID)
)

CREATE TABLE CourseProfTeach_tag
(
CourseProfTeach_tagID INT IDENTITY (1,1) PRIMARY KEY,
UniqueCourseID INT  NOT NULL,
ProfessorID VARCHAR(15) NOT NULL,
Syllbuslink VARCHAR(100) NULL,
CONSTRAINT CourseProfTeach_tag_FK_CourseID FOREIGN KEY (UniqueCourseID) REFERENCES UniqueCourse(UniqueCourseID),
CONSTRAINT CourseProfTeach_tag_ProfessorID FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID)
);

CREATE TABLE CourseStudentEnrollment_tag
(
CourseStudentEnrollment_tagID INT IDENTITY (1,1) PRIMARY KEY,
UniqueCourseID INT  NOT NULL,
SUID VARCHAR(9) NOT NULL,
YrOfProgram VARCHAR(15) NOT NULL CHECK ( YrOfProgram IN ('First Year','Second Year')),
SemOfProgram VARCHAR (40) NOT NULL CHECK (SemOfProgram IN ('First Semester','Second Semester','Winter Semester','Summer Semester')),
CONSTRAINT CourseStudentEnrollment_tag_FK_CourseID FOREIGN KEY (UniqueCourseID) REFERENCES UniqueCourse(UniqueCourseID),
CONSTRAINT CourseStudentEnrollment_tag_FK_SUID FOREIGN KEY (SUID) REFERENCES Student(SUID)
);

CREATE TABLE CourseGrade_tag
(
CourseGrade_tagID INT IDENTITY (1,1) PRIMARY KEY,
UniqueCourseID INT  NOT NULL,
SUID VARCHAR(9) NOT NULL,
ProfessorID VARCHAR(15) NOT NULL,
Grade INT NOT NULL,
CONSTRAINT CourseGrade_tag_FK_CourseID FOREIGN KEY (UniqueCourseID) REFERENCES UniqueCourse(UniqueCourseID),
CONSTRAINT CourseGrade_tag_FK_SUID  FOREIGN KEY (SUID) REFERENCES Student(SUID),
CONSTRAINT CourseGrade_tag_FK_ProfessorID FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID)
);

CREATE TABLE CourseEvaluation_tag
(
EvaluationID INT IDENTITY (1,1) PRIMARY KEY,
UniqueCourseID INT  NOT NULL,
SUID VARCHAR(9) NOT NULL,
ProfessorID VARCHAR(15) NOT NULL,
EvaluationScore INT NOT NULL,
CONSTRAINT CourseEvaluation_tag_FK_CourseID FOREIGN KEY (UniqueCourseID) REFERENCES UniqueCourse(UniqueCourseID),
CONSTRAINT CourseEvaluation_tag_FK_SUID  FOREIGN KEY (SUID) REFERENCES Student(SUID),
CONSTRAINT CourseEvaluation_tag_FK_ProfessorID FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID)
)

SELECT * FROM Student
INSERT INTO Student VALUES ('306754123','Minyang','Wang','ADS',2018,'fall')
INSERT INTO Student VALUES ('999687609','Abdulaziz','Alsuwayh','ADS',2018,'fall')
INSERT INTO Student VALUES ('422443360','Aditya','Chauhan','ADS',2018,'fall')
INSERT INTO Student VALUES ('591906345','Aditya','Patil','ADS',2018,'fall')
INSERT INTO Student VALUES ('964388836','Alyssa','Gorsky','ADS',2018,'fall')
INSERT INTO Student VALUES ('394006011','Amanda','Gomes','ADS',2018,'fall')
INSERT INTO Student VALUES ('164596264','Apoorva','Angre','ADS',2018,'fall')
INSERT INTO Student VALUES ('945728613','Ashik','Liyakathali','ADS',2018,'fall')
INSERT INTO Student VALUES ('669031207','Austin','Lewis','ADS',2018,'fall')
INSERT INTO Student VALUES ('560617330','Bhavik','Lalwani','ADS',2018,'fall')
INSERT INTO Student VALUES ('782371674','Christopher','Whelan','ADS',2018,'spring')
INSERT INTO Student VALUES ('141954588','Dara','Kim','ADS',2018,'spring')
INSERT INTO Student VALUES ('327172693','Fernando','Granato','ADS',2018,'spring')
INSERT INTO Student VALUES ('139702045','Gustavo','Oliveira','ADS',2018,'spring')
INSERT INTO Student VALUES ('132094679','Han','Zhuang','ADS',2018,'spring')
INSERT INTO Student VALUES ('896855658','Ivan','Huang','ADS',2018,'spring')
INSERT INTO Student VALUES ('117641979','James','Lu','ADS',2018,'spring')
INSERT INTO Student VALUES ('146723606','Jeff','Hemsley','ADS',2018,'spring')
INSERT INTO Student VALUES ('658982897','Jieqing','Hu','BA',2018,'spring')
INSERT INTO Student VALUES ('269118464','Jim','Hwang','BA',2018,'spring')
INSERT INTO Student VALUES ('971866967','Jingyi','Wang','BA',2018,'spring')
INSERT INTO Student VALUES ('835995188','Joey','Sisti','BA',2018,'spring')
INSERT INTO Student VALUES ('651240959','Julia','Fontana','BA',2018,'spring')
INSERT INTO Student VALUES ('884664445','Khushnud','Sapaev','BA',2018,'spring')
INSERT INTO Student VALUES ('936527751','Kirti','Hassani','BA',2018,'spring')
INSERT INTO Student VALUES ('250021379','Linqing','Li','BA',2018,'fall')--
INSERT INTO Student VALUES ('886726697','Luigi','Penaloza','BA',2018,'fall')
INSERT INTO Student VALUES ('687498203','Max','Gerstman','BA',2018,'fall')
INSERT INTO Student VALUES ('664510579','Mengjie','Ge','BA',2018,'fall')
INSERT INTO Student VALUES ('790938363','Mudita','Humar','BA',2018,'fall')
INSERT INTO Student VALUES ('446629472','Narasimha','Shenoy','BA',2018,'fall')
INSERT INTO Student VALUES ('434405468','Nata','Barbosa','BA',2018,'fall')
INSERT INTO Student VALUES ('874367270','Nidhi','Shetty','BA',2018,'fall')
INSERT INTO Student VALUES ('152822640','Nikhila','Gupta','BA',2018,'fall')

SELECT * FROM Professor

INSERT INTO Professor VALUES ('684413987','Ben','Nichols','Adjunt','Ischool','bwnichol@syr.edu','Hinds Hall 027','https://www.linkedin.com/in/ben-nichols/',NULL)
INSERT INTO Professor VALUES ('728349753','Steve','Wallace','Professor of Practice','Ischool','swalla02@syr.edu ','Hinds Hall 229','https://www.linkedin.com/in/swallacebizlitics/','https://bizlitics.com/')
INSERT INTO Professor VALUES ('187057756','Bei','Yu','Associate Professor','Ischool','byu@syr.edu','Hinds Hall 320','https://www.linkedin.com/in/beiyu/','http://faculty.ischool.syr.edu/byu/')
INSERT INTO Professor VALUES ('705879702','Anna','Chernobai','Associate Professor','Whitman','annac@syr.edu','Room 609',NULL,'https://sites.google.com/a/g.syr.edu/anna-chernobai/')
INSERT INTO Professor VALUES ('962201151','Jeffrey','Saltz','Associate Professor','Ischool','jsaltz@syr.edu','Hinds Hall 233',NULL,NULL)
INSERT INTO Professor VALUES ('773463701','Xiao','Lu','Associate Professor','Ischool','lxiao04@syr.edu','Hinds Hall 213',NULL,NULL)
INSERT INTO Professor VALUES ('550546672','Daniel','Acuna','Associate Professor','Ischool','deacuna@syr.edu','Hinds Hall 312',NULL,'https://acuna.io/')
INSERT INTO Professor VALUES ('870632924','Jeff','Hemsley','Associate Professor','Ischool','jjhemsle@syr.edu','Hinds Hall 346','https://www.linkedin.com/in/jeffhemsley/',NULL)
INSERT INTO Professor VALUES ('177316189','Amiya','Basu','Professor','Whitman','abasu@syr.edu','Room 628',NULL,NULL)
INSERT INTO Professor VALUES ('441309639','Ravi','Shukla','Associate Professor','Whitman','rkshukla@syr.edu','Room 629',NULL,NULL)
INSERT INTO Professor VALUES ('278849767','Lai','Xu','Associate Professor','Whitman','lxu100@syr.edu','Room 521',NULL,NULL)
INSERT INTO Professor VALUES ('365704328','Don','Harter','Associate Professor','Whitman','dharter@syr.edu','Room 503',NULL,NULL)
INSERT INTO Professor VALUES ('539417874','Yang','Wang','Associate Professor','Ischool','ywang@syr.edu','Hinds Hall 342',NULL,'http://yangwang.syr.edu/')
INSERT INTO Professor VALUES ('711822233','Ingrid','Erickson','Assistant Professor','Ischool','imericks@syr.edu','Hinds Hall 214','https://www.linkedin.com/in/ingrid-erickson-917b452/',NULL)
INSERT INTO Professor VALUES ('385089845','Radhika','Garg','Assistant Professor','Ischool','rgarg01@syr.edu','Hinds Hall 330',NULL,NULL)

SELECT * FROM UniqueCourse

INSERT INTO UniqueCourse VALUES('IST615','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST600','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST659','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST659','M002',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST664','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST664','M002',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST687','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST707','M003',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST718','M002',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST718','M003',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST719','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST719','M002',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST736','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST736','M002',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST615','M001',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST652','M002',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST659','M002',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST659','M003',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST664','M002',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST664','M003',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST707','M001',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST718','M002',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST718','M003',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST719','M001',2018,'spring')
INSERT INTO UniqueCourse VALUES('IST719','M002',2018,'spring')
INSERT INTO UniqueCourse VALUES('MBC638','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('SCM651','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('SCM651','M001',2018,'spring')
INSERT INTO UniqueCourse VALUES('SCM651','M002',2018,'spring')
INSERT INTO UniqueCourse VALUES('MAR653','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('FIN654','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('FIN756','M001',2018,'fall')
INSERT INTO UniqueCourse VALUES('IST687','M001',2018,'spring')


SELECT * FROM CourseInfo

INSERT INTO CourseInfo VALUES (1,'Cloud Management','Wed 9:30-12:15','Hinds Hall 021','Lecture')
INSERT INTO CourseInfo VALUES (2,'Intro to Cloud Technology','Wed 12:45-15:35','Hinds Hall 111','Lecture')
INSERT INTO CourseInfo VALUES (3,'Data Admin Concepts & Db Mgmt','Mon 12:30-15:15','Hinds Hall 013','Lab')
INSERT INTO CourseInfo VALUES (4,'Data Admin Concepts & Db Mgmt','Mon 17:15-20:05','Hinds Hall 027','Lab')
INSERT INTO CourseInfo VALUES (5,'Natural Language Processing','Mon 9:30-12:15','Hinds Hall 013','Lecture')
INSERT INTO CourseInfo VALUES (6,'Natural Language Processing','Mon 14:15-17:05','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (7,'Introduction to Data Science','Th 9:30-10:50','Grant Auditorium','Lecture')
INSERT INTO CourseInfo VALUES (8,'Data Analytics','Tu 9:30-12:15','Hinds Hall 027','Lab')
INSERT INTO CourseInfo VALUES (9,'Big Data Analytics','Mon 9:30-12:15','Hinds Hall 011','Lecture')
INSERT INTO CourseInfo VALUES (10,'Big Data Analytics','Tu 9:30-12:15','Hinds Hall 011','Lecture')
INSERT INTO CourseInfo VALUES (11,'Information Visualization','Tu 9:30-12:15','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (12,'Information Visualization','Wed 9:30-12:15','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (13,'Text Mining','Wed 9:30-12:15','Hinds Hall 013','Lab')
INSERT INTO CourseInfo VALUES (14,'Text Mining','Wed 14:15-17:05','Hinds Hall 013','Lab')
INSERT INTO CourseInfo VALUES (15,'Cloud Management','Wed 9:30-12:15','Hinds Hall 021','Lecture')
INSERT INTO CourseInfo VALUES (16,'Scripting for Data Analysis','Mon 17:15-20:05','Hinds Hall 027','Lab')
INSERT INTO CourseInfo VALUES (17,'Data Admin Concepts & Db Mgmt','Mon 12:45-15:30','Hinds Hall 013','Lab')
INSERT INTO CourseInfo VALUES (18,'Data Admin Concepts & Db Mgmt','Mon 9:30-12:15','Hinds Hall 013','Lab')
INSERT INTO CourseInfo VALUES (19,'Natural Language Processing','Mon 9:30-12:15','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (20,'Natural Language Processing','Th 9:30-12:15','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (21,'Data Analytics','Wed 12:45-15:35','Hinds Hall 013','Lab')
INSERT INTO CourseInfo VALUES (22,'Big Data Analytics','Tu 14:00-16:50','Hinds Hall 117','Lecture')
INSERT INTO CourseInfo VALUES (23,'Big Data Analytics','Wed 9:30-12:15','Hinds Hall 117','Lecture')
INSERT INTO CourseInfo VALUES (24,'Information Visualization','Tu 9:30-12:15','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (25,'Information Visualization','Wed 9:30-12:15','Hinds Hall 010','Lecture')
INSERT INTO CourseInfo VALUES (26,'Data Analysis and Decision Making','Wed 9:30-12:15','Whitman 007','Lecture')
INSERT INTO CourseInfo VALUES (27,'Business Analytics','Fri 13:00-15:45','Whitman 104','Lecture')
INSERT INTO CourseInfo VALUES (28,'Business Analytics','Fri 9:30-12:15','Whitman 104','Lecture')
INSERT INTO CourseInfo VALUES (29,'Business Analytics','Fri 13:00-15:45','Whitman 104','Lecture')
INSERT INTO CourseInfo VALUES (30,'Marketing Analytics ','Mon 17:15-18:35, Wed 17:15-18:35','Whitman 204','Lecture')
INSERT INTO CourseInfo VALUES (31,'Financial Analytics','Tu 18:30-19:50, Th 18:30-19:50','Whitman 009','Lecture')
INSERT INTO CourseInfo VALUES (32,'Investment Analysis','Th 8:00-9:20, Th 8:00-9:20','Whitman 007','Lecture')
INSERT INTO CourseInfo VALUES (33,'Introduction to Data Science','Th 9:30-10:50','Grant Auditorium','Lecture')


SELECT * FROM CourseProfTeach_tag

INSERT INTO CourseProfTeach_tag VALUES (1,'385089845',NULL)
INSERT INTO CourseProfTeach_tag VALUES (2,'385089845',NULL)
INSERT INTO CourseProfTeach_tag VALUES (3,'539417874',NULL)
INSERT INTO CourseProfTeach_tag VALUES (4,'684413987',NULL)
INSERT INTO CourseProfTeach_tag VALUES (5,'773463701',NULL)
INSERT INTO CourseProfTeach_tag VALUES (6,'773463701',NULL)
INSERT INTO CourseProfTeach_tag VALUES (7,'962201151',NULL)
INSERT INTO CourseProfTeach_tag VALUES (8,'728349753',NULL)
INSERT INTO CourseProfTeach_tag VALUES (9,'550546672',NULL)
INSERT INTO CourseProfTeach_tag VALUES (10,'550546672',NULL)
INSERT INTO CourseProfTeach_tag VALUES (11,'870632924',NULL)
INSERT INTO CourseProfTeach_tag VALUES (12,'870632924',NULL)
INSERT INTO CourseProfTeach_tag VALUES (13,'187057756',NULL)
INSERT INTO CourseProfTeach_tag VALUES (14,'187057756',NULL)
INSERT INTO CourseProfTeach_tag VALUES (15,'385089845',NULL)
INSERT INTO CourseProfTeach_tag VALUES (16,'684413987',NULL)
INSERT INTO CourseProfTeach_tag VALUES (17,'539417874',NULL)
INSERT INTO CourseProfTeach_tag VALUES (18,'539417874',NULL)
INSERT INTO CourseProfTeach_tag VALUES (19,'773463701',NULL)
INSERT INTO CourseProfTeach_tag VALUES (20,'728349753',NULL)
INSERT INTO CourseProfTeach_tag VALUES (21,'728349753',NULL)
INSERT INTO CourseProfTeach_tag VALUES (22,'550546672',NULL)
INSERT INTO CourseProfTeach_tag VALUES (23,'550546672',NULL)
INSERT INTO CourseProfTeach_tag VALUES (24,'870632924',NULL)
INSERT INTO CourseProfTeach_tag VALUES (25,'870632924',NULL)
INSERT INTO CourseProfTeach_tag VALUES (26,'705879702',NULL)
INSERT INTO CourseProfTeach_tag VALUES (27,'177316189',NULL)
INSERT INTO CourseProfTeach_tag VALUES (28,'177316189',NULL)
INSERT INTO CourseProfTeach_tag VALUES (29,'177316189',NULL)
INSERT INTO CourseProfTeach_tag VALUES (30,'177316189',NULL)
INSERT INTO CourseProfTeach_tag VALUES (31,'278849767',NULL)
INSERT INTO CourseProfTeach_tag VALUES (32,'441309639',NULL)
INSERT INTO CourseProfTeach_tag VALUES (33,'962201151',NULL)


SELECT * FROM CourseStudentEnrollment_tag

INSERT INTO CourseStudentEnrollment_tag VALUES (4,'306754123','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'306754123','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (14,'306754123','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'306754123','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (3,'999687609','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'999687609','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'999687609','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'422443360','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'422443360','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (30,'422443360','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'591906345','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'591906345','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (30,'591906345','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'964388836','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'964388836','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (5,'964388836','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'394006011','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'394006011','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'394006011','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'164596264','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'164596264','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (1,'164596264','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'945728613','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'945728613','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'945728613','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'669031207','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (5,'669031207','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'669031207','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (13,'669031207','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'560617330','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'560617330','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (3,'560617330','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'782371674','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (15,'782371674','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (19,'782371674','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'141954588','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'141954588','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (21,'141954588','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'327172693','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'327172693','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (28,'327172693','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'139702045','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (17,'139702045','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (19,'139702045','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'132094679','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (29,'132094679','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (30,'132094679','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'896855658','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (28,'896855658','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'896855658','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'117641979','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (29,'117641979','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (17,'117641979','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'146723606','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'146723606','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (19,'146723606','First Year','First Semester')

INSERT INTO CourseStudentEnrollment_tag VALUES (8,'782371674','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'782371674','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'782371674','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'141954588','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (9,'141954588','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'141954588','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (13,'141954588','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'327172693','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (3,'327172693','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (5,'327172693','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'139702045','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'139702045','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'139702045','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'132094679','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (5,'132094679','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (9,'132094679','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (13,'132094679','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'896855658','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'896855658','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'896855658','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'117641979','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (5,'117641979','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'117641979','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'146723606','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (31,'146723606','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'146723606','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'146723606','First Year','Second Semester')

INSERT INTO CourseStudentEnrollment_tag VALUES (33,'658982897','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (28,'658982897','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (17,'658982897','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'269118464','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (29,'269118464','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (17,'269118464','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'269118464','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'971866967','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (28,'971866967','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'971866967','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'835995188','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (29,'835995188','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (19,'835995188','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'651240959','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (28,'651240959','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (20,'651240959','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'884664445','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (29,'884664445','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'884664445','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (33,'936527751','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (16,'936527751','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (29,'936527751','First Year','First Semester')

INSERT INTO CourseStudentEnrollment_tag VALUES (26,'658982897','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'658982897','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (14,'658982897','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'269118464','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (9,'269118464','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (11,'269118464','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'269118464','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'971866967','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (13,'971866967','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'971866967','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (9,'835995188','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (12,'835995188','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'835995188','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (8,'651240959','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (31,'651240959','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'651240959','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (32,'884664445','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (10,'884664445','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (14,'884664445','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'936527751','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (31,'936527751','First Year','Second Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (12,'936527751','First Year','Second Semester')

INSERT INTO CourseStudentEnrollment_tag VALUES (7,'250021379','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'250021379','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'250021379','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'886726697','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'886726697','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'886726697','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (30,'886726697','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'687498203','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'687498203','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (31,'687498203','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'664510579','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'664510579','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (30,'664510579','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'790938363','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'790938363','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (32,'790938363','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'790938363','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'446629472','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'446629472','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'446629472','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'434405468','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'434405468','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'434405468','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'874367270','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'874367270','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'874367270','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (7,'152822640','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (26,'152822640','First Year','First Semester')
INSERT INTO CourseStudentEnrollment_tag VALUES (27,'152822640','First Year','First Semester')


SELECT * FROM CourseGrade_tag

INSERT INTO CourseGrade_tag VALUES (1, '164596264', '385089845',99)
INSERT INTO CourseGrade_tag VALUES (3, '327172693', '539417874',90)
INSERT INTO CourseGrade_tag VALUES (3, '560617330', '539417874',86)
INSERT INTO CourseGrade_tag VALUES (3, '999687609', '539417874',84)
INSERT INTO CourseGrade_tag VALUES (4, '306754123', '684413987',87)
INSERT INTO CourseGrade_tag VALUES (5, '117641979', '773463701',97)
INSERT INTO CourseGrade_tag VALUES (5, '132094679', '773463701',91)
INSERT INTO CourseGrade_tag VALUES (5, '327172693', '773463701',96)
INSERT INTO CourseGrade_tag VALUES (5, '669031207', '773463701',96)
INSERT INTO CourseGrade_tag VALUES (5, '964388836', '773463701',99)
INSERT INTO CourseGrade_tag VALUES (7, '152822640', '962201151',94)
INSERT INTO CourseGrade_tag VALUES (7, '164596264', '962201151',90)
INSERT INTO CourseGrade_tag VALUES (7, '250021379', '962201151',90)
INSERT INTO CourseGrade_tag VALUES (7, '394006011', '962201151',85)
INSERT INTO CourseGrade_tag VALUES (7, '422443360', '962201151',98)
INSERT INTO CourseGrade_tag VALUES (7, '434405468', '962201151',93)
INSERT INTO CourseGrade_tag VALUES (7, '446629472', '962201151',91)
INSERT INTO CourseGrade_tag VALUES (7, '560617330', '962201151',93)
INSERT INTO CourseGrade_tag VALUES (7, '591906345', '962201151',94)
INSERT INTO CourseGrade_tag VALUES (7, '664510579', '962201151',93)
INSERT INTO CourseGrade_tag VALUES (7, '669031207', '962201151',90)
INSERT INTO CourseGrade_tag VALUES (7, '687498203', '962201151',96)
INSERT INTO CourseGrade_tag VALUES (7, '790938363', '962201151',90)
INSERT INTO CourseGrade_tag VALUES (7, '874367270', '962201151',90)
INSERT INTO CourseGrade_tag VALUES (7, '886726697', '962201151',90)
INSERT INTO CourseGrade_tag VALUES (7, '945728613', '962201151',100)
INSERT INTO CourseGrade_tag VALUES (7, '964388836', '962201151',85)
INSERT INTO CourseGrade_tag VALUES (7, '999687609', '962201151',98)
INSERT INTO CourseGrade_tag VALUES (8, '117641979', '728349753',85)
INSERT INTO CourseGrade_tag VALUES (8, '139702045', '728349753',90)
INSERT INTO CourseGrade_tag VALUES (8, '146723606', '728349753',93)
INSERT INTO CourseGrade_tag VALUES (8, '306754123', '728349753',87)
INSERT INTO CourseGrade_tag VALUES (8, '651240959', '728349753',91)
INSERT INTO CourseGrade_tag VALUES (8, '658982897', '728349753',92)
INSERT INTO CourseGrade_tag VALUES (8, '782371674', '728349753',86)
INSERT INTO CourseGrade_tag VALUES (8, '896855658', '728349753',91)
INSERT INTO CourseGrade_tag VALUES (8, '945728613', '728349753',86)
INSERT INTO CourseGrade_tag VALUES (8, '971866967', '728349753',90)
INSERT INTO CourseGrade_tag VALUES (9, '132094679', '550546672',89)
INSERT INTO CourseGrade_tag VALUES (9, '141954588', '550546672',88)
INSERT INTO CourseGrade_tag VALUES (9, '269118464', '550546672',92)
INSERT INTO CourseGrade_tag VALUES (9, '835995188', '550546672',99)

INSERT INTO CourseGrade_tag VALUES (10, '884664445', '550546672',75)
INSERT INTO CourseGrade_tag VALUES (11, '139702045', '870632924',88)
INSERT INTO CourseGrade_tag VALUES (11, '141954588', '870632924',87)
INSERT INTO CourseGrade_tag VALUES (11, '146723606', '870632924',94)
INSERT INTO CourseGrade_tag VALUES (11, '269118464', '870632924',82)
INSERT INTO CourseGrade_tag VALUES (11, '394006011', '870632924',83)
INSERT INTO CourseGrade_tag VALUES (11, '782371674', '870632924',98)
INSERT INTO CourseGrade_tag VALUES (11, '896855658', '870632924',86)
INSERT INTO CourseGrade_tag VALUES (12, '835995188', '870632924',98)
INSERT INTO CourseGrade_tag VALUES (12, '936527751', '870632924',84)
INSERT INTO CourseGrade_tag VALUES (13, '132094679', '187057756',92)
INSERT INTO CourseGrade_tag VALUES (13, '141954588', '187057756',93)
INSERT INTO CourseGrade_tag VALUES (13, '669031207', '187057756',99)
INSERT INTO CourseGrade_tag VALUES (13, '971866967', '187057756',80)
INSERT INTO CourseGrade_tag VALUES (14, '306754123', '187057756',75)
INSERT INTO CourseGrade_tag VALUES (14, '658982897', '187057756',83)
INSERT INTO CourseGrade_tag VALUES (14, '884664445', '187057756',80)
INSERT INTO CourseGrade_tag VALUES (15, '782371674', '385089845',85)
INSERT INTO CourseGrade_tag VALUES (16, '141954588', '684413987',98)
INSERT INTO CourseGrade_tag VALUES (16, '146723606', '684413987',82)
INSERT INTO CourseGrade_tag VALUES (16, '269118464', '684413987',72)
INSERT INTO CourseGrade_tag VALUES (16, '327172693', '684413987',88)
INSERT INTO CourseGrade_tag VALUES (16, '884664445', '684413987',97)
INSERT INTO CourseGrade_tag VALUES (16, '896855658', '684413987',78)
INSERT INTO CourseGrade_tag VALUES (16, '936527751', '684413987',99)
INSERT INTO CourseGrade_tag VALUES (16, '971866967', '684413987',99)
INSERT INTO CourseGrade_tag VALUES (17, '117641979', '539417874',87)
INSERT INTO CourseGrade_tag VALUES (17, '139702045', '539417874',97)
INSERT INTO CourseGrade_tag VALUES (17, '269118464', '539417874',89)
INSERT INTO CourseGrade_tag VALUES (17, '658982897', '539417874',98)
INSERT INTO CourseGrade_tag VALUES (19, '139702045', '773463701',93)
INSERT INTO CourseGrade_tag VALUES (19, '146723606', '773463701',98)
INSERT INTO CourseGrade_tag VALUES (19, '782371674', '773463701',99)
INSERT INTO CourseGrade_tag VALUES (19, '835995188', '773463701',81)

INSERT INTO CourseGrade_tag VALUES (20, '651240959', '728349753',75)
INSERT INTO CourseGrade_tag VALUES (21, '141954588', '728349753',88)
INSERT INTO CourseGrade_tag VALUES (26, '117641979', '705879702',87)
INSERT INTO CourseGrade_tag VALUES (26, '132094679', '705879702',94)
INSERT INTO CourseGrade_tag VALUES (26, '139702045', '705879702',82)
INSERT INTO CourseGrade_tag VALUES (26, '141954588', '705879702',83)
INSERT INTO CourseGrade_tag VALUES (26, '146723606', '705879702',98)
INSERT INTO CourseGrade_tag VALUES (26, '152822640', '705879702',86)
INSERT INTO CourseGrade_tag VALUES (26, '164596264', '705879702',98)
INSERT INTO CourseGrade_tag VALUES (26, '250021379', '705879702',84)
INSERT INTO CourseGrade_tag VALUES (26, '269118464', '705879702',92)
INSERT INTO CourseGrade_tag VALUES (26, '306754123', '705879702',93)
INSERT INTO CourseGrade_tag VALUES (26, '327172693', '705879702',99)
INSERT INTO CourseGrade_tag VALUES (26, '394006011', '705879702',80)
INSERT INTO CourseGrade_tag VALUES (26, '422443360', '705879702',75)
INSERT INTO CourseGrade_tag VALUES (26, '434405468', '705879702',83)
INSERT INTO CourseGrade_tag VALUES (26, '446629472', '705879702',80)
INSERT INTO CourseGrade_tag VALUES (26, '560617330', '705879702',85)
INSERT INTO CourseGrade_tag VALUES (26, '591906345', '705879702',98)
INSERT INTO CourseGrade_tag VALUES (26, '651240959', '705879702',82)
INSERT INTO CourseGrade_tag VALUES (26, '658982897', '705879702',72)
INSERT INTO CourseGrade_tag VALUES (26, '664510579', '705879702',88)
INSERT INTO CourseGrade_tag VALUES (26, '669031207', '705879702',97)
INSERT INTO CourseGrade_tag VALUES (26, '687498203', '705879702',78)
INSERT INTO CourseGrade_tag VALUES (26, '782371674', '705879702',87)
INSERT INTO CourseGrade_tag VALUES (26, '790938363', '705879702',97)
INSERT INTO CourseGrade_tag VALUES (26, '835995188', '705879702',89)
INSERT INTO CourseGrade_tag VALUES (26, '874367270', '705879702',98)
INSERT INTO CourseGrade_tag VALUES (26, '884664445', '705879702',90)
INSERT INTO CourseGrade_tag VALUES (26, '886726697', '705879702',98)
INSERT INTO CourseGrade_tag VALUES (26, '896855658', '705879702',93)
INSERT INTO CourseGrade_tag VALUES (26, '936527751', '705879702',84)
INSERT INTO CourseGrade_tag VALUES (26, '945728613', '705879702',99)
INSERT INTO CourseGrade_tag VALUES (26, '964388836', '705879702',96)
INSERT INTO CourseGrade_tag VALUES (26, '971866967', '705879702',89)
INSERT INTO CourseGrade_tag VALUES (26, '999687609', '705879702',88)

INSERT INTO CourseGrade_tag VALUES (27, '152822640', '177316189',91)
INSERT INTO CourseGrade_tag VALUES (27, '250021379', '177316189',88)
INSERT INTO CourseGrade_tag VALUES (27, '434405468', '177316189',90)
INSERT INTO CourseGrade_tag VALUES (27, '446629472', '177316189',80)
INSERT INTO CourseGrade_tag VALUES (27, '790938363', '177316189',89)
INSERT INTO CourseGrade_tag VALUES (27, '874367270', '177316189',96)
INSERT INTO CourseGrade_tag VALUES (27, '886726697', '177316189',93)
INSERT INTO CourseGrade_tag VALUES (28, '327172693', '177316189',100)
INSERT INTO CourseGrade_tag VALUES (28, '651240959', '177316189',88)
INSERT INTO CourseGrade_tag VALUES (28, '658982897', '177316189',86)
INSERT INTO CourseGrade_tag VALUES (28, '896855658', '177316189',87)
INSERT INTO CourseGrade_tag VALUES (28, '971866967', '177316189',92)
INSERT INTO CourseGrade_tag VALUES (29, '117641979', '177316189',81)
INSERT INTO CourseGrade_tag VALUES (29, '132094679', '177316189',91)
INSERT INTO CourseGrade_tag VALUES (29, '269118464', '177316189',91)
INSERT INTO CourseGrade_tag VALUES (29, '835995188', '177316189',87)
INSERT INTO CourseGrade_tag VALUES (29, '884664445', '177316189',88)
INSERT INTO CourseGrade_tag VALUES (29, '936527751', '177316189',93)

INSERT INTO CourseGrade_tag VALUES (30, '132094679', '177316189',100)
INSERT INTO CourseGrade_tag VALUES (30, '422443360', '177316189',82)
INSERT INTO CourseGrade_tag VALUES (30, '591906345', '177316189',77)
INSERT INTO CourseGrade_tag VALUES (30, '664510579', '177316189',85)
INSERT INTO CourseGrade_tag VALUES (30, '886726697', '177316189',94)
INSERT INTO CourseGrade_tag VALUES (31, '146723606', '278849767',92)
INSERT INTO CourseGrade_tag VALUES (31, '651240959', '278849767',80)
INSERT INTO CourseGrade_tag VALUES (31, '687498203', '278849767',95)
INSERT INTO CourseGrade_tag VALUES (31, '936527751', '278849767',86)
INSERT INTO CourseGrade_tag VALUES (32, '790938363', '441309639',82)
INSERT INTO CourseGrade_tag VALUES (32, '884664445', '441309639',93)
INSERT INTO CourseGrade_tag VALUES (33, '117641979', '962201151',86)
INSERT INTO CourseGrade_tag VALUES (33, '132094679', '962201151',89)
INSERT INTO CourseGrade_tag VALUES (33, '139702045', '962201151',81)
INSERT INTO CourseGrade_tag VALUES (33, '141954588', '962201151',88)
INSERT INTO CourseGrade_tag VALUES (33, '146723606', '962201151',89)
INSERT INTO CourseGrade_tag VALUES (33, '269118464', '962201151',86)
INSERT INTO CourseGrade_tag VALUES (33, '327172693', '962201151',94)
INSERT INTO CourseGrade_tag VALUES (33, '651240959', '962201151',86)
INSERT INTO CourseGrade_tag VALUES (33, '658982897', '962201151',87)
INSERT INTO CourseGrade_tag VALUES (33, '782371674', '962201151',95)
INSERT INTO CourseGrade_tag VALUES (33, '835995188', '962201151',80)
INSERT INTO CourseGrade_tag VALUES (33, '884664445', '962201151',77)
INSERT INTO CourseGrade_tag VALUES (33, '896855658', '962201151',83)
INSERT INTO CourseGrade_tag VALUES (33, '936527751', '962201151',93)
INSERT INTO CourseGrade_tag VALUES (33, '971866967', '962201151',91)

SELECT * FROM CourseEvaluation_tag

INSERT INTO CourseEvaluation_tag VALUES (1, '164596264', '385089845',5)
INSERT INTO CourseEvaluation_tag VALUES (3, '327172693', '539417874',3)
INSERT INTO CourseEvaluation_tag VALUES (3, '560617330', '539417874',3)
INSERT INTO CourseEvaluation_tag VALUES (3, '999687609', '539417874',4)
INSERT INTO CourseEvaluation_tag VALUES (4, '306754123', '684413987',5)
INSERT INTO CourseEvaluation_tag VALUES (5, '117641979', '773463701',4)
INSERT INTO CourseEvaluation_tag VALUES (5, '132094679', '773463701',3)
INSERT INTO CourseEvaluation_tag VALUES (5, '327172693', '773463701',2)
INSERT INTO CourseEvaluation_tag VALUES (5, '669031207', '773463701',4)
INSERT INTO CourseEvaluation_tag VALUES (5, '964388836', '773463701',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '152822640', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (7, '164596264', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (7, '250021379', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (7, '394006011', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (7, '422443360', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '434405468', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (7, '446629472', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (7, '560617330', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '591906345', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '664510579', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (7, '669031207', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (7, '687498203', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '790938363', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (7, '874367270', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '886726697', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '945728613', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '964388836', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (7, '999687609', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (8, '117641979', '728349753',5)
INSERT INTO CourseEvaluation_tag VALUES (8, '139702045', '728349753',3)
INSERT INTO CourseEvaluation_tag VALUES (8, '146723606', '728349753',3)
INSERT INTO CourseEvaluation_tag VALUES (8, '306754123', '728349753',4)
INSERT INTO CourseEvaluation_tag VALUES (8, '651240959', '728349753',4)
INSERT INTO CourseEvaluation_tag VALUES (8, '658982897', '728349753',5)
INSERT INTO CourseEvaluation_tag VALUES (8, '782371674', '728349753',4)
INSERT INTO CourseEvaluation_tag VALUES (8, '896855658', '728349753',1)
INSERT INTO CourseEvaluation_tag VALUES (8, '945728613', '728349753',5)
INSERT INTO CourseEvaluation_tag VALUES (8, '971866967', '728349753',4)
INSERT INTO CourseEvaluation_tag VALUES (9, '132094679', '550546672',5)
INSERT INTO CourseEvaluation_tag VALUES (9, '141954588', '550546672',4)
INSERT INTO CourseEvaluation_tag VALUES (9, '269118464', '550546672',5)
INSERT INTO CourseEvaluation_tag VALUES (9, '835995188', '550546672',5)


INSERT INTO CourseEvaluation_tag VALUES (10, '884664445', '550546672',5)
INSERT INTO CourseEvaluation_tag VALUES (11, '139702045', '870632924',4)
INSERT INTO CourseEvaluation_tag VALUES (11, '141954588', '870632924',5)
INSERT INTO CourseEvaluation_tag VALUES (11, '146723606', '870632924',4)
INSERT INTO CourseEvaluation_tag VALUES (11, '269118464', '870632924',2)
INSERT INTO CourseEvaluation_tag VALUES (11, '394006011', '870632924',3)
INSERT INTO CourseEvaluation_tag VALUES (11, '782371674', '870632924',5)
INSERT INTO CourseEvaluation_tag VALUES (11, '896855658', '870632924',5)
INSERT INTO CourseEvaluation_tag VALUES (12, '835995188', '870632924',4)
INSERT INTO CourseEvaluation_tag VALUES (12, '936527751', '870632924',4)
INSERT INTO CourseEvaluation_tag VALUES (13, '132094679', '187057756',5)
INSERT INTO CourseEvaluation_tag VALUES (13, '141954588', '187057756',4)
INSERT INTO CourseEvaluation_tag VALUES (13, '669031207', '187057756',5)
INSERT INTO CourseEvaluation_tag VALUES (13, '971866967', '187057756',5)
INSERT INTO CourseEvaluation_tag VALUES (14, '306754123', '187057756',5)
INSERT INTO CourseEvaluation_tag VALUES (14, '658982897', '187057756',3)
INSERT INTO CourseEvaluation_tag VALUES (14, '884664445', '187057756',4)
INSERT INTO CourseEvaluation_tag VALUES (15, '782371674', '385089845',5)
INSERT INTO CourseEvaluation_tag VALUES (16, '141954588', '684413987',3)
INSERT INTO CourseEvaluation_tag VALUES (16, '146723606', '684413987',2)
INSERT INTO CourseEvaluation_tag VALUES (16, '269118464', '684413987',2)
INSERT INTO CourseEvaluation_tag VALUES (16, '327172693', '684413987',4)
INSERT INTO CourseEvaluation_tag VALUES (16, '884664445', '684413987',3)
INSERT INTO CourseEvaluation_tag VALUES (16, '896855658', '684413987',4)
INSERT INTO CourseEvaluation_tag VALUES (16, '936527751', '684413987',4)
INSERT INTO CourseEvaluation_tag VALUES (16, '971866967', '684413987',5)
INSERT INTO CourseEvaluation_tag VALUES (17, '117641979', '539417874',4)
INSERT INTO CourseEvaluation_tag VALUES (17, '139702045', '539417874',5)
INSERT INTO CourseEvaluation_tag VALUES (17, '269118464', '539417874',3)
INSERT INTO CourseEvaluation_tag VALUES (17, '658982897', '539417874',4)
INSERT INTO CourseEvaluation_tag VALUES (19, '139702045', '773463701',3)
INSERT INTO CourseEvaluation_tag VALUES (19, '146723606', '773463701',5)
INSERT INTO CourseEvaluation_tag VALUES (19, '782371674', '773463701',4)
INSERT INTO CourseEvaluation_tag VALUES (19, '835995188', '773463701',5)

 
INSERT INTO CourseEvaluation_tag VALUES (20, '651240959', '728349753',5)
INSERT INTO CourseEvaluation_tag VALUES (21, '141954588', '728349753',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '117641979', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '132094679', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '139702045', '705879702',2)
INSERT INTO CourseEvaluation_tag VALUES (26, '141954588', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '146723606', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '152822640', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '164596264', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '250021379', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '269118464', '705879702',2)
INSERT INTO CourseEvaluation_tag VALUES (26, '306754123', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '327172693', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '394006011', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '422443360', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '434405468', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '446629472', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '560617330', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '591906345', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '651240959', '705879702',2)
INSERT INTO CourseEvaluation_tag VALUES (26, '658982897', '705879702',2)
INSERT INTO CourseEvaluation_tag VALUES (26, '664510579', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '669031207', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '687498203', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '782371674', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '790938363', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '835995188', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '874367270', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '884664445', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '886726697', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '896855658', '705879702',3)
INSERT INTO CourseEvaluation_tag VALUES (26, '936527751', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '945728613', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '964388836', '705879702',5)
INSERT INTO CourseEvaluation_tag VALUES (26, '971866967', '705879702',4)
INSERT INTO CourseEvaluation_tag VALUES (26, '999687609', '705879702',5)


INSERT INTO CourseEvaluation_tag VALUES (27, '152822640', '177316189',1)
INSERT INTO CourseEvaluation_tag VALUES (27, '250021379', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (27, '434405468', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (27, '446629472', '177316189',3)
INSERT INTO CourseEvaluation_tag VALUES (27, '790938363', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (27, '874367270', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (27, '886726697', '177316189',3)
INSERT INTO CourseEvaluation_tag VALUES (28, '327172693', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (28, '651240959', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (28, '658982897', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (28, '896855658', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (28, '971866967', '177316189',2)
INSERT INTO CourseEvaluation_tag VALUES (29, '117641979', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (29, '132094679', '177316189',3)
INSERT INTO CourseEvaluation_tag VALUES (29, '269118464', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (29, '835995188', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (29, '884664445', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (29, '936527751', '177316189',3)

INSERT INTO CourseEvaluation_tag VALUES (30, '132094679', '177316189',3)
INSERT INTO CourseEvaluation_tag VALUES (30, '422443360', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (30, '591906345', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (30, '664510579', '177316189',5)
INSERT INTO CourseEvaluation_tag VALUES (30, '886726697', '177316189',4)
INSERT INTO CourseEvaluation_tag VALUES (31, '146723606', '278849767',5)
INSERT INTO CourseEvaluation_tag VALUES (31, '651240959', '278849767',4)
INSERT INTO CourseEvaluation_tag VALUES (31, '687498203', '278849767',4)
INSERT INTO CourseEvaluation_tag VALUES (31, '936527751', '278849767',5)
INSERT INTO CourseEvaluation_tag VALUES (32, '790938363', '441309639',5)
INSERT INTO CourseEvaluation_tag VALUES (32, '884664445', '441309639',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '117641979', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (33, '132094679', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (33, '139702045', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (33, '141954588', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (33, '146723606', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '269118464', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '327172693', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '651240959', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '658982897', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '782371674', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '835995188', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (33, '884664445', '962201151',3)
INSERT INTO CourseEvaluation_tag VALUES (33, '896855658', '962201151',5)
INSERT INTO CourseEvaluation_tag VALUES (33, '936527751', '962201151',4)
INSERT INTO CourseEvaluation_tag VALUES (33, '971866967', '962201151',4)


CREATE VIEW Course_check AS
(
SELECT s.Program, ci.CourseTittle, COUNT(cse.SUID) AS 'Number of enrollment', cse.YrOfProgram, cse.SemOfProgram 
FROM Student AS s
INNER JOIN CourseStudentEnrollment_tag AS cse
ON cse.SUID = s.SUID
INNER JOIN CourseProfTeach_tag AS cpt
ON cpt.UniqueCourseID = cse.UniqueCourseID
INNER JOIN CourseInfo AS ci
ON ci.UniqueCourseID = cse.UniqueCourseID
GROUP BY s.Program, ci.CourseTittle, cse.YrOfProgram, cse.SemOfProgram 
)


SELECT * FROM Course_check
WHERE Program = 'ADS'
AND YrOfProgram = 'First Year'
AND SemOfProgram = 'Second Semester'
ORDER BY [Number of enrollment] DESC


CREATE VIEW Course_gradeAndevaluation_check AS
(
SELECT uc.CourseNumber, ci.CourseTittle, p.FirstName, p.LastName, AVG(cg.Grade/1.0) AS 'Average Score', AVG(ce.EvaluationScore/1.0) AS 'Average Evaluation Score',COUNT(distinct cg.SUID) AS 'Number of enrollment'
FROM CourseGrade_tag AS cg
INNER JOIN CourseInfo AS ci
ON ci.UniqueCourseID = cg.UniqueCourseID
INNER JOIN Professor AS p
ON p.ProfessorID = cg.ProfessorID 
INNER JOIN UniqueCourse AS uc
On uc.UniqueCourseID = cg.UniqueCourseID
INNER JOIN CourseEvaluation_tag AS ce
ON ce.UniqueCourseID = ci.UniqueCourseID
GROUP BY uc.CourseNumber,ci.CourseTittle, p.FirstName, p.LastName
)


SELECT * FROM Course_gradeAndevaluation_check 
Where CourseTittle = 'Data Admin Concepts & Db Mgmt'





CREATE VIEW Course_Info_Check AS
(
SELECT u.CourseNumber, u.SectionNumber,ci.CourseTittle,p.FirstName,p.LastName,ci.CourseTime,ci.Location,ci.CourseType,u.AcademicYear,u.Semester, cpt.Syllbuslink
FROM UniqueCourse AS u
INNER JOIN CourseInfo AS ci
ON ci.UniqueCourseID = u.UniqueCourseID
INNER JOIN CourseProfTeach_tag AS cpt
ON cpt.UniqueCourseID = u.UniqueCourseID
INNER JOIN Professor AS p
ON p.ProfessorID = cpt.ProfessorID
GROUP BY u.CourseNumber, u.SectionNumber,ci.CourseTittle,p.FirstName,p.LastName,ci.CourseTime,ci.Location,ci.CourseType,u.AcademicYear,u.Semester,cpt.Syllbuslink
)

Select * FROM Course_Info_Check
WHERE CourseNumber ='IST659' AND FirstName = 'Ben' AND LastName = 'Nichols'

CREATE VIEW Course_Number_Check AS
(
SELECT p.FirstName, p.LastName,p.Department,uc.AcademicYear,uc.Semester, COUNT(cpt.UniqueCourseID) AS 'Number of courses teaching'
FROM Professor AS p
INNER JOIN CourseProfTeach_tag AS cpt
ON cpt.ProfessorID = p.ProfessorID
INNER JOIN UniqueCourse AS uc
ON uc.UniqueCourseID = cpt.UniqueCourseID
GROUP BY p.FirstName, p.LastName,p.Department,uc.AcademicYear,uc.Semester
)

SELECT * FROM Course_Number_Check

SELECT * FROM Student_Program_Check
WHERE CourseTittle = 'Information Visualization' AND FirstName = 'Jeff' AND LastName = 'Hemsley'

CREATE VIEW Student_Program_Check AS
(
SELECT ci.CourseTittle, p.FirstName,p.LastName, uc.CourseNumber, uc.SectionNumber,uc.AcademicYear, uc.Semester, s.Program, COUNT(s.Program) AS 'Number of enrollment from this program'
FROM UniqueCourse AS uc
INNER JOIN CourseInfo AS ci
ON ci.UniqueCourseID = uc.UniqueCourseID
INNER JOIN CourseStudentEnrollment_tag AS cse
On cse.UniqueCourseID = uc.UniqueCourseID
INNER JOIN CourseProfTeach_tag AS cpt
ON cpt.UniqueCourseID = uc.UniqueCourseID
INNER JOIN Student AS s
ON s.SUID = cse.SUID
INNER JOIN Professor AS p
On p.ProfessorID = cpt.ProfessorID
GROUP BY ci.CourseTittle,p.FirstName,p.LastName, uc.CourseNumber, uc.SectionNumber,uc.AcademicYear, uc.Semester, s.Program
)

CREATE VIEW Evaluation_check AS
(
SELECT p.FirstName, p.LastName, uc.CourseNumber,uc.AcademicYear,uc.Semester, AVG(ce.EvaluationScore/1.0) AS 'Average evaluation score'
FROM Professor AS p
INNER JOIN CourseProfTeach_tag AS cpt
ON cpt.ProfessorID = p.ProfessorID
INNER JOIN CourseEvaluation_tag AS ce
ON ce.ProfessorID = p.ProfessorID
INNER JOIN UniqueCourse AS uc
ON uc.UniqueCourseID = ce.UniqueCourseID
GROUP BY p.FirstName, p.LastName, uc.CourseNumber,uc.AcademicYear,uc.Semester
)


SELECT * FROM Evaluation_check
WHERE FirstName = 'Amiya' AND LastName = 'Basu' AND CourseNumber = 'SCM651'


SELECT * FROM Student


ALTER TABLE Student ADD Number_of_course INT
CREATE PROCEDURE Stud_Num_of_course
AS
BEGIN
	UPDATE Student
	SET Number_of_course = nc.Number_of_course
	FROM
		(
		SELECT s.SUID, COUNT(cg.UniqueCourseID) AS 'Number_of_course'
		FROM Student AS s
		INNER JOIN CourseGrade_tag AS cg
		ON cg.SUID = s.SUID
		GROUP BY s.SUID
		) AS nc
		WHERE Student.SUID = nc.SUID
END;
EXECUTE Stud_Num_of_course

ALTER TABLE Student ADD GPA INT
CREATE PROCEDURE Stud_GPA
AS
BEGIN
	UPDATE Student
	SET GPA = gpa.GPA
	FROM
		(
		SELECT s.SUID, AVG(cg.Grade) AS 'GPA'
		FROM Student AS s
		INNER JOIN CourseGrade_tag AS cg
		ON cg.SUID = s.SUID
		GROUP BY s.SUID
		) AS gpa
		WHERE Student.SUID = gpa.SUID
END;
EXECUTE Stud_GPA


SELECT * FROM Student


CREATE TRIGGER Update_num_of_course
ON CourseGrade_tag
FOR INSERT, UPDATE
AS
IF @@ROWCOUNT >= 1
BEGIN
UPDATE Student
	SET Number_of_course = nc.Number_of_course
	FROM
		(
		SELECT s.SUID, COUNT(cg.UniqueCourseID) AS 'Number_of_course'
		FROM Student AS s
		INNER JOIN CourseGrade_tag AS cg
		ON cg.SUID = s.SUID
		GROUP BY s.SUID
		) AS nc
		WHERE Student.SUID = nc.SUID
END;

DROP TRIGGER Update_num_of_course
DROP TRIGGER Update_GPA


CREATE TRIGGER Update_GPA
ON CourseGrade_tag
FOR INSERT, UPDATE
AS
IF @@ROWCOUNT >= 1
BEGIN
UPDATE Student
	SET GPA = gpa.GPA
	FROM
		(
		SELECT s.SUID, AVG(cg.Grade) AS 'GPA'
		FROM Student AS s
		INNER JOIN CourseGrade_tag AS cg
		ON cg.SUID = s.SUID
		GROUP BY s.SUID
		) AS gpa
		WHERE Student.SUID = gpa.SUID
END;


117641979
SELECT * FROM Student WHERE SUID = '306754123'
DELETE FROM CourseGrade_tag WHERE UniqueCourseID = 1 AND SUID = '306754123'
SELECT * FROM CourseGrade_tag WHERE SUID = '306754123'
SELECT * FROM CourseProfTeach_tag

INSERT INTO CourseGrade_tag VALUES (1,'306754123','385089845',0)
SELECT * FROM Student WHERE SUID = '306754123'


BEGIN TRANSACTION Office_change
UPDATE Professor
SET  Office = 'Hinds Hall 225'
WHERE FirstName = 'Ben'
SELECT * FROM Professor WHERE FirstName = 'Ben'

ROLLBACK TRANSACTION Office_change
SELECT * FROM Professor WHERE FirstName = 'Ben'