SELECT
    empno AS "사번",
    name AS "이름",
    birthday AS "생년월일",
    hobby AS "취미",
    pay AS "급여",
    pay*1.5 AS "성과급",
    REPLACE(emp_type, 'employee', 'family') AS "직원 분류",
    tel,
    CASE
        WHEN pay BETWEEN 35000001 AND 45000000 THEN '하'
        WHEN pay BETWEEN 45000001 AND 60000000 THEN '중'
        WHEN pay >= 60000001 THEN '상'
        ELSE '화이팅'
    END AS "급여수준"
FROM emp2
WHERE TO_CHAR(birthday, 'YY') BETWEEN '70' AND '79' AND ( SUBSTR(tel, 1, INSTR(tel, ')')-1) IN ('02','031') );
