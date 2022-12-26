/* 3.1. Класифікуйте значення однієї з колонок на 3 категорії залежно від загальної суми
значень у будь-якій числовій колонці. Використати аналітичну функцію NTILE.
*/

SELECT 
    NTILE(3) OVER (ORDER BY sal) AS salNtile, 
    cName,
    hireDate,
    sal
FROM COACH;

/* Результат:

  SALNTILE CNAME      HIREDATE        SAL
---------- ---------- -------- ----------
         1 Antoniy    27.09.18       7000
         1 Philip     20.05.18       7500
         2 Olesya     11.11.18       8000
         2 Ivan       03.04.19       8000
         3 Andrey     07.04.17       8000
         3 Alexander  04.07.15       9000

6 rows selected. 
*/



/* 3.2. Складіть запит, який поверне списки лідерів (список за убуванням відповідного
значення) у підгрупах, отриманих у першому завданні етапу 1.
*/

WITH
nTile AS (SELECT cName, hireDate, sal,
    NTILE(3) OVER (ORDER BY sal) AS salNtile
    FROM COACH),
rank AS (SELECT cName, hireDate, sal, salNtile,
    RANK() OVER (PARTITION BY salNtile ORDER BY sal) pos
    FROM nTile)
SELECT cName, hireDate, sal, salNtile, pos
FROM rank
WHERE pos = 1;

/* Результат:

CNAME      HIREDATE        SAL   SALNTILE        POS
---------- -------- ---------- ---------- ----------
Antoniy    27.09.18       7000          1          1
Olesya     11.11.18       8000          2          1
Ivan       03.04.19       8000          2          1
Andrey     07.04.17       8000          3          1
*/



/* 3.3. Модифікуйте рішення попереднього завдання, повернувши по 2 лідери у кожній
підгрупі.
*/

WITH
nTile AS (SELECT cName, hireDate, sal,
    NTILE(3) OVER (ORDER BY sal) AS salNtile
    FROM COACH),
rank AS (SELECT cName, hireDate, sal, salNtile,
    ROW_NUMBER() OVER (PARTITION BY salNtile ORDER BY sal) pos
    FROM nTile)
SELECT cName, hireDate, sal, salNtile, pos
FROM rank
WHERE pos <= 2;

/* Результат:

CNAME      HIREDATE        SAL   SALNTILE        POS
---------- -------- ---------- ---------- ----------
Antoniy    27.09.18       7000          1          1
Philip     20.05.18       7500          1          2
Olesya     11.11.18       8000          2          1
Ivan       03.04.19       8000          2          2
Andrey     07.04.17       8000          3          1
Alexander  04.07.15       9000          3          2

6 rows selected. 
*/



/* 3.4. Складіть запит, який повертає рейтинг будь-якого з перерахованих значень
відповідно до вашої предметноїобласті: товарів/послуг/співробітників/клієнтів тощо.
*/

SELECT cName, hireDate, sal,
    RANK() OVER (ORDER BY sal DESC) rank
FROM COACH;

/* Результат:

CNAME      HIREDATE        SAL       RANK
---------- -------- ---------- ----------
Alexander  04.07.15       9000          1
Olesya     11.11.18       8000          2
Ivan       03.04.19       8000          2
Andrey     07.04.17       8000          2
Philip     20.05.18       7500          5
Antoniy    27.09.18       7000          6

6 rows selected. 
*/



/* 3.5. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає перше значення у кожній підгрупі. Використати аналітичну функцію
FIRST_VALUE.
*/

WITH 
coach_first_sal AS (
    SELECT gymNo, cName, hireDate, sal,
	    FIRST_VALUE(sal) OVER (
            PARTITION BY gymNo ORDER BY sal DESC) as max_sal
	FROM COACH)
SELECT gymNo, cName, hireDate, sal
FROM coach_first_sal
WHERE sal = max_sal;


/* Результат: 

     GYMNO CNAME      HIREDATE        SAL
---------- ---------- -------- ----------
         1 Alexander  04.07.15       9000
         5 Andrey     07.04.17       8000
         6 Olesya     11.11.18       8000
*/