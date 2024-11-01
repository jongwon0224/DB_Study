/*

1. 조회 SELECT

※구조※
-SELECT 조회 대상 컬럼명(한줄) FROM 테이블명;
ex) 컬럼명 : DEPTNO / DNAME / LOC 임
변수명처럼 컬럼명도 잘 지어야 됨

※파일 실행은 ctrl + enter※

※ 전체설정 문법 : select * from dept;※
- * : 전체 all

※테이블 구조 확인 (Describe)※
-DESC 테이블명;

※조회 데이터 리터럴 활용!※
-select '문자', 3019 from 테이블명;

※컬럼명 별도로 지정하기(컬럼별칭) like 변수설정 느낌※
1.select 컬럼명 as "컬럼별칭" from 테이블명;
2.select컬럼명 "컬럼별칭" from 테이블명;
3.select컬럼명 컬럼별칭 from 테이블명;

*/

select * from dept; --dept테이블에 있는 모든 컬럼을 조회

select * from dept2; --dept2테이블에 있는 모든 컬럼을 조회

select * from emp; --emp 테이블에 있는 모든 컬럼을 조회

select mgr, sal from emp; --emp테이블에서 mgr과 sal을 조회

-- 가독성 SELECT 조회 대상 컬럼명(한줄)
-- FROM 테이블명;

SELECT *
FROM EMP;

SELECT
    EMPNO,
    MGR,
    JOB
FROM EMP;

DESC emp; --emp테이블의 구조를 보여달라

SELECT empno, ename, '그냥문자', 999 FROM emp;
SELECT '그냥문자', 999, q'[요'기 안'에다]'FROM emp; --문자열은 작은따옴표- + 작은따옴표 넣기

SELECT ename AS "이름",
       empno "사번",
       job 직업,
       '그냥문자' 중요한의미,
       sal "직원의 월급" --테이블명 띄어쓰기시 큰따옴표 넣어야됨
FROM emp;


/*
SELECT + 테이블명 + FROM + 데이터테이블
-엑셀 필터와 같음
-특정 테이블명 설정시 그 테이블값만 보여줌

DESC 테이블명;
-테이블 구조 확인(Describe)
-표 테두리, 표 양식, 데이터 보여줌

SELECT + DISTINCT + 테이블명 + FROM + 데이터테이블
-중복데이터뺀 머리글만 보여줌

|| 연결 연산자
SELECT '나는' || '배고프다' FROM dept;

*/
SELECT *
FROM emp;

SELECT DISTINCT job --JOB테이블 중복되는 데이터빼줌
FROM emp;

SELECT DISTINCT deptno --deptno 부서번호 중복제거 조회
FROM emp;

SELECT DISTINCT deptno, job --deptno랑 job(RAW DATA)의 중복되지 않는 값 조회
FROM emp;


※ || 연결 연산자※
SELECT '나는' || '배고프다' FROM dept;

SELECT DEPTNO || DNAME AS "부서번호 및 이름",
       DEPTNO || DNAME "부서번호 및 이름",
       DEPTNO || DNAME 부서번호및이름
FROM dept;


SELECT deptno+10,
       deptno+20,
       deptno+30
FROM dept;

SELECT deptno+deptno+deptno AS dept
FROM dept;

SELECT * FROM student;

--연습문제01
SELECT name || '''s ID : ' || id || ', WEIGHT is ' || weight || 'Kg' AS "ID AND WEIGHT"
FROM student;

--연습문제02
SELECT ename || '(' || job || ') , ' || ename || '''' || job || '''' AS "NAME AND JOB"
FROM emp;

--연습문제03
SELECT ename || '''s sal is $' || sal AS "Name and Sal"
FROM emp;


※ WHERE 조건 ※ select ~ + from ~ + where 조건
-SELECT ...
-FROM ...
-WHERE ...

SELECT * FROM emp;

SELECT *
FROM emp
WHERE comm is not null;

SELECT DISTINCT deptno
FROM emp;

--emp테이블 부서번호 20번인 사람 이름 및 급여 출력
SELECT ename, sal
FROM emp
WHERE deptno = 20;

--emp테이블 급여 2000보다 적게 받고 상여가 0이 아닌 사람 목록
SELECT *
FROM emp
WHERE sal < 2000 AND comm != 0;

--emp테이블 직업이 clerk인사람
SELECT *
FROM emp
WHERE job = 'CLERK';

