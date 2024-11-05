SELECT 
    name,
    jumin,
    birthday,
    CASE 
        WHEN TO_CHAR(birthday, 'MM') BETWEEN 1 AND 3 THEN '1분기'
        WHEN TO_CHAR(birthday, 'MM') BETWEEN 4 AND 6 THEN '2분기'
        WHEN TO_CHAR(birthday, 'MM') BETWEEN 7 AND 9 THEN '3분기'
        ELSE '4분기'
    END AS "분기"
FROM student;

SELECT
    empno,
    ename,
    sal,
    CASE
        WHEN sal < 1001 THEN 'Level 1'
        WHEN sal < 2001 THEN 'Level 2'
        WHEN sal < 3001 THEN 'Level 3'
        WHEN sal < 4001 THEN 'Level 4'
        WHEN sal > 4000 THEN 'Level 5'
    END AS "LEVEL(급여등급)"
FROM emp;