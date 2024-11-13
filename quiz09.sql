-- morning quiz (24-11-13)

--A업체 TABLE_DATA_1 생성
CREATE TABLE TABLE_DATA_1
(
no number(10),
create_date DATE
);

INSERT INTO TABLE_DATA_1 VALUES (1, '2023-04-01');
INSERT INTO TABLE_DATA_1 VALUES (2, '2023-04-02');
INSERT INTO TABLE_DATA_1 VALUES (3, '2023-04-03');
INSERT INTO TABLE_DATA_1 VALUES (4, '2023-04-04');
------------------------------------------------------------------------------------------------------------------------------------------------------------

--B업체 TABLE_DATA_2 생성
CREATE TABLE TABLE_DATA_2
(
no number(10),
create_date DATE
);

INSERT INTO TABLE_DATA_2 VALUES (1, '2023-04-02');
INSERT INTO TABLE_DATA_2 VALUES (2, '2023-04-03');
INSERT INTO TABLE_DATA_2 VALUES (3, '2023-04-04');
INSERT INTO TABLE_DATA_2 VALUES (4, '2023-04-05');
------------------------------------------------------------------------------------------------------------------------------------------------------------
--데이터 취합여부를 체크 / TABLE_COLC 생성
CREATE TABLE TABLE_COLC
(
std_date DATE,
CHECK_DATA1 VARCHAR2(6),
CHECK_DATA2 VARCHAR2(6)
);



select * from table_data_1;
select * from table_data_2;
select * from table_colc order by std_date;
----------------------------------------------------------------------------
--t1테이블 병합
MERGE INTO table_colc t
USING table_data_1 t1
ON (t.std_date = t1.create_date)
WHEN MATCHED THEN -- 조건이 일치하면
    UPDATE 
    SET t.check_data1 = 'Y' -- data1값에 y입력
WHEN NOT MATCHED THEN -- 조건이 일치안하면
    INSERT (t.std_date, t.check_data1, t.check_data2)
    VALUES(t1.create_date, 'Y', 'N');    --날짜, y, n 입력 (어처피 n해도 다음 병합에서 바뀜)

--t2테이블 병합    
MERGE INTO table_colc t
USING table_data_2 t2
ON (t.std_date = t2.create_date)
WHEN MATCHED THEN
    UPDATE 
    SET t.check_data2 = 'Y'
WHEN NOT MATCHED THEN
    INSERT (t.std_date, t.check_data1, t.check_data2)
    VALUES(t2.create_date, 'N', 'Y');   --날짜, n, y 입력 (어처피 n해도 다음 병합에서 바뀜)
----------------------------------------------------------------------------







