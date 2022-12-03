/* 1.1. Одна з колонок таблиць повинна містити строкове значення з трьома різними буквами у
першій позиції. Створіть запит, який отримає три рядки таблиці з урахуванням трьох букв,
використовуючи оператор LIKE.
*/

SELECT * FROM coach 
WHERE 
    cName LIKE 'Ale%'
    OR cName LIKE 'And%'
    OR cName LIKE 'Ant%';

/* Результат:

   COACHNO CNAME             MGR HIREDATE        SAL CWORKING      GYMNO       RANK
---------- ---------- ---------- -------- ---------- -------- ---------- ----------
         1 Alexander             04.07.15       9000                   1          5
         3 Andrey                07.04.17       8000                   5          4
         4 Antoniy               27.09.18       7000                   6          3
*/



/* 1.2. Повторіть завдання 1, використовуючи регулярні вирази з альтернативними варіантами.
*/

SELECT * FROM coach 
WHERE 
    regexp_like(cName, '^(Ale|And|Ant)');

/* Результат:

   COACHNO CNAME             MGR HIREDATE        SAL CWORKING      GYMNO       RANK
---------- ---------- ---------- -------- ---------- -------- ---------- ----------
         1 Alexander             04.07.15       9000                   1          5
         3 Andrey                07.04.17       8000                   5          4
         4 Antoniy               27.09.18       7000                   6          3
*/



/* 1.3. Одна з колонок таблиць повинна містити строкове значення з цифрами від 3 до 8 у
будь-якій позиції. Створіть запит, який отримає рядки таблиці з урахуванням присутності у
вказаній колонці будь-якої цифри від 3 до 8.
*/

SELECT * FROM gym
WHERE 
    regexp_like(address, '[3-8]');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         1 Levitan 79                           3              56          1         
         2 Kyrylivska 39                        5              87          2 25.02.17
         5 Pekarskaya 38                        2              40          3         
         6 Sportivnaya 3                        2              35          4         
         7 Korabelnaya 67                       2              30          4         
*/



/* 1.4. Створіть запит, який отримає рядки таблиці з урахуванням відсутності в зазначеній
колонці будь-якої цифри від 3 до 8.
*/

SELECT * FROM gym
WHERE 
    regexp_like(address, '^[^3-8]*$');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         3 Vladimirskaya 1                      1              67          2         
         4 Sofievskaya 21                       4              67          1 11.10.22
*/



/* 1.5. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше вказаній
колонці поєднання будь-яких трьох цифр розміщених підряд від 3 до 8.
*/

SELECT * FROM gym
WHERE 
    regexp_like(address, '[3-8]{3}');

/* Результат:

     GYMNO ADDRESS         GWORKING TRAININGZONES SPORTSEQUIPMENT      LOCNO OPENDATE
---------- --------------- -------- ------------- --------------- ---------- --------
         8 Akkordnaya 476                       3              47          3         
         9 Konnaya 755                          2              37          1         
*/