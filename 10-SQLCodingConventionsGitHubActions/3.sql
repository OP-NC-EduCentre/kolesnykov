/* Помилки:
L016	1 / 87	Line is too long.
L016	2 / 89	Line is too long.
L001	6 / 7	Unnecessary trailing whitespace.
L014	7 / 5	Unquoted identifiers must be consistently upper case.
L001	7 / 11	Unnecessary trailing whitespace.
L008	7 / 11	Commas should be followed by a single whitespace unless followed by a comment.
L014	8 / 5	Unquoted identifiers must be consistently upper case.
L014	9 / 6	Unquoted identifiers must be consistently upper case.
L037	10 / 1	Ambiguous order by clause. Order by clauses should specify order direction for ALL columns or NO columns.
L014	10 / 10	Unquoted identifiers must be consistently upper case.
L014	10 / 17	Unquoted identifiers must be consistently upper case.
*/



/* 2.6 Для однієї з таблиць створити команду отримання значення двох колонок, значення
яких відсортовані в порядку зростання (для першої колонки) та в порядку зменшення (друга
колонка).
*/

SELECT 
    gymNo, 
    sal
FROM Coach
ORDER BY gymNo, sal DESC;

/* Результат:

     GYMNO        SAL
---------- ----------
         1       9000
         2       9000
*/