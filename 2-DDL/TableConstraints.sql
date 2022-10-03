-- обмеження потенційного ключа
ALTER TABLE Loc ADD CONSTRAINT loc_lName_unique 
    UNIQUE (lName);
ALTER TABLE Loc MODIFY (lName NOT NULL);

-- обмеження первинного ключа
ALTER TABLE Loc ADD CONSTRAINT loc_pk
    PRIMARY KEY (locNo);

-- обмеження потенційного ключа
ALTER TABLE Gym ADD CONSTRAINT gym_address_unique
    UNIQUE (address,locNo);
ALTER TABLE Gym MODIFY (address NOT NULL);
ALTER TABLE Gym MODIFY (locNo NOT NULL);

-- обмеження первинного ключа
ALTER TABLE Gym ADD CONSTRAINT gym_pk
    PRIMARY KEY (gymNo);
	
-- обмеження зовнішнього ключа
ALTER TABLE Gym ADD CONSTRAINT gym_locNo_fk
    FOREIGN KEY (locNo) REFERENCES Loc(locNo);
		  
-- обмеження первинного ключа
ALTER TABLE Coach ADD CONSTRAINT coach_pk
	PRIMARY KEY (coachNo);

-- обмеження зовнішнього ключа
ALTER TABLE Coach ADD CONSTRAINT coach_gymNo_fk
	FOREIGN KEY (gymNo) 
          REFERENCES Gym (gymNo);

-- обмеження вмісту стовпчика таблиці
ALTER TABLE Coach ADD CONSTRAINT coach_salary_not_zero
    CHECK ( sal > 0);

-- обмеження первинного ключа
ALTER TABLE Administrator ADD CONSTRAINT administrator_pk
	PRIMARY KEY (administratorNo);

-- обмеження зовнішнього ключа
ALTER TABLE Administrator ADD CONSTRAINT administrator_gymNo_fk
	FOREIGN KEY (gymNo) 
          REFERENCES Gym (gymNo);

-- обмеження вмісту стовпчика таблиці
ALTER TABLE Administrator ADD CONSTRAINT administrator_salary_not_zero
    CHECK ( sal > 0);

-- обмеження первинного ключа
ALTER TABLE Cleaner ADD CONSTRAINT cleaner_pk
	PRIMARY KEY (cleanerNo);

-- обмеження зовнішнього ключа
ALTER TABLE Cleaner ADD CONSTRAINT cleaner_gymNo_fk
	FOREIGN KEY (gymNo) 
          REFERENCES Gym (gymNo);

-- обмеження вмісту стовпчика таблиці
ALTER TABLE Cleaner ADD CONSTRAINT cleaner_salary_not_zero
    CHECK ( sal > 0);