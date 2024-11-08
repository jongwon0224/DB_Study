--sub query

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
                            
--사번이 7844인 사원과 같은 부서 사람들 조회

-- IN :  서브쿼리 결과와 같은 값을 찾음
-- EXISTS : 서브쿼리 결과중 값이 있을때 true, false수행
-- >ANY : 서브쿼리 결과중 한개 값보다 작아도됨.. 최솟값 반환
-- <ANY : 서브쿼리 결과중 한개 값보다 작아도됨.. 최댓값 반환
-- <ALL : 서브쿼리 결과중 모든 값 보다 작아야됨.. 최솟값을 반환
-- >ALL : 서브쿼리 결과중 모든 값 보다 작아야됨.. 최댓값을 반환
-- any == or / all == and 같은 느낌 (하나만 / 전체)

-- IN 사용 (deptno와 dept2의 값은 동일한데 테이블이 다르기 때문에  in사용)
select *
from emp2
where deptno in (select dcode from dept2 where area = 'Pohang Main Office');

select deptno from emp2;
select * from dept2;
-- & + 컬럼명 = 스캐너처럼 입력값 받아서 출력
-- : + 컬럼명 = 입력값받아서 저장해놓음
select *
from emp2
where deptno = &dno;


-- 동일문제 EXISTS 사용
select *
from emp2
where EXISTS (select dcode from dept2 where area = 'Pohang Main Office' and dcode = deptno);

-- 동일문제 IN 사용
select *
from emp2
where deptno IN (select dcode from dept2 where area = 'Pohang Main Office');

--1번
SELECT
    name,
    position,
    pay
FROM emp2
WHERE pay > (SELECT MIN(pay) 
                           FROM emp2
                           WHERE position = 'Section head');

--2번
SELECT
    name,
    grade,
    weight
FROM student
WHERE weight <all (SELECT  weight -- < all + weight 써도되고 min(weight)사용가능
                                  FROM student
                                  WHERE grade = 2);

--3번
select d.dname, e.name, e.pay
from emp2 e, dept2 d 
where e.pay < all (select avg(pay)
                        from emp2
                        group by deptno)
and e.deptno = d.dcode;


-- 다중 컬럼 sub query
--where + (비교 조건 복수개) in (서브쿼리에도 동일 컬럼 2개 들어가야됨)
select *
from student
where (grade, weight) in (select grade, max(weight) from student group by grade);

--다중 컬럼 연습문제 1
select p.profno, p.name, p.hiredate, d.dname
from professor p, department d
where p.deptno = d.deptno
and (p.deptno, p.hiredate) in (select deptno, min(hiredate)
                                                  from professor
                                                  group by deptno)
order by p.hiredate;

--다중 컬럼 연습문제 2
select
    name,
    position,
    TO_CHAR(pay, '$999,999,999') pay
from emp2
where (position, pay) in (select position,max(pay)
                                            from emp2
                                            group by position)
order by pay;


--  상호연관 sub query
-- 메인쿼리 : emp2 테이블에서 pay가 서브쿼리 값보다 크거나 같을때 출력
--서브쿼리 : a.position 1개값과 b.position n개의 b.pay평균값 출력 
-- ex) a.position = department head일 경우 -> b.position의 department head인 데이터 총 n개 출력후 평균값 구함
select *
from emp2 a
where a.pay >= (select avg(b.pay)
                            from emp2 b
                            where b.position = a.position);

--join 이나 subquery로 해결가능
--join 사용
select e.name, d.dname
from emp2 e, dept2 d
where e.deptno = d.dcode;

--스칼라 sub query 사용 (select부분에 사용)
select 
            name, 
            (select dname --dept2테이블에서 emp2 decode컬럼과 dept2의 deptno값이 같은 데이터의 dname출력(부서명)
             from dept2
             where dcode = deptno)
from emp2;


--inline view (from에 서브쿼리 넣을 경우)
--서브쿼리 컬럼명 주의 필요 (아래와 같은 상황에서는 변수명 재설정)
select deptno, avg_pay
from (select deptno, avg(pay) avg_pay --avg(pay)를 컬럼명 그대로 사용시 맨위 select에서 avg(pay)를 못부름-> 평균값 구하라고 인식해서 오류남 -> 별도의 컬럼명 필요
            from emp2
            group by deptno)
where avg_pay > 30000000
;


select deptno, max(sal)
from emp
group by deptno
;

-- inline view 사용해서 다른 테이블과 join가능
-- inline view 내에 group by 사용
select e.deptno, e.max_sal, d.dname
from (select deptno, max(sal) max_sal from emp group by deptno) e, dept d
where e.deptno = d.deptno;

-- inline view 밖에 group by 사용
select deptno, max(sal), dname
from (select e.sal, e.deptno, d.dname
            from emp e, dept d
            where e.deptno = d.deptno)
group  by deptno, dname;

--1.student, department 테이블 활용
학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.

select * from student;
select * from department;

select s.deptno1, d.dname, s.name, s.height 
from student s, department d
where s.deptno1 = d.deptno
;

select d.dname, s.name, height
from (select s.deptno1, s.height, s.name from student s, department d where s.deptno1 = d.deptno) s, department d
where s.deptno1 = d.deptno

;

select deptno1, max(height)
from student
group by deptno1
;
--1 다중컬럼 비교 & JOIN 사용
select d.dname, s.height MAX_HEIGHT, s.name, s.height
from student s, department d
where (s.deptno1, s.height) in (select deptno1, max(height) from student group by deptno1)
and s.deptno1 = d.deptno;


--2 서브쿼리 (스칼라 서브쿼리)
select (select dname from department where deptno = deptno1) DEPTNO, height MAX_HEIGHT, name, height
from student
where (deptno1, height) in (select deptno1, max(height) from student group by deptno1);


select (select dname from department where deptno = deptno1), height, name, height
from student
where height in (select max(height) from student group by deptno1);



--3 IN LINE VIEW
select (select dname from department where deptno = s.deptno1), t.max_height, s.name, s.height
from (select deptno1, max(height) max_height from student group by deptno1) t, student s
where t.deptno1 = s.deptno1 and t.max_height = s.height;;


--2-1
select s1.grade, s2.name, s2.height, s1.avg_height
from (select grade, avg(height) avg_height from student group by grade) s1, student s2
where s1.avg_height < s2.height
and s1.grade = s2.grade
order by s2.grade, s2.height;






