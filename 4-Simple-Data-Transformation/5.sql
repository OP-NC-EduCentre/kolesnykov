/* 5.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці, згрупованих по
одній з колонок, яка також повинна бути отримана, об'єднавши її з командою отримання загальної
кількості рядків із зазначенням слова «Разом:», наприклад:
Колонка Кількість
значення1 10
значення2 15
Разом: 25
При виконанні завдання необхідно врахувати, що підсумковий рядок завжди повинен бути
останнім, незалежно від значень колонки у попередніх рядках.
*/

SELECT 
    address,
    COUNT(address) AS "COUNT"
FROM gym
GROUP BY address
UNION ALL
SELECT
    'Разом:',
    COUNT(gymNo)
FROM gym;

/* Результат:

ADDRESS              COUNT
--------------- ----------
Korabelnaya 67           1
Kyrylivska 39            1
Levitan 79               1
Pekarskaya 38            1
Sofievskaya 21           1
Sportivnaya 3            1
Vladimirskaya 1          1
Разом:                   7

8 rows selected. 
*/
