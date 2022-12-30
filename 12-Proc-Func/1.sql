/* 1.1. Повторіть виконання завдання 4 етапу 1 із попередньої лабораторної роботи:
− циклічно внести 5000 рядків;
− визначити загальний час на внесення зазначених рядків;
− вивести на екран значення часу.
*/

DECLARE
	t1 INTEGER;
	t2 INTEGER;
	delta INTEGER;
BEGIN
    t1 := DBMS_UTILITY.get_time;
	FOR i IN 1..5000 LOOP
        INSERT INTO coach(coachNo, cName, hiredate, sal, gymNo)
        VALUES(coach_coachNo_seq.nextval, 'Alina',
            to_date('07/12/2022','DD/MM/YYYY'), 7500, 1);
	END LOOP;
    t2 := DBMS_UTILITY.get_time;
    delta := t2 - t1;
    DBMS_OUTPUT.PUT_LINE('Time (centisec) = ' || delta);
END;
/

/* Результат:

Time (centisec) = 25
*/



/* 1.2. Повторіть виконання попереднього завдання, порівнявши час виконання
циклічних внесень рядків, використовуючи два способи: FOR і FORALL.
*/

DROP TABLE coach1;
DROP TABLE coach2;
CREATE TABLE coach1 (coachNo INTEGER, cName VARCHAR2(15));
CREATE TABLE coach2 (coachNo INTEGER, cName VARCHAR2(15));

DECLARE
  TYPE NumTab IS TABLE OF coach.coachNo%TYPE INDEX BY PLS_INTEGER;
  TYPE NameTab IS TABLE OF coach.cName%TYPE INDEX BY PLS_INTEGER;
  coachNos  NumTab; cNames NameTab;
  iterations CONSTANT PLS_INTEGER := 5000;
  t1 INTEGER; t2 INTEGER; delta1 INTEGER; delta2 INTEGER;
BEGIN
  FOR j IN 1..iterations LOOP
     coachNos(j) := j; cNames(j) := 'Iv-' || TO_CHAR(j);
  END LOOP;
  t1 := DBMS_UTILITY.get_time;
  FOR i IN 1..iterations LOOP
     INSERT INTO coach1 VALUES (coachNos(i), cNames(i));
  END LOOP;
  t2 := DBMS_UTILITY.get_time;
  delta1 := t2 - t1;
  t1 := DBMS_UTILITY.get_time;
  FORALL i IN 1..iterations
     INSERT INTO coach2 VALUES (coachNos(i), cNames(i));
  t2 := DBMS_UTILITY.get_time;
  delta2 := t2 - t1;
  DBMS_OUTPUT.PUT_LINE('Execution time (sec)');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  DBMS_OUTPUT.PUT_LINE('FOR-loop: ' || TO_CHAR((delta1)/100));
  DBMS_OUTPUT.PUT_LINE('FORALL-operator:   ' || TO_CHAR((delta2)/100));
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
END;
/

/* Результат:

Execution time (sec)
-------------------------------
FOR-loop: ,11
FORALL-operator:   ,02
-------------------------------
*/



/* 1.3. Для однієї з таблиць отримайте рядки з використанням курсору та пакетної
обробки SELECT-операції з оператором BULK COLLECT.
*/

DECLARE
    CURSOR coach_list_cursor IS
        SELECT coachNo, cName, hireDate, sal, gymNo
        FROM coach;
    TYPE coach_list_bulk_type IS TABLE OF coach_list_cursor%ROWTYPE;
    coach_list_bulk coach_list_bulk_type;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('coachNo', 10, ' ') || RPAD('cName', 10, ' ') ||
        RPAD('hireDate', 10, ' ') || RPAD('sal', 10, ' ') || 'gymNo');
    DBMS_OUTPUT.PUT_LINE('CURSOR :');
    FOR i IN coach_list_cursor
        LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(i.coachNo, 10, ' ') ||
                RPAD(i.cName, 10, ' ') || RPAD(i.hireDate, 10, ' ') ||
                RPAD(i.sal, 10, ' ') || i.gymNo);
        END LOOP;

    DBMS_OUTPUT.PUT_LINE('BULK COLLECT :');
    SELECT coachNo, cName, hireDate, sal, gymNo
        BULK COLLECT
        INTO coach_list_bulk
    FROM coach;
    FOR i IN coach_list_bulk.first..coach_list_bulk.last
        LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(coach_list_bulk(i).coachNo, 10, ' ') ||
                RPAD(coach_list_bulk(i).cName, 10, ' ') ||
                RPAD(coach_list_bulk(i).hireDate, 10, ' ') ||
                RPAD(coach_list_bulk(i).sal, 10, ' ') ||
                coach_list_bulk(i).gymNo);
        END LOOP;
END;
/

/* Результат:

coachNo   cName     hireDate  sal       gymNo
CURSOR :
2         Philip    20.05.18  7500      5
6         Olesya    11.11.18  8000      6
1         Alexander 04.07.15  9000      1
3         Andrey    07.04.17  8000      5
4         Antoniy   27.09.18  7000      6
5         Ivan      03.04.19  8000      1
BULK COLLECT :
2         Philip    20.05.18  7500      5
6         Olesya    11.11.18  8000      6
1         Alexander 04.07.15  9000      1
3         Andrey    07.04.17  8000      5
4         Antoniy   27.09.18  7000      6
5         Ivan      03.04.19  8000      1
*/
