--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
---EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���

SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC;

SELECT COUNT(*) �����
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES 
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG')
ORDER BY SALARY DESC;

SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEES; --6461
SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'; --5760

-----------------------------������ �ڵ�
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');



--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT *
FROM (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100) D
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID; 


---------------------������ �ڵ�
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);



--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat'; --201

--------������ �ڵ�
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPOLYEES WHERE FIRST_NAME = 'Pat');

---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');

SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James'; --120, 121


------------------------������ �ڵ�
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');



--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
--ROW_NUMBER()
SELECT T.*
FROM(SELECT ROW_NUMBER() OVER(ORDER BY FIRST_NAME DESC) ���ȣ,
       CONCAT(FIRST_NAME, ' ' || LAST_NAME) �̸�
FROM EMPLOYEES) T
WHERE ���ȣ >= 41 AND ���ȣ <= 50 ; 

--ROUNUM
SELECT I.*
FROM (SELECT ROWNUM ���ȣ,
             CONCAT(FIRST_NAME, ' ' || LAST_NAME) �̸�
      FROM (SELECT * 
            FROM EMPLOYEES 
            ORDER BY FIRST_NAME DESC)
    )I
WHERE ���ȣ BETWEEN 41 AND 50;


-----------------------------------������ �ڵ�
SELECT *
FROM (SELECT E.*,
       ROWNUM AS RN
       FROM (SELECT * 
             FROM EMPLOYEES 
             ORDER BY FIRST_NAME DESC) E
        )
WHERE RN > 40 AND RN <= 50;






--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���
--ROW_NUMBER()
SELECT R.*
FROM(SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE) ���ȣ,
       EMPLOYEE_ID ���ID,
       CONCAT(FIRST_NAME, ' ' || LAST_NAME) �̸�,
       PHONE_NUMBER ��ȣ,
       HIRE_DATE �Ի���
FROM EMPLOYEES) R
WHERE ���ȣ >= 31 AND ���ȣ <=40;

--ROWNUM
SELECT R.*
FROM (SELECT ROWNUM ���ȣ,
             EMPLOYEE_ID ���ID,
             CONCAT(FIRST_NAME, ' ' || LAST_NAME) �̸�,
             PHONE_NUMBER ��ȣ,
             HIRE_DATE �Ի���
      FROM (SELECT *
            FROM EMPLOYEES
            ORDER BY HIRE_DATE)
      ) R
WHERE ���ȣ BETWEEN 31 AND 40; 


-----------------------������ �ڵ�
SELECT *
FROM (SELECT E.*,
             ROWNUM RN
      FROM (SELECT EMPLOYEE_ID,
                   FIRST_NAME || ' ' || LAST_NAME AS NAME,
                   PHONE_NUMBER,
                   HIRE_DATE
            FROM EMPLOYEES
            ORDER BY HIRE_DATE ) E
     )
WHERE RN BETWEEN 31 AND 40; 

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT EMPLOYEE_ID �������̵�,
       CONCAT(E.LAST_NAME, ' ' || E.FIRST_NAME) �̸�,
       E.DEPARTMENT_ID �μ����̵�,
       DEPARTMENT_NAME �μ���
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


---------------������ �ڵ�
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME AS NAME,
       D.DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT EMPLOYEE_ID �������̵�,
       CONCAT(LAST_NAME, ' ' || FIRST_NAME) �̸�,
       DEPARTMENT_ID �μ����̵�,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) �μ���
FROM EMPLOYEES E
ORDER BY JOB_ID;


-----------------------������ �ڵ�
SELECT EMPLOYEE_ID,
       FIRST_NAME || LAST_NAME AS NAME,
       DEPARTMENT_ID,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D 
        WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;



--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT DEPARTMENT_ID �μ����̵�,
       DEPARTMENT_NAME �μ��̸�,
       MANAGER_ID �Ŵ������̵�,
       D.LOCATION_ID �����̼Ǿ��̵�,
       STREET_ADDRESS �Ÿ��ּ�,
       POSTAL_CODE �����ȣ,
       CITY ����
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;


------------------------������ �ڵ�
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       D.LOCATION_ID,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       L.CITY
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;


--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT DEPARTMENT_ID �μ����̵�,
       DEPARTMENT_NAME �μ��̸�,
       MANAGER_ID �Ŵ������̵�,
       LOCATION_ID �����̼Ǿ��̵�,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) �Ÿ��ּ�,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) �����ȣ,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) ����
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;

--------------------------------������ �ڵ�
SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME,
       MANAGER_ID,
       LOCATION_ID,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID),
       (SELECT CITY FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID)
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;


--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT LOCATION_ID �����̼Ǿ��̵�,
       STREET_ADDRESS �ּ�,
       CITY ��Ƽ,
       C.COUNTRY_ID ������̵�,
       COUNTRY_NAME �����̸�
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON C.COUNTRY_ID = L.COUNTRY_ID
ORDER BY COUNTRY_NAME;


----------------������ �ڵ�
SELECT L.LOCATION_ID,
       L.STREET_ADDRESS,
       L.CITY,
       L.COUNTRY_ID,
       C.COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY COUNTRY_NAME;
       
 
--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT LOCATION_ID �����̼Ǿ��̵�,
       STREET_ADDRESS �ּ�,
       CITY ��Ƽ,
       (SELECT COUNTRY_ID FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) ������̵�,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) �����̸�
FROM LOCATIONS L
ORDER BY �����̸�;

SELECT * FROM COUNTRIES;
SELECT * FROM LOCATIONS;

----------------------------������ �ڵ�
SELECT L.LOCATION_ID,
       L.STREET_ADDRESS,
       L.CITY,
       L.COUNTRY_ID,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) COUNTRY_NAME
FROM LOCATIONS L 
ORDER BY COUNTRY_NAME;