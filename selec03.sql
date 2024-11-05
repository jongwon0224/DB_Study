-- 복수행 함수
-- 행의 데이터 개수를 세줌

--COUNT(대상, 갯수)
-- null값은 count안함
select count(empno), count(ename), count(hiredate), count(comm), count(mgr)
from emp;


--sum(대상)
select sum(sal), count(*), sum(comm)
from emp;


--10번, 20번 부서 직원 수 및 총 급여 합계
select count(*), sum(sal)
from emp
where deptno in (10,20);

--avg:평균, max:최대, min:최소, stddev:표준편차, variance:분산값
select
    avg(height),
    max(height),
    min(height),
    stddev(height),
    variance(height)
from student;



--student평균키 -> 그룹별 평균키
select
    '1학년' 학년,
    avg(height) 평균키
from student
where grade = 1
union all
select
    '2학년',
    avg(height)
from student
where grade = 2
union all
select
    '3학년',
    avg(height)
from student
where grade = 3
union all
select
    '4학년',
    avg(height)
from student
where grade = 4;

-- group by 사용하기
-- group by + 대상 테이블 // 조건 같이 조회 가능 (그룹 지을 수 있는 경우에만 가능)
select grade, avg(height)
from student
group by grade
order by grade;


select grade, avg(height) height
from student
where grade in (1,2,3)
group by grade
order by height;







