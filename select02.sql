/*
단일행 함수
임시로 사용하는 테이블(테스트용) dual
*/
--INITCAP 첫글자 대문자로 변환
SELECT 
    ename,
    INITCAP('ABCDE') "테스트",
    INITCAP(ename) "첫글자대문자"
FROM emp;

-- LOWER 전부 소문자로 변환 , UPPER 전부 대문자로 변환
SELECT 
    name,
    INITCAP(name),
    LOWER(name),
    UPPER(name)
FROM student;

--LENGTH 글자 길이
SELECT
    LENGTH('abcdefaef') --확인 하는데 불필요하게 dept테이블구성에 맞게 4행씩이나 나옴
FROM dept;

SELECT
    LENGTH('abcdefaef') "단어길이",
    LENGTHB('abcdefaef') "단어길이의 바이트값",
    LENGTH('점심'),
    LENGTHB('점심')
FROM dual;  -- dual 테이블 안만들고 기능 확인용 테이블 1행만 출력

SELECT *
FROM emp   --emp테이블에서 이름이 5글자 이상인 사람들 찾기
WHERE LENGTH(ename) >= 5;

-- CONCAT ||과 동일한기능 이지만 매개변수2개까지 받음
SELECT '아침' || '점심', CONCAT('아침', '점심')
FROM dual;

SELECT '아침' || '점심' || '저녁', CONCAT('아침', '점심')   --CONCAT함수는 매개변수가 2개라서 3개이상은 못넣음
FROM dual;

SELECT '아침' || '점심' || '저녁', CONCAT( CONCAT('아침', '점심'), '저녁')   --CONCAT함수는 매개변수가 2개라서 3개이상은 못넣음 더 추가하려면 묶어서 써줘야함
FROM dual;

--SUBSTR (대상, 시작지점, 자리수) 첫글자가 1번
SELECT 
    SUBSTR('abcdefg', 2, 3), --b로 시작해서 d까지
    SUBSTR('abcdefgehtgfyihsergfhreid', 3, 5),
    SUBSTR('abcdefgehtgfyihsergfhreid', -6, 5)  -- -붙이면 뒤에서부터 몇번째
FROM dual;

SELECT 
    name,
    SUBSTR(jumin, 3, 4) Birthday,  -- 주번 3번째 글자부터시작해서 4번째까지 읽음
    SUBSTR(jumin, 3, 4) -1 "Birthday - 1"
FROM student
WHERE deptno1 = 101;

--INSTR (대상, 찾을거, 시작(1=글자맨처음부터), 몇번째찾을꺼나올때까지)
SELECT
    INSTR('2024/11/04 10/45/45', '/', 1),
    INSTR('2024/11/04 10/45/45', '/', 6),
    INSTR('2024/11/04 10/45/45', '/', 1, 4),
    INSTR('2024/11/04 10/45/45', '/', 6, 2),
    INSTR('2024/11/04 10/45/45', '/', 1, 5),
    INSTR('2024/11/04 10/45/45', '/', 16, 2)
FROM dual;

SELECT  -- student 테이블에서 전공넘버가 201애들중 tel의 ) 표시가 몇번째에 적혀있는지 찾기
    name,
    tel,
    INSTR(tel, ')')
FROM student
WHERE deptno1 = 201;

-- 간단한 연습 --
SELECT *
FROM student;

SELECT
    name "이름",
    SUBSTR(jumin, 1, 2) "년도",
    SUBSTR(jumin, 3, 2) "월",
    SUBSTR(jumin, 5, 2) "일"
FROM student;

SELECT
    name,
    tel,
    INSTR( tel, ')' ) "괄호위치"
FROM student
WHERE deptno1 = 201;

SELECT
    name,
    tel,
    INSTR( tel, '3', 1, 1) "'3' 이 처음 나오는 위치"
FROM student
WHERE deptno1 = 101;

SELECT
    name,
    tel,
    SUBSTR(tel, 1, INSTR( tel, ')')-1 ) "지역번호"
FROM student
WHERE deptno1 = 201;
-- 연습 끝 --

-- LPAD 왼쪽에 문자채움  RPAD 오른쪽에 문자채움
SELECT
    LPAD('문자', 10, '*'),
    LPAD(123, 5, 0),
    LPAD(33, 3, 0)
FROM dual;

SELECT
    LPAD(id, 10, '*'),
    RPAD(id, 10, '*')
