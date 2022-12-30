/* 2.1. Повторити виконання завдання 1 етапу 1, створивши процедуру з вхідним
параметром у вигляді кількості рядків, що вносяться.
Навести приклад виконання створеної процедури.
*/

CREATE OR REPLACE PROCEDURE create_administrator(amount IN NUMBER)
IS
	t1 INTEGER;
	t2 INTEGER;
	delta INTEGER;
BEGIN
    t1 := DBMS_UTILITY.get_time;
	FOR i IN 1..amount
        LOOP
        INSERT INTO administrator(administratorNo, aName, hireDate, sal, gymNo)
        VALUES(administrator_administratorNo_seq.nextval, 'Alina',
            to_date('07/12/2022','DD/MM/YYYY'), 3500, 2);
	END LOOP;
    t2 := DBMS_UTILITY.get_time;
    delta := t2 - t1;
    DBMS_OUTPUT.PUT_LINE('Time (centisec) = ' || delta);
END;
/

BEGIN
    create_administrator(1000);
END;
/

/* Результат:

Time (centisec) = 6
*/



/* 2.2. Створити функцію, яка повертає суму значень однієї з цілих колонок однієї з
таблиць. Навести приклад виконання створеної функції.
*/

-- Отримання суми всіх зарплат тренерів із певного тренажерного залу

CREATE OR REPLACE FUNCTION sum_sal_coach_from_gym(gym IN coach.gymNo%TYPE)
RETURN NUMBER
IS
    res NUMBER;
BEGIN
    SELECT SUM(sal)
    INTO res
    FROM coach
    WHERE gymNo = gym;
    RETURN res;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(sum_sal_coach_from_gym(1));

/* Результат:

17000
*/
