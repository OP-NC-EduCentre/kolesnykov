/* 2.6 Для однієї з таблиць створити команду отримання
значення двох колонок, значення яких відсортовані в
порядку зростання (для першої колонки) та в порядку
зменшення (друга колонка).
*/

SELECT
    GYMNO,
    SAL
FROM COACH
ORDER BY GYMNO ASC, SAL DESC;

/* Результат:

     GYMNO        SAL
---------- ----------
         1       9000
         2       9000
*/
