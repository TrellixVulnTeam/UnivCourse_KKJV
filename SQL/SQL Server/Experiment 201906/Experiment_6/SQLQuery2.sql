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


--��JXGL���ݿ���в�ѯ��
--1.	��ѯѡ��2�ſγ̵�ѧ��������
select Sname
from SC
inner join Student
on Student.Sno = SC.Sno and Cno = '2'
group by Sname, Student.Sno

select Sname
from Student, SC
where Student.Sno = SC.Sno and Cno = '2'

--2.	��ѯǮ��ͬѧѡ�޵Ŀγ̺źͷ���
select Sname, Cno, Grade
from Student, SC
where Student.Sno = SC.Sno and Sname = 'Ǯ��'

--3.	��ѯCSϵѧ��ѡ�޵Ŀγ̺źͷ���
select SC.Sno, Cno, Grade
from Student, SC
where Student.Sno = SC.Sno and Sdept = 'CS'

--4.	��ѯѡ���������γ̵�ѧ��ѧ�ţ���ֱ�����п���5�ſγ̡�
select Sno
from SC
where Cno in
(
	select Cno
	from Course
	where Cpno=5
)

--5.	��ѯѡ�޵Ŀγ̳ɼ�Ϊ90�����ϵ�ѧ��������γ����ͳɼ���
select Student.Sname, SC.Sno, SC.Grade
from Student, SC
where Student.Sno = SC.Sno and SC.Grade >= 90

--6.	��ѯѡ��2�ſγ��ҳɼ���90�����ϵ�����ѧ����ѧ�š�������
select Student.Sname, SC.Sno
from Student, SC
where Student.Sno = SC.Sno and SC.Grade >= 90 and Cno = 2

--7.	��ѯÿ��ѧ����ѧ�š�������ѡ�޵Ŀγ������ɼ���
select Student.Sno, Student.Sname, Course.Cname, SC.Grade
from Student, SC, Course
where Student.Sno = SC.Sno and Course.Cno = SC.Cno

--8.	��ѯ�Ա�Ϊ�С��γ̳ɼ������ѧ��ѧ�ţ��������γ̺š��ɼ���
select Student.Sno, Student.Sname, SC.Cno, SC.Grade
from Student, SC
where Student.Sno = SC.Sno and Student.Ssex = '��'

--9.	��ѯƽ���ɼ�����85�ֵ�ѧ�š�������ƽ���ɼ���
select Student.Sno, Student.Sname, AVG(SC.Grade) 'ƽ���ɼ�'
from Student, SC
where Student.Sno = SC.Sno
group by Student.Sno, Student.Sname
having AVG(SC.Grade) >= 85

--10.	��ѯѡ�������ݿ�ϵͳ��ѧ�����������ɼ���
select Student.Sname, SC.Grade
from Student, SC, Course
where Student.Sno = SC.Sno and Course.Cno = SC.Cno and Course.Cname = '���ݿ�ϵͳ'

--11.	��ѯÿ��ϵ��ѧ��ѡ�޵�1�ſγ̵�ƽ���ɼ�����߷֣���ͷ֣�ѡ��������
select AVG(SC.Grade) 'ƽ���ɼ�', MAX(SC.Grade) '��߷�', MIN(SC.Grade) '��ͷ�', COUNT(SC.Grade) 'ѡ������'
from Student, SC, Course
where Student.Sno = SC.Sno and Course.Cno = SC.Cno and Course.Cno = 1
group by Student.Sdept

--12.	��ѯͬʱѡ���ˡ�1���γ̺͡�2���γ̵�ѧ�������������������Ӳ�ѯ��
select Student.Sname
from Student
where Student.Sno in (
	select SC.Sno
	from SC
	where SC.Cno = 1 and SC.Sno in (
		select SC.Sno
		from SC
		where SC.Cno = 2
	)
)

select Student.Sname
from Student, SC SC1, SC SC2
where Student.Sno = SC1.Sno and Student.Sno = SC2.Sno and SC1.Cno = 1 and SC2.Cno = 2

--13.	��ѯ����ѡ����2�ſγ̵�ѧ����ѧ���š����������ӣ�
select SC1.Sno
from SC SC1, SC SC2 
where SC1.Sno = SC2.Sno
group by SC1.Sno
having COUNT(SC1.Cno) >= 2

--14.	��ѯÿ�ſγ̵����޿ε����޿Ρ����������ӣ�
select Course2.Cpno
from Course Course1, Course Course2
where Course1.Cno = Course2.Cno
group by Course2.Cno, Course2.Cpno
