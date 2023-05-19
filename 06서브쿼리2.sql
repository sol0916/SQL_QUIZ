--문제 12. 
--employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 1-10번째 데이터만 출력합니다
--조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 부서아이디, 부서이름 을 출력합니다.
--조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.




-------------------선생님 코드
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


--문제 13. 
----EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의 LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요
-- 아래 내용을 JOIN에 넣으시오
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'SA_MAN';

SELECT E.LAST_NAME,
       E.JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN') E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-----------------------------선생님 코드
SELECT E.LAST_NAME,
       E.JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT *
      FROM EMPLOYEES
      WHERE JOB_ID = 'SA_MAN') E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


--문제 14
----DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
----인원수 기준 내림차순 정렬하세요.
----사람이 없는 부서는 출력하지 뽑지 않습니다
SELECT * FROM DEPARTMENTS;

SELECT E.DEPARTMENT_ID ID,
       D.DEPARTMENT_NAME NAME,
       D.MANAGER_ID MANAGER,
       E.인원수
FROM(SELECT DEPARTMENT_ID,
             COUNT(*) 인원수
      FROM EMPLOYEES
      --WHERE DEPARTMENT_ID IS NOT NULL
      --사람이 없는 부서를 찾는거라 굳이 필요 없음
      GROUP BY DEPARTMENT_ID
      ORDER BY COUNT(*) DESC) E LEFT JOIN DEPARTMENTS D
      ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 인원수 DESC;
 
------------------------------선생님 코드
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.인원수
FROM DEPARTMENTS D 
INNER JOIN (SELECT DEPARTMENT_ID,
             COUNT(*) AS 인원수
       FROM EMPLOYEES
       GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY 인원수 DESC;



--문제 15
----부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요
----부서별 평균이 없으면 0으로 출력하세요

--다시 해보기
SELECT L.STREET_ADDRESS 주소,
       L.POSTAL_CODE 우편번호,
       D.TRUNC(AVG(SALARY)) 평균연봉
FROM LOCATIONS L LEFT JOIN (
SELECT DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
) E ON L.LOCATION_ID = D.LOCATION_ID;

SELECT * FROM EMPLOYEES;
SELECT * FROM LOCATIONS;


----------------------선생님 코드
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




--문제 16
---문제 15결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서 ROWNUM을 붙여 1-10데이터 까지만
--출력하세요

------------------------선생님 코드
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
