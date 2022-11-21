/* 1.1 Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-
з'єднанням.
*/

-- Отримати список прізвищ тренерів,
-- зарплата яких більша за зарплату тренера за номером 3.

SELECT cName
FROM coach
WHERE sal > 
           (
           SELECT sal
             FROM coach WHERE coachNo = 3
            );

-- Отримати список прізвищ тренерів,
-- які працюють у тому ж залі як і тренер під номером 3
-- та зарплата яких більша за зарплату тренера за номером 4.

SELECT cName, gymNo FROM coach
WHERE gymNo = 
      (SELECT gymNo FROM coach WHERE coachNo = 3)
AND     sal >
      (SELECT sal
      FROM coach WHERE coachNo = 4);

/* Результат:

CNAME     
----------
Alexander


CNAME           GYMNO
---------- ----------
Andrey              5
*/



/* 1.2 Використання агрегатних функцій у підзапитах.
*/

-- Отримати список тренерів, зарплата яких максимальна

SELECT cName, gymNo, sal
FROM coach
WHERE sal = 
           (SELECT MAX(sal) FROM coach);

/* Результат:

CNAME           GYMNO        SAL
---------- ---------- ----------
Alexander           1       9000
*/



/* 1.3 Пропозиція HAVING із підзапитами.
*/

-- Отримати список залів, у яких середня зарплата тренерів
-- більше середньої зарплати тренера у всій компанії

SELECT gymNo, AVG(sal)
FROM coach
GROUP BY gymNo
HAVING AVG(sal) >
				(SELECT AVG(sal) FROM coach);

/* Результат:

     GYMNO   AVG(SAL)
---------- ----------
         1       8500
*/



/* 1.4 Виконання багаторядкових підзапитів
*/

-- Отримати список тренерів, які не є тренерами у задонному залі,
-- а зарплата яких менша за будь-яку зарплату, яку отримують тренера у задонному залі

SELECT coachNo, cName, gymNo
FROM coach
WHERE sal < ANY 
				(SELECT sal FROM coach 
					WHERE gymNo = 1)	
		AND gymNo <> 1;

-- Отримати список тренерів, зарплата яких більша
-- середньої зарплати у різних залах

SELECT coachNo, cName, gymNo
FROM coach
WHERE sal > ALL
				(SELECT AVG(sal) FROM coach 
					GROUP BY gymNo);

/* Результат:

   COACHNO CNAME           GYMNO
---------- ---------- ----------
         3 Andrey              5
         4 Antoniy             6


   COACHNO CNAME           GYMNO
---------- ---------- ----------
         1 Alexander           1
*/



/* 1.5 Використання оператора WITH для структуризації запиту
*/

-- Вибрати тренерів з більшою зарплатою,
-- ніж середня зарплата у тренерів у їх залах

WITH
AVG_SAL AS
	(
		SELECT gymNo, AVG(sal) salAvg
		FROM coach
		GROUP BY gymNo
	)
SELECT C.cName, C.sal, C.gymNo, S.salAvg
FROM coach C, AVG_SAL S
	WHERE 	C.gymNo = S.gymNo
			AND C.sal > S.salAvg;

/* Результат:

CNAME             SAL      GYMNO     SALAVG
---------- ---------- ---------- ----------
Alexander        9000          1       8500
*/



/* 1.6 Використання кореляційних підзапитів
*/

-- Отримати список залів, у яких є тренери

SELECT G.address, G.gymNo
	FROM gym G
	WHERE EXISTS (
			SELECT C.gymNo
			FROM coach C 
			WHERE C.gymNo = G.gymNo);

/* Результат:

ADDRESS              GYMNO
--------------- ----------
Levitan 79               1
Pekarskaya 38            5
Sportivnaya 3            6
*/