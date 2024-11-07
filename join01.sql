--join 01 
-- 서로 다른 데이터의 동일값을  합쳐줌

--ORACLE JOIN 문법
--컬럼명이 동일시 '변수.컬럼명'으로 출력해야됨
SELECT e.empno, e.ename, d.dname, d.loc, d.deptno 
FROM emp e, dept d -- table 변수명 설정
where e.deptno = d.deptno; --table명 + '.' + 가져올 테이블명 

--ANSI JOIN 문법
SELECT e.empno, e.ename, d.dname, d.loc, d.deptno 
FROM emp e INNER JOIN dept d -- 콤마 대신 inner join 입력
ON e.deptno = d.deptno; --where 대신 on 입력

--카티션 곱 : 추가 조건없이 그냥 생으로 데이터 join한 값
SELECT *
FROM emp e, dept d
ORDER BY e.deptno;

--ORACLE JOIN
SELECT  *
FROM student s, professor p
WHERE s.profno = p.profno
ORDER BY s.profno;


--INNER JOIN : 데이터가 있는것만 가져옴

--ORACLE JOIN
SELECT  *
FROM student s, professor p
WHERE s.profno = p.profno;

--ANSI JOIN
SELECT  *
FROM student s INNER JOIN professor p
ON s.profno = p.profno;

--OUTER JOIN : 데이터가 없어도 null값으로 데이터 가져옴

--ORACLE JOIN
SELECT  *
FROM student s, professor p
WHERE s.profno = p.profno (+);

--ANSI JOIN
SELECT  *
FROM student s LEFT OUTER JOIN professor p
ON s.profno = p.profno;


SELECT
    s.deptno1,
    s.name AS "학생이름",
    d.dname AS "학과이름",
    p.name AS "교수이름"
FROM
    student s, professor p, department d
WHERE
    p.deptno= d.deptno AND s.profno = p.profno;

select
    s.name,
    s.deptno1,
    d.dname,
    s.profno,
    p.profno,
    p.name,
    p.deptno,
    d2.dname
from
student s INNER JOIN professor p ON s.profno = p.profno
INNER JOIN department d ON s.deptno1 = d.deptno
INNER JOIN department d2 ON p.deptno = d2.deptno;

select c.gname, g.gname
from customer c INNER JOIN gift g;

SELECT c.gname, c.point, g.gname
FROM customer c INNER JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end;

--JOIN 연습문제
-- 1번
SELECT
    stu.studno AS "학번",
    stu.name AS "이름",
    sco.total AS "점수",
    h.grade AS "학점"
FROM student stu, score sco, hakjum h
WHERE stu.studno = sco.studno AND  sco.total BETWEEN h.min_point AND h.max_point
ORDER BY sco.total DESC;

-- 2번
SELECT
    stu.studno AS "학번",
    stu.name AS "이름",
    sco.total AS "점수",
    h.grade AS "학점"
FROM
    student stu,
    score sco,
    hakjum h
WHERE
    stu.studno = sco.studno
    AND sco.total BETWEEN h.min_point AND h.max_point
    AND stu.deptno1 IN (101,102)
ORDER BY sco.total DESC;

-- 3번
SELECT
    stu.name,
    stu.grade,
    prof.name,
    prof.deptno,
    dep.dname
FROM student stu, department dep, professor prof
WHERE stu.profno = prof.profno
    AND prof.deptno <> 301
    AND prof.deptno = dep.deptno
ORDER BY grade DESC;

--inner join
select *
from student s, professor p
where s.profno = p.profno;

--outer join -> 학생기준 지도교수 없어도 출력
select *
from student s, professor p
where s.profno = p.profno(+);

--outer join -> 교수 기준 학생없어도 출력
select *
from student s, professor p
where s.profno(+) = p.profno;

select *
from student s, professor p
where s.profno = p.profno(+)
union
select *
from student s, professor p
where s.profno(+) = p.profno;

--같은 테이블 반복 사용으로 직원의 상사 구하기
select e1.empno, e1.ename, e1.mgr, e1.job, e2.empno, e2.ename, e2.job
from emp e1, emp e2
where e1.mgr = e2.empno;

select *
from emp;

--3번 2010-05-30일 기준
--1번
SELECT s.name AS "STU_NAME", s.deptno1, d.dname AS "DEPT_NAME"
FROM student s, department d
WHERE deptno1 = deptno
ORDER BY deptno1;

--2번
SELECT
    e.name,
    e.position,
    TO_CHAR( e.pay, '999,999,999') AS "PAY",
    TO_CHAR( DECODE(e.position, p.position, p.s_pay), '999,999,999') AS "LOW PAY",
    TO_CHAR( DECODE(e.position, p.position, p.e_pay), '999,999,999') AS "HIGHT PAY"    
FROM emp2 e, p_grade p
WHERE e.position IS NOT NULL AND e.position = p.position(+)
ORDER BY p.s_pay;

--3번
SELECT 
    e.name,
    SUBSTR('2010-05-30', 1, 4) - TO_CHAR(e.birthday, 'YYYY') +1 AS "한국나이",
    e.position AS "지금포지션",
    p.position AS "지금나이에맞는포지션"
FROM emp2 e, p_grade p
WHERE  SUBSTR('2010-05-30', 1, 4) - TO_CHAR(e.birthday, 'YYYY') +1 BETWEEN p.s_age AND p.e_age;

--4번
SELECT c.gname, c.point, g.gname
FROM customer c, gift g
WHERE c.point > g.g_start  AND g.gno = 7;

--5번
select profno, name, hiredate, rank() over (order by TO_CHAR(p1.hiredate, 'YYYY') )-1 "자신보다 입사일 빠른사람"
from professor p1
ORDER BY hiredate;


-- where에 조건
-- group by에는 그룹화하고 싶은 컬럼명
-- select는 where조건에 맞는 개수 출력나옴..
select p1.profno, p1.name, p1.hiredate, count(p2.profno)
from professor p1, professor p2
where p1.hiredate > p2.hiredate (+)
group by p1.profno, p1.name, p1.hiredate
order by p1.hiredate;

-- 6번
select e1.empno, e1.ename, e1.hiredate, count(e2.empno)
from emp e1, emp e2
where e1.hiredate > e2.hiredate (+)
group by e1.empno, e1.ename, e1.hiredate
order by e1.hiredate;

--모르겠으면 위에 코드 세미콜론 하나씩 내려가면서 다시볼것.. 이해 조금 간다..
