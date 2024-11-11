--DDL02 제약조건
-- 테이블 생성시  컬럼명에 입력
------------------------------------------------------------------------------------------
NOT NULL : 컬럼에 null값 입력안됨
UNIQUE : 중복값 입력안됨
PRIMARY KEY : not null + unique 특징 => 테이블 내 유일성 보장
FOREIGN KEY : 다른 테이블의 컬럼을 참조해서 검사
CHECK : 이 조건에 설정된 값만 허용 & 나머지값 거부

--TRUE / FALSE 설정 종류
1:true 0:false
Y:true N:false
T:true F:false
true:true False :false
;
------------------------------------------------------------------------------------------
-- 약식 제약조건 설정 예시
CREATE TABLE tt01
(
    no NUMBER (3) UNIQUE, -- 중복값 입력 안됨
    name VARCHAR(10) NOT NULL, --Null값 입력 안됨
    hiredate DATE,
    score NUMBER(3) CHECK (score BETWEEN 0 AND 10)
);


--FORMAL 식으로 제약조건 설정
CREATE TABLE tt03
(
    no NUMBER(3) CONSTRAINT tt03_no_uk UNIQUE,
    name VARCHAR2(10) CONSTRAINT tt03_nn NOT NULL,
    score NUMBER(3) CONSTRAINT tt03_score_ck CHECK (score BETWEEN 0 AND 10),
    pass VARCHAR2(2) CONSTRAINT tto3_pass_ch CHECK (pass IN ('Y','N'))
);



------------------------------------------------------------------------------------------
--DML 입력시 주의사항
INSERT INTO tt01
VALUES (1, '이름1', sysdate);
--VALUES (1, '이름2', sysdate) -- no컬럼값 동일으로 중복값 입력 오류나옴

INSERT INTO tt01
VALUES (2, '이름2', sysdate);
--VALUES (2, null, sysdate); -- null을 name컬럼에 입력못함 => 널오류
------------------------------------------------------------------------------------------
-- DML 데이터 입력 예시
INSERT INTO tt03
VALUES (1, '이름1', 10, 'Y'); -- no컬럼 => 중복 unique

INSERT INTO tt03
VALUES (2, null, 50, 'Y');-- name컬럼 => not null

INSERT INTO tt03
VALUES (2, '이름2', 500, 'Y'); -- score컬럼 => check /  between 0 ~ 10

INSERT INTO tt03
VALUES (2, '이름2', 50, 'T'); -- pass 컬럼 => / check / Y and N
------------------------------------------------------------------------------------------
