/*
1.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
4.2 з лабораторної роботи No3: для однієї з таблиць створити команду отримання значень усіх
колонок (явно перерахувати) за окремими рядками з урахуванням умови, в якій рядкове
значення однієї з колонок має співпадати з якимось константним значенням. Отримати вміст
таблиці.
*/

CREATE OR REPLACE VIEW GYM_LIST
(gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo, openDate)
AS
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

SELECT * 
FROM GYM_LIST;

/* Результат:

View GYM_LIST created.

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         3 Vladimirskaya 1                      4              67          2         
*/



/*
1.2 Виконати команду зміни значення колонки створеної віртуальної таблиці на
значення, яка входить в умову вибірки рядків із рішення попереднього завдання, при цьому нове
значення має відрізнятись від поточного.
*/

UPDATE GYM_LIST SET trainingZones = 1
	WHERE
    address = 'Vladimirskaya 1';

SELECT * 
FROM GYM_LIST;

/* Результат:

1 row updated.

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         3 Vladimirskaya 1                      1              67          2         
*/



/* 1.3 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
3.2 з лабораторної роботи No4: для двох таблиць, пов'язаних через PK-колонку та FK-колонку,
створити команду отримання двох колонок першої та другої таблиць з використанням екві-
сполучення таблиць. Отримати вміст таблиці.
*/

CREATE OR REPLACE VIEW COACH_LIST
(no, name, GymNo, address)
AS
SELECT
    c.coachNo,
	c.cName,
	c.gymNo,
	g.address
FROM coach c JOIN gym g ON (c.gymNo = g.gymNo);

SELECT * 
FROM COACH_LIST;

/* Результат:

View COACH_LIST created.

        NO NAME            GYMNO ADDRESS        
---------- ---------- ---------- ---------------
         4 Antoniy             6 Sportivnaya 3  
         1 Alexander           1 Levitan 79     
         2 Leonid              2 Kyrylivska 39  
         3 Andrey              5 Pekarskaya 38  
*/



/* 1.4 Виконати команду додавання нового рядка до однієї з таблиць, що входить до запиту
з попереднього завдання.
*/

INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (coach_coachNo.NEXTVAL, 'Ivan', NULL, TO_DATE('03/04/2019', 'DD/MM/YYYY'),
        8000, NULL, 1);

SELECT * 
FROM COACH_LIST;

/* Результат:

1 row inserted.

        NO NAME            GYMNO ADDRESS        
---------- ---------- ---------- ---------------
         4 Antoniy             6 Sportivnaya 3  
        23 Ivan                1 Levitan 79     
         1 Alexander           1 Levitan 79     
         2 Leonid              2 Kyrylivska 39  
         3 Andrey              5 Pekarskaya 38  

*/
