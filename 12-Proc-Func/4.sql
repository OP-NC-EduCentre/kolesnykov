/* 4.1. З урахуванням вашої предметної області створити табличну функцію, що
повертає значення будь-яких двох колонок будь-якої таблиці з урахуванням значення однієї
з колонок, що передається як параметр. Показати приклад виклику функції.
*/

DROP TYPE coach_sal_info_List;
DROP TYPE coach_sal_info;

CREATE TYPE coach_sal_info AS OBJECT (
 cName 	VARCHAR(10),
 sal 	NUMBER(10)
);
/
CREATE TYPE coach_sal_info_List IS TABLE OF coach_sal_info;
/

CREATE OR REPLACE FUNCTION get_coach_list(v_gymNo IN NUMBER)
RETURN coach_sal_info_List
AS
	coach_list coach_sal_info_List := coach_sal_info_List();
BEGIN
 	SELECT coach_sal_info(cName, sal)
		 BULK COLLECT INTO coach_list 
		 FROM coach
		 WHERE gymNo = v_gymNo;
	RETURN coach_list ;
END;
/

SELECT cName, sal FROM TABLE(get_coach_list(1));

/* Результат:

Type COACH_SAL_INFO compiled

Type COACH_SAL_INFO_LIST compiled

Function GET_COACH_LIST compiled

CNAME             SAL
---------- ----------
Alexander        9000
Ivan             8000
*/



/* 4.2. Повторіть рішення попереднього завдання, але з використанням конвеєрної
табличної функції.
*/

CREATE OR REPLACE PACKAGE coach_pkg IS
	TYPE coach_sal_info IS RECORD (
        cName 	VARCHAR(10),
        sal 	NUMBER(10)
	);
	TYPE coach_sal_info_List IS TABLE OF coach_sal_info;
	FUNCTION get_coach_list(v_gymNo IN NUMBER)
		RETURN coach_sal_info_List PIPELINED;
END coach_pkg;
/

CREATE OR REPLACE PACKAGE BODY coach_pkg IS
	FUNCTION get_coach_list(v_gymNo IN NUMBER)
		RETURN coach_sal_info_List PIPELINED
	AS
	BEGIN
		FOR elem IN (SELECT cName, sal 
					FROM coach
					WHERE gymNo = v_gymNo) LOOP
			PIPE ROW(elem);
		END LOOP;
	END;
END coach_pkg;
/

SELECT cName, sal FROM TABLE(coach_pkg.get_coach_list(5));

/* Результат:


Package COACH_PKG compiled

Package Body COACH_PKG compiled

CNAME             SAL
---------- ----------
Philip           7500
Andrey           8000
*/
