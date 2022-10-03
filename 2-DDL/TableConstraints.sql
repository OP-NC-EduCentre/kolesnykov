-- ��������� ������������ �����
ALTER TABLE Loc ADD CONSTRAINT loc_lName_unique 
    UNIQUE (lName);
ALTER TABLE Loc MODIFY (lName NOT NULL);

-- ��������� ���������� �����
ALTER TABLE Loc ADD CONSTRAINT loc_pk
    PRIMARY KEY (locNo);

-- ��������� ������������ �����
ALTER TABLE Gym ADD CONSTRAINT gym_address_unique
    UNIQUE (address,locNo);
ALTER TABLE Gym MODIFY (address NOT NULL);
ALTER TABLE Gym MODIFY (locNo NOT NULL);

-- ��������� ���������� �����
ALTER TABLE Gym ADD CONSTRAINT gym_pk
    PRIMARY KEY (gymNo);
	
-- ��������� ���������� �����
ALTER TABLE Gym ADD CONSTRAINT gym_locNo_fk
    FOREIGN KEY (locNo) REFERENCES Loc(locNo);
		  
-- ��������� ���������� �����
ALTER TABLE Coach ADD CONSTRAINT coach_pk
	PRIMARY KEY (coachNo);

-- ��������� ���������� �����
ALTER TABLE Coach ADD CONSTRAINT coach_gymNo_fk
	FOREIGN KEY (gymNo) 
          REFERENCES Gym (gymNo);

-- ��������� ����� ��������� �������
ALTER TABLE Coach ADD CONSTRAINT coach_salary_not_zero
    CHECK ( sal > 0);

-- ��������� ���������� �����
ALTER TABLE Administrator ADD CONSTRAINT administrator_pk
	PRIMARY KEY (administratorNo);

-- ��������� ���������� �����
ALTER TABLE Administrator ADD CONSTRAINT administrator_gymNo_fk
	FOREIGN KEY (gymNo) 
          REFERENCES Gym (gymNo);

-- ��������� ����� ��������� �������
ALTER TABLE Administrator ADD CONSTRAINT administrator_salary_not_zero
    CHECK ( sal > 0);

-- ��������� ���������� �����
ALTER TABLE Cleaner ADD CONSTRAINT cleaner_pk
	PRIMARY KEY (cleanerNo);

-- ��������� ���������� �����
ALTER TABLE Cleaner ADD CONSTRAINT cleaner_gymNo_fk
	FOREIGN KEY (gymNo) 
          REFERENCES Gym (gymNo);

-- ��������� ����� ��������� �������
ALTER TABLE Cleaner ADD CONSTRAINT cleaner_salary_not_zero
    CHECK ( sal > 0);