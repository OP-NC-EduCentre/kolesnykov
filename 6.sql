/* 6.1 Створити таблицю описів зв'язків "іменована асоціація" між екземплярами об'єктів.
*/

CREATE TABLE OBJREFERENCE (
	ATTR_ID   NUMBER(20),
	REFERENCE NUMBER(20),
	OBJECT_ID NUMBER(20)
); 

ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_PK
	PRIMARY KEY (ATTR_ID,REFERENCE,OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_REFERENCE_FK
	FOREIGN KEY(REFERENCE) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_OBJECT_ID_FK
	FOREIGN KEY (OBJECT_ID) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_ATTR_ID_FK
	FOREIGN KEY (ATTR_ID) REFERENCES ATTRTYPE (ATTR_ID);

/* Результат:

Table OBJREFERENCE created.

Table OBJREFERENCE altered.

Table OBJREFERENCE altered.

Table OBJREFERENCE altered.

Table OBJREFERENCE altered.
*/



/* 6.2 Заповнити таблицю зв'язків з урахуванням можливих зв'язків «іменована асоціація» між
раніше створеними екземплярами об'єктів класів.
*/

/*
Екземпляр об'єкта "Тренер" - "Alex" (OBJECT_ID = 3)
зв'язаний з екземпляром об'єкта "Тренажерний зал" - "Pekarskaya 16" ( OBJECT_ID = 2 )
атрибутним зв'язком "WORK" (ATTR_ID = 6) за кратністю "багато до одного"
*/
INSERT INTO OBJREFERENCE (ATTR_ID,OBJECT_ID,REFERENCE) 
	VALUES (6,3,2);
/*
Екземпляр об'єкта "Тренер" - "Roman" (OBJECT_ID = 4)
зв'язаний з екземпляром об'єкта "Тренажерний зал" - "Pekarskaya 16" ( OBJECT_ID = 2 )
атрибутним зв'язком "WORK" (ATTR_ID = 6) за кратністю "багато до одного"
*/
INSERT INTO OBJREFERENCE (ATTR_ID,OBJECT_ID,REFERENCE) 
	VALUES (6,4,2);

/* Результат:

1 row inserted.

1 row inserted.
*/
