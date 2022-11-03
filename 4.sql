/* 4.1 Створити таблицю описів екземплярів об'єктів.
*/

CREATE TABLE OBJECTS (
	OBJECT_ID      NUMBER(20),
	PARENT_ID      NUMBER(20),
	OBJECT_TYPE_ID NUMBER(20),
	NAME           VARCHAR2(2000),
	DESCRIPTION    VARCHAR2(4000)
);

ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PK
	PRIMARY KEY (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);

/* Результат:

Table OBJECTS created.

Table OBJECTS altered.

Table OBJECTS altered.

Table OBJECTS altered.
*/



/* 4.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3,
заповнити описи екземплярів об'єктів.
*/

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (1,NULL,1,'Odessa',NULL);
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (2,NULL,1,'Kyiv',NULL);
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (3,NULL,3,'Alex',NULL);
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (4,NULL,3,'Roman',NULL);

/* Результат:

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.
*/



/* 4.3 Отримати колекцію екземплярів об'єктів для одного з об'єктних типів, використовуючи
його код.
*/

SELECT OBJECT_ID,NAME
	FROM OBJECTS
	WHERE OBJECT_TYPE_ID = 1;

/* Результат:

 OBJECT_ID       NAME 
---------------------------------------------------------------------------
Odessa             1

Kyiv               2
*/



/* 4.4 Отримати один екземпляр об'єкта заданого імені для одного з об'єктних типів,
використовуючи його код.
*/

SELECT COACH.OBJECT_ID,COACH.NAME
FROM OBJECTS COACH, OBJTYPE COACH_TYPE
WHERE 
	COACH.OBJECT_ID = 3
	AND COACH_TYPE.CODE = 'COACH'
	AND COACH_TYPE.OBJECT_TYPE_ID = COACH.OBJECT_TYPE_ID;

/* Результат:

 OBJECT_ID       NAME 
---------------------------------------------------------------------------
 3               Alex 
*/
