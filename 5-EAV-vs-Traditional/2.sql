/* 2.1. Створити таблицю описів атрибутних типів.
*/

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

/* Результат:

Table ATTRTYPE created.

Table ATTRTYPE altered.

Table ATTRTYPE altered.

Table ATTRTYPE altered.
*/



/* 2.2 Для раніше використаних класів UML-діаграми заповнити описи атрибутних типів.
*/

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

/* Результат:

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.

1 row inserted.
*/




/* 2.3 Отримати інформацію про атрибутні типи.
*/

SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME
	FROM OBJTYPE O, ATTRTYPE A
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;

/* Результат:

CODE                    ATTR_ID CODE                 NAME                                                                                                                                                                                                    
-------------------- ---------- -------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LOC                           1 LOC                  Місто                                                                                                                                                                                                 
GYM                           2 GYM                  Адреса                                                                                                                                                                                          
COACH                         3 NAME                 Прізвище                                                                                                                                                                                                
COACH                         4 SAL                  Зарплата                                                                                                                                                                                                
COACH                         5 HIREDATE             Дата зарахування                                                                                                                                                                                        
COACH                         6 WORK                 Робота                                                                                                                                                                                                  

6 rows selected. 
*/



/* 2.4 Отримати інформацію про атрибутні типи та можливі зв'язки між ними типу «іменована
асоціація».
*/

SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME, O_REF.CODE O_REF
	FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF ON 
								(A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;


/* Результат:

CODE                    ATTR_ID CODE                 NAME                                                                                                                                                                                                     O_REF               
-------------------- ---------- -------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------
LOC                           1 LOC                  Місто                                                                                                                                                                                                                       
GYM                           2 GYM                  Адреса                                                                                                                                                                                           LOC                 
COACH                         3 NAME                 Прізвище                                                                                                                                                                                                                     
COACH                         4 SAL                  Зарплата                                                                                                                                                                                                                     
COACH                         5 HIREDATE             Дата зарахування                                                                                                                                                                                                             
COACH                         6 WORK                 Робота                                                                                                                                                                                                   GYM                 

6 rows selected. 
*/
