--�Ʒ� ���� YYYY��MM��DD�� ���·� ���
--SELECT '20050105' FROM DUAL;
SELECT TO_CHAR(TO_DATE('20050105', 'YYYYMMDD'), 'YYYY"��"MM"��"DD"��"') ��¥ FROM DUAL;

--�Ʒ� ���� ���� ��¥�� �ϼ� ���̸� ���ϼ���
--SELECT '2005��01��05��' FROM DUAL;
SELECT ROUND(SYSDATE - TO_DATE('2005��01��05��', 'YYYY"��"MM"��"DD"��"')) ��¥ FROM DUAL;


--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������.
SELECT EMPLOYEE_ID �����ȣ,
       CONCAT(FIRST_NAME, LAST_NAME) �����,
       HIRE_DATE �Ի�����,
       TRUNC((SYSDATE - HIRE_DATE)/365) �ټӳ��
FROM EMPLOYEES WHERE TRUNC((SYSDATE - HIRE_DATE)/365) >= 10
ORDER BY �ټӳ�� DESC;


--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������, 
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) DEPARTMENT_ID�� 50�� ������� ������θ� ��ȸ�մϴ�

--DECODE
SELECT FIRST_NAME �̸�,
       MANAGER_ID �Ŵ������̵�,
       DECODE (MANAGER_ID, 100, '���',
                          120, '����',
                          121, '�븮',
                          122, '����',
                          '�ӿ�') ����
FROM EMPLOYEES WHERE DEPARTMENT_ID = '50';


SELECT FIRST_NAME �̸�,
       MANAGER_ID �Ŵ������̵�,
       CASE MANAGER_ID WHEN 100 THEN '���'
                       WHEN 120 THEN '����'
                       WHEN 121 THEN '�븮'
                       WHEN 122 THEN '����'
                       ELSE '�ӿ�'
       END ����
FROM EMPLOYEES WHERE DEPARTMENT_ID = '50';