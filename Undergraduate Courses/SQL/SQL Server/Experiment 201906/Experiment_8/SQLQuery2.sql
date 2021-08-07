--1�������ݿ�ԭ��ʵ���塪��ѧ��ѡ�ο��У���Transact-SQL���ʵ�����м����ݲ�ѯ������
--1)	��ѯѡ���˼������ϵ�ṹ��ѧ���Ļ�����Ϣ��
select S.Snum, S.Sname, S.Sage, S.Sex, S.Sphone, S.Dnum
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and C.Cname = '�������ϵ�ṹ'

--2)	��ѯ���������С��ѧ����ѧ�źͳɼ���
select DISTINCT SC.Snum, SC.Sroce
from S, SC
where S.Snum = SC.Snum and S.Sage < (
	select S.Sage
	from S
	where S.Sname = '����'
)
group by SC.Snum, SC.Sroce

--3)	��ѯ����ϵ�б�ϵ���Ϊ��D1����ѧ����������С��Ҫ���ѧ������Ϣ��
select S.Snum, S.Sname, S.Sage, S.Sex, S.Sphone, S.Dnum
from S
where S.Dnum != 'D1' and S.Sage > (
	select MIN(S.Sage)
	from S
	where S.Dnum = 'D1'
)

--4)	��ѯ����ϵ�б�ϵ���Ϊ��D3����ѧ�����䶼���ѧ����������
select S.Sname
from S
where S.Dnum != 'D3' and S.Sage > (
	select MAX(S.Sage)
	from S
	where S.Dnum = 'D3'
)

--5)	��ѯ��C1���γ̵ĳɼ�����70��ѧ��������
select S.Sname
from S, SC
where S.Snum = SC.Snum and SC.Cnum = 'C1' and SC.Sroce >= 70

--6)	��ѯ��C1���γ̵ĳɼ�������70��ѧ��������
select S.Sname
from S, SC
where S.Snum = SC.Snum and SC.Cnum = 'C1' and SC.Sroce <= 70


--7)	��ѯû��ѡ�޵�ѧ��������
select DISTINCT S.Sname
from S
where S.Snum not in (
	select SC.Snum
	from SC
)

--8)	��ѯѧУ����Ŀγ�������
select COUNT(Cnum) '����γ�����'
from C

--9)	��ѯѡ�����ż��������Ͽγ̵�ѧ��������
select S.Sname
from S, SC
where S.Snum = SC.Snum
group by S.Sname
having COUNT(SC.Snum) >= 2

--10)	��ѯ����Ŀγ̺�ѡ�޸ÿγ̵�ѧ�����ܳɼ���ƽ���ɼ�����߳ɼ�����ͳɼ���
select SC.Cnum, SUM(SC.Sroce) '�ܳɼ�', AVG(SC.Sroce) 'ƽ���ɼ�', MAX(SC.Sroce) '��߳ɼ�', MIN(SC.Sroce) '��ͳɼ�'
from SC
group by Cnum

--11)	��ѯ�ԡ�DB����ͷ,�ҵ�����3���ַ�Ϊ��s���Ŀγ̵���ϸ�����
select *
from C
where C.Cname like 'DB\_%s__'

--12)	��ѯ�����е�2����Ϊ��������ѧ��������ѧ�ż�ѡ�޵Ŀγ̺š��γ�����
select S.Sname, S.Snum, C.Cnum, C.Cname
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and S.Sname like '_��%'

--13)	�г�ѡ���ˡ���ѧ�����ߡ���ѧӢ���ѧ��ѧ�š�����������Ժϵ��ѡ�޿γ̺ż��ɼ���
select S.Snum, S.Sname, S.Dnum, SC.Cnum , SC.Sroce
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and SC.Snum in (
	select SC.Snum
	from C, SC
	where C.Cnum = SC.Cnum and C.Cname = '��ѧ' and C.Cname = '��ѧӢ��'
	group by SC.Snum
)
select S.Snum, S.Sname, S.Dnum, SC.Cnum , SC.Sroce
from S, SC
where S.Snum = SC.Snum and SC.Cnum in (
	select C.Cnum
	from C
	where  C.Cname = '��ѧ' or C.Cname = '��ѧӢ��' 
)

--14)	��ѯȱ�ٳɼ�������ѧ������ϸ�����
select *
from S
where S.Snum not in (
	select SC.Snum
	from SC
)

--15)	��ѯ�롮������(��������Ψһ)���䲻ͬ������ѧ������Ϣ��
select *
from S
where S.Sage != (
	select S.Sage
	from S
	where S.Sname like '����'
)

--16)	��ѯ��ѡ�γ̵�ƽ���ɼ�����������ƽ���ɼ���ѧ��ѧ�š�������ƽ���ɼ���
select SC.Snum, S.Sname, AVG(SC.Sroce) 'ƽ���ɼ�'
from S, SC
where S.Snum = SC.Snum
group by SC.Snum, S.Sname
having AVG(SC.Sroce) > (
	select AVG(SC.Sroce)
	from S, SC
	where S.Snum = SC.Snum and S.Sname like '����'
	group by SC.Snum, S.Sname
)

--17)	�г�ֻѡ��һ�ſγ̵�ѧ����ѧ�š�������Ժϵ���ɼ���
select S.Snum, S.Sname, S.Dnum, SUM(SC.Sroce) '�ɼ�'
from S, SC
where S.Snum = SC.Snum
group by S.Snum, S.Sname, S.Dnum
having COUNT(SC.Cnum) = 1

--18)	��ѯѡ�ޡ����ݿ⡱�����ݽṹ���γ̵�ѧ���Ļ�����Ϣ��
select S.Snum, S.Sname, S.Sage, S.Sex, S.Sphone, S.Dnum
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and C.Cname in ('���ݿ�','���ݽṹ')

select *
from S
where S.Snum in (
	select SC.Snum
	from SC
	where SC.Cnum in (
		select C.Cnum
		from C
		where C.Cname in ('���ݿ�', '���ݽṹ')
	)
)

--19)	�г����б�ѡ�޿γ̵���ϸ����������γ̺š��γ�����ѧ�š��������ɼ���
select SC.Cnum, C.Cname, S.Snum, S.Sname, SC.Sroce
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and C.Cnum in (
	select C.Cnum
	from C, SC
	where SC.Cnum is not NULL
)

--20)	��ѯֻ��һ��ѧ��ѡ�޵Ŀγ̵Ŀγ̺š��γ�����
select SC.Cnum, C.Cname
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and SC.Snum in (
	select SC.Snum
	from S, SC
	where S.Snum = SC.Snum
	group by SC.Snum
	having COUNT(SC.Cnum) = 1
)

--21)	ʹ��Ƕ�ײ�ѯ�г�ѡ���ˡ����ݽṹ���γ̵�ѧ��ѧ�ź�������
select S.Snum, S.Sname
from S, C, SC
where S.Snum = SC.Snum and C.Cnum = SC.Cnum and C.Cname = '���ݽṹ'

--22)	�г��롮��������һ��Ժϵ��ѧ������Ϣ��
select * 
from S
where S.Dnum in (
	select S.Dnum
	from S
	where S.Sname = '����'
)

--23)	ʹ�ü��ϲ�ѯ�г�CSϵ��ѧ���Լ��Ա�ΪŮ��ѧ��������
select * 
from S
where S.Dnum = 'CS' or S.Sex = 'Ů'