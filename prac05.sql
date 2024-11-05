SELECT 
    empno,
    ename,
    TO_CHAR(hiredate, 'YYYY-MM-DD') "HIREDATE",
    TO_CHAR((sal*12)+comm, '$999,999') "SAL",
    TO_CHAR(((sal*12)+comm)*1.15, '$999,999') "15%인상"
FROM emp
WHERE comm IS NOT NULL;