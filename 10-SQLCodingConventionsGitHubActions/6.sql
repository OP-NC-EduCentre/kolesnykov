/* Помилки:
L016	2 / 94	Line is too long.
L014	6 / 21	Unquoted identifiers must be consistently upper case.
L004	7 / 1	Incorrect indentation type found in file.
L003	7 / 2	Expected 0 indentations, found 1 [compared to line 06]
L014	8 / 5	Unquoted identifiers must be consistently upper case.
L044	10 / 1	Query produces an unknown number of result columns.
L001	10 / 9	Unnecessary trailing whitespace.
L016	17 / 86	Line is too long.
L016	18 / 86	Line is too long.
L001	19 / 77	Unnecessary trailing whitespace.
L016	19 / 86	Line is too long.
*/



/* 1.2 Виконати команду зміни значення колонки створеної віртуальної таблиці на
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