/* ��������� ������� � ��������� ���������� 
�������� ����� �������� */
drop table Cleaner CASCADE CONSTRAINTS;
drop table Administrator CASCADE CONSTRAINTS;
drop table Coach CASCADE CONSTRAINTS;
drop table Gym CASCADE CONSTRAINTS;
drop table Loc CASCADE CONSTRAINTS;

CREATE TABLE Loc( -- ���� �������
    locNo NUMBER(2), -- N �������
    lName VARCHAR(15) -- ����� �������
);

CREATE TABLE Gym( -- ���� ������������ ����
    gymNo NUMBER(2), -- N ������������ ����
    address VARCHAR(15), -- ������ ������������ ����
    gWorkingHours DATE , -- ��� ������
    trainingZones NUMBER(2), -- ������� ���������� ���
    sportsEquipment NUMBER(3), -- ������� ���������
    locNo NUMBER(2) -- ������� ������������ ����
);

CREATE TABLE Coach ( -- ���� �������
    coachNo NUMBER(4), -- N �������
    cName VARCHAR(10), -- ��'�
    mgr NUMBER(4), -- N ��������� �������
    hiredate DATE, -- ���� ������� �� ������
    sal NUMBER(6,2), -- �/�
    cWorkingHours DATE, -- ��� ������
    gymNo NUMBER(2) -- N ����, �� ������ ������
);


CREATE TABLE Administrator ( -- ���� �������
    administratorNo NUMBER(4), -- N ������������
    aName VARCHAR(10), -- ��'�
    mgr NUMBER(4), -- N ��������� ������������
    hiredate DATE, -- ���� ������� �� ������
    sal NUMBER(6,2), -- �/�
    aWorkingHours DATE, -- ��� ������
    gymNo NUMBER(2) -- N ����, �� ������ �����������
);


CREATE TABLE Cleaner ( -- ���� �������������
    cleanerNo NUMBER(4), -- N �������������
    cName VARCHAR(10), -- ��'�
    mgr NUMBER(4), -- N ��������� �������������
    hiredate DATE, -- ���� ������� �� ������
    sal NUMBER(6,2), -- �/�
    cWorkingHours DATE, -- ��� ������
    gymNo NUMBER(2) -- N ����, �� ������ ������������
);