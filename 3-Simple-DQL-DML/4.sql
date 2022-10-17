/* 4.1 Для однієї з таблиць створити команду отримання значень всіх колонок
(явно перерахувати) за окремими рядками з урахуванням умови: цілочисельне
значення однієї з колонок має бути більшим за якесь константне значення.
*/

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym
WHERE
    sportsequipment > 70;

/* Результат:

     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE  
---------- --------------- ---------- ------------- --------------- ---------- ----------
         2 Kyrylivska 39                          5              87          2 25/02/2017
*/

/* 4.2 Для однієї з таблиць створити команду отримання значень всіх колонок
(явно перерахувати) за окремими рядками з урахуванням умови: символьне значення
однієї з колонок має співпадати з якимось константним значенням.
*/

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym
WHERE
    address = 'Vladimirskaya 1';

/* Результат:

     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE  
---------- --------------- ---------- ------------- --------------- ---------- ----------
         3 Vladimirskaya 1                        4              67          2           
*/

/* 4.3 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
повинно містити в першому та третьому знакомісті якісь надані вами символи.
*/

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym
WHERE
    address LIKE 'S_f%';

/* Результат:

     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO
---------- --------------- ---------- ------------- --------------- ----------
OPENDATE
----------
         4 Sofievskaya 21                         4              67          2
11/10/2022
*/

/* 4.4 У завданні 1.2 було додано колонку типу date. Створити команду отримання значень
всіх колонок (явно перерахувати) за окремими рядками з урахуванням умови: значення доданої
колонки містить невизначене значення.
*/

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym
WHERE
    openDate IS NULL;

/* Результат:

     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO
---------- --------------- ---------- ------------- --------------- ----------
OPENDATE
----------
         1 Levitan 79                             3              56          1


         3 Vladimirskaya 1                        4              67          2
*/

/* 4.5 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
рядками з урахуванням умови, що поєднує умови з рішень завдань 4.1 та 4.2
*/

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym
WHERE
    sportsequipment > 70
    AND address = 'Kyrylivska 39';

/* Результат:

     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO
---------- --------------- ---------- ------------- --------------- ----------
OPENDATE
----------
         2 Kyrylivska 39                          5              87          2
25/02/2017
*/

/*4.6 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
рядками з урахуванням умови, що інвертує результат рішення 4.5
*/

SELECT 
    gymNo,
        address,
        gWorkingHours,
        trainingZones,
        sportsEquipment,
        locNo,
        openDate
FROM Gym
WHERE
    NOT(
        sportsequipment > 70
        AND address = 'Kyrylivska 39');

/* Результат:
     GYMNO ADDRESS         GWORKINGHO TRAININGZONES SPORTSEQUIPMENT      LOCNO
---------- --------------- ---------- ------------- --------------- ----------
OPENDATE
----------
         1 Levitan 79                             3              56          1


         3 Vladimirskaya 1                        4              67          2


         4 Sofievskaya 21                         4              67          2
11/10/2022
*/