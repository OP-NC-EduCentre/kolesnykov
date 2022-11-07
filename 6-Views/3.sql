/* 3.1 Створити нового користувача, ім'я якого = «ваше_прізвище_латиницею»+'EAV',
наприклад, blazhko_eav, з правами, достатніми для створення та заповнення таблиць БД EAV.
*/

CREATE USER kolesnikov_eav IDENTIFIED BY qwerty;
GRANT CONNECT TO kolesnikov_eav;
GRANT RESOURCE TO kolesnikov_eav;
GRANT CREATE TABLE TO kolesnikov_eav;
GRANT CREATE SEQUENCE TO kolesnikov_eav;
GRANT CREATE VIEW TO kolesnikov_eav;
ALTER USER kolesnikov_eav quota unlimited on USERS;



/* 3.2 Створити таблиці БД EAV та заповнити таблиці об'єктних типів та атрибутних типів,
взявши рішення з лабораторної роботи No5.
*/

-- OBJTYPE:

CREATE TABLE OBJTYPE (
	OBJECT_TYPE_ID NUMBER(20),
	PARENT_ID      NUMBER(20),
	CODE           VARCHAR2(20),
	NAME           VARCHAR2(200),
	DESCRIPTION    VARCHAR2(1000)
);

ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_PK
	PRIMARY KEY (OBJECT_TYPE_ID);
ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_CODE_UNIQUE
	UNIQUE (CODE);
ALTER TABLE OBJTYPE 
	MODIFY (CODE NOT NULL);
ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJTYPE(OBJECT_TYPE_ID);
    
-- Приклад створення об'єктного типу (класу) "Місто"
INSERT INTO OBJTYPE (OBJECT_TYPE_ID,PARENT_ID,CODE,NAME,DESCRIPTION) 
	VALUES (1,NULL,'LOC','Місто',NULL);
	
-- Приклад створення об'єктного типу (класу) "Тренажерний зал",
-- який має зв'язок "агрегатна асоціація" з класом "Місто",
INSERT INTO OBJTYPE (OBJECT_TYPE_ID,PARENT_ID,CODE,NAME,DESCRIPTION) 
	VALUES (2,1,'GYM','Тренажерний зал',NULL);
	
-- Приклад створення об'єктного типу (класу) "Тренер"
INSERT INTO OBJTYPE (OBJECT_TYPE_ID,PARENT_ID,CODE,NAME,DESCRIPTION) 
	VALUES (3,NULL,'COACH','Тренер',NULL);
    
-- ATTRTYPE:

CREATE TABLE ATTRTYPE (
    ATTR_ID      		NUMBER(20),
    OBJECT_TYPE_ID 		NUMBER(20),
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200)
);

ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_PK
	PRIMARY KEY (ATTR_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_REF_FK
	FOREIGN KEY (OBJECT_TYPE_ID_REF) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
    
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (1,1,NULL,'LOC','Місто');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (2,2,1,'GYM','Адреса');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (3,3,NULL,'NAME','Прізвище');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (4,3,NULL,'SAL','Зарплата');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (5,3,NULL,'HIREDATE','Дата зарахування');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME) 
	VALUES (6,3,2,'WORK','Робота');


-- OBJECTS

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

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (1,NULL,1,'Odessa',NULL);
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (2,NULL,1,'Kyiv',NULL);
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (3,NULL,3,'Alex',NULL);
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
	VALUES (4,NULL,3,'Roman',NULL);

-- ATTRIBUTES

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



/* 3.3 Створити генератор послідовності таблиці OBJECTS БД EAV, ініціалізувавши його
початковим значенням з урахуванням вже заповнених значень.
*/

SELECT MAX(OBJECT_ID) FROM OBJECTS; --5
CREATE SEQUENCE objects_id_seq START WITH 6;

/* Результат:

Sequence created.
*/



/* 3.4 Налаштувати права доступу нового користувача до таблиць схеми даних із таблицями
реляційної БД вашої предметної області, створеної в лабораторній роботі No2.
*/

GRANT SELECT ON kolesnikov.LOC TO kolesnikov_eav;
GRANT SELECT ON kolesnikov.GYM TO kolesnikov_eav;
GRANT SELECT ON kolesnikov.COACH TO kolesnikov_eav;
GRANT SELECT ON kolesnikov.CLEANER TO kolesnikov_eav;
GRANT SELECT ON kolesnikov.ADMINISTRATOR TO kolesnikov_eav;

/* Результат:

Grant succeeded.

Grant succeeded.

Grant succeeded.

Grant succeeded.

Grant succeeded.
*/



/* 3.5 Створити множину запитів типу INSERT INTO ... SELECT, які автоматично заповнять
таблицю OBJECTS, взявши потрібні дані з реляційної бази даних вашої предметної області.
*/

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME)
	SELECT OBJECTS_ID_SEQ.NEXTVAL,NULL,OT.OBJECT_TYPE_ID,L.LNAME
	FROM OBJTYPE OT, kolesnikov.LOC L
	WHERE 
	    OT.CODE = 'LOC';

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME)
	SELECT OBJECTS_ID_SEQ.NEXTVAL,O2.OBJECT_ID,OT.OBJECT_TYPE_ID,G.ADDRESS
	FROM OBJTYPE OT, kolesnikov.LOC L, System.GYM G, OBJECTS O2
	WHERE 	OT.CODE = 'GYM'
			AND L.LOCNO = G.LOCNO
			AND L.LNAME = O2.NAME;

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME)
	SELECT OBJECTS_ID_SEQ.NEXTVAL,NULL,OT.OBJECT_TYPE_ID,C.CNAME
	FROM OBJTYPE OT, kolesnikov.COACH C
	WHERE 
	    OT.CODE = 'COACH';

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME)
	SELECT OBJECTS_ID_SEQ.NEXTVAL,NULL,OT.OBJECT_TYPE_ID,C.CNAME
	FROM OBJTYPE OT, kolesnikov.CLEANER C
	WHERE 
	    OT.CODE = 'CLEANER';

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME)
	SELECT OBJECTS_ID_SEQ.NEXTVAL,NULL,OT.OBJECT_TYPE_ID,A.ANAME
	FROM OBJTYPE OT, kolesnikov.ADMINISTRATOR A
	WHERE 
	    OT.CODE = 'ADMINISTRATOR';

/* Результат:

 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
         1                         1
Odessa

         5          1              2
Pekarskaya 16

         6                         1
Chernomorsk


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
         7                         1
Kyiv

         2                         1
Kyiv

         3                         3
Alex


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
         4                         3
Roman

         8                         1
Lviv

         9                         1
Odesa


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
        10          6              2
Korabelnaya 67

        11          7              2
Kyrylivska 39

        12          2              2
Kyrylivska 39


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
        13          9              2
Levitan 79

        14          8              2
Pekarskaya 38

        15          7              2
Sofievskaya 21


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
        16          2              2
Sofievskaya 21

        17          6              2
Sportivnaya 3

        18          7              2
Vladimirskaya 1


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
        19          2              2
Vladimirskaya 1

        20                         3
Antoniy

        21                         3
Ivan


 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID
---------- ---------- --------------
NAME
--------------------------------------------------------------------------------
        22                         3
Alexander

        23                         3
Leonid

        24                         3
Andrey


24 rows selected.
*/
