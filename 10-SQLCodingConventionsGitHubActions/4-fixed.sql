/* 4.2 Повторити рішення завдання 3.2 Для двох таблиць, пов'язаних через
PK-колонку та FK-колонку, створити командуотримання двох колонок першої
та другої таблиць з використанням екві-з’єднання таблиць.
Використовувати префікси.
*/

SELECT
    coach.coachno,
    coach.cname,
    coach.gymno,
    gym.address
FROM
    coach,
    gym
WHERE
    coach.gymno = gym.gymno;

/* Результат:

   COACHNO CNAME           GYMNO ADDRESS
---------- ---------- ---------- ---------------
         4 Antoniy             6 Sportivnaya 3
         1 Alexander           1 Levitan 79
         2 Leonid              2 Kyrylivska 39
         3 Andrey              5 Pekarskaya 38
*/