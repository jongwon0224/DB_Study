--ddl03
-- Foriegn key 사용법
-- table 1컬럼에 references + 테이블2 이름  (참조하는 컬럼명)

CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(30),
    club_id NUMBER REFERENCES T_CLUB(id)
);

CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(30)
    
);
------------------------------------------------------------------------------------------------------------------------------------------------------------
--T_CLUB의 id값 => 외래키 설정
INSERT INTO T_CLUB
VALUES (1, '독서');

INSERT INTO T_CLUB
VALUES (2, '등산');

INSERT INTO T_CLUB
VALUES (3, '낚시');
------------------------------------------------------------------------------------------------------------------------------------------------------------
--T_MEMBER의 club_id값 => T_CLub의 외래키

INSERT INTO T_MEMBER
VALUES (1, '황종원', 3); --T_CLUB 몇번 동호회를 참조하고 있냐 => 3번 동호회

INSERT INTO T_MEMBER
VALUES (2, '황종투', 8); -- 8입력시 제약조건 위반 => 외래키는 3번까지

INSERT INTO T_MEMBER
VALUES (2, '황종투', 2);

INSERT INTO T_MEMBER
VALUES (3, '황종쓰리', 3);

INSERT INTO T_MEMBER
VALUES (4, '황종포', null); -- null은 가능
------------------------------------------------------------------------------------------------------------------------------------------------------------
delete from t_club where id = 3; --외래키 설정된 테이블에서 자신을 참조하는 데이터가 존재하는 경우 -> 삭제 불가능
------------------------------------------------------------------------------------------------------------------------------------------------------------

--외래키 삭제조건
ON DELETE CASCADE; --같이 삭제
ON DELETE SET NULL; -- 널로 처리

-- ON DELETE SET NULL ==> 외래키 행 삭제하면 연결되어있는 데이터 null로 바뀜
CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(30),
    club_id NUMBER REFERENCES T_CLUB(id) ON DELETE SET NULL
);

-- ON DELETE CASCADE ==> 외래키 행 삭제하면 연결되어있는 데이터 같이 삭제
CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(30),
    club_id NUMBER REFERENCES T_CLUB(id) ON DELETE CASCADE
);
------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 데이터 딕셔너리 (데이터 종류 보는 방법)
-- USER_ / DBA_ / ALL_ / INDEXES / CONSTRAINTS / TABLES / SEQUENCES / SYNONYMS / VIEWS
select * from user_user;
select * from user_dba;
select * from all_tables;
select * from user_indexes;
select * from user_constraints;
select * from user_tables;
select * from user_sequences;
select * from user_synonyms;
select * from user_views;
select * from tab;

-- table 이름 찾을때 like '%테이블명 겹치는부분%'
select * from tab where tname like '%DEPT%';

------------------------------------------------------------------------------------------------------------------------------------------------------------
--복합키 예시 (기본키 여러개, primary key 여러개) 
CREATE TABLE tt05
(
    id number,
    no number,
    age number,
    CONSTRAINT tt05_pk PRIMARY KEY (id, no)
);
------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO tt05
VALUES (4, 4, 3);

select * from tt05;
