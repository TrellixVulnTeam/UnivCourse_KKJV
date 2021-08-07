/*
1������ѧ��ѡ�����ݿ⣬��ѧ��ѡ�ο���ʹ�����ݵ���ķ�ʽ�����������ű�
S (Snum,Sname,Sex,Sage,Sphone,Dnum)
C (Cnum,Cname, Cfreq)
SC(Snum,Cnum,Score)
Snum��ʾѧ��,Sname��ʾ����,Sex��ʾ�Ա�,Sage��ʾ�绰,Dnum��ʾϵ���,Cnum��ʾ�γ̺�,Cname��ʾ�γ���,Cfreq��ʾѧ��,Score��ʾ����.
*/

create database Student_Course
	on
	  (
		name= Student_Course,
		filename = 'E:\University\SQL SERVER\ʵ��\20190415\Student_Course.mdf',
		SIZE = 5,
		filegrowth=5
	  )
	log on
	  (
		name= Student_Course_Log,
		filename = 'E:\University\SQL SERVER\ʵ��\20190415\Student_Course_Log.ldf',
		SIZE = 5,
		filegrowth=1
	  )

--use Student_Course
--go
create table S
(
	Snum char(4),
	Sname nchar(4),
	Sex nchar(1),
	Sage int,
	Sphone char(20),
	Dnum char(2),
	primary key(Snum)
)

--use Student_Course
create table C
(
	Cnum char(2),
	Cname nchar(10),
	Cfreq int,
	primary key(Cnum)
)

--use Student_Course
create table SC
(
	Snum char(4) foreign key references S(Snum),
	Cnum char(2) foreign key references C(Cnum),
	Sroce int check(Sroce between 0 and 100),
	primary key(Snum, Cnum)
)

insert into S values
('S001','����','��',19,'86824571','D2'),
('S002','����','��',23,'89454321','D3'),
('S003','����','Ů',21,'','D1'),
('S004','��Ƽ','Ů',23,'','D1'),
('S005','����','��',24,'13098765892','D3'),
('S006','����','Ů',20,'','D1')

insert into C values
('C1','���ݿ�ϵͳԭ��','4'),
('C2','C�������','4'),
('C3','�������ϵ�ṹ','3'),
('C4','�Զ�����ԭ��','2'),
('C5','���ݽṹ','4')

insert into SC values
('S001','C1',83),
('S001','C2',89),
('S001','C3',65),
('S001','C4',85),
('S001','C5',69),
('S002','C3',78),
('S002','C4',75),
('S005','C1',95),
('S004','C1',85),
('S005','C2',92),
('S005','C3',76)

--1)	��ѯϵ���Ϊ��D2��ѧ���Ļ�����Ϣ��ѧ�š��������Ա����䣩
select Snum, Sname, Sex, Sage
from S
where Dnum = 'D2'

--2)	��ѯѧ��ΪS006��ѧ��������
select Sname
from S
where Snum = 'S006'

--3)	��ѯ�ɼ���60-85֮���ѧ����ѧ��
select Snum
from SC
where Sroce between 60 and 85

--4)	��ѯ������������������Ϊ�����ֵ�ѧ������Ϣ��
select *
from S
--group by Sname
--having Sname like '��_'
where rtrim(Sname) like '��_'

--5)	��ѯѡ�޿γ̺�Ϊ��C1���ҳɼ��ǿյ�ѧ��ѧ�źͳɼ����ɼ���150���������ÿ���ɼ�����ϵ��1.5��
select Snum, Sroce * 1.5 '�ɼ�' 
from SC
--group by Cnum,Snum
--having Cnum = 'C1'
where Cnum = 'C1' and Sroce is not null

--6)	��ѯ��ѡ�μ�¼������ѧ����ѧ�ţ���DISTINCT���ƽ����ѧ�Ų��ظ�
select DISTINCT Snum
from SC
--group by Cnum,Snum
--having Cnum = 'C1'
where Cnum is not null

--7)	��ѯѡ�޿γ̡�C1����ѧ��ѧ�źͳɼ���������ɼ����������У�����ɼ���ͬ��ѧ�ŵĽ�������
select Snum, Sroce
from SC
--group by Cnum,Snum
--having Cnum = 'C1'
where Cnum = 'C1'
order by Sroce, Snum DESC

--8)	�г����в�������ѧ����Ϣ
select *
from S
--group by Sname
--having Sname like '��_'
where rtrim(Sname) not like '��%'

--9)	�г��ա�����ȫ��Ϊ3�����ֵ�ѧ����
select *
from S
--group by Sname
--having Sname like '��_'
where rtrim(Sname) like '��__'

