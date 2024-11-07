--1
SELECT
    deptno AS "부서번호",
    AVG(sal) AS "평균급여"
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

--2
SELECT 
    p_date AS "판매일자",
    SUM(p_qty) AS "판매수량",
    SUM(p_total) AS "판매금액"
FROM panmae
GROUP BY p_date
ORDER BY p_date;

--3
SELECT p_date 판매일자, p_code 상품코드, SUM(p_qty) 판매수량, SUM(p_total) 판매금액
FROM panmae
GROUP BY ROLLUP(p_date, p_code);




