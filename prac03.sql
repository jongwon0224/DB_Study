--1,
SELECT 
    ename,
    REPLACE(ename, SUBSTR(ename,3,2), '--') "REPLACE"
FROM emp
WHERE deptno = 20;

--2,
SELECT
    name,
    REPLACE(jumin, SUBSTR(jumin,7,7), '-/-/-/-') "주민뒷자리숨김"
    FROM student
WHERE deptno1 = 101;

--3,
SELECT 
    name,
    tel,
    REPLACE(tel, SUBSTR(tel,5,3), '***') "REPLACE"
FROM student
WHERE deptno1 = 102;

--4.
SELECT 
    name,
    tel,
    REPLACE(tel, SUBSTR(tel,-4,4), '****') "REPLACE"
FROM student
WHERE deptno1 = 101;

--응용문제 중요--
SELECT
    name,
    tel,
    SUBSTR(tel, 1, INSTR(tel, ')')) || LPAD('*', INSTR(tel, '-') - INSTR(tel, ')')-1, '*') || SUBSTR(tel, -5, 5) "가운데 숫자 별",
    INSTR(tel, '-') - INSTR(tel, ')') - 1 "가운데 자리 개수"
FROM student
WHERE deptno1 = 101;
