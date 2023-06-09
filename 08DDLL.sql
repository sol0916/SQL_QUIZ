--문제 1. - 표 확인
--다음과 같은 테이블을 생성하고 데이터를 insert하세요 (커밋)
--조건) M_NAME 는 가변문자형, 널값을 허용하지 않음
--조건) M_NUM 은 숫자형, 이름(mem_memnum_pk) primary key
--조건) REG_DATE 는 날짜형, 널값을 허용하지 않음, 이름:(mem_regdate_uk) UNIQUE키
--조건) GENDER 고정문자형(1개) 'M' OR 'F' 만 들어가야 함 
--조건) LOCA 숫자형, 이름:(mem_loca_loc_locid_fk) foreign key ? 참조 locations테이블(location_id)

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


--------------------------선생님 코드
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



--문제 2.
--MEMBERS테이블과 LOCATIONS테이블을 INNER JOIN 하고 m_name, m_mum, street_address, location_id
--컬럼만 조회
--m_num기준으로 오름차순 조회

SELECT M.M_NAME 이름,
       M.M_NUM 번호,
       L.STREET_ADDRESS 주소,
       L.LOCATION_ID 
FROM MEMBERS M JOIN LOCATIONS L ON (M.LOCA = L.LOCATION_ID)
ORDER BY 번호;



----------------------선생님 코드
SELECT M.M_NAME,
       M.M_NUM,
       L.STREET_ADDRESS,
       L.LOCATION_ID
FROM MEMBERS M JOIN LOCATIONS L ON M.LOCA = L.LOCATION_ID;

COMMIT;