/* 1.1 Для всіх таблиць нової БД створити генератори послідовності, щоб забезпечити
автоматичне створення нових значень колонок, які входять у первинний ключ. Врахувати наявність
рядків у таблицях. Виконати тестове внесення одного рядка до кожної таблиці.
*/

CREATE SEQUENCE loc_locno START WITH 3;

CREATE SEQUENCE gym_gymNo START WITH 5;

CREATE SEQUENCE coach_coachNo START WITH 3;

CREATE SEQUENCE cleaner_cleanerNo START WITH 3;

CREATE SEQUENCE administrator_administratorNo START WITH 3;

INSERT INTO Loc (locno, lname )
	VALUES (loc_locno.NEXTVAL, 'LVIV');

INSERT INTO Gym 
   (gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo) 
VALUES (gym_gymNo.NEXTVAL, 'Pekarskaya 38', NULL, 2, 40, loc_locno.CURRVAL);

INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (coach_coachNo.NEXTVAL, 'Andrey', NULL, TO_DATE('07/04/2017', 'DD/MM/YYYY'),
        8000, NULL, gym_gymNo.CURRVAL);

INSERT INTO Cleaner
   (cleanerNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (cleaner_cleanerNo.NEXTVAL, 'Victor', NULL, TO_DATE('03/04/2017', 'DD/MM/YYYY'),
        3200, NULL, gym_gymNo.CURRVAL);

INSERT INTO Administrator
   (administratorNo, aName, mgr, hireDate, sal, aWorkingHours, gymNo) 
VALUES (administrator_administratorNo.NEXTVAL, 'Alexey', NULL, TO_DATE('01/04/2017', 'DD/MM/YYYY'),
        3500, NULL, gym_gymNo.CURRVAL);

/* Результат:
Sequence LOC_LOCNO created.
Sequence GYM_GYMNO created.
Sequence COACH_COACHNO created.
Sequence CLEANER_CLEANERNO created.
Sequence ADMINISTRATOR_ADMINISTRATORNO created.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
*/



/* 1.2 Для всіх пар взаємопов'язаних таблиць створити транзакції, що включають дві INSERT-
команди внесення рядка в дві таблиці кожної пари з урахуванням зв'язку між PK-колонкою першої
таблиці і FK-колонкою 2-ї таблиці пари з використанням псевдоколонок NEXTVAL і CURRVAL.
*/

INSERT INTO Loc (locno, lname )
	VALUES (loc_locno.NEXTVAL, 'CHERNOMORSK');

INSERT INTO Gym 
   (gymNo, address, gWorkingHours, trainingZones, sportsEquipment, locNo) 
VALUES (gym_gymNo.NEXTVAL, 'Sportivnaya 3', NULL, 2, 35, loc_locno.CURRVAL);

INSERT INTO Coach
   (coachNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (coach_coachNo.NEXTVAL, 'Antoniy', NULL, TO_DATE('27/09/2018', 'DD/MM/YYYY'),
        7000, NULL, gym_gymNo.CURRVAL);

INSERT INTO Cleaner
   (cleanerNo, cName, mgr, hireDate, sal, cWorkingHours, gymNo) 
VALUES (cleaner_cleanerNo.NEXTVAL, 'Mila', NULL, TO_DATE('09/09/2018', 'DD/MM/YYYY'),
        2800, NULL, gym_gymNo.CURRVAL);

INSERT INTO Administrator
   (administratorNo, aName, mgr, hireDate, sal, aWorkingHours, gymNo) 
VALUES (administrator_administratorNo.NEXTVAL, 'Svyatoslav', NULL, TO_DATE('15/09/2018', 'DD/MM/YYYY'),
        3300, NULL, gym_gymNo.CURRVAL);

/* Результат:

1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
1 row inserted.
*/



/* 1.3 Отримати інформацію про створені генератори послідовностей, використовуючи системну
таблицю СУБД Oracle.
*/

SELECT SEQUENCE_NAME,LAST_NUMBER
	FROM USER_SEQUENCES
		WHERE SEQUENCE_NAME IN 
        ('LOC_LOCNO', 
        'GYM_GYMNO',
        'COACH_CHOACHNO',
        'CLEANER_CLEANERNO',
        'ADMINISTRATOR_ADMINISTRATORNO'); 

/* Результат:

SEQUENCE_NAME                                                                                                                    LAST_NUMBER
-------------------------------------------------------------------------------------------------------------------------------- -----------
ADMINISTRATOR_ADMINISTRATORNO                                                                                                             23
CLEANER_CLEANERNO                                                                                                                         23
GYM_GYMNO                                                                                                                                 25
LOC_LOCNO                                                                                                                                 23
*/



/* 1.4 Використовуючи СУБД Oracle >= 12 для однієї з таблиць створити генерацію унікальних
значень PK-колонки через DEFAULT-оператор. Виконати тестове внесення одного рядка до таблиці.
*/

ALTER TABLE Gym MODIFY 
	(gymNo number DEFAULT gym_gymNo.nextval NOT NULL);

INSERT INTO Gym 
   (address, gWorkingHours, trainingZones, sportsEquipment, locNo) 
VALUES ('Korabelnaya 67', NULL, 2, 30, loc_locno.CURRVAL);

SELECT * FROM Gym;

/* Результат:

Table GYM altered.
1 row inserted.

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         6 Sportivnaya 3                        2              35          4         
         7 Korabelnaya 67                       2              30          4         
         1 Levitan 79                           3              56          1         
         2 Kyrylivska 39                        5              87          2 25.02.17
         3 Vladimirskaya 1                      4              67          2         
         4 Sofievskaya 21                       4              67          2 11.10.22
         5 Pekarskaya 38                        2              40          3         

7 rows selected. 
*/
