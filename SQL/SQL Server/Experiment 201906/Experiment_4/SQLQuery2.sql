--1��	��ѯѧ��������
select COUNT(Sno) 'ѧ������'
from Student

--2��	��ѯѡ���˿γ̵�ѧ������
select COUNT(distinct Sno) 'ѡ��ѧ������'
from SC

--3��	����1�ſγ̵�ѧ��ƽ���ɼ�
select AVG(Grade) 'ƽ����'
from SC
where cno = 1

--4��	��ѯѡ��1�ſγ̵�ѧ����߷���
select MAX(Grade) '��߷�'
from SC
where cno = 1

--5��	����ѡ��1�ſγ̵�ѧ����������߳ɼ�����ͳɼ���ƽ���ɼ�
select COUNT(Sno) 'ѧ������', MAX(Grade) '��߷�', MIN(Grade) '��ͷ�', AVG(Grade) 'ƽ����'
from SC
where cno = 1

--6��	������γ̺ż���Ӧ��ѡ������
select COUNT(distinct Sno) '�����γ̺�ѡ��ѧ������'
from SC
group by Cno

--7��	��ѯѡ����3�����Ͽγ̵�ѧ��ѧ��
select Sno 'ѡ����3�����Ͽγ�'
from SC
group by Sno
having COUNT(*) >= 3

select Sno 'ѡ����3�����Ͽγ�'
from Student
where Sno in (
	select sc.Sno
	from SC
	group by SC.Sno
	having COUNT(*) >= 3
)

--8��	��ѯ��3�����Ͽγ���90�����ϵ�ѧ����ѧ��
select Sno '��3�����Ͽγ���90������'
from SC
where Grade >= 90
group by Sno
having COUNT(*) >= 3

--9��	��ѯ��רҵ��רҵ����ѧ������
select Sdept, COUNT(Sno) '��רҵѧ������'
from Student
group by Sdept

--10��	��ѯƽ���ɼ���80�����ϵ�ѧ����ѧ�ż�ƽ���ɼ�
select Sno, AVG(Grade) 'ƽ���ɼ�'
from SC
--where AVG(Grade) >= 80
group by Sno
having AVG(Grade) >= 80

--11��	��ѯ������2����ѡ�޵Ŀγ̵Ŀγ̺ţ�ѡ������
select Cno, COUNT(Cno) 'ѡ������'
from SC
group by Cno
having COUNT(Cno) >= 2

--12��	��ѯѡ����3�ſγ̵�ѧ����ѧ�ż���ɼ�����ѯ�����������������
select Sno, Grade
from SC
where Cno = 3
order by Grade DESC
--where Cno = 3
--having Cno = 3

--13��	��ѯȫ��ѧ���������ѯ���������ϵ��ϵ���������У�ͬһϵ�е�ѧ�������併������
select *
from Student
order by Sdept, Sage DESC