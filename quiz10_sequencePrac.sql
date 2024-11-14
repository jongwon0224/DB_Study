-- morning quiz / 24.11.14
/*
1. 다음 두 명령어는 어떤 기능을 수행하는 명령어인지 작성하고,
두 기능의 차이점이 있다면 설명하시오.

DELETE FROM 테이블명;
-- DML
-- 테이블 자체를 삭제하는 명령어 (구조 자체를 삭제)

TRUNCATE TABLE 테이블명;
-- DDL
-- 테이블은 존재 + 데이터 내용만 제거 (테이블 틀은 유지)*/
-- 롤백 불가 (테이블 삭제시 주의 필요)
----------------------------------------------------------------------------------------------------------------------------------------
--2. 다음 조건에 따라 테이블을 생성하시오.

/*
*내부 컬럼
ID : 숫자형 6자리
순번 : 숫자형 6자리
멤버ID : 문자형 24바이트, Null 안됨(꼭 입력해야함)
점수 : 숫자형 3자리
채점일시 : 날짜형, 단 입력된 값이 없을 경우 입력(현재)시간을 기본값으로 설정
※ 기본키(PK) : ID와 순번의 조합
*/
CREATE TABLE T_MEMBER_POINT
(
    id NUMBER(6),
    no NUMBER(6),
    mem_id VARCHAR2(24) NOT NULL,
    score NUMBER(3),
    chk_date DATE DEFAULT SYSDATE,
    CONSTRAINT T_MEMBER_POINT_pk PRIMARY KEY (id, no)
);

----------------------------------------------------------------------------------------------------------------------------------------
/*
3. 다음 조건에 맞는 시퀀스를 생성하시오. -> 생성한 시퀀스는 id 컬럼에 사용
시퀀스명 : T_MEMBER_POINT_PK_SEQ
*상세조건
1부터 시작하며 1씩 증가한다.
값의 범위는 1~999999
순환하지 않도록 한다.
*/
CREATE SEQUENCE T_MEMBER_POINT_PK_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 999999
NOCYCLE;
----------------------------------------------------------------------------------------------------------------------------------------
/*
4. 생성한 시퀀스의 값을 불러서 임의의 데이터를 저장해보시오.
(*순번은 각 멤버ID 별로 자동 계산되어 저장하도록 해주세요)
- 시퀀스 사용 -> id
- 순번(no) -> 해당 학생이 시험을 치룬 회차 계산되서 저장
--
-- 4번문제
id는 시퀀스, 순번은 쿼리로 작성 ==> id는 순차대로 // 순번은 멤버가 재시험시 횟수 증가 & 새로운 멤버가 시험시 횟수 1시작
*/
----------------------------------------------------------------------------------------------------------------------------------------
--멤버 id A 데이터
INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'A'), 'A', 80);

INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'A'), 'A', 90);

INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'A'), 'A', 70);
----------------------------------------------------------------------------------------------------------------------------------------
--멤버 id B 데이터
INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'B'), 'B', 80);

INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'B'), 'B', 60);

INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'B'), 'B', 90);
----------------------------------------------------------------------------------------------------------------------------------------
--멤버 id C 데이터
INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'C'), 'C', 20);

INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (SELECT nvl( max(no), 0) +1 FROM T_MEMBER_POINT WHERE mem_id = 'C'), 'C', 10);
----------------------------------------------------------------------------------------------------------------------------------------
-- count로 구분해서 데이터 입력 (데이터 삭제시 오류발생)
INSERT INTO T_MEMBER_POINT (id, no, mem_id, score)
VALUES (T_MEMBER_POINT_PK_SEQ.NEXTVAL, (select count(*)+1 from t_member_point where mem_id = 'A'), 'A', 80);
----------------------------------------------------------------------------------------------------------------------------------------
select * from T_MEMBER_POINT;




