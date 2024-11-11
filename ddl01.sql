테이블 생성/수정/삭제 : DDL (definition)
데이터 삽입/수정/삭제 : DML (manipulation) <-> select( 때에 따라 다름..data query language DQL이라고도 함)
데이터 제어 : DCL (control)

--------------------------------------------------------------------------------------
-- DDL
CREATE TABLE new_table
(
    no NUMBER(3), --default = 0 //  3자리 숫자 입럭가능
    name VARCHAR2(10), --default = 'No Name'
    birth DATE --default = sysdate
);

-- talbe 생성 확인
select *
from new_table;

desc new_table; -- 테이블 구조 보는 명령어 -> desc (describe)
--------------------------------------------------------------------------------------
--tt02 테이블 생성 (default값 넣기)
CREATE TABLE tt02
(
    no NUMBER(3,1) DEFAULT 0,
    name VARCHAR2(10) DEFAULT 'No Name',
    hiredate DATE DEFAULT sysdate
);

select *
from tt02;

desc tt02;
--------------------------------------------------------------------------------------
--테이블 복사 (생성 x)
-- dept2테이블 복사 -> dept3 복붙
CREATE TABLE dept3
AS
SELECT * FROM dept2;

select * from dept3;

--dept2테이블에서 특정 컬럼만 복사 가능
CREATE TABLE dept4
AS
SELECT dcode, area FROM dept2;

select * from dept4;

-- dept2의 테이블 구조만 가져오기 (데이터 x)
--where에 1=2 (false)값을 대입해서 구조만 나오게하기
CREATE TABLE dept5
AS
select * from dept2 where 1=2;

select * from dept5;
--------------------------------------------------------------------------------------
-- 컬럼 추가 -> ALTER TABLE + (테이블) + ADD + (컬럼명 + 타입)
ALTER TABLE dept4 -- dept4 : 수정하고자 하는 테이블 설정
ADD (location VARCHAR2(10)); -- location VARCHAR2(10) : 컬럼명 + 타입

--테이블 변경시 default값 지정가능
ALTER TABLE dept4
ADD (location VARCHAR2(10) DEFAULT 'Cheonan');
--------------------------------------------------------------------------------------
-- 컬럼삭제 -> ALTER TABLE + 테이블명 + DROP COLUMN + 컬럼명
ALTER TABLE dept4
DROP COLUMN location;





select * from dept4;
--------------------------------------------------------------------------------------
--임시부서 여부를 체크 컬럼명 temp_code
--임시부서 : Y / 정식부서 : N
ALTER TABLE dept4
ADD (temp_code VARCHAR2(2) DEFAULT 'N');
--------------------------------------------------------------------------------------
-- 컬럼 데이터 변경하기
-- UPDATE + 테이블명 + SET 컬럼명 = 값  WHERE + 조건
UPDATE dept4
SET temp_code = 'Y'
WHERE dcode = 2000;

select * from dept4;
select * from dept4 where temp_code = 'Y';
--------------------------------------------------------------------------------------
--연습1. professor테이블에서 포지션이 assistant professor인 사람들의
-- 보너스를 200으로 수정하기

-- 1. professor2 테이블 복사
CREATE TABLE professor2
AS
SELECT * FROM professor;
--2. 컬럼 데이터값 수정
UPDATE professor2
--SET bonus = 200 -- 보너스를 200으로 저장
SET bonus = bonus + 200 -- 기존값에서 200 인상
WHERE position = 'assistant professor';

select * from professor2 where position = 'assistant professor';

select * from dept4;

update dept4
set location = 'Asan'
where dcode = 2000;

-- DDL은 rollback이 안됨... (주의)
-- commit : 되돌릴수없음 -> sqlplus에 데이터확정됨
-- rollback : 되돌릴수있음 -> sqlplus에는 데이터확정안되어있음
INSERT INTO dept4
VALUES (2001, 'Asan office', 'Asan', 'Y');
-- commit (확정) 안해서 sql devloper상에만 데이터 나옴
-- commit 전은 rollback해서 데이터 복구가능
commit; --확정
rollback; --취소
--------------------------------------------------------------------------------------
--DDL 데이터 삭제 (테이블 or 테이블 테두리만 남기고)
DROP TABLE + 테이블명; --(Rollback 안됨)
TRUNCATE TABLE + 테이블명; --(테두리는 남고 데이터만 사라짐)

--DDL로 테이블 삭제(롤백 불가 / 자동 커밋)
DROP TABLE dept5; --dept5 테이블 자체를 삭제
TRUNCATE TABLE dept6; --테두리만 남고 데이터만 사라짐
----------------------
--DML 데이터삭제 (데이터만)
DELETE FROM + 테이블명 + WHERE 조건;

--DML로 테이블 삭제(롤백 가능 / 수동 커밋)
DELETE FROM dept4;

select *
--delete
from dept4
where temp_code = 'Y';

select * from dept4;
--------------------------------------------------------------------------------------
