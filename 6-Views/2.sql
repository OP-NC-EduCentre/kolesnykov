/* 2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
2.3 з лабораторної роботи No5, але враховує опцію «WITH READ ONLY»: отримати інформацію
про атрибутні типи. Отримати вміст таблиці.
*/

CREATE OR REPLACE VIEW INFO_ATTR_TYPE
(OBJECT_CODE, ATTR_ID, ATTR_CODE, NAME)
AS
SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME
	FROM OBJTYPE O, ATTRTYPE A
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID
    WITH READ ONLY;

SELECT * 
FROM INFO_ATTR_TYPE;

/* Результат:

View INFO_ATTR_TYPE created.

OBJECT_CODE             ATTR_ID ATTR_CODE            NAME                                                                                                                                                                                                    
-------------------- ---------- -------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LOC                           1 LOC                  Місто                                                                                                                                                                                                   
GYM                           2 GYM                  Адреса                                                                                                                                                                                                  
COACH                         3 NAME                 Прізвище                                                                                                                                                                                                
COACH                         4 SAL                  Зарплата                                                                                                                                                                                                
COACH                         5 HIREDATE             Дата зарахування                                                                                                                                                                                        
COACH                         6 WORK                 Робота                                                                                                                                                                                                  

6 rows selected.
*/



/* 2.2 Виконати видалення одного рядка з віртуальної таблиці, створеної у попередньому
завданні. Прокоментувати реакцію СУБД.
*/

DELETE FROM INFO_ATTR_TYPE WHERE INFO_ATTR_TYPE.attr_code = 3;

/* Результат:

Error starting at line : 13 in command -
DELETE FROM INFO_ATTR_TYPE WHERE INFO_ATTR_TYPE.attr_code = 3
Error at Command Line : 13 Column : 13
Error report -
SQL Error: ORA-42399: невозможно выполнить операцию DML для доступного только для чтения представления
42399.0000 - "cannot perform a DML operation on a read-only view"
*/



/* 2.3 Створити віртуальну таблицю, що містить дві колонки:
назва класу, кількість екземплярів об'єктів класу. Отримати вміст таблиці.
*/

CREATE OR REPLACE VIEW OBJECTS_COUNT
(OBJECT_TYPE, OBJECT_COUNT)
AS
SELECT OBJTYPE.NAME, COUNT(OBJECTS.OBJECT_ID)
	FROM OBJTYPE, OBJECTS
	WHERE OBJECTS.OBJECT_TYPE_ID = OBJTYPE.OBJECT_TYPE_ID
	GROUP BY OBJTYPE.NAME;

SELECT * 
FROM OBJECTS_COUNT;

/* Результат:

View OBJECTS_COUNT created.

OBJECT_TYPE                                  OBJECT_COUNT
-------------------------------------------- ------------
Місто                                                   2
Тренажерний зал                                         1
Тренер                                                  2
*/



/* 2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
створеної у попередньому завданні. Прокоментувати реакцію СУБД.
*/

UPDATE OBJECTS_COUNT
SET OBJECT_COUNT = 7
WHERE OBJECTS_COUNT.OBJECT_TYPE = 'Тренер';

/* Результат:

Error report -
SQL Error: ORA-01732: обработка данных для данного предст.пользователя не разрешена
01732. 00000 -  "data manipulation operation not legal on this view"
*Cause:    
*Action:
Не можна змінювати результат функцій агрегації
*/
