--sub query

select *
from student;

select *
from department;
--sub query 연습문제
select s.name, s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno
AND s.deptno1 =  (select  deptno1
                                 from student
                                 where name = 'Anthony Hopkins');
                                 
--1번 문제                
select p1.name, p1.hiredate, d1.dname
from professor p1, department d1
where p1.deptno = d1.deptno
and p1.hiredate > (select hiredate
                                from professor
                                where name = 'Meg Ryan')
 order by hiredate;


--2번 문제
select name, weight
from student
where weight > (select avg(weight)
                            from student
                            where deptno1 = 201);

