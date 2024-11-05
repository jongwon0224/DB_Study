SELECT 
    empno,
    ename,
    comm,
    sal,
    NVL2(comm, 'Exist', 'NULL') "NVL2",
    sal*12 + NVL2(comm, comm, 0) "TOTAL1", --NVL2로 총합 구하기 1
    NVL2(comm, sal*12+comm, sal*12) "TOTAL2" --NVL2로 총합 구하기 2
FROM emp
WHERE deptno = 30;


