/* 4.1. Виконайте введення 5 рядків у таблицю бази даних із динамічною генерацією
команди. Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/

DECLARE
	v_coachNo coach.coachNo%TYPE;
	v_cName coach.cName%TYPE;
	v_hireDate coach.hireDate%TYPE;
    v_sal coach.sal%TYPE;
	v_gymNo coach.gymNo%TYPE;
	sql_str VARCHAR2(500);
BEGIN
	sql_str := 'INSERT INTO coach(coachNo, cName, hireDate, sal, gymNo)'
					|| ' VALUES(:1,:2,:3,:4,:5)';
	FOR i IN 1..5 LOOP
		v_coachNo := coach_coachNo_seq.NEXTVAL;
		v_cName := 'Jack';
		v_hireDate := to_date('21/12/2022','DD/MM/YYYY');
		v_sal := 8250;
        v_gymNo := 1;
		EXECUTE IMMEDIATE sql_str
			USING v_coachNo, v_cName, v_hireDate,
					v_sal, v_gymNo;
	END LOOP;
END;
/

/* Результат:

PL/SQL procedure successfully completed.
*/



/* 4.2. Скласти динамічний запит створення таблиці, іменами колонок якої будуть значення
будь-якої символьної колонки. Попередньо виконати перевірку існування таблиці з її
видаленням.
*/

DECLARE 
	create_str VARCHAR2(500);
	CURSOR c IS
		SELECT cName
        FROM coach;
BEGIN
	BEGIN
		EXECUTE IMMEDIATE 'DROP TABLE coach_new';
	EXCEPTION
		WHEN OTHERS THEN
			NULL;
	END;
	create_str := 'CREATE TABLE coach_new (';
	FOR coach_rec IN c LOOP
		create_str := create_str || coach_rec.cName || ' VARCHAR2(10),';
	END LOOP;
	create_str := RTRIM(create_str,',') || ')';
	EXECUTE IMMEDIATE create_str;
END;
/

/* Результат:

PL/SQL procedure successfully completed.
*/



/* 4.3. Команда ALTER SEQUENCE може змінювати початкове значення генератора
починаючи з СУБД версії 12. Для ранніх версій доводиться виконувати дві команди: видалення
генератора та створення генератора з новим початковим значенням.
З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
викликатиме один із варіантів SQL-запитів зміни початкового значення генератора залежно від
значення версії СУБД.
*/

DECLARE
    start_val NUMBER(4) := 7;
    sql_str VARCHAR2(500);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Oracle DB version = ' || DBMS_DB_VERSION.VERSION);
    
    IF DBMS_DB_VERSION.VERSION >= 12 THEN
        sql_str := 'ALTER SEQUENCE coach_coachNo_seq RESTART START WITH '
            || start_val;
        EXECUTE IMMEDIATE sql_str;
    ELSE
        sql_str := 'DROP SEQUENCE coach_coachNo_seq';
        EXECUTE IMMEDIATE sql_str;
        sql_str := 'CREATE SEQUENCE coach_coachNo_seq START WITH '
            || start_val;
        EXECUTE IMMEDIATE sql_str;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(sql_str);
END;
/

/* Результат:

Oracle DB version = 21
ALTER SEQUENCE coach_coachNo_seq RESTART START WITH 7
*/
