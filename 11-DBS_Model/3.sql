/* 3.1. Виконайте DELETE-запит із попередніх рішень, додавши аналіз даних із неявного
курсору. Наприклад, кількість віддалених рядків
*/

BEGIN
	DELETE FROM coach;
	DBMS_OUTPUT.PUT_LINE('Total deleted rows = ' || SQL%ROWCOUNT);
END;
/

/* Результат:

Total deleted rows = 6
*/



/* 3.2. Повторіть виконання завдання 3 етапу 1 з використанням явного курсору.
*/

DECLARE
    CURSOR coach_list IS
        SELECT gymNo, AVG(sal) AS avg_sal
        FROM coach
        GROUP BY gymNo;
BEGIN
	DBMS_OUTPUT.PUT_LINE(RPAD('gymNo', 10, ' ') || 'avg_sal');
    FOR gymNo_avg_sal IN coach_list
    LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(gymNo_avg_sal.gymNo, 10, ' ')
            || gymNo_avg_sal.avg_sal);
    END LOOP;
END;
/

/* Результат:

gymNo     avg_sal
5         7750
6         7500
1         8500
*/



/* 3.3. З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
викликатиме один із варіантів подібних SQL-запитів залежно від значення версії СУБД.
При вирішенні використовувати:
− значення змінної DBMS_DB_VERSION.VERSION;
− явний курсор із параметричним циклом.
*/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Oracle DB version = ' || DBMS_DB_VERSION.VERSION);
    
    IF DBMS_DB_VERSION.VERSION < 12 THEN
        DECLARE
            CURSOR coach_list IS
                WITH
                coach_high_sal AS (
                    SELECT cName, sal
                    FROM coach
                    ORDER BY sal DESC
                ),
                coach_high_sal_rownum AS (
                    SELECT
                        ROWNUM AS r,
                        cName,
                        sal
                    FROM coach_high_sal
                )
                SELECT
                    cName,
                    sal
                FROM coach_high_sal_rownum
                WHERE
                    r <= 5;
        BEGIN
             DBMS_OUTPUT.PUT_LINE(RPAD('coach', 10, ' ') || 'sal');
             FOR coach_elem IN coach_list
             LOOP
                 DBMS_OUTPUT.PUT_LINE(RPAD(coach_elem.cName, 10, ' ')
                    || coach_elem.sal);
             END LOOP;
        END;
    
    ELSE
        DECLARE
            CURSOR coach_list IS
                SELECT
                    cName,
                    sal
                FROM coach
                ORDER BY sal DESC
                FETCH FIRST 5 ROWS ONLY;
        BEGIN
            DBMS_OUTPUT.PUT_LINE(RPAD('coach', 10, ' ') || 'sal');
            FOR coach_elem IN coach_list
            LOOP
                DBMS_OUTPUT.PUT_LINE(RPAD(coach_elem.cName, 10, ' ') ||
                    coach_elem.sal);
            END LOOP;
        END;
    END IF;
END;
/

/* Результат:

Oracle DB version = 21
coach     sal
Alexander 9000
Olesya    8000
Ivan      8000
Andrey    8000
Philip    7500
*/
