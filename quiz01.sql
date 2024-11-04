--컬럼명 짓기 연습문제 01
SELECT deptno AS "부서번호",
       dname AS "부서이름",
       loc AS "위치"
FROM dept;

--컬럼명 짓기 연습문제 01
SELECT name || '(' || ID || ')' AS "교수정보",
       position AS "POSITION",
       hiredate AS "입사일자",
       email AS "이메일"
FROM professor; 