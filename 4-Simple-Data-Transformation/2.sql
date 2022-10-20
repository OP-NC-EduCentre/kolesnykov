/* 2.1 Для однієї з таблиць створити команду отримання символьних значень колонки з
переведенням першого символу у верхній регістр, інших у нижній. При виведенні на екран визначити
для вказаної колонки нову назву псевдоніму.
*/

SELECT 
    locNo, 
    INITCAP(lname) AS CITY
FROM loc; 

/* Результат: 

     LOCNO CITY           
---------- ---------------
         3 Lviv           
         4 Chernomorsk    
         1 Odesa          
         2 Kyiv    
*/



/* 2.2. Модифікувати рішення попереднього завдання, створивши команду оновлення значення
вказаної колонки у таблиці.
*/

UPDATE loc 
    SET lname = INITCAP(lname);

/* Результат: 

4 rows updated.
*/



/* 2.3 Для однієї з символьних колонок однієї з таблиць створити команду отримання
мінімальної, середньої та максимальної довжин рядків.
*/

SELECT
    MAX(LENGTH(cName)),
    AVG(LENGTH(cName)),
    MIN(LENGTH(cName))
FROM coach;

/* Результат: 

MAX(LENGTH(CNAME)) AVG(LENGTH(CNAME)) MIN(LENGTH(CNAME))
------------------ ------------------ ------------------
                 9                  7                  6
*/



/* 2.4 Для колонки типу date однієї з таблиць отримати кількість днів, тижнів та місяців, що
пройшли до сьогодні.
*/

SELECT
    cName,
    ROUND((SYSDATE-hiredate)) DAY,
    ROUND((SYSDATE-hiredate)/7) WEEKS,
    ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)) MONTH
FROM Coach;

/* Результат:

CNAME             DAY      WEEKS      MONTH
---------- ---------- ---------- ----------
Antoniy          1485        212         49
Alexander        2666        381         88
Leonid           2080        297         68
Andrey           2023        289         66
 */
