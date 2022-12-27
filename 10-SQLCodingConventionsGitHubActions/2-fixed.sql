CREATE TABLE Coach ( -- опис тренера
    CoachNo NUMBER(4), -- N тренера
    CName VARCHAR(10), -- ім'я
    Mgr NUMBER(4), -- N начальник тренера
    Hiredate DATE, -- дата прийому на роботу
    Sal NUMBER(6, 2), -- з/п
    CWorkingHours DATE, -- час роботи
    GymNo NUMBER(2) -- N залу, де працює тренер
);
