-- quiz
--product1 테이블 생성 및 데이터 입력
CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);
------------------------------------------------------------------------------------
-- price테이블 생성
CREATE TABLE price
(
    price_group NUMBER, 
    products NUMBER
);
------------------------------------------------------------------------------------
-- list 테이블 생성 (min, max)
CREATE TABLE list
(
    min_p NUMBER,
    max_p NUMBER
);

INSERT INTO list
VALUES (0,9999);

INSERT INTO list
VALUES (10000,19999);

INSERT INTO list
VALUES (20000,29999);

INSERT INTO list
VALUES (30000,39999);
------------------------------------------------------------------------------------
-- price테이블에 데이터 삽입
INSERT INTO price

-- price테이블 조건값 구하는 방법
--1. union all로
select 0 PRICE_GROUP, count(*) PRODUCTS
from product_quiz
where price between 0 and 9999
union all
select 10000, count(*)
from product_quiz
where price between 10000 and 19999
union all
select 20000, count(*)
from product_quiz
where price between 20000 and 29999
union all
select 30000, count(*)
from product_quiz
where price between 30000 and 39999;

select * from product_quiz;

--2. group by로
--만의자리수를 뽑아내면?
select floor(price/10000)*10000 price_group, count(*) products
from product_quiz
group by floor(price/10000)
order by price_group;

-- 3. case문으로 만의자리수 구함
select case
                    when price between 0 and 9999 then 0
                    when price between 10000 and 19999 then 10000
                    when price between 20000 and 29999 then 20000
                    when price between 30000 and 39999 then 30000
            end price_group,
            count(*) products
from product_quiz
group by case
                    when price between 0 and 9999 then 0
                    when price between 10000 and 19999 then 10000
                    when price between 20000 and 29999 then 20000
                    when price between 30000 and 39999 then 30000
                end
order by price_group;


-- 4-1. subquery 사용
select price price_group, count(*) prodcuts
from (
            select product_id, product_code, trunc(price/10000) * 10000 price
            from product_quiz)
group by price
order by price;

-- 4-2. subquery사용
select price price_group, count(*) prodcuts
from (
            select trunc(price/10000) * 10000 price
            from product_quiz)
group by price
order by price;
------------------------------------------------------------------------------------
--각 테이블별 확인
select * from product_quiz;
select * from list;
select * from price;
