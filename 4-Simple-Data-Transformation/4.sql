/* 4.1 Повторити рішення завдання 3.1 Для будь-яких двох таблиць
створити команду отримання декартового добутку.
*/

SELECT 
    cname, 
	address
FROM 
    Coach, 
    gym;

/* Результат: 

CNAME      ADDRESS        
---------- ---------------
Antoniy    Korabelnaya 67 
Antoniy    Kyrylivska 39  
Antoniy    Levitan 79     
Antoniy    Pekarskaya 38  
Antoniy    Sofievskaya 21 
Antoniy    Sportivnaya 3  
Antoniy    Vladimirskaya 1
Alexander  Korabelnaya 67 
Alexander  Kyrylivska 39  
Alexander  Levitan 79     
Alexander  Pekarskaya 38  

CNAME      ADDRESS        
---------- ---------------
Alexander  Sofievskaya 21 
Alexander  Sportivnaya 3  
Alexander  Vladimirskaya 1
Leonid     Korabelnaya 67 
Leonid     Kyrylivska 39  
Leonid     Levitan 79     
Leonid     Pekarskaya 38  
Leonid     Sofievskaya 21 
Leonid     Sportivnaya 3  
Leonid     Vladimirskaya 1
Andrey     Korabelnaya 67 

CNAME      ADDRESS        
---------- ---------------
Andrey     Kyrylivska 39  
Andrey     Levitan 79     
Andrey     Pekarskaya 38  
Andrey     Sofievskaya 21 
Andrey     Sportivnaya 3  
Andrey     Vladimirskaya 1

28 rows selected. 
*/



/* 4.2 Повторити рішення завдання 3.2 Для двох таблиць, пов'язаних через
PK-колонку та FK-колонку, створити командуотримання двох колонок першої
та другої таблиць з використанням екві-з’єднання таблиць.
Використовувати префікси.
*/

SELECT 
    c.coachNo, 
	c.cName, 
	c.gymNo, 
	g.address
FROM 
    coach c, 
	gym g
WHERE 
    c.gymNo = g.gymNo;

/* Результат:

   COACHNO CNAME           GYMNO ADDRESS        
---------- ---------- ---------- ---------------
         4 Antoniy             6 Sportivnaya 3  
         1 Alexander           1 Levitan 79     
         2 Leonid              2 Kyrylivska 39  
         3 Andrey              5 Pekarskaya 38  
*/



/* 4.3 Повторити рішення завдання 3.4 Повторити рішення завдання 3.2, 
замінивши еквіз'єднання на зовнішнє з'єднання (лівостороннє або правостороннє),
яке дозволить побачити рядки таблиці з PK-колонкою, не пов'язані
з FK-колонкою.
*/

SELECT 
    c.coachNo, 
	c.cName, 
	c.gymNo, 
	g.address
FROM 
    coach c, 
	gym g
WHERE 
    c.gymNo (+) = g.gymNo;

/* Результат:

   COACHNO CNAME           GYMNO ADDRESS        
---------- ---------- ---------- ---------------
         4 Antoniy             6 Sportivnaya 3  
         1 Alexander           1 Levitan 79     
         2 Leonid              2 Kyrylivska 39  
         3 Andrey              5 Pekarskaya 38  
                                 Korabelnaya 67 
                                 Sofievskaya 21 
                                 Vladimirskaya 1

7 rows selected. 
*/