--10)	��ʾ��1985���Ժ������ѧ���Ļ�����Ϣ��
select *
from S
where (YEAR(GETDATE())-Sage) > 1985

--11)	��ѯ���γ������С����ݡ��ִ������пγ̻�����Ϣ��
select *
from C
where Cname like '%����%'

--12)	��ʾѧ�ŵڰ�λ���ߵھ�λ��1��2��3��4����9��ѧ����ѧ�š��������Ա����估Ժϵ��
select Snum, Sname, Sex, Sage, Dnum
from S
where Snum like '_______[1,2,3,4,9]%' or Snum like '________[1,2,3,4,9]%'

--13)	�г�ѡ���ˡ�C1���γ̵�ѧ�������ɼ��Ľ������У�
select Snum, Sroce
from SC
where Cnum = 'C1'
order by Sroce DESC

--14)	�г�ͬʱѡ�ޡ�C1���ſγ̺͡�C2���ſγ̵�����ѧ����ѧ�ţ�
select Snum
from SC
where Cnum = 'C1' and Cnum = 'C2'

--15)	�г��γ̱���ȫ����Ϣ����ѧ�ֵ��������У�
select *
from C
order by Cfreq DESC

--16)	�г����䳬��ƽ��ֵ������ѧ��������������Ľ�����ʾ��
select *
from S
where Sage>(
	select AVG(Sage)
	from S
)
order by Sage DESC

--17)	���ճ������������ʾ����ѧ����ѧ�š��������Ա𡢳�����ݼ�Ժϵ���ڽ�������б���ֱ�ָ��Ϊ��ѧ�ţ��������Ա𣬳�����ݣ�Ժϵ����
select Snum 'ѧ��', Sname '����', Sex '�Ա�', YEAR(GETDATE())-Sage '�������', Dnum 'Ժϵ'
from S
order by YEAR(GETDATE())-Sage

--18)	���տγ̺š��ɼ�������ʾ�γ̳ɼ���70-80֮���ѧ����ѧ�š��γ̺ż��ɼ���
select Snum, Cnum, Sroce
from SC
where Sroce between 70 and 80

--19)	��ʾѧ����Ϣ���е�ѧ����������ƽ�����䣬�ڽ�������б���ֱ�ָ��Ϊ��ѧ����������ƽ�����䡱��
select COUNT(Snum) 'ѧ��������', AVG(Sage) 'ƽ������'
from S

--20)	��ʾѡ�޵Ŀγ�������3�ĸ���ѧ����ѡ�޿γ�����
select Snum, COUNT(Cnum) 'ѡ�޿γ���'
from SC
group by Snum
having COUNT(Cnum) >= 3

--21)	���γ̺Ž�����ʾѡ�޸����γ̵�����������߳ɼ�����ͳɼ���ƽ���ɼ���
select Cnum, COUNT(Snum) '������', MAX(Sroce) '��߳ɼ�', MIN(Sroce) '��ͳɼ�', AVG(Sroce) 'ƽ���ɼ�'
from SC
group by Cnum
order by Cnum DESC

--ѡ���⣺
--1)	��ʾƽ���ɼ����ڡ�S001��ѧ��ƽ���ɼ��ĸ���ѧ����ѧ�š�ƽ���ɼ���
select Snum, AVG(Sroce) 'ƽ���ɼ�'
from SC
where Sroce>(
	select AVG(Sroce)
	from SC
	where Snum = 'S001'
)
group by Snum

select Snum, AVG(Sroce) 'ƽ���ɼ�'
from SC
group by Snum
having AVG(Sroce)>(
	select AVG(Sroce)
	from SC
	where Snum = 'S001'
)

--2)	��ʾѡ�޸����γ̵ļ��������;
select Cnum, COUNT(Snum) '��������'
from SC
where Sroce between 60 and 100
group by Cnum

--3)	��ʾ����Ժϵ��Ů�������������ڽ�������б���ֱ�ָ��Ϊ��Ժϵ���ơ��Ա�,������
select Dnum 'Ժϵ����', Sex '�Ա�', COUNT(Snum) '����'
from S
group by Dnum, Sex
order by Dnum

--4)	�г��ж������Ͽγ̣������ţ��������ѧ����ѧ�ż���ѧ����ƽ���ɼ���
select Snum 'ѧ��', AVG(Sroce) 'ƽ���ɼ�'
from SC
where Sroce between 0 and 60
group by Snum
having COUNT(Cnum) >= 2
