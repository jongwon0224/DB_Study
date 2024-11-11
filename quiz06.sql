--서브쿼리 활용
select
    empno,
    name,
    deptno,
    (select dname from dept2 where dcode = deptno) dname,
    (select area from dept2 where dcode = deptno) area,
    pay
from emp2
where pay > (select avg(pay)
                        from emp2
                        where deptno in (select dcode
                                                        from dept2
                                                        where area = (select area
                                                                                from dept2
                                                                                where dcode = (select deptno 
                                                                                                            from emp2 
                                                                                                            where name = 'AL Pacino'))));

--join활용
select
    e.empno,
    e.name,
    e.deptno,
    d.dname,
    d.area,
    e.pay
from emp2 e, dept2 d
where pay > (select avg(pay)
                        from emp2
                        where deptno in (select dcode
                                                        from dept2
                                                        where area = (select area
                                                                                from dept2
                                                                                where dcode = (select deptno 
                                                                                                            from emp2 
                                                                                                            where name = 'AL Pacino'))))
and e.deptno = d.dcode;