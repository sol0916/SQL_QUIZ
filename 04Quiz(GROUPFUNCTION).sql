--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���
SELECT JOB_ID, COUNT(*) �����, 
       TRUNC(AVG(SALARY)) �޿���� 
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY �޿���� DESC;

---------------������ �ڵ�
SELECT JOB_ID, 
       COUNT(*) AS �����,
       AVG(SALARY) AS �޿����
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY �޿���� DESC;



--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT HIRE_DATE �Ի�⵵,
       COUNT(*) �����
FROM EMPLOYEES
GROUP BY HIRE_DATE --�� �����°ǰ�...?
ORDER BY HIRE_DATE;

--------------������ �ڵ�
SELECT TO_CHAR(HIRE_DATE, 'YY'),
       COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');



--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
--�� �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT DEPARTMENT_ID �μ�, 
       TRUNC(AVG(SALARY)) ��ձ޿� 
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING TRUNC(AVG(SALARY)) >= 2000
ORDER BY ��ձ޿� DESC;

---------------������ �ڵ�
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
WHERE SALARY >= 1000
GROUP BY DEPARTMENT_ID
HAVING TRUNC(AVG(SALARY)) >= 2000;



--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT DEPARTMENT_ID �μ�, 
       --TRUNC(AVG(NVL2(COMMISSION_PCT, SALARY+(SALARY*COMMISSION_PCT), SALARY))) �������,
       --WHERE������ ������ �༭ NVL�� �� �ʿ䰡 ����
       TRUNC(AVG(SALARY+(SALARY*COMMISSION_PCT)),2) �������,
       SUM(SALARY) �����հ�, COUNT(*) �����
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID
ORDER BY ������� DESC;

-----------------������ �ڵ�
SELECT DEPARTMENT_ID,
       TRUNC(AVG(SALARY+SALARY*COMMISSION_PCT),2) AS �޿����,
       SUM(SALARY + SALARY*COMMISSION_PCT) AS �޿���,
       COUNT(*) AS �����
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
GROUP BY DEPARTMENT_ID;



--���� 5.
--������ ������, ���հ踦 ����ϼ���
SELECT JOB_ID, TRUNC(SUM(SALARY)) ������
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID) 
ORDER BY JOB_ID;
--ROLLUP �հ�..?

--------------������ �ڵ�
SELECT DECODE(GROUPING(JOB_ID), 1, '�հ�', JOB_ID) AS JOB_ID, 
       SUM(SALARY)
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);


--���� 6.
--�μ���, JOB_ID�� �׷��� �Ͽ�
--��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ�
--�Ұ� �հ踦 ǥ���ϼ���
SELECT DECODE(GROUPING(DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID) DEPARTMENT_ID,
       DECODE(GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID) JOB_ID, 
       COUNT(*) TOTAL,
       SUM(SALARY) SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;

----------------������ �ڵ�
SELECT DECODE(GROUPING(DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID) AS DEPARTMENT_ID, 
       DECODE(GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID) AS JOB_ID,
       COUNT(*) AS TOTAL,
       SUM(SALARY) AS SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;
