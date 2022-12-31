/* 3.1. Розробити механізм журналізації DML-операцій, що виконуються над таблицею
вашої бази даних, враховуючи такі дії:
– створити таблицю з ім'ям LOG_ім'я_таблиці. Структура таблиці повинна
включати: ім'я користувача, тип операції, дата виконання операції, атрибути, що містять
старі та нові значення.
– створити тригер журналювання.
Перевірити роботу тригера журналювання для операцій INSERT, UPDATE,
DELETE.
*/

CREATE TABLE coach_log (
	new_coachNo	 NUMBER,
	new_cName	 CHAR(40),
	new_sal		 NUMBER,
    new_gymNo	 NUMBER,
	old_cName	 CHAR(40),
	old_sal	     NUMBER,
    old_gymNo	 NUMBER,
	op_type	 	 CHAR(6),
	user_name 	 CHAR(20),
	change_date  DATE
);

CREATE OR REPLACE TRIGGER coach_log
	AFTER INSERT OR UPDATE OR DELETE ON coach
	FOR EACH ROW
DECLARE 
	op_type_ coach_log.op_type%TYPE;
BEGIN
	IF INSERTING THEN op_type_ := 'INSERT'; END IF;
	IF UPDATING THEN op_type_ := 'UPDATE';  END IF;
	IF DELETING THEN op_type_ := 'DELETE'; END IF;
	INSERT INTO coach_log VALUES (
		:NEW.coachNo,
		:NEW.cName,
		:NEW.sal,
        :NEW.gymNo,
		:OLD.cName,
		:OLD.sal,
        :OLD.gymNo,
		op_type_,
		USER,
		SYSDATE
	);
END;
/

INSERT INTO coach (coachNo, cName, sal, gymNo)
    VALUES(8, 'Denis', 7500, 5);

UPDATE coach
SET sal = 8000 
WHERE 
    coachNo = 8;
    
DELETE FROM coach
WHERE 
    coachNo = 8;

SELECT * 
FROM coach_log;

/* Результат:

Table COACH_LOG created.

Trigger COACH_LOG compiled

1 row inserted.

1 row updated.

1 row deleted.

NEW_COACHNO NEW_CNAME                                   NEW_SAL  NEW_GYMNO OLD_CNAME                                   OLD_SAL  OLD_GYMNO OP_TYP USER_NAME            CHANGE_D
----------- ---------------------------------------- ---------- ---------- ---------------------------------------- ---------- ---------- ------ -------------------- --------
          8 Denis                                          7500          5                                                                INSERT KOLESNIKOV           31.12.22
          8 Denis                                          8000          5 Denis                                          7500          5 UPDATE KOLESNIKOV           31.12.22
                                                                           Denis                                          8000          5 DELETE KOLESNIKOV           31.12.22
*/



/* 3.2. Припустимо, що використовується СУБД до 12-ї версії, яка не підтримує механізм
DEFAULT SEQUENCE, який дозволяє автоматично внести нове значення первинного
ключа, якщо воно не задано при операції внесення. Для будь-якої колонки вашої бази даних
створити тригер з підтримкою механізму DEFAULT SEQUENCE. Навести тест-кейс
перевірки роботи тригера.
*/

CREATE SEQUENCE coach_coachNo START WITH 8;

CREATE OR REPLACE TRIGGER coach_default_sequence
	BEFORE INSERT ON coach
	FOR EACH ROW
BEGIN
	IF :NEW.coachNo IS NULL THEN
		:NEW.coachNo := coach_coachNo.NEXTVAL;
	END IF;
END;
/

INSERT INTO coach (cName, sal, hiredate, gymNo)
    VALUES('Alex', 7250, to_date('22/12/2022','dd/mm/yyyy'), 6);

SELECT coachNo, cName
FROM coach
WHERE
     cName = 'Alex';

/* Результат:

Sequence COACH_COACHNO created.

Trigger COACH_DEFAULT_SEQUENCE compiled

1 row inserted.

   COACHNO CNAME     
---------- ----------
         8 Alex      
*/
