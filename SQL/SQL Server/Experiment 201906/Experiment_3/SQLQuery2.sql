insert into Student values
('98001','Ǯ��',18,'��','CS'),
('98002','����',19,'Ů','CS'),
('98003','����',20,'��','IS'),
('98004','����',16,'Ů','MA'),
('98005','ŷ����',19,'��','MA'),
('98019','����',18,'��','IS')

insert into Course values
(1,'���ݿ�ϵͳ',5,4),
(2,'��ѧ����',NULL,2),
(3,'��Ϣϵͳ����',1,3),
(4,'����ϵͳԭ��',6,3),
(5,'���ݽṹ',7,4),
(6,'���ݴ������',NULL,4),
(7,'C����',6,3)

insert into SC values
(98001,1,87),
(98001,2,67),
(98001,3,90),
(98002,2,95),
(98002,3,88),
(98004,2,Null)


select Sno,Sname
from Student

select Sname,Sno,Sdept
from Student

select *
from Student

select Sname, YEAR(GETDATE())-Sage as �������
from Student

select Sname, YEAR(GETDATE())-Sage as �������, LOWER(Sdept) as ����ϵ
from Student

select distinct Sno
from SC

select Sname,Sage
from Student
where Sage<=20

select Sname,Sdept,Sage
from Student
where Sage between 20 and 23

select Sname,Sdept,Sage
from Student
where Sage not between 20 and 23

select Sname,Ssex
from Student
where Sdept in ('IS','MA','CS')

select Sname,Ssex
from Student
where Sdept not in ('IS','MA','CS')

select *
from Student
where Sno='98001'

select *
from Student
where Sno in ('98001')

select Sno
from SC
where Grade>=90

select Sname,Sno,Sage
from Student
where Sname like '��%'

select Sname
from Student
where Sname like 'ŷ��%'

select Sname,Sno
from Student
where Sname like '_��%'

select Sname
from Student
where Sname not like '��%'

select Sno,Cno
from SC
where Grade is null

select Sno,Cno
from SC
where Grade is not null





