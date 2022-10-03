/* видалення таблиць з каскадним видаленням 
можливих описів цілісності */
drop table Cleaner CASCADE CONSTRAINTS;
drop table Administrator CASCADE CONSTRAINTS;
drop table Coach CASCADE CONSTRAINTS;
drop table Gym CASCADE CONSTRAINTS;
drop table Loc CASCADE CONSTRAINTS;

CREATE TABLE Loc( -- опис локації
    locNo NUMBER(2), -- N локації
    lName VARCHAR(15) -- назва локації
);

CREATE TABLE Gym( -- опис тренажерного залу
    gymNo NUMBER(2), -- N тренажерного залу
    address VARCHAR(15), -- адреса тренажерного залу
    gWorkingHours DATE , -- час роботи
    trainingZones NUMBER(2), -- кількість спортивних зон
    sportsEquipment NUMBER(3), -- кількість тренажерів
    locNo NUMBER(2) -- локація тренажерного залу
);

CREATE TABLE Coach ( -- опис тренера
    coachNo NUMBER(4), -- N тренера
    cName VARCHAR(10), -- ім'я
    mgr NUMBER(4), -- N начальник тренера
    hiredate DATE, -- дата прийому на роботу
    sal NUMBER(6,2), -- з/п
    cWorkingHours DATE, -- час роботи
    gymNo NUMBER(2) -- N залу, де працює тренер
);


CREATE TABLE Administrator ( -- опис тренера
    administratorNo NUMBER(4), -- N адміністратора
    aName VARCHAR(10), -- ім'я
    mgr NUMBER(4), -- N начальник адміністратора
    hiredate DATE, -- дата прийому на роботу
    sal NUMBER(6,2), -- з/п
    aWorkingHours DATE, -- час роботи
    gymNo NUMBER(2) -- N залу, де працює адміністратор
);


CREATE TABLE Cleaner ( -- опис прибиральника
    cleanerNo NUMBER(4), -- N прибиральника
    cName VARCHAR(10), -- ім'я
    mgr NUMBER(4), -- N начальник прибиральника
    hiredate DATE, -- дата прийому на роботу
    sal NUMBER(6,2), -- з/п
    cWorkingHours DATE, -- час роботи
    gymNo NUMBER(2) -- N залу, де працює прибиральник
);