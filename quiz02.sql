--문제1
SELECT STUDNO "번호", name "이름", id "아이디" 
FROM student
WHERE height BETWEEN 160 AND 175
UNION ALL
SELECT profno, name, id
FROM professor
WHERE deptno IN (101,102,103,201) AND bonus IS NULL;

--문제2
SELECT 
    CONCAT('이름:',name) "이름",
    CONCAT('아이디:', id) "아이디",
    '주민번호:' || SUBSTR(jumin,1,6) || '-' || SUBSTR(jumin,7,7) "주민번호" 
FROM student;

