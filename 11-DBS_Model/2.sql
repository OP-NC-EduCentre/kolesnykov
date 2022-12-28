/* 2.1. Повторити виконання завдання 3 етапу 1, забезпечивши контроль відсутності даних у
відповіді на запит із використанням винятку.
*/

DECLARE
	v_coach_avg_sal coach.sal%TYPE;
BEGIN
    SELECT sal
    INTO v_coach_avg_sal
    FROM coach
    WHERE gymNo = 111;
	DBMS_OUTPUT.PUT_LINE('v_avg_sal_gym_1 = ' || v_coach_avg_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Gym number not found');
END;
/

/* Результат:

Gym number not found
*/



/* 2.2. Повторити виконання завдання 3 етапу 1, забезпечивши контроль отримання
багаторядкової відповіді на запит.
*/

DECLARE
	v_coach_avg_sal coach.sal%TYPE;
BEGIN
    SELECT sal
    INTO v_coach_avg_sal
    FROM coach
    WHERE gymNo = 1;
	DBMS_OUTPUT.PUT_LINE('v_avg_sal_gym_1 = ' || v_coach_avg_sal);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Only one value is expected');
END;
/

/* Результат:

Only one value is expected
*/



/* 2.3. Повторити виконання завдання 3 етапу 1, забезпечивши контроль за внесенням
унікальних значень.
*/

BEGIN
	INSERT INTO coach(coachNo, cName, hiredate, sal, gymNo)
	VALUES(2, 'Nikolay', to_date('17/12/2022','DD/MM/YYYY'), 7000, 1);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Gym number is already exists');
END;
/

/* Результат:

Gym number is already exists
*/
