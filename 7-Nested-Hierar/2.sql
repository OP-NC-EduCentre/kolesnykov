/* 2.1 Багатотабличне внесення даних.
Створіть один схожий запит, виконавши 
одночасне внесення до двох таблиць вашої БД.
*/

-- Використовуючи один INSERT-оператор, зареєструвати нового тренера
-- У новому залі, який також має бути зареєстрований.
-- Адреса залу = 'Primorskaya 8' і розташований в тому самому місті, 
-- що і зал його керівника.
-- Тренер: ім'я = 'Nikolay', дата зарахування = поточна дата,
-- зарплата = 7000, керівником є тренер з ім'ям Ivan.

CREATE SEQUENCE gymNo START WITH 8 INCREMENT BY 10;
CREATE SEQUENCE coachNo START WITH 6;
INSERT ALL
	INTO gym (gymNo, address, locNo)
		VALUES (gymNo.NEXTVAL, 'Primorskaya 8', locNo) 
	INTO coach (coachNo, cName, mgr, hireDate, sal, gymNo)
		VALUES (coachNo.NEXTVAL, 'Nikolay', coachNo, SYSDATE,
        7000, gymNo.CURRVAL)
SELECT C.coachNo, G.locNo
FROM coach C, gym G
WHERE C.cName = 'Ivan' 
		AND C.gymNo = G.gymNo;

/* Результат: 

Sequence GYMNO created.

Sequence COACHNO created.

2 rows inserted.
*/



/* 2.2 Використання багатостовпцевих підзапитів при зміні даних.
Створіть один схожий запит на зміну двох колонок однієї таблиці
вашої БД, використовуючи багатостовпцевий підзапит.
*/

-- Зміна зарплати та залу тренера
-- з номером = 4 на такі ж, як у тренера з номером = 3.

UPDATE coach
  SET  (sal, gymNo) = 
				  (SELECT sal, gymNo
                          FROM    coach
                          WHERE   coachNo = 3)
  WHERE   coachNo = 4;

/* Результат: 

1 row updated.
*/



/* 2.3 Видалення рядків із використанням кореляційних підзапитів.
Створіть один схожий запит на видалення рядків таблиці за допомогою 
EXISTS або NOT EXISTS.
*/

-- Видалити всі міста, які не мають тренажерних залів.

DELETE FROM loc L
	WHERE NOT EXISTS  
		       (SELECT gymNo
 			    FROM gym G
 			    WHERE L.locNo = G.locNo);

/* Результат: 

1 row deleted.
*/



/* 2.4 Поєднаний INSERT/UPDATE запит – оператор MERGE.
Створіть один схожий запит на видалення, використовуючи 
одну або дві таблиці вашої бази даних.
*/

-- Створюємо копію таблиці змінюємо номер тренажерного залу
-- у всіх тренерів на 1 і видаляємо тренерів із зарплатою
-- менше 8000. Після відновлюємо дані у таблиці копії.


CREATE TABLE coach_copy AS
	SELECT * FROM coach;
    
UPDATE coach_copy SET gymNo = 1;

DELETE FROM coach_copy
	WHERE sal < 8000;
    
MERGE INTO coach_copy copy
	USING coach C
		ON (C.coachNo = copy.coachNo)
	WHEN MATCHED THEN
		UPDATE SET copy.gymNo = C.gymNo
	WHEN NOT MATCHED THEN
		INSERT (coachNo, cName, hireDate, sal, gymNo)
			VALUES (C.coachNo, C.cName, C.hireDate,
                    C.sal, C.gymNo);

/* Результат: 

Table COACH_COPY created.

4 rows updated.

1 row deleted.

4 rows merged.
*/