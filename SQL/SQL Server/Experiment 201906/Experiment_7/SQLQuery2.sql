--��JXGL���ݿ���в�ѯ�����Ӳ�ѯ��������⡣
--1.	��ѯδ��ѡ�޵Ŀγ̵Ŀγ�����ѧ�֡�
select Course.Cname, Course.Ccredit
from Course
where Course.Cno not in (
	select DISTINCT SC.Cno
	from SC
)

--2.	��ѯ��CS��ϵѧ����ѡ����Ϣ��
select Student.Sno, Course.Cno, Course.Cname, Course.Ccredit, Course.Cpno
from Student, Course, SC
where Student.Sno = SC.Sno and Course.Cno = SC.Cno and Student.Sdept = 'CS'
group by Student.Sno, Course.Cno, Course.Cname, Course.Ccredit, Course.Cpno

--3.	��ѯ��ѡ1�ſγ̵�ѧ�����֡�
select Student.Sname
from Student
where Student.Sno not in (
	select Student.Sno
	from Student, SC
	where Student.Sno = SC.Sno and SC.Cno = 1
)

--4.	��ѯ���ٱ�2��ѧ��ѡ�޵Ŀγ̵Ŀγ�����
select Course.Cname
from Course, SC
where Course.Cno = SC.Cno
group by SC.Cno, Course.Cname
having COUNT(SC.Cno)>=2

--5.	��ѯ�����ϵ��CS��ѡ����2�ż����Ͽγ̵�ѧ����ѧ�š�
select Student.Sno
from Student, SC
where Student.Sno = SC.Sno and Student.Sdept = 'CS'
group by Student.Sno
having COUNT(SC.Sno)>=2

--6.	��ѯ�롰Ǯ�ᡱ��ͬһ��ϵѧϰ��ѧ����Ϣ��
select *
from Student
where Student.Sdept in (
	select Student.Sdept
	from Student
	where rtrim(Student.Sname) like 'Ǯ��'
)

--7.	��ѯѡ���˿γ���Ϊ����ѧ��������ѧ��ѧ�š�����������ϵ��
select Student.Sno, Student.Sname, Student.Sdept
from Student, Course, SC
where Student.Sno = SC.Sno and Course.Cno = SC.Cno and Course.Cname = '��ѧ����'
--group by Student.Sno, Course.Cno, Course.Cname, Course.Ccredit, Course.Cpno

--8.	��ѯͬʱѡ���ˡ�1���γ̺͡�2���γ̵�ѧ����������
select Student.Sname
from Student, SC SC1, SC SC2
where Student.Sno = SC1.Sno and Student.Sno = SC2.Sno and SC1.Cno = 1 and SC2.Cno = 2

--9.	��ѯ����ѡ����3�ſγ̵�ѧ����������
select Student.Sname
from Student, SC
where Student.Sno = SC.Sno
group by Student.Sno, Student.Sname
having COUNT(SC.Sno)>=3

--10.	��ѯƽ���ɼ���80�����ϵ�ѧ����������
select Student.Sname
from Student, SC
where Student.Sno = SC.Sno
group by Student.Sno, Student.Sname
having AVG(SC.Grade)>=80