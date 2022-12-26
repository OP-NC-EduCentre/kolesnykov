/* 2.1. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає накопичувальні підсумки другої колонки від початку
вікна до поточного рядка.
*/

SELECT cName, gymNo, hireDate, sal,
    SUM(sal) OVER (ORDER BY hireDate 
        ROWS BETWEEN UNBOUNDED PRECEDING 
            AND CURRENT ROW) sum_sal
FROM COACH;

/* Результат:

CNAME           GYMNO HIREDATE        SAL    SUM_SAL
---------- ---------- -------- ---------- ----------
Alexander           1 04.07.15       9000       9000
Andrey              5 07.04.17       8000      17000
Philip              5 20.05.18       7500      24500
Antoniy             6 27.09.18       7000      31500
Olesya              6 11.11.18       8000      39500
Ivan                1 03.04.19       8000      47500

6 rows selected. 
*/



/* 2.2. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає накопичувальні підсумки другої колонки
попереднього та поточного рядка (ковзаюче вікно розміром 2 рядки).
*/

SELECT cName, gymNo, hireDate, sal,
    SUM(sal) OVER (ORDER BY hireDate 
        ROWS BETWEEN 1 PRECEDING
            AND CURRENT ROW) sum_sal
FROM COACH;

/* Результат:

CNAME           GYMNO HIREDATE        SAL    SUM_SAL
---------- ---------- -------- ---------- ----------
Alexander           1 04.07.15       9000       9000
Andrey              5 07.04.17       8000      17000
Philip              5 20.05.18       7500      15500
Antoniy             6 27.09.18       7000      14500
Olesya              6 11.11.18       8000      15000
Ivan                1 03.04.19       8000      16000

6 rows selected. 
*/



/* 2.3. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає:
 накопичувальні підсумки другої колонки від початку вікна до поточного
рядка для кожного вікна цілком
 накопичувальний результат порядково (для демонстрації відмінностей
роботи типу RANG від ROWS).
*/

SELECT cName, gymNo, hireDate, sal,
    SUM(sal) OVER (ORDER BY hireDate 
        ROWS BETWEEN UNBOUNDED PRECEDING 
            AND CURRENT ROW) sum_sal_rows,
    SUM(sal) OVER (ORDER BY hireDate 
        RANGE BETWEEN UNBOUNDED PRECEDING 
            AND CURRENT ROW) sum_sal_range
FROM COACH;

/* Результат:

CNAME           GYMNO HIREDATE        SAL SUM_SAL_ROWS SUM_SAL_RANGE
---------- ---------- -------- ---------- ------------ -------------
Alexander           1 04.07.15       9000         9000          9000
Andrey              5 07.04.17       8000        17000         17000
Philip              5 20.05.18       7500        24500         24500
Antoniy             6 27.09.18       7000        31500         31500
Olesya              6 11.11.18       8000        39500         39500
Ivan                1 03.04.19       8000        47500         47500

6 rows selected. 
*/