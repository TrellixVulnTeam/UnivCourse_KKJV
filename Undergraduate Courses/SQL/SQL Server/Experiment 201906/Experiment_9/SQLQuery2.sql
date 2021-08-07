--1.	���������ϵ��CS����ѧ����Ϣ��ͼV_1��
create view V_1
as
select *
from Student
where Sdept = 'CS'

--2.	���������ϵ(CS)ѡ����1�ſγ̵�ѧ����Ϣ��ͼV_2��
create view V_2
as
select distinct Student.Sno, Student.Sname, Student.Ssex, Student.Sage, Student.Sdept
from Student, SC
where Sdept = 'CS' and SC.Cno = 1

--3.	���������ϵѡ����1�ſγ��ҳɼ���90�����ϵ�ѧ������ͼV_3��
create view V_3
as
select Student.Sno, Student.Sname
from Student, SC
where Student.Sno = SC.Sno and Student.Sdept = 'CS' and SC.Cno = 1 and SC.Grade >= 90

--4.	����һ����ӳѧ��ѧ�ţ�������������ݵ���ͼV_4��
create view V_4
as
select Student.Sno, Student.Sname, YEAR(GETDATE())-Student.Sage '�������'
from Student

--5.	��ѧ����ѧ�ż���ƽ���ɼ�����Ϊһ����ͼV_5��
create view V_5
as
select SC.Sno, AVG(SC.Grade) 'ƽ���ɼ�'
from SC
group by SC.Sno

--6.	���������ϵ(CS)ѧ����ƽ���ɼ���ͼV_6,����ѧ�ź�ƽ���ɼ�
create view V_6
as
select SC.Sno, AVG(SC.Grade) 'ƽ���ɼ�'
from Student, SC
where Student.Sno = SC.Sno and Student.Sdept = 'CS'
group by SC.Sno

--7.	ͨ��V_2��ͼ��ѯ�����ϵѡ����1�ſγ̵�ѧ���������Ա����䡣
create view V_7
as
--select distinct V_2.Sno, V_2.Sname, V_2.Ssex, V_2.Sage, V_2.Sdept
select distinct V_2.Sname, V_2.Ssex, V_2.Sage
from V_2
--where Sdept = 'CS' and SC.Cno = 1

--8.	��V_5��ͼ�в�ѯƽ���ɼ���90�����ϵ�ѧ��ѧ�ź�ƽ���ɼ���
create view V_8
as
select *
from V_5
where ƽ���ɼ� >= 90

--9.	�������ϵѧ����ͼV_1��ѧ��98002��ѧ��������Ϊ����������
UPDATE V_1
SET Sname = '����'
WHERE Sno =  '98002'

--10.	������ϵѧ����ͼV_1�в���һ���µ�ѧ����¼��95029�����£�20��
INSERT INTO
V_1(Sno, Sname, Sage, Sdept)
VALUES
('95029','����',20,'CS')

--11.	ɾ����ͼV_1��ѧ��Ϊ95029�ļ�¼��
DELETE V_1
WHERE Sno = '95029'