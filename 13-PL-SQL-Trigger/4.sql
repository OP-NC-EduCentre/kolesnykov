/* 4.1. Створити таблицю для реєстрації наступних DDL-подій: тип події, що спричинила
запуск тригера; ім'я користувача; ім'я об'єкта БД. Створити тригер реєстрації заданих подій
створення об'єктів. Подати тест-кейси перевірки роботи тригера.
*/

CREATE TABLE ddl_action_log (
	sys_event VARCHAR2(30),
    login_user VARCHAR2(30),
    obj_name VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER track_ddl_action
	AFTER CREATE ON KOLESNIKOV.SCHEMA
BEGIN
	INSERT into ddl_action_log VALUES(
        ORA_SYSEVENT,
		ORA_LOGIN_USER,
		ORA_DICT_OBJ_NAME);
END;
/

CREATE TABLE TEST_TABLE1 ( 
	ID INTEGER, 
	NAME VARCHAR2(10)
);

SELECT * 
FROM ddl_action_log;

/* Результат:

Table DDL_ACTION_LOG created.

Trigger TRACK_DDL_ACTION compiled

Table TEST_TABLE1 created.

SYS_EVENT                      LOGIN_USER                     OBJ_NAME                      
------------------------------ ------------------------------ ------------------------------
CREATE                         KOLESNIKOV                     TEST_TABLE1                   
*/
