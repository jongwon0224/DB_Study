--1번
SELECT 
    studno,
    name,
    TO_CHAR(birthday, 'YYYY-MM-DD') "BIRTHDAY"
FROM student --테이블정보 팝업은 shift + f4
WHERE TO_CHAR(birthday, 'MM') = '01';

--2번
SELECT 
    empno,
    ename,
    hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'MM') IN ('01','02','03');



