/* 2.1. Створити тригер для реалізації каскадного видалення рядків зі значеннями PK-
колонки, пов'язаних з FK-колонкою. Навести тест-кейс перевірки роботи тригера.
*/

CREATE OR REPLACE TRIGGER gym_del_cascade
  AFTER DELETE ON gym
  FOR EACH ROW
BEGIN
  DELETE FROM coach WHERE coach.gymNo = :OLD.gymNo;
  DELETE FROM administrator WHERE administrator.gymNo = :OLD.gymNo;
  DELETE FROM cleaner WHERE cleaner.gymNo = :OLD.gymNo;
END;
/

DELETE FROM gym;

SELECT * 
FROM cleaner;

/* Результат:

Trigger GYM_DEL_CASCADE compiled

11 rows deleted.

no rows selected
*/



/* 2.2. Створити тригер для реалізації предметно-орієнтованого контролю спроби
додавання значення FK-колонки, що не існує у PK-колонці. Навести тест-кейс перевірки
роботи тригера.
*/

CREATE OR REPLACE TRIGGER coach_insert_coachNo_control
  BEFORE INSERT ON coach
  FOR EACH ROW
DECLARE
	gymNo_ gym.gymNo%TYPE;
BEGIN
	SELECT gymNo INTO gymNo_ FROM gym
		WHERE gymNo = :NEW.gymNo;
EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20551,
				'Gym with gymNo='
				|| :NEW.gymNo || ' not exists!'
			);
END;
/


INSERT INTO coach (coachNo, cName, sal, hireDate, gymNo) 
	VALUES(8, 'Olesya', 7000, to_date('18/12/2022','dd/mm/yyyy'), 50);

INSERT INTO coach (coachNo, cName, sal, hireDate, gymNo) 
	VALUES(7, 'Nikolay', 7000, to_date('17/12/2022','dd/mm/yyyy'), 1);

/* Результат:

Trigger COACH_INSERT_COACHNO_CONTROL compiled

Error starting at line : 19 in command -
INSERT INTO coach (coachNo, cName, sal, hireDate, gymNo) 
	VALUES(8, 'Olesya', 7000, to_date('18/12/2022','dd/mm/yyyy'), 50)
Error report -
ORA-20551: Gym with gymNo=50 not exists!
ORA-06512: на  "KOLESNIKOV.COACH_INSERT_COACHNO_CONTROL", line 8
ORA-04088: ошибка во время выполнения триггера 'KOLESNIKOV.COACH_INSERT_COACHNO_CONTROL'

1 row inserted.
*/
