select * from tb_car
insert into car1 values(null,'宝马',SYSDATE());

/*delete 和 truncate的区别*/
/*可以跟where条件的*/
/*truncate 是不可以的是删除所有的数据*/
delete from car1 where CAR_ID=1

truncate table car1 where CAR_ID=1

/*in、not in、=、!=、exists、not exists等。*/

/*求出和宝马的服务项不同的车型有哪些*/

select CAR_SERVICE from tb_car where CAR_NAME='宝马'

select * from tb_car where CAR_SERVICE not in (select CAR_SERVICE from tb_car where CAR_NAME='宝马')

select *  from   tb_car1

drop table  tb_car1

/*不仅复制表的结构，也复制表的数据*/
create table tb_car1 as select *  from   tb_car where 1=2
/*合并数据必须表结构一致*/
/*去掉重复的*/
select * from tb_car union select * from tb_car1

/*不去掉重复的*/
select * from tb_car union all select * from tb_car1

/*人力资源记录公司的人员*/
/*employee  trigger  employee1*/

/*经理级别*/
/*拼成订单标题*/

/*横着拼*/
SELECT CAR_ID,CAR_NAME,CAR_PRICE,GROUP_CONCAT('汽车ID',CAR_ID,CAR_NAME,CAR_PRICE) as INFO FROM tb_car where CAR_ID=1

select * from tb_car
/*四舍五入*/

/* STR_TO_DATE('1992-04-12',"%Y-%m-%d") */
update tb_car set ORDER_TIME=SYSDATE() where CAR_ID=1
/*SELECT STR_TO_DATE('2016-01-02', '%Y-%m-%d %H');*/
update tb_car set ORDER_TIME=STR_TO_DATE('1992-04-12 12:12:08',"%Y-%m-%d %H") where CAR_ID=1

update tb_car set ORDER_TIME='1992-04-12 12:12:08' where CAR_ID=1

insert into tb_car values (null,'迈凯伦',SYSDATE(),480,340,'维修','1992-04-12 12:12:08')

insert into tb_car values (null,'GTR',SYSDATE(),450,320,'维修','1993-06-12 09:11:08')

update tb_car set PRICE=268 where CAR_ID between 2 and 6

/*日期类型，需要掌握的，单独取年，单独取月，单独取日，区间取值*/

/*查出1992年下单的车型有哪些*/(至少有两种)
select year(ORDER_TIME) from tb_car

select * from tb_car where year(ORDER_TIME)=1992

 select date_format(now(), '%Y%m%d %h:%i:%s');
/*做固定的值通用方法(不适用于区间)*/

select date_format(ORDER_TIME, '%Y%m%d %h:%i:%s') from tb_car

select date_format(ORDER_TIME, '%Y') from tb_car

select date_format(ORDER_TIME, '%Y-%m') from tb_car

/*
left(str, length)，即：left(被截取字符串， 截取长度)：
substring(str, pos)，即：substring(被截取字符串， 从第几位开始截取)
substring(str, pos, length)，即：substring(被截取字符串，从第几位开始截取，截取长度)
*/

 select date_format(now(), '%Y%m%d %h:%i:%s') from tb_car;

select left(date_format(now(), '%Y%m%d %h:%i:%s'), 6) from tb_car
/*日期转换为字符串*/

select * from tb_car where left(date_format(ORDER_TIME, '%Y%m%d %h:%i:%s'), 6)='199204'

select * from tb_car where left(date_format(ORDER_TIME, '%Y%m%d %h:%i:%s'), 4)='1992'







/*查出1992年4月份的车型有哪些*/



/*查出1992年到1993的车型有哪些*/
select year(ORDER_TIME) from tb_car
select * from tb_car where year(ORDER_TIME)>=1992 and year(ORDER_TIME)<=1993


select * from tb_car where year(ORDER_TIME) between 1992 and 1993

/*区间*/



/*查出1992年4月份到1993年6月份的车型有哪些*/

/*超过了27年的订单有哪些*/

/*超过了9855天的订单有哪些*/

/*思考题   求出在每个月的最后一天下的订单有哪些*/






ALTER TABLE  tb_car  add PRICE  DECIMAL(4,1)  AFTER CAR_PRICE;

/*去掉精度之后是取整数部分，同样也是四舍五入*/
ALTER TABLE  tb_car  MODIFY PRICE  DECIMAL  AFTER CAR_PRICE;

dec(3,2)

3.32   5.566   12.45  12.6

字符个数是3位，1表示的是小数点后面保留的位数








