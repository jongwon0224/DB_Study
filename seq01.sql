-- seq 시퀀스
---------------------------------------------------------------------------------------------------
-- seq 테이블 생성
CREATE TABLE seq_test
(
    no NUMBER(3) PRIMARY KEY,
    name VARCHAR2(32)
);
---------------------------------------------------------------------------------------------------
-- 수동으로 저장
INSERT INTO seq_test VALUES (1, '가');
-- 다음 가입자 이름 '나' 저장
INSERT INTO seq_test VALUES (2, '나');
---------------------------------------------------------------------------------------------------
-- 1. 서브쿼리로 개수 활용 (count활용시 데이터 삭제후 다시 insert into하면 오류발생)
SELECT COUNT(*) FROM seq_test; -- 현재 저장된 개수
SELECT COUNT(*)+1 FROM seq_test; -- 다음 저장할 차례 값

-- values의 값에 서브쿼리 활용
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test),  '다');
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test),  '라');
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test),  '마');
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test),  '바');
INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test),  '사');
---------------------------------------------------------------------------------------------------
--테이블 관리
-- 데이터 삭제로 관리하는 테이블
-- 서브쿼리 count로 할 경우 오류 나옴
select * from seq_test;
delete from seq_test where no = 3;

INSERT INTO seq_test VALUES ( (SELECT COUNT(*)+1 FROM seq_test),  '바');
---------------------------------------------------------------------------------------------------
-- 2. 서브쿼리로 개수 활용 -> no pk값으로 서브쿼리 활용
SELECT MAX(no) FROM seq_test; -- count말고 no를 활용
SELECT MAX(no)+1 FROM seq_test; -- max(no) + 1로 다음에 나오는 값 자동 출력

-- value값에 최댓값 출력 +1 활용
INSERT INTO seq_test VALUES ( (SELECT MAX(no)+1 FROM seq_test),  '아');

-- delete후 데이터 입력시 오류 => 데이터 0일때 max가 안잡힘..
★해결방안★ => NVL(MAX)로 max가 null이여도 0으로 바꿔줌..
SELECT NVL( MAX( no), 0) + 1 FROM seq_test;

INSERT INTO seq_test VALUES (  (SELECT NVL( MAX(no), 0) +1 from seq_test)  , '차이름');
INSERT INTO seq_test VALUES (  (SELECT NVL( MAX(no), 0) +1 from seq_test)  , '카이름');
---------------------------------------------------------------------------------------------------
★순차적으로 중복되지 않는 값을 사용 -> 시퀀스★
-- 방법1
CREATE SEQUENCE seq_test_pk_seq
INCREMENT BY 1 --1씩 증가
START WITH 1 -- 1부터 시작
MINVALUE 1 -- 최소 1
MAXVALUE 10 --최대10
CYCLE -- 순환( max값 도달후 다시 min값으로 옴)
--NOCYCLE -- 순환 안됨
CACHE 5; --캐시 5

-- 방법2
CREATE SEQUENCE seq_test_pk_seq
INCREMENT BY 1
START WITH 1;
--MIN/MAX 체크X    생략 가능
--NOCYCLE
--CACHE 20
---------------------------------------------------------------------------------------------------
-- 시퀀스 호출 함수
시퀀스명.nextval 다음값 호출(사용)
select seq_test_pk_seq.nextval from dual;

시퀀스명.currval 현재값 확인
select seq_test_pk_seq.currval from dual;

-- INSERT INTO로 값 입력
INSERT INTO seq_test VALUES ( seq_test_pk_seq.nextval  , 'A이름');
INSERT INTO seq_test VALUES ( seq_test_pk_seq.nextval  , 'B이름');
INSERT INTO seq_test VALUES ( seq_test_pk_seq.nextval  , 'C이름');
---------------------------------------------------------------------------------------------------
-- 방법1. 시퀀스 초기화 및 삭제
--1이 될수 있도록 증가값을 변경
ALTER SEQUENCE seq_test_pk_seq INCREMENT BY -17;
ALTER SEQUENCE seq_test_pk_seq MINVALUE 0;
--시퀀스 1회 실행
select seq_test_pk_seq.nextval from dual;
--다시 증가값 설정 변경
ALTER SEQUENCE seq_test_pk_seq INCREMENT BY 1;
--설정 완료 후 시퀀스 확인
select seq_test_pk_seq.nextval from dual;

-- 방법2 시퀀스 삭제
DROP SEQUENCE seq_test_pk_seq;
---------------------------------------------------------------------------------------------------



