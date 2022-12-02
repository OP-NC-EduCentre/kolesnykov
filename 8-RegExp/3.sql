/* 3.1. Одна з колонок таблиць повинна містити строкове значення з двома словами,
розділеними пробілом. Виконайте команду UPDATE, помінявши місцями ці два слова.
*/

SELECT * FROM gym
WHERE regexp_like(address, '(.*)\s(.*)\s(.*)');

UPDATE gym
    SET address = regexp_replace(
    address, 
    '(.*)\s(.*)\s(.*)', 
    '\2 \1 \3');
    
SELECT * FROM gym
WHERE regexp_like(address, '(.*)\s(.*)\s(.*)');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
        10 street street 4                                                 1         
        11 Green street 7                                                  2         


11 rows updated.


     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
        10 street street 4                                                 1         
        11 street Green 7                                                  2         
*/



/* 3.2. Одна з колонок таблиць має містити строкове значення з електронною поштовою
адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит,
вилучення логіна користувача з електронної адреси (підстрока перед символом @).
*/

SELECT * FROM coach;

SELECT 
    regexp_substr(email, '[[:alpha:]]{3}')
FROM coach;

/* Результат:

   COACHNO CNAME             MGR HIREDATE        SAL CWORKING      GYMNO       RANK PHONENUMBER          EMAIL               
---------- ---------- ---------- -------- ---------- -------- ---------- ---------- -------------------- --------------------
         1 Alexander             04.07.15       9000                   1          5 +38(063)723-12-78    Lex@ukr.net.ua      
         3 Andrey                07.04.17       8000                   5          4 +38(097)951-56-11                        
         4 Antoniy               27.09.18       7000                   6          3                      Ant@gma.ill.ua      
         5 Ivan                  03.04.19       8000                   1            +38(073)007-89-10                        


REGEXP_SUBSTR(EMAIL,
--------------------
Lex

Ant
*/


/* 3.3. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Виконайте команду UPDATE,
додавши перед номером телефону фразу «Mobile:».
*/

SELECT phoneNumber
FROM coach;

UPDATE coach
    SET phoneNumber = regexp_replace(
    phoneNumber,
    '(\+\d{2}\(\d{3}\)\d{3}\-\d{2}\-\d{2})',
    'Mobile: \1');
    
SELECT phoneNumber
FROM coach;

/* Результат:

PHONENUMBER                   
------------------------------
+38(063)723-12-78
+38(097)951-56-11

+38(073)007-89-10


4 rows updated.


PHONENUMBER                   
------------------------------
Mobile: +38(063)723-12-78
Mobile: +38(097)951-56-11

Mobile: +38(073)007-89-10
*/



/* 3.4. Додайте до колонки з електронною адресою обмеження цілісності, що забороняє
вносити дані, відмінні від формату електронної адреси, використовуючи команду ALTER TABLE
таблиця ADD CONSTRAINT обмеження CHECK (умова). Перевірте роботу обмеження на двох
прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
*/

ALTER TABLE coach ADD CONSTRAINT emailFormat CHECK (
    regexp_like(
    email,
    '[[:alpha:]]{3}\@[[:alpha:]]{3}\.[[:alpha:]]{3}\.[[:alpha:]]{2}'));

UPDATE coach
    SET email='Ivan@gmail.com' WHERE coachNo = 5;
    
UPDATE coach
    SET email='Adr@ukr.net.ua' WHERE coachNo = 3;

SELECT email FROM coach;

/* Результат:

Table COACH altered.

Error starting at line : 1 in command -
UPDATE coach
    SET email='Ivan@gmail.com' WHERE coachNo = 5
Error report -
ORA-02290: нарушено ограничение целостности CHECK(KOLESNIKOV.EMAILFORMAT)

1 row updated.

EMAIL               
--------------------
Lex@ukr.net.ua
Adr@ukr.net.ua
Ant@gma.ill.ua
*/



/* 3.5. Видаліть зайві дані з колонки з номером мобільного телефону, залишивши тільки номер
телефону в заданому форматі.
*/

SELECT phoneNumber FROM coach;

UPDATE coach
    SET phoneNumber = regexp_substr(
    phoneNumber,
    '\+\d{2}\(\d{3}\)\d{3}\-\d{2}\-\d{2}');

SELECT phoneNumber FROM coach;

/* Результат:

PHONENUMBER                   
------------------------------
Mobile: +38(063)723-12-78
Mobile: +38(097)951-56-11

Mobile: +38(073)007-89-10


4 rows updated.


PHONENUMBER                   
------------------------------
+38(063)723-12-78
+38(097)951-56-11

+38(073)007-89-10
*/



/* 3.6. Додайте в колонку з мобільним телефоном обмеження цілісності, що забороняє вносити
дані, відмінні від формату, записаного в завданні 3. Перевірте роботу обмеження на двох
прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
*/

ALTER TABLE coach ADD CONSTRAINT phoneNumberFormat CHECK (
    regexp_like(
    phoneNumber,
    '\+\d{2}\(\d{3}\)\d{3}\-\d{2}\-\d{2}'));

UPDATE coach
    SET phoneNumber='+380637231278' WHERE coachNo = 1;
    
UPDATE coach
    SET phoneNumber='+38(063)611-92-13' WHERE coachNo = 4;

SELECT phoneNumber FROM coach;

/* Результат:

Table COACH altered.

Error starting at line : 6 in command -
UPDATE coach
    SET phoneNumber='+380637231278' WHERE coachNo = 1
Error report -
ORA-02290: нарушено ограничение целостности CHECK(KOLESNIKOV.PHONENUMBERFORMAT)

1 row updated.

PHONENUMBER                   
------------------------------
+38(063)723-12-78
+38(097)951-56-11
+38(063)611-92-13
+38(073)007-89-10
*/
