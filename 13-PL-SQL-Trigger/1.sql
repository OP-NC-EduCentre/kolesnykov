/* 1.1. Створити інформуючий тригер для виведення повідомлення на екран після
додавання, зміни або видалення рядка з будь-якої таблиці Вашої бази даних із зазначенням
у повідомленні операції, на яку зреагував тригер. Навести тест-кейс перевірки роботи
тригера.
*/

CREATE OR REPLACE TRIGGER coach_control_after
	AFTER INSERT OR UPDATE OR DELETE ON coach
BEGIN
	IF INSERTING THEN 
		DBMS_OUTPUT.PUT_LINE('INSERTING INTO COACH ... ');
	ELSIF UPDATING THEN 
		DBMS_OUTPUT.PUT_LINE('UPDATING COACH ... ');
	ELSIF DELETING THEN 
		DBMS_OUTPUT.PUT_LINE('DELETING COACH ... ');
	END IF;	
END;
/

INSERT INTO coach (coachNo, cName, sal) VALUES (7, 'Vlad', 7500);

UPDATE coach SET sal = 8000 WHERE coachNo = 7;

DELETE FROM coach WHERE coachNo = 7;

/* Результат:

Trigger COACH_CONTROL_AFTER compiled

1 row inserted.

1 row updated.

1 row deleted.

INSERTING INTO COACH ...

UPDATING COACH ...

DELETING COACH ...
*/



/* 1.2. Повторити попереднє завдання лише під час роботи користувача, ім'я якого
збігається з вашим логіном. Навести тест-кейс перевірки роботи тригера.
*/

CREATE OR REPLACE TRIGGER coach_control_after
	AFTER INSERT OR UPDATE OR DELETE ON coach
    FOR EACH ROW
    WHEN(USER = 'KOLESNIKOV')
BEGIN
	IF INSERTING THEN 
		DBMS_OUTPUT.PUT_LINE('INSERTING INTO COACH ... ');
	ELSIF UPDATING THEN 
		DBMS_OUTPUT.PUT_LINE('UPDATING COACH ... ');
	ELSIF DELETING THEN 
		DBMS_OUTPUT.PUT_LINE('DELETING COACH ... ');
	END IF;	
END;
/

INSERT INTO coach (coachNo, cName, sal) VALUES (7, 'Vlad', 7500);

UPDATE coach SET sal = 8000 WHERE coachNo = 7;

DELETE FROM coach WHERE coachNo = 7;

/* Результат:

Trigger COACH_CONTROL_AFTER compiled

1 row inserted.

1 row updated.

1 row deleted.

INSERTING INTO COACH ...

UPDATING COACH ...

DELETING COACH ...

При спробі іншого користувача виконати команду DML,
тригер нічого не виводить
*/
