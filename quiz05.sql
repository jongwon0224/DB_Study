SELECT
    TO_CHAR( TO_DATE(p1.p_date), 'YYYY-MM-DD' ) 판매일자,
    p1.p_code 상품코드,
    p2.p_name 상품명,
    TO_CHAR(p2.p_price, '999,999') 상품가,
    p1.p_qty 구매수량,
    TO_CHAR(p1.p_total, '999,999') 출금액,
    TO_CHAR(p1.p_total*100, '999,999') 적립포인트,
    TO_CHAR( DECODE( SUBSTR(p1.p_date, 5), '0101', p1.p_total*200, p1.p_total*100), '999,999') 새해2배적립포인트,
    g.gname 사은품명,
    TO_CHAR(g.g_start, '999,999,999') 포인트START,
    TO_CHAR(g.g_end, '999,999,999') 포인트END
FROM
    panmae p1,
    product p2,
    gift g
WHERE
    p1.p_code = p2.p_code 
    AND DECODE( SUBSTR(p1.p_date, 5), '0101', p1.p_total*200, p1.p_total*100) BETWEEN g.g_start AND g.g_end
ORDER BY
    p1.p_date;





select * from product;
select * from gift;