/* 1.1. Створити таблицю опису об'єктних типів.
*/

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

/* Результат:

Table OBJTYPE created.

Table OBJTYPE altered.

Table OBJTYPE altered.

Table OBJTYPE altered.

Table OBJTYPE altered.
*/



/* 1.2 Нехай у лабораторній роботі No1 було створено UML-діаграму концептуальних класів. Для
трьох класів з UML-діаграми, пов'язаних між собою, бажано зв'язком «узагальнення», «агрегатна
асоціація» та «іменована асоціація», заповнити опис об'єктних типів.
*/

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

/* Результат:

1 row inserted.

1 row inserted.

1 row inserted.
*/



/* 1.3 Отримати інформацію про об'єктні типи.
*/

SELECT OBJECT_TYPE_ID,PARENT_ID,CODE,NAME
	FROM OBJTYPE;

/* Результат:

OBJECT_TYPE_ID  PARENT_ID CODE                 NAME                                                                                                                                                                                                    
-------------- ---------- -------------------- --------------------------
             1            LOC                  Місто                                                                                                                                                                                                   
             2          1 GYM                  Тренажерний зал                                                                                                                                                                                         
             3            COACH                Тренер            
*/



/* 1.4 Отримати інформацію про об'єктні типи та можливі зв'язки між ними типу «узагальнення», 
«агрегатна асоціація».
*/

SELECT P.OBJECT_TYPE_ID,P.CODE,
	C.OBJECT_TYPE_ID OBJ_T_ID_LINK, C.CODE CODE_LINK
	FROM OBJTYPE C, OBJTYPE P
	WHERE P.OBJECT_TYPE_ID = C.PARENT_ID(+);

/* Результат: 

OBJECT_TYPE_ID CODE                 OBJ_T_ID_LINK CODE_LINK           
-------------- -------------------- ------------- --------------------
             1 LOC                              2 GYM                 
             2 GYM                                                    
             3 COACH                                                  

*/
