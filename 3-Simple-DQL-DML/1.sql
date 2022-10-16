/* Етап 1 Конструювання простих INSERT-команд
*/

-- 1.1 Для кожної таблиці БД створити команди внесення даних,
-- тобто внести по два рядки.

INSERT INTO Loc 
   (locNo, lName) 
VALUES (1, 'ODESA');

INSERT INTO Loc 
   (locNo, lName) 
VALUES (2, 'KYIV');

-- 1.4 Створити команду налаштування формату date = dd/mm/yyyy.
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';


-- 1.2 Для однієї з таблиць створити команду додавання колонки типу date
-- з урахуванням предметної області.
ALTER TABLE Gym ADD openDate date;

INSERT INTO Gym 
   (gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo) 
VALUES (1, 'Levitan 79', NULL, 3, 56, 1);

INSERT INTO Gym 
   (gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo, openDate) 
VALUES (2, 'Kyrylivska 39', NULL, 5, 87, 2, '25/02/2017');

-- 1.3 Для зазначеної таблиці створити команду на внесення одного рядка,
-- але з невизначеним значенням колонки типу date.
INSERT INTO Gym 
   (gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo, openDate) 
VALUES (3, 'Vladimirskaya 1', NULL, 4, 67, 2, NULL);

-- 1.5 Для задіяної в завданні 1.2 таблиці створити ще одну команду 
-- на внесення одного рядка з урахуванням значення колонки типу date.
INSERT INTO Gym 
   (gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo, openDate) 
VALUES (4, 'Sofievskaya 21', NULL, 4, 67, 2, '11.10.2022');

INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (1, 'Alexander', NULL, TO_DATE('04/07/2015', 'DD/MM/YYYY'),
        9000, NULL, 1);

INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (2, 'Leonid', NULL, TO_DATE('09/02/2017', 'DD/MM/YYYY'),
        9000, NULL, 2);
        
INSERT INTO Cleaner
   (cleanerNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (1, 'Maria', NULL, TO_DATE('01/08/2015', 'DD/MM/YYYY'),
        3000, NULL, 1);

INSERT INTO Cleaner
   (cleanerNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (2, 'Anna', NULL, TO_DATE('04/3/2017', 'DD/MM/YYYY'),
        3000, NULL, 2);
        
INSERT INTO Administrator
   (administratorNo, aName, mgr, hireDate, sal, aWorkingHours, gymNo) 
VALUES (1, 'Dmitriy', NULL, TO_DATE('13/07/2015', 'DD/MM/YYYY'),
        3000, NULL, 1);

INSERT INTO Administrator
   (administratorNo, aName, mgr, hireDate, sal, aWorkingHours, gymNo) 
VALUES (2, 'Viktorya', NULL, TO_DATE('28/2/2017', 'DD/MM/YYYY'),
        3000, NULL, 2);

/*Результат завдань 1.1 – 1.5
1 row inserted.


1 row inserted.


Session altered.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.


1 row inserted.
*/

/* 1.6 Для однієї з таблиць, що містить обмеження цілісності потенційного
ключа, виконати команду додавання нового рядка зі значенням колонки,
що порушує це обмеження. Перевірити реакцію СКБД на таку зміну.
*/
INSERT INTO Loc 
   (locNo, lName) 
VALUES (3, 'ODESA');

/* Результат:
Error starting at line : 77 in command -
INSERT INTO Loc 
   (locNo, lName) 
VALUES (3, 'ODESA')
Error report -
ORA-00001: нарушено ограничение уникальности (KOLESNYKOV.LOC_LNAME_UNIQUE)
*/


/* 1.7 Для однієї з таблиць, що містить обмеження цілісності зовнішнього
ключа, виконати команду додавання нового рядка зі значенням колонки зовнішнього
ключа, який відсутній у колонці первинного ключа відповідної таблиці.
Перевірити реакцію СКБД на подібне додавання,
яке порушує обмеження цілісності зовнішнього ключа.
*/
INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (3, 'Nikolay', NULL, TO_DATE('15/08/2016', 'DD/MM/YYYY'),
        9000, NULL, 9);

/* Результат:
Error starting at line : 88 in command -
INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (3, 'Nikolay', NULL, TO_DATE('15/08/2016', 'DD/MM/YYYY'),
        9000, NULL, 9)
Error report -
ORA-02291: нарушено ограничение целостности (KOLESNYKOV.COACH_GYMNO_FK) - исходный ключ не найден
*/