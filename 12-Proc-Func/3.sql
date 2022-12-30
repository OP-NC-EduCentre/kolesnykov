/* 3.1. Оформіть рішення завдань етапу 2 у вигляді програмного пакета. Наведіть
приклад виклику збереженої процедури та функції, враховуючи назву пакету.
*/

CREATE OR REPLACE PACKAGE gym_staff_pkg IS
    PROCEDURE create_administrator(amount IN NUMBER);
    FUNCTION sum_sal_coach_from_gym(gym IN coach.gymNo%TYPE)
        RETURN NUMBER;
END gym_staff_pkg;
/

CREATE OR REPLACE PACKAGE BODY gym_staff_pkg IS
PROCEDURE create_administrator(amount IN NUMBER)
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

FUNCTION sum_sal_coach_from_gym(gym IN coach.gymNo%TYPE)
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
END gym_staff_pkg;
/

BEGIN
	gym_staff_pkg.create_administrator(100);
    DBMS_OUTPUT.PUT_LINE(gym_staff_pkg.sum_sal_coach_from_gym(1));
END;
/



/* Результат:

Package GYM_STAFF_PKG compiled

Package Body GYM_STAFF_PKG compiled

PL/SQL procedure successfully completed.

Time (centisec) = 2
17000
*/
