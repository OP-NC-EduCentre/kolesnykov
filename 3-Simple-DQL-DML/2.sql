-- 2.1 Для однієї з таблиць створити команду отримання значень всіх колонок
-- (явно перерахувати) у всіх рядках.

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym;

/* Результат:

     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE  
---------- --------------- ---------- ------------- --------------- ---------- ----------
         1 Levitan 79                             3              56          1           
         2 Kyrylivska 39                          5              87          2 25/02/2017
         3 Vladimirskaya 1                        4              67          2           
         4 Sofievskaya 21                         4              67          2 11/10/2022
*/

/* 2.2 Для однієї з таблиць створити команду отримання цілого числа колонки з
використанням будь-якої арифметичної операції. При виведенні на екран визначити для
зазначеної колонки нову назву псевдоніма.
*/

SELECT 
    cName AS name,
    	sal*12 AnnualSalary
FROM Coach;

/* Результат:

NAME       ANNUALSALARY
---------- ------------
Alexander        108000
Leonid           108000
*/

/* 2.3 Для однієї з таблиць, що містить колонку зовнішнього ключа створити команду отримання
значення колонки без дублювання значень.
*/

SELECT DISTINCT 
    locNo
FROM Gym;

/* Результат:

     LOCNO
----------
         1
         2
*/

/* 2.4 Для однієї з таблиць створити команду отримання результату конкатенації значень будь-
яких двох колонок. При виведенні на початок рядка виведення додати літерал «UNION=».
*/

SELECT
    'UNION = ' || cName || ' is hiredate ' || hiredate AS "Union"
FROM Coach;

/* Результат:

Union                                    
-----------------------------------------
UNION = Alexander is hiredate 04/07/2015
UNION = Leonid is hiredate 09/02/2017
*/

/* 2.5 Модернізувати рішення завдання 2.2, отримавши в порядку
зростання значення псевдоніму.
*/

SELECT 
    cName AS name,
    	sal*12 AnnualSalary
FROM Coach
ORDER BY AnnualSalary;

/* Результат:

NAME       ANNUALSALARY
---------- ------------
Leonid           108000
Alexander        108000
*/

/* 2.6 Для однієї з таблиць створити команду отримання значення двох колонок, значення
яких відсортовані в порядку зростання (для першої колонки) та в порядку зменшення (друга
колонка).
*/


SELECT 
    gymNo, 
    sal
FROM Coach
ORDER BY gymNo, sal DESC;

/* Результат:

     GYMNO        SAL
---------- ----------
         1       9000
         2       9000
*/