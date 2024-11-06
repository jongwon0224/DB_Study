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


--having절 : group by절에서 그룹데이터 조건 뽑을때 사용 / where사용시 데이터 추출 오류
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;

--where 사용 예시
--급여가 1500이상인 직원만 대상으로, 부서별 평균 급여
select deptno, avg(sal)
from emp
where sal >= 1500
group by deptno;

--having 사용 예시
--부서별 평균급여가 1500이상인 경우만, 부서별 평균급여 보여주기
select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 1500;


--각 학년별 평균 몸무게, 평균몸무게 65이상인 경우만 출력
select grade, avg(weight)
from student
group by grade
having avg(weight) >= 65;

--4학년 제외 및 각 학년별 평균 몸무게, 평균몸무게 65이상인 경우만 출력
select grade, avg(weight)
from student
where grade <> 4
group by grade
having avg(weight) >= 65;


select deptno, job, round(avg(sal),1)
from emp
group by rollup (deptno, job);
--1) deptno, job 그룹화
--2) deptno 그룹화 계
--3) () 그룹화 계

select deptno, job, round(avg(sal),1)
from emp
group by rollup ( (deptno, job) );
--1) (deptno, job) 그룹화
--2) () 그룹화 계



-- rank() over (order by ~~)
-- dense_rank() over(order by ~~)
select
    deptno,
    ename,
    sal,
    rank() over(order by sal desc) Rank,
    dense_rank() over (order by sal desc) denseRank --공동 등수 있어도 바로 다음값 출력
from emp;

-- 그룹단위 순위 rank() over (partition by 기준 order by 정렬기준)
-- partition == group by같은느낌
select
    name,
    height,
    rank() over(order by height desc) Rank,
    dense_rank() over(order by height desc) denseRank,
    grade,
    rank() over(partition by grade order by height desc) partitionBy1,
    dense_rank() over(partition by grade order by height desc) partitionBy2
from student
order by grade, height desc;

