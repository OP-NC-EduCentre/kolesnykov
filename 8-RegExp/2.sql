/* 2.1. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше
вказаній колонці поєднання будь-яких двох підряд розташованих цифр, або трьох підряд
розташованих букв.
*/

SELECT * FROM gym
WHERE 
     regexp_like(address, '\d{2}|[[:alpha:]]{3}');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         1 Levitan 79                           3              56          1         
         2 Kyrylivska 39                        5              87          2 25.02.17
         3 Vladimirskaya 1                      1              67          2         
         4 Sofievskaya 21                       4              67          1 11.10.22
         5 Pekarskaya 38                        2              40          3         
         6 Sportivnaya 3                        2              35          4         
         7 Korabelnaya 67                       2              30          4         
         8 Akkordnaya 476                       3              47          3         
         9 Konnaya 755                          2              37          1         

9 rows selected. 
*/



/* 2.2. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
буквами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
колонки.
*/

SELECT * FROM gym
WHERE 
     regexp_like(address, '([[:alpha:]])\1');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         8 Akkordnaya 476                       3              47          3         
         9 Konnaya 755                          2              37          1         
*/



/* 2.3. Одна з колонок таблиць повинна містити строкове значення з двома однаковими
словами, що повторюються підряд. Створіть запит, який отримає рядки таблиці з таким значенням
колонки.
*/

SELECT * FROM gym
WHERE 
     regexp_like(address, '([[:alpha:]]+)(\s+)\1');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
        10 street street 4                                                 1         
*/



/* 2.4. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Створіть запит, який отримає рядки
таблиці з таким значенням колонки.
*/

ALTER TABLE coach 
ADD phoneNumber VARCHAR(20);

SELECT * FROM coach
WHERE 
     regexp_like(phoneNumber, '\+\d{2}\(\d{3}\)\d{3}\-\d{2}\-\d{2}');

/* Результат:

   COACHNO CNAME             MGR HIREDATE        SAL CWORKING      GYMNO       RANK PHONENUMBER         
---------- ---------- ---------- -------- ---------- -------- ---------- ---------- --------------------
         1 Alexander             04.07.15       9000                   1          5 +38(063)723-12-78   
         3 Andrey                07.04.17       8000                   5          4 +38(097)951-56-11   
         5 Ivan                  03.04.19       8000                   1            +38(073)007-89-10   
*/



/* 2.5. Одна з колонок таблиць має містити строкове значення з електронною поштовою
адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит, який
отримає рядки таблиці з таким значенням колонки.
*/

ALTER TABLE coach 
ADD email VARCHAR(20);

SELECT * FROM coach
WHERE
    regexp_like(email, '[[:alpha:]]{3}\@[[:alpha:]]{3}\.[[:alpha:]]{3}\.[[:alpha:]]{2}');

/* Результат:

   COACHNO CNAME             MGR HIREDATE        SAL CWORKING      GYMNO       RANK PHONENUMBER          EMAIL               
---------- ---------- ---------- -------- ---------- -------- ---------- ---------- -------------------- --------------------
         1 Alexander             04.07.15       9000                   1          5 +38(063)723-12-78    Lex@ukr.net.ua      
         4 Antoniy               27.09.18       7000                   6          3                      Ant@gma.ill.ua    
*/