FROM student;

SELECT
    ename,
    LPAD(ename, 9, 123456789)
FROM emp;

-- LTRIM 왼쪽에서 제거할 문자 RTRIM 오른쪽에서 제거할 문자
-- 불필요한 요소 제거함 ( 공백 제거용으로 많이 쓰임 ) ex)" 점심은 30분 후 "
SELECT
    LTRIM('abcd', 'a'),
    RTRIM('abcd', 'd'),
    RTRIM('abcdef', 'ef'),
    LTRIM(' ab cd '), -- 따로 지정을 안해줘도 왼쪽끝띄어쓰기를 제거해줌.
    RTRIM(' ab cd '), -- 따로 지정을 안해줘도 오른쪽끝띄어쓰기를 제거해줌.
    TRIM(' ab cd ') -- 따로 지정을 안해줘도 양쪽띄어쓰기를 제거해줌.
FROM dual;

-- REPLACE 지정한것을 다른 문자로 바꾸겠다
SELECT
    REPLACE('abcde', 'c', '*'),
    REPLACE('2024-11-04', '-', '/')
FROM dual;

SELECT
    ename,
    REPLACE(ename, SUBSTR(ename,1 ,2), '**') "REPLACE"
FROM emp;


--소숫점
--round : 반올림
--trunc : 절삭(내림)

--나머지
--mod : 나머지값 출력

--정수
--ceil : 근접한 정수 출력(올림)
--floor : 근접한 정수 출력(내림)
--power : 입력숫자1의 입력숫자2 승을 출력 ex) POWER(3,2) -> 3의 2승 9출력

SELECT
    rownum, --행번호
    CEIL(rownum / 3), -- 1/3, 2/3, 3/3, 4/3 ~ 12/3까지해서 나머지 올림해서 정수만듬
    empno,
    ename
FROM emp;

--sysdate : 현재 날짜
--systimestamp : 현재 날짜 + 시간 출력
SELECT
    SYSDATE,
    SUBSTR(SYSTIMESTAMP, 1, 14)
FROM dual;

--month_between : 두날짜의 개월수 차이값 출력
--add_months : 현 시간에 입력숫자 더한후 날짜
SELECT
    MONTHS_BETWEEN('2024/03/31','2024/01/05'),
    MONTHS_BETWEEN('2024/03/31','2024/01/05'),
    ADD_MONTHS(SYSDATE, 3)
FROM dual;

--next_day : 해당 입력날짜가 언제오나
--Last_day : 해당 입력한 날짜의 마지막 일 ex.10월 -> 31일
SELECT
    LAST_DAY(SYSDATE),
    NEXT_DAY(SYSDATE, '수')
FROM dual;

--날짜 응용 (년, 월, 일 기준으로 절삭가능)
SELECT
    TRUNC(SYSDATE, 'MM'), --월 만 출력 
    TRUNC(SYSDATE, 'YY'), --년 만 출력
    ADD_MONTHS(SYSDATE, 1), --1개월 더한 값 출력
    TRUNC(SYSDATE + 7), -- 7일후 출력
    TRUNC(ADD_MONTHS(SYSDATE, 1), 'MM'), --현시점 기준 다음달 1일 출력
    LAST_DAY(SYSDATE)+1, --현시점 기준 다음달 1일 출력
    TRUNC(SYSDATE, 'MM')-1, -- 월만 출력후 -1일후 절삭
    LAST_DAY(ADD_MONTHS(SYSDATE, -1)) -- -1개월후 마지막날 
FROM dual;


--형변환 함수
SELECT
    2 + '2', --자동형변환
    TO_CHAR(51561.238), --숫자 문자로 변경
FROM dual;

SELECT
    TO_CHAR(SYSDATE, 'YYYY'), -- YY로 변경 
    TO_CHAR(SYSDATE, 'MM'), --MM로 변경
    TO_CHAR(SYSDATE, 'DD'), --DD로 변경
    TO_CHAR(SYSDATE, 'YYYY/MM/DD'), -- 형식 '00/00/00'
    TO_CHAR(SYSDATE, 'YYYY-MM-DD'), -- 형식 '00-00-00'
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), -- hh,mi,ss /시,분,초
    TO_CHAR(SYSDATE, 'HH24:MI:SS'),
    TO_CHAR( ROUND(SYSDATE), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;





