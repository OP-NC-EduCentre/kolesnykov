/* Помилки:
L001	7 / 7	Unnecessary trailing whitespace.
L014	8 / 7	Unquoted identifiers must be consistently lower case.
L001	8 / 15	Unnecessary trailing whitespace.
L008	8 / 15	Commas should be followed by a single whitespace unless followed by a comment.
L004	9 / 1	Incorrect indentation type found in file.
L014	9 / 4	Unquoted identifiers must be consistently lower case.
L001	9 / 10	Unnecessary trailing whitespace.
L008	9 / 10	Commas should be followed by a single whitespace unless followed by a comment.
L004	10 / 1	Incorrect indentation type found in file.
L014	10 / 4	Unquoted identifiers must be consistently lower case.
L001	10 / 10	Unnecessary trailing whitespace.
L008	10 / 10	Commas should be followed by a single whitespace unless followed by a comment.
L004	11 / 1	Incorrect indentation type found in file.
L001	12 / 5	Unnecessary trailing whitespace.
L011	13 / 11	Implicit/explicit aliasing of table.
L031	13 / 11	Avoid aliases in from clauses and join conditions.
L001	13 / 13	Unnecessary trailing whitespace.
L008	13 / 13	Commas should be followed by a single whitespace unless followed by a comment.
L004	14 / 1	Incorrect indentation type found in file.
L011	14 / 6	Implicit/explicit aliasing of table.
L031	14 / 6	Avoid aliases in from clauses and join conditions.
L001	15 / 6	Unnecessary trailing whitespace.
L014	16 / 7	Unquoted identifiers must be consistently lower case.
L014	16 / 17	Unquoted identifiers must be consistently lower case.
L001	20 / 41	Unnecessary trailing whitespace.
L001	22 / 47	Unnecessary trailing whitespace.
L001	23 / 44	Unnecessary trailing whitespace.
L001	24 / 47	Unnecessary trailing whitespace.
L001	25 / 47	Unnecessary trailing whitespace.
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