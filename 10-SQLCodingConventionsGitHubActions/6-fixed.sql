/* 1.2 Виконати команду зміни значення колонки створеної
віртуальної таблиці на значення, яка входить в умову
вибірки рядків із рішення попереднього завдання, при
цьому нове значення має відрізнятись від поточного.
*/

UPDATE GYM_LIST SET TRAININGZONES = 1
WHERE
    ADDRESS = 'Vladimirskaya 1';

SELECT
    GYMNO,
    ADDRESS,
    GWORKING,
    TRAININGZONES,
    SPORTSEQUIPMENT,
    LOCNO,
    OPENDATE
FROM GYM_LIST;

/* Результат:

1 row updated.

GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
----- --------------- -------- ------------- --------------- ---------- --------
3 Vladimirskaya 1                      1              67          2
*/
