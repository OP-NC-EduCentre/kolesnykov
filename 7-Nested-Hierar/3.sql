/* 3.1 Виберіть таблицю вашої БД, до якої потрібно додати нову колонку, яка стане FK-
колонкою для PK-колонки цієї таблиці та буде використана для зберігання ієрархії.
Використовується команда ALTER TABLE таблиця ADD колонка тип_даних;
Заповніть дані для створеної колонки, виконавши серію команд UPDATE.
*/

ALTER TABLE coach
    ADD rank NUMBER(2);

ALTER TABLE coach
    ADD CONSTRAINT coach_rank_fk
        FOREIGN KEY (rank) REFERENCES coach (coachNo);
        
UPDATE coach
SET rank = 5
WHERE coachNo = 1;

UPDATE coach
SET rank = 4
WHERE coachNo = 3;

UPDATE coach
SET rank = 3
WHERE coachNo = 4;

SELECT * FROM coach;

/* Результат:

Table COACH altered.

Table COACH altered.

1 row updated.

1 row updated.

1 row updated.

   COACHNO CNAME             MGR HIREDATE        SAL CWORKING      GYMNO       RANK
---------- ---------- ---------- -------- ---------- -------- ---------- ----------
         1 Alexander             04.07.15       9000                   1          5
         3 Andrey                07.04.17       8000                   5          4
         4 Antoniy               27.09.18       7000                   6          3
         5 Ivan                  03.04.19       8000                   1           

*/



/* 3.2 Використовуючи створену колонку, отримайте дані з таблиці через ієрархічний зв'язок
типу «зверху-вниз».
*/

SELECT coachNo, cName, hireDate, sal, rank, level
FROM coach
START WITH rank IS NULL
CONNECT BY PRIOR coachNo = rank
ORDER BY level;

/* Результат:

   COACHNO CNAME      HIREDATE        SAL       RANK      LEVEL
---------- ---------- -------- ---------- ---------- ----------
         5 Ivan       03.04.19       8000                     1
         1 Alexander  04.07.15       9000          5          2
*/



/* 3.3 Згенеруйте унікальну послідовність чисел, використовуючи рекурсивний запит, в
діапазоні від 1 до 100. На основі отриманого результату створіть запит, що виводить на екран
список ще не внесених значень однієї з PK-колонок однієї з таблиць БД.
*/

SELECT SQ.RN
FROM (SELECT ROWNUM AS RN 
		FROM DUAL CONNECT BY LEVEL <= 100
) SQ 
WHERE SQ.RN NOT IN (SELECT gymNo FROM gym) 
ORDER BY RN;

/* Результат:

        RN
----------
         8
         9
        10
        11
        12
        13
        14
        15
        16
        17
        18

        RN
----------
        19
        20
        21
        22
        23
        24
        25
        26
        27
        28
        29

        RN
----------
        30
        31
        32
        33
        34
        35
        36
        37
        38
        39
        40

        RN
----------
        41
        42
        43
        44
        45
        46
        47
        48
        49
        50
        51

        RN
----------
        52
        53
        54
        55
        56
        57
        58
        59
        60
        61
        62

        RN
----------
        63
        64
        65
        66
        67
        68
        69
        70
        71
        72
        73

        RN
----------
        74
        75
        76
        77
        78
        79
        80
        81
        82
        83
        84

        RN
----------
        85
        86
        87
        88
        89
        90
        91
        92
        93
        94
        95

        RN
----------
        96
        97
        98
        99
       100

93 rows selected. 
*/