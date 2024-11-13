--1. 아래 조건에 테이블 생성
CREATE TABLE T_ITEM_LIST
(
    no NUMBER(6) PRIMARY KEY,
    item_name VARCHAR2(24)  NOT NULL,
    price NUMBER(6),
    create_date DATE  DEFAULT SYSDATE
);
---------------------------------------------------------------------------------------------------------------------
--2. 다음 조건에 맞는 시퀀스를 생성하시오.
CREATE SEQUENCE T_ITEM_LIST_PK_SEQ
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 999999
NOCYCLE;
---------------------------------------------------------------------------------------------------------------------
--3. 생성한 시퀀스의 값을 불러서 사용하는 방법을 작성하시오.
SELECT T_ITEM_LIST_PK_SEQ.NEXTVAL FROM dual;
---------------------------------------------------------------------------------------------------------------------
--4. 해당 시퀀스를 활용하여, 테이블에 INSERT 처리 하는 쿼리문을 작성하시오.
INSERT INTO T_ITEM_LIST
VALUES (T_ITEM_LIST_PK_SEQ.NEXTVAL, 'A', 5000, sysdate);

INSERT INTO T_ITEM_LIST
VALUES (T_ITEM_LIST_PK_SEQ.NEXTVAL, 'B', 15000, sysdate);

/* INSERT ALL에는 시퀀스 작동안됨
INSERT ALL
INTO T_ITEM_LIST VALUES(T_ITEM_LIST_PK_SEQ.NEXTVAL, 'B', 6000, sysdate)
INTO T_ITEM_LIST VALUES(T_ITEM_LIST_PK_SEQ.NEXTVAL, 'C', 7000, sysdate)
SELECT * FROM dual;*/
---------------------------------------------------------------------------------------------------------------------
select * from t_item_list;