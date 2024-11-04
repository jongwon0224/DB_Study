--SUBSTR, INSTR을 활용한 연습문제

--1번 문제
SELECT name AS "이름",
       SUBSTR(birthday,1,2) AS "년도",
       SUBSTR(birthday,4,2) AS "월",
       SUBSTR(birthday,7,2) AS "일"
FROM student;

--2번 문제
SELECT name,
       tel,
       INSTR(tel, ')') AS "괄호위치"
FROM student
WHERE deptno1 = 201;

--3번 문제
SELECT name,
       tel,
       INSTR(tel, '3') AS "3출력 위치"
FROM student
WHERE deptno1 = 101;

--4번 문제
SELECT name,
       tel,
       SUBSTR(tel, 1, INSTR(tel, ')')-1) AS "지역번호"
FROM student
WHERE deptno1 = 201;


