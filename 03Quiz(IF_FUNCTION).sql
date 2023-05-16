--문제 1.
--현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
--사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요.
SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID 사원번호,
       CONCAT(FIRST_NAME, LAST_NAME) 사원명,
       HIRE_DATE 입사일자,
       TRUNC((SYSDATE-HIRE_DATE)/365,0) 근속년수
FROM EMPLOYEES WHERE TRUNC((SYSDATE-HIRE_DATE)/365,0) >= 10 
ORDER BY HIRE_DATE DESC; 



--문제 2.
--EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
--100이라면 ‘사원’, 
--120이라면 ‘주임’
--121이라면 ‘대리’
--122라면 ‘과장’
--나머지는 ‘임원’ 으로 출력합니다.
--조건 1) manager_id가 50인 사람들을 대상으로만 조회합니다

SELECT FIRST_NAME 이름,
       CASE MANAGER_ID WHEN 100 THEN '사원'
                       WHEN 120 THEN '주임'
                       WHEN 121 THEN '대리'
                       WHEN 122 THEN '과장' 
              ELSE '임원'
       END 직급
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
