/* 1.1. Виберіть таблицю бази даних, що містить стовпець типу date. Оголосіть змінні, що
відповідають стовпцям цієї таблиці, використовуючи посилальні типи даних. Надайте змінним
значення, використовуйте SQL-функції для формування значень послідовності, перетворення
дати до вибраного стилю. Виведіть на екран рядок.
*/

DECLARE
	v_coach coach%ROWTYPE;
BEGIN
	v_coach.coachNo := coach_coachNo_seq.nextval;
	v_coach.cName := 'Leonid';
	v_coach.hiredate := TO_DATE('13/12/2022','DD/MM/YYYY');
	v_coach.sal := 7250;
    v_coach.gymNo := 1;
	DBMS_OUTPUT.PUT_LINE('v_coachNo = ' || v_coach.coachNo);
    DBMS_OUTPUT.PUT_LINE('v_cName = ' || v_coach.cName);
    DBMS_OUTPUT.PUT_LINE('v_hiredate = ' || v_coach.hiredate);
    DBMS_OUTPUT.PUT_LINE('v_sal = ' || v_coach.sal);
    DBMS_OUTPUT.PUT_LINE('v_gymNo = ' || v_coach.gymNo);
END;
/

/* Результат:

v_coachNo = 7
v_cName = Leonid
v_hiredate = 13.12.22
v_sal = 7250
v_gymNo = 1
*/



/* 1.2. Додати інформацію до однієї з таблиць, обрану у попередньому завданні.
Використовувати формування нового значення послідовності та перетворення формату дати.
*/

BEGIN
	INSERT INTO coach(coachNo, cName, hiredate, sal, gymNo)
	VALUES(coach_coachNo_seq.nextval, 'Nikolay',
        to_date('17/12/2022','DD/MM/YYYY'), 7000, 1);
END;
/

/* Результат:

PL/SQL procedure successfully completed.
*/



/* 1.3. Для однієї з таблиць створити команду отримання середнього значення однієї з
цілих колонок, використовуючи умову вибірки за заданим значенням іншої колонки. Результат
присвоїти змінній і вивести на екран.
*/

DECLARE
	v_coach_avg_sal coach.sal%TYPE;
BEGIN
    SELECT AVG(sal)
    INTO v_coach_avg_sal
    FROM coach
    WHERE gymNo = 1;
	DBMS_OUTPUT.PUT_LINE('v_avg_sal_gym_1 = ' || v_coach_avg_sal);
END;
/

/* Результат:

v_avg_sal_gym_1 = 8000
*/



/* 1.4. Виконайте введення 5 рядків у таблицю бази даних, використовуючи цикл з
параметрами. Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/

BEGIN
	FOR i IN 1..5 LOOP
        INSERT INTO coach(coachNo, cName, hiredate, sal, gymNo)
        VALUES(coach_coachNo_seq.nextval, 'Alina',
            to_date('07/12/2022','DD/MM/YYYY'), 7500, 1);
	END LOOP;	
END;
/

/* Результат:

PL/SQL procedure successfully completed.
*/