--emp테이블 직업이 clerk이 아닌 사람
SELECT *
FROM emp
WHERE job <> 'CLERK';

--emp테이블 급여가 2000~3000인 사람 조회
SELECT *
FROM emp
WHERE sal Between 2000 AND 3000;

--student 테이블에서 1학년과 3학년만 조회
--IN은 or 대신 사용 ~ IN(1,3) = 1아니면 3
SELECT *
FROM student
WHERE grade IN(1,3);

--student 테이블에서 1학년과 3학년만 제외하고 조회
SELECT *
FROM student
WHERE grade NOT IN(1,3);

-- 날짜 비교-- '문자열'로 취급 or '년도-월-일' 식으로 표현
SELECT *
FROM emp
WHERE hiredate < '81/05/01';

SELECT birthday
FROM student;


---LIKE 패턴 검색
-구조 : Like % _
1. % : 아무거나 아무갯수 0~n개
2. _ : 그 위치에 한개

SELECT *
FROM emp
WHERE ename LIKE 'MI%'; -- '~%' MI~ 담긴 데이터만 출력 => %위치에 따라 다름
--WHERE ename LIKE '%MI%'; -- '~%' ~MI or MI~가 담긴 데이터 출력

SELECT *
FROM emp
WHERE ename LIKE '_MI'; -- 3글자인데 첫글자 랜덤 + 2~3번째 글자는 MI
WHERE ename LIKE '_MI__'; -- 5글자인데 첫글자 랜덤 + 2~3번째 글자는 MI
WHERE ename LIKE '_MI%'; -- 글자수 상관없음 + 2~3번째 글자는 MI

/*
※정렬 ORDER BY※
-정렬을 사용하지 않으면 순서 보장 X 
-ORDER By => 정렬할 기준이되는 컬럼명 [ASC|DESC] [오름차순|내림차순]
*/

SELECT ...
FROM ...
WHERE ...
ORDER BY ...
;

SELECT *
FROM student
--WHERE height BETWEEN 160 AND 180
ORDER BY name; --오름차순
--ORDER BY name DESC; DESC 내림차순

SELECT *
FROM emp
ORDER BY grade;

SELECT *
FROM student
WHERE grade IN(1,2,3) -- 1,2,3학년 조회
ORDER BY grade, height DESC; -- 학년 오름차순 후 키순 정렬

--집합연산자--
-UNION 합집합 (중복제거) --다른 쿼리끼리 합칠수있음
-UNION ALL 합집합 (중복제거x)
-INTERSECT 교집합
-MINUS 차집합


--학생들 중에 101번학과 학생들과 102번 학과 학생들 조회
-- 두 집합의 컬럼의 개수 및 데이터형이 동일해야됨
/*
SELECT *    ==> 오류출력
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT *
FROM student
WHERE deptno1 = 102;
*/
--각 테이블 조회 결과 개수/타입이 일치하는 형태로 만들어서 결합 ex) 숫자/문자/숫자 -> 3개
SELECT studno, name, deptno1, 2 AS "구분"
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno, 1 AS "구분"
FROM professor
WHERE deptno = 101;

-------student 데이터 컬럼없는 부분 임의로 null추가----------

SELECT studno idno,
       name,
       deptno1 "deptno",
       null AS "email"
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno,
       name,
       deptno,
       email
FROM professor
WHERE deptno = 101;

---------- null값 추가할때 숫자로 추가해주는게 좋음 ex) 1, 2 -------------

SELECT studno idno, name, deptno1 "deptno", 1 AS "status"
FROM student
WHERE deptno1 = 101
UNION ALL
SELECT profno, name, deptno, 2 AS "status"
FROM professor
WHERE deptno = 101;

------------  교집합 사용  ---------------------
SELECT *
FROM student
WHERE deptno1 = 101
INTERSECT
SELECT *
FROM student
WHERE deptno2 = 201;
--------------  교집합 대신 and구문 사용  -------------------
SELECT *
FROM student
WHERE deptno1 = 101 AND deptno2 = 201;


SELECT empno, ename, sal
FROM emp
MINUS
SELECT empno, ename, sal
FROM emp
WHERE sal > 2500;

-------ex) 성과 받을 직원 목록에서 이미 받은 직원의 차집합 --------
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND comm > 400
MINUS
SELECT *
FROM emp
WHERE hiredate < '1981-01-01';


