--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.




-------------------������ �ڵ�
SELECT *
FROM (SELECT ROWNUM RN,
               A.*
      FROM (SELECT E.EMPLOYEE_ID,
                   E.FIRST_NAME,
                   E.PHONE_NUMBER,
                   E.HIRE_DATE,
                   E.DEPARTMENT_ID,
                   D.DEPARTMENT_NAME
             FROM EMPLOYEES E 
             LEFT JOIN DEPARTMENTS D 
             ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
             ORDER BY HIRE_DATE) A
       )
WHERE RN > 0 AND RN <=10;


--���� 13. 
----EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���
-- �Ʒ� ������ JOIN�� �����ÿ�
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN';

SELECT E.LAST_NAME,
       E.JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN') E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-----------------------------������ �ڵ�
SELECT E.LAST_NAME,
       E.JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT *
      FROM EMPLOYEES
      WHERE JOB_ID = 'SA_MAN') E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


--���� 14
----DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
----�ο��� ���� �������� �����ϼ���.
----����� ���� �μ��� ������� ���� �ʽ��ϴ�
SELECT * FROM DEPARTMENTS;

SELECT E.DEPARTMENT_ID ID,
       D.DEPARTMENT_NAME NAME,
       D.MANAGER_ID MANAGER,
       E.�ο���
FROM(SELECT DEPARTMENT_ID,
             COUNT(*) �ο���
      FROM EMPLOYEES
      --WHERE DEPARTMENT_ID IS NOT NULL
      --����� ���� �μ��� ã�°Ŷ� ���� �ʿ� ����
      GROUP BY DEPARTMENT_ID
      ORDER BY COUNT(*) DESC) E LEFT JOIN DEPARTMENTS D
      ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY �ο��� DESC;
 
------------------------------������ �ڵ�
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.�ο���
FROM DEPARTMENTS D 
INNER JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) AS �ο���
       FROM EMPLOYEES
       GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY �ο��� DESC;



--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���

--�ٽ� �غ���
SELECT L.STREET_ADDRESS �ּ�,
       L.POSTAL_CODE �����ȣ,
       D.TRUNC(AVG(SALARY)) ��տ���
FROM LOCATIONS L LEFT JOIN (
SELECT DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
) E ON L.LOCATION_ID = D.LOCATION_ID;

SELECT * FROM EMPLOYEES;
SELECT * FROM LOCATIONS;


----------------------������ �ڵ�
SELECT D.*,
       NVL(E.SALARY, 0) AS SALARY,
       L.STREET_ADDRESS,
       L.POSTAL_CODE
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                  TRUNC(AVG(SALARY)) AS SALARY
           FROM EMPLOYEES
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;




--���� 16
---���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���

------------------------������ �ڵ�
SELECT *
FROM (SELECT ROWNUM RN,
             X.*
      FROM (SELECT D.*,
                   NVL(E.SALARY, 0) AS SALARY,
                   L.STREET_ADDRESS,
                   L.POSTAL_CODE
            FROM DEPARTMENTS D
            LEFT JOIN (SELECT DEPARTMENT_ID,
                              TRUNC(AVG(SALARY)) AS SALARY
                        FROM EMPLOYEES
                        GROUP BY DEPARTMENT_ID) E
                        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                        LEFT JOIN LOCATIONS L
                        ON D.LOCATION_ID = L.LOCATION_ID
                        ORDER BY D.DEPARTMENT_ID DESC
             ) X
    )
WHERE RN > 10 AND RN <=20;
