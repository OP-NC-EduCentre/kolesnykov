/* 5.1 Створити таблицю описів значень атрибутів екземплярів об'єктів.
*/

CREATE TABLE ATTRIBUTES (
	ATTR_ID NUMBER(10),
	OBJECT_ID NUMBER(20),
	VALUE VARCHAR2(4000),
	DATE_VALUE DATE,
	LIST_VALUE_ID NUMBER(10)
);  

ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_PK
	PRIMARY KEY (ATTR_ID, OBJECT_ID);
ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_LIST_VALUE_ID_FK
	FOREIGN KEY (LIST_VALUE_ID) REFERENCES LISTS (LIST_VALUE_ID);
ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES ATTRTYPE (ATTR_ID);
ALTER TABLE ATTRIBUTES ADD CONSTRAINT ATTRIBUTES_OBJECT_ID_FK
	FOREIGN KEY (OBJECT_ID) REFERENCES OBJECTS (OBJECT_ID);

/* Результат:

Table ATTRIBUTES created.

Table ATTRIBUTES altered.

Table ATTRIBUTES altered.

Table ATTRIBUTES altered.

Table ATTRIBUTES altered.
*/



/* 5.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3, та опису
атрибутів екземплярів об'єктів, заповнити описи значень атрибутів екземплярів об'єктів.
*/

INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, VALUE)
	VALUES(1, 1, 'Odessa');
    
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, VALUE)
	VALUES(1, 2, 'Kyiv');
    
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, VALUE)
	VALUES(3, 3, 'Alex');
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, VALUE)
	VALUES(4, 3, 8000);
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, DATE_VALUE)
	VALUES(5, 3, TO_DATE('21/05/2021','DD/MM/YYYY'));
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, LIST_VALUE_ID)
	VALUES(6, 3, 1);

INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, VALUE)
	VALUES(3, 4, 'Roman');
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, VALUE)
	VALUES(4, 4, 9000);
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, DATE_VALUE)
	VALUES(5, 4, TO_DATE('03/10/2020','DD/MM/YYYY'));
INSERT INTO ATTRIBUTES(ATTR_ID, OBJECT_ID, LIST_VALUE_ID)
	VALUES(6, 4, 2);

/* Результат:

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.
*/



/* 5.3 Модифікувати рішення завдання 4.3, отримавши колекцію екземплярів об'єктів за заданим
значенням одного з атрибутів об'єктів.
*/

SELECT COACH.NAME, A.VALUE SAL
FROM OBJECTS COACH, OBJTYPE COACH_TYPE, ATTRIBUTES A
WHERE 
	COACH_TYPE.CODE = 'COACH'
	AND COACH_TYPE.OBJECT_TYPE_ID = COACH.OBJECT_TYPE_ID
	AND COACH.OBJECT_ID = A.OBJECT_ID
	AND A.ATTR_ID = 4;

/* Результат:

NAME                    SAL 
-----------------------------------------------------------
Alex                    8000

Roman                   9000
*/
