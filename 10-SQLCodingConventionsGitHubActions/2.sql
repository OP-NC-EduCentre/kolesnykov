/* Помилки:
L014	2 / 5	Unquoted identifiers must be consistently pascal case.
L014	3 / 5	Unquoted identifiers must be consistently pascal case.
L014	4 / 5	Unquoted identifiers must be consistently pascal case.
L014	5 / 5	Unquoted identifiers must be consistently pascal case.
L014	6 / 5	Unquoted identifiers must be consistently pascal case.
L008	6 / 17	Commas should be followed by a single whitespace unless followed by a comment.
L014	7 / 5	Unquoted identifiers must be consistently pascal case.
L014	8 / 5	Unquoted identifiers must be consistently pascal case.
*/

CREATE TABLE Coach ( -- опис тренера
    coachNo NUMBER(4), -- N тренера
    cName VARCHAR(10), -- ім'я
    mgr NUMBER(4), -- N начальник тренера
    hiredate DATE, -- дата прийому на роботу
    sal NUMBER(6,2), -- з/п
    cWorkingHours DATE, -- час роботи
    gymNo NUMBER(2) -- N залу, де працює тренер
);