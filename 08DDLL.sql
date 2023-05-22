--���� 1. - ǥ Ȯ��
--������ ���� ���̺��� �����ϰ� �����͸� insert�ϼ��� (Ŀ��)
--����) M_NAME �� ����������, �ΰ��� ������� ����
--����) M_NUM �� ������, �̸�(mem_memnum_pk) primary key
--����) REG_DATE �� ��¥��, �ΰ��� ������� ����, �̸�:(mem_regdate_uk) UNIQUEŰ
--����) GENDER ����������(1��) 'M' OR 'F' �� ���� �� 
--����) LOCA ������, �̸�:(mem_loca_loc_locid_fk) foreign key ? ���� locations���̺�(location_id)

CREATE TABLE MEMBERS (
    M_NAME VARCHAR2(20)  NOT NULL,
    M_NUM NUMBER(2)      CONSTRAINT MEM_MEMNUM_PK PRIMARY KEY,
    REG_DATE DATE        NOT NULL CONSTRAINT MEM_REGDATE_UK UNIQUE,
    GENDER CHAR(1)       CHECK (GENDER = 'M' OR GENDER = 'F'),
    LOCA NUMBER(4)       CONSTRAINT MEM_LOCA_LOC_LOCID_FK REFERENCES LOCATIONS(LOCATION_ID)
);


INSERT INTO MEMBERS VALUES('AAA', 1, '2018/07/01', 'M', 1800);
INSERT INTO MEMBERS VALUES('BBB', 2, '2018/07/02', 'F', 1900);
INSERT INTO MEMBERS VALUES('CCC', 3, '2018/07/03', 'M', 2000);
INSERT INTO MEMBERS VALUES('DDD', 4, SYSDATE, 'M', 2000);


SELECT * FROM MEMBERS;


--------------------------������ �ڵ�
CREATE TABLE MEMBERS (
    M_NAME VARCHAR2(30) NOT NULL,
    M_NUM NUMBER(5),
    REG_DATE DATE,
    GENDER CHAR(1),
    LOCA NUMBER(4)
);

ALTER TABLE MEMBERS ADD CONSTRAINT mem_memnum_pk PRIMARY KEY (M_NUM);
ALTER TABLE MEMBERS ADD CONSTRAINT mem_regdate_uk UNIQUE (REG_DATE);
ALTER TABLE MEMBERS ADD CONSTRAINT mem_gender_ck CHECK(GENDER IN('M', 'F'));
ALTER TABLE MEMBERS ADD CONSTRAINT mem_loca_loc_locid_fk FOREIGN KEY (LOCA) REFERENCES LOCATIONS(LOCATION_ID);


SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MEMVERS';

INSERT INTO MEMBERS VALUES('AAA', 1, '2018/07/01', 'M', 1800);
INSERT INTO MEMBERS VALUES('BBB', 2, '2018/07/02', 'F', 1900);
INSERT INTO MEMBERS VALUES('CCC', 3, '2018/07/03', 'M', 2000);
INSERT INTO MEMBERS VALUES('DDD', 4, SYSDATE, 'M', 2000);



--���� 2.
--MEMBERS���̺�� LOCATIONS���̺��� INNER JOIN �ϰ� m_name, m_mum, street_address, location_id
--�÷��� ��ȸ
--m_num�������� �������� ��ȸ

SELECT M.M_NAME �̸�,
       M.M_NUM ��ȣ,
       L.STREET_ADDRESS �ּ�,
       L.LOCATION_ID 
FROM MEMBERS M JOIN LOCATIONS L ON (M.LOCA = L.LOCATION_ID)
ORDER BY ��ȣ;



----------------------������ �ڵ�
SELECT M.M_NAME,
       M.M_NUM,
       L.STREET_ADDRESS,
       L.LOCATION_ID
FROM MEMBERS M JOIN LOCATIONS L ON M.LOCA = L.LOCATION_ID;

COMMIT;