--1��	Ϊstudent���sname�д���������
CREATE INDEX indexStudentSname ON Student(Sname)

--2��	Ϊstudent��sname������sage�Ľ�����������
CREATE INDEX indexStudentSnameSage ON Student(Sname ASC, Sage DESC)

--3��	����course���cname�н��򴴽�Ψһ������
CREATE INDEX indexCourseCname ON Course(Cname DESC)

--4��	����student������student1����student1���sno�д���Ψһ�ۼ�������
select *
into Student2
from Student
CREATE UNIQUE INDEX indexStudent2Sno ON Student2(Sno)

--5��	ɾ��course��cname���ϵ�������
DROP INDEX Course.indexCourseCname

--6��	ʹ�ô洢���̲鿴student�������е�������
EXEC sp_helpindex student
