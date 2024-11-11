--DML

-- 데이터 저장 INSERT
-- 데이터 수정 UPDATE
-- 데이터 삭제 DELETE
-- 데이터 병합 MERGE

--INSERT 구문 
INSERT INTO 테이블명 (컬럼명 ~~)
VALUES (데이터 값~~);
--------------------------------------------------------------------------------------
--예시
INSERT INTO new_table (no, name, birth)
VALUES (1, '이름1', sysdate);

INSERT INTO new_table (birth, name, no)
VALUES (sysdate, '이름2', 2);

INSERT INTO new_table (birth, name, no)
VALUES (sysdate, '이름3', 3);

--날짜 입력시 TO_DATE() 사용하는게 좋음
INSERT INTO new_table (name, birth, no)
VALUES ('이름4', TO_DATE('1998-02-24'), 4);

--INSERT INTO new_table()에 컬럼명 생략하는 경우
-- 전체 컬럼에 저장하는 경우 + 순서가 맞으면 생략가능
INSERT INTO new_table --컬럼명 생략 가능
VALUES(5, '이름5', sysdate);

--컬럼 2개에만 저장할때 : 컬럼값 2개 지정 + value값 2개 지정
INSERT INTO new_table (no, name)
VALUES (6, '이름6');

--컬럼값 지정안하고 value값에 3개 넣어도 가능
INSERT INTO new_table
VALUES (7, '이름7', null);
--------------------------------------------------------------------------------------
--tt02 테이블 데이터 조작
INSERT INTO tt02 (no)
VALUES (1);

-- null로 입력시 default값이 들어가는게 아님.
--null입력으로 테이블에 null값 출력
INSERT INTO tt02 (no, name, hiredate)
VALUES (2, null, null);


INSERT INTO dept4
VALUES (2000, 'Cheonan Office');











