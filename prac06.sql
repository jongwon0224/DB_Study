SELECT
    profno,
    name,
    pay,
    NVL(bonus, '0') "BONUS",
    TO_CHAR( pay*12+NVL(bonus, 0), '999,999') "TOTAL"
FROM professor
WHERE deptno = 201;