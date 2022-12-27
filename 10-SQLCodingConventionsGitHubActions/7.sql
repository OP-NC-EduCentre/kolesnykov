/* Помилки:
L023	8 / 9	Single whitespace expected after 'AS' in 'WITH' clause.
L004	9 / 1	Incorrect indentation type found in file.
L003	9 / 2	Expected 0 indentations, found 1 [compared to line 08]
L004	10 / 1	Incorrect indentation type found in file.
L003	10 / 3	Expected 0 indentations, found 2 [compared to line 08]
L036	10 / 3	Select targets should be on a new line unless there is only one select target.
L014	10 / 10	Unquoted identifiers must be consistently upper case.
L014	10 / 21	Unquoted identifiers must be consistently upper case.
L012	10 / 26	Implicit/explicit aliasing of columns.
L014	10 / 26	Unquoted identifiers must be consistently upper case.
L004	11 / 1	Incorrect indentation type found in file.
L003	11 / 3	Expected 0 indentations, found 2 [compared to line 08]
L014	11 / 8	Unquoted identifiers must be consistently upper case.
L004	12 / 1	Incorrect indentation type found in file.
L003	12 / 3	Expected 0 indentations, found 2 [compared to line 08]
L014	12 / 12	Unquoted identifiers must be consistently upper case.
L004	13 / 1	Incorrect indentation type found in file.
L003	13 / 2	Expected 0 indentations, found 1 [compared to line 08]
L022	14 / 1	Blank line expected but not found after CTE closing bracket.
L036	14 / 1	Select targets should be on a new line unless there is only one select target.
L014	14 / 10	Unquoted identifiers must be consistently upper case.
L014	14 / 19	Unquoted identifiers must be consistently upper case.
L014	14 / 26	Unquoted identifiers must be consistently upper case.
L014	14 / 35	Unquoted identifiers must be consistently upper case.
L014	15 / 6	Unquoted identifiers must be consistently upper case.
L011	15 / 12	Implicit/explicit aliasing of table.
L031	15 / 12	Avoid aliases in from clauses and join conditions.
L011	15 / 23	Implicit/explicit aliasing of table.
L031	15 / 23	Avoid aliases in from clauses and join conditions.
L004	16 / 1	Incorrect indentation type found in file.
L003	16 / 2	Expected 0 indentations, found 1 [compared to line 15]
L004	16 / 7	Incorrect indentation type found in file. The indent occurs after other text, so a manual fix is needed.
L039	16 / 7	Unnecessary whitespace found.
L014	16 / 11	Unquoted identifiers must be consistently upper case.
L014	16 / 21	Unquoted identifiers must be consistently upper case.
L004	17 / 1	Incorrect indentation type found in file.
L003	17 / 4	Expected 0 indentations, found 3 [compared to line 15]
L014	17 / 10	Unquoted identifiers must be consistently upper case.
L014	17 / 18	Unquoted identifiers must be consistently upper case.
*/



/* 1.5 Використання оператора WITH для структуризації запиту
*/

-- Вибрати тренерів з більшою зарплатою,
-- ніж середня зарплата у тренерів у їх залах

WITH
AVG_SAL AS
	(
		SELECT gymNo, AVG(sal) salAvg
		FROM coach
		GROUP BY gymNo
	)
SELECT C.cName, C.sal, C.gymNo, S.salAvg
FROM coach C, AVG_SAL S
	WHERE 	C.gymNo = S.gymNo
			AND C.sal > S.salAvg;

/* Результат:

CNAME             SAL      GYMNO     SALAVG
---------- ---------- ---------- ----------
Alexander        9000          1       8500
*/