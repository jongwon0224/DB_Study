-- DML02
-- MERGE
--------------------------------------------------------------------------------------------------------------------------------------------------------
MERGE INTO table1 --1. 테이블 1을
USING table2 --2. 테이블 2를 사용해서 병합해라
ON (병합 조건절) -- 3. ON (조건)일때
WHEN MATCHED THEN -- 4.테이블 1, 2가 동일하면
    UPDATE SET 업데이트 내용 -- 5. 데이터를 업데이트 시키거나
    DELETE WHERE 조건 -- 6. 데이터를 삭제
WHEN NOT MATCHED THEN --7. 테이블 1,2가 동일하지 않으면
    INSERT VALUES(컬럼 이름); -- 8. 데이터 삽입  
--------------------------------------------------------------------------------------------------------------------------------------------------------
MERGE 할때는 테이블 최소 3개 필요
기본 1, 기본2, 총 테이블1..
1. 기본1 -> 총테이블 1에 병합
2. 기본2 -> 총테이블 2에 병합
3. 총테이블로 데이터 다루기;
--------------------------------------------------------------------------------------------------------------------------------------------------------

-- 신발가게 날짜별 매출
CREATE TABLE SHOE_M
(
    w_date DATE,
    s_code NUMBER(3), --매장 고유 코드
    sales NUMBER(10)
);

-- 옷가게 날짜별 매출
CREATE TABLE CLOT_M
(
    w_date DATE,
    s_code NUMBER(3), --매장 고유 코드
    sales NUMBER(10)
);

-- 본사 전체 매출
CREATE TABLE HQ_M
(
    w_date DATE,
    s_code NUMBER(3), --매장 고유 코드
    sales NUMBER(10)
);
--------------------------------------------------------------------------------------------------------------------------------------------------------
--select 로 데이터 입력시 수정할때 delete함수 써야됨.
select * from shoe_m;
select * from clot_m;
select * from hq_m;

INSERT INTO HQ_M
SELECT * from SHOE_M;

INSERT INTO HQ_M
SELECT * from CLOT_M;

update shoe_m
set sales = 130000
where w_date = '2024-11-02';
--------------------------------------------------------------------------------------------------------------------------------------------------------
--하나의 가게 + 날짜 중복 x
INSERT ALL 
INTO SHOE_M VALUES (TO_DATE('2024-11-01'), 1, 5000)
INTO SHOE_M VALUES (TO_DATE('2024-11-02'), 1, 10000)
INTO SHOE_M VALUES (TO_DATE('2024-11-03'), 1, 20000)
SELECT * FROM dual;

INSERT ALL 
INTO CLOT_M VALUES (TO_DATE('2024-11-04'), 50, 9000)
INTO CLOT_M VALUES (TO_DATE('2024-11-05'), 50, 13000)
INTO CLOT_M VALUES (TO_DATE('2024-11-06'), 50, 95000)
SELECT * FROM dual;

-----------HQ_M + SHOE_M
MERGE INTO HQ_M m
USING SHOE_M s
ON (m.w_date = s.w_date) --조건
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT VALUES (s.w_date, s.s_code, s.sales);

-----------HQ_M + CLOT_M    
MERGE INTO HQ_M m
USING CLOT_M c
ON (m.w_date = c.w_date) --조건
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE SET m.sales = c.sales
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT VALUES (c.w_date, c.s_code, c.sales);
--------------------------------------------------------------------------------------------------------------------------------------------------------
--날짜별 여러가게 : 머지 조건 -> 날짜 + 코드

INSERT ALL 
INTO SHOE_M VALUES (TO_DATE('2024-11-01'), 2, 15000)
INTO SHOE_M VALUES (TO_DATE('2024-11-02'), 2, 16000)
INTO SHOE_M VALUES (TO_DATE('2024-11-03'), 2, 30000)
SELECT * FROM dual;

INSERT ALL 
INTO CLOT_M VALUES (TO_DATE('2024-11-04'), 60, 19000)
INTO CLOT_M VALUES (TO_DATE('2024-11-05'), 60, 33000)
INTO CLOT_M VALUES (TO_DATE('2024-11-06'), 60, 65000)
SELECT * FROM dual;


MERGE INTO HQ_M m
USING SHOE_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code) --조건
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT VALUES (s.w_date, s.s_code, s.sales);
 
 
MERGE INTO HQ_M m
USING CLOT_M c
ON (m.w_date = c.w_date AND m.s_code = c.s_code) --조건
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE SET m.sales = c.sales
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT VALUES (c.w_date, c.s_code, c.sales);


select * from hq_m;
select * from shoe_m;
select * from clot_m;
--------------------------------------------------------------------------------------------------------------------------------------------------------
--가게 타입별로 병합후 데이터 출력
-- 머지 조건 -> 날짜 + 코드
-- 조건 일치안할때 타입명 입력
select * from shoe_m;
CREATE TABLE HQ_M
(
    w_date DATE,
    s_code NUMBER(3), --매장 고유 코드
    sales NUMBER(10),
    type VARCHAR(2)
);


MERGE INTO HQ_M m
USING SHOE_M s
ON (m.w_date = s.w_date AND m.s_code = s.s_code) --조건
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE SET m.sales = s.sales
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT VALUES (s.w_date, s.s_code, s.sales, 'S');

 
MERGE INTO HQ_M m
USING CLOT_M c
ON (m.w_date = c.w_date AND m.s_code = c.s_code) --조건
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE SET m.sales = c.sales
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT VALUES (c.w_date, c.s_code, c.sales, 'C');

---------------------------------------------------------------------
select * from shoe_m;
select * from clot_m;
select * from hq_m;

select type, sum(sales)
from hq_m
group by type;
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
--연습문제
--1
select * from dept2;

INSERT INTO DEPT2 (dcode, dname, pdept, area)
VALUES (9010, 'temp_10', 1006, 'temp area');
------------------------------------------------------------------------------------------------------------------------------------------------
--2
INSERT INTO DEPT2 (dcode, dname, pdept)
VALUES(9020, 'temp_20', 1006);
------------------------------------------------------------------------------------------------------------------------------------------------
--3
select * from professor4;

--TABLE 생성 방법 1. create table as ~
CREATE TABLE professor4
AS
SELECT profno, name, pay
FROM professor
WHERE profno <= 3000;

--TABLE 생성 방법 2. create table  ~ where 1=2해서 틀만 가져온후 insert into~로 데이터 가져오기
CREATE TABLE professor5
AS
select profno, name, pay
from professor
where 1=2;

INSERT INTO professor5
SELECT profno, name, pay
FROM professor
WHERE profno <= 3000;
------------------------------------------------------------------------------------------------------------------------------------------------
--4
UPDATE professor
SET bonus = 100
WHERE name = 'Sharon Stone';
















