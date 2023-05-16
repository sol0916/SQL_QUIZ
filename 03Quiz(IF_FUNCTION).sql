--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID �����ȣ,
       CONCAT(FIRST_NAME, LAST_NAME) �����,
       HIRE_DATE �Ի�����,
       TRUNC((SYSDATE-HIRE_DATE)/365,0) �ټӳ��
FROM EMPLOYEES WHERE TRUNC((SYSDATE-HIRE_DATE)/365,0) >= 10 
ORDER BY HIRE_DATE DESC; 



--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �������, 
--120�̶�� �����ӡ�
--121�̶�� ���븮��
--122��� �����塯
--�������� ���ӿ��� ���� ����մϴ�.
--���� 1) manager_id�� 50�� ������� ������θ� ��ȸ�մϴ�

SELECT FIRST_NAME �̸�,
       CASE MANAGER_ID WHEN 100 THEN '���'
                       WHEN 120 THEN '����'
                       WHEN 121 THEN '�븮'
                       WHEN 122 THEN '����' 
              ELSE '�ӿ�'
       END ����
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
