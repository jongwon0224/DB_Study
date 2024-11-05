--1
SELECT AVG(sal) "전체 평균급여"
FROM emp;

--2
SELECT AVG(sal) "30번 부서 평균급여"
FROM emp
WHERE deptno = 30;


--3
SELECT deptno, AVG(sal) "각 부서별 평균급여"
FROM emp
GROUP BY deptno
ORDER BY deptno;

--4
SELECT deptno, count(*) "각 부서별 인원", AVG(sal) "각 부서별 평균급여"
FROM emp
GROUP BY deptno
ORDER BY deptno;

--5
SELECT job, AVG(sal) "각 직업별 평균급여"
FROM emp
GROUP BY job;

--6
SELECT job, MAX(sal) "각 직업별 높은 급여"
FROM emp
GROUP BY job;

--7
SELECT deptno, MAX(sal) "각 부서별 높은 급여"
FROM emp
GROUP BY deptno
ORDER BY deptno;