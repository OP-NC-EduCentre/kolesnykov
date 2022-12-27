/* 1.5 Використання оператора WITH для структуризації запиту
*/

-- Вибрати тренерів з більшою зарплатою,
-- ніж середня зарплата у тренерів у їх залах

WITH
AVG_SAL AS (
    SELECT
        GYMNO,
        AVG(SAL) AS SALAVG
    FROM COACH
    GROUP BY GYMNO
)

SELECT
    COACH.CNAME,
    COACH.SAL,
    COACH.GYMNO,
    AVG_SAL.SALAVG
FROM COACH, AVG_SAL
WHERE COACH.GYMNO = AVG_SAL.GYMNO
    AND COACH.SAL > AVG_SAL.SALAVG;

/* Результат:

CNAME             SAL      GYMNO     SALAVG
---------- ---------- ---------- ----------
Alexander        9000          1       8500
*/
