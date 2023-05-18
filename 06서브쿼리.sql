--문제 1.
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
---EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
---EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요

SELECT *
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC;

SELECT COUNT(*) 사원수
FROM EMPLOYEES
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES 
WHERE SALARY > ALL (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG')
ORDER BY SALARY DESC;

SELECT TRUNC(AVG(SALARY)) FROM EMPLOYEES; --6461
SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'; --5760

--문제 2.
---DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
--EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.
SELECT *
FROM (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100) D
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE MANAGER_ID IS NOT NULL; 


--문제 3.
---EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
---EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat'; --201

---EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 갖는 모든 사원의 데이터를 출력하세요.
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');

SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James'; --120, 121


--문제 4.
---EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 행 번호, 이름을 출력하세요
SELECT T.*
FROM(SELECT ROW_NUMBER() OVER(ORDER BY FIRST_NAME DESC) 행번호,
       CONCAT(FIRST_NAME, ' ' || LAST_NAME) 이름
FROM EMPLOYEES) T
WHERE 행번호 >= 41 AND 행번호 <= 50 ; 



--문제 5.
---EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 
--입사일을 출력하세요
SELECT R.*
FROM(SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE) 행번호,
       EMPLOYEE_ID 사원ID,
       CONCAT(FIRST_NAME, ' ' || LAST_NAME) 이름,
       PHONE_NUMBER 번호,
       HIRE_DATE 입사일
FROM EMPLOYEES) R
WHERE 행번호 >= 31 AND 행번호 <=40;



--문제 6.
--employees테이블 departments테이블을 left 조인하세요
--조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
--조건) 직원아이디 기준 오름차순 정렬
SELECT EMPLOYEE_ID 직원아이디,
       CONCAT(E.LAST_NAME, ' ' || E.FIRST_NAME) 이름,
       E.DEPARTMENT_ID 부서아이디,
       DEPARTMENT_NAME 부서명
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;


--문제 7.
--문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT EMPLOYEE_ID 직원아이디,
       CONCAT(LAST_NAME, ' ' || FIRST_NAME) 이름,
       DEPARTMENT_ID 부서아이디,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) 부서명
FROM EMPLOYEES E
ORDER BY JOB_ID;


--문제 8.
--departments테이블 locations테이블을 left 조인하세요
--조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
--조건) 부서아이디 기준 오름차순 정렬
SELECT DEPARTMENT_ID 부서아이디,
       DEPARTMENT_NAME 부서이름,
       MANAGER_ID 매니저아이디,
       D.LOCATION_ID 로케이션아이디,
       STREET_ADDRESS 거리주소,
       POSTAL_CODE 우편번호,
       CITY 도시
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;


--문제 9.
--문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT DEPARTMENT_ID 부서아이디,
       DEPARTMENT_NAME 부서이름,
       MANAGER_ID 매니저아이디,
       LOCATION_ID 로케이션아이디,
       (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) 거리주소,
       (SELECT POSTAL_CODE FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) 우편번호,
       (SELECT CITY FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID) 도시
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_ID;


--문제 10.
--locations테이블 countries 테이블을 left 조인하세요
--조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
--조건) country_name기준 오름차순 정렬
SELECT LOCATION_ID 로케이션아이디,
       STREET_ADDRESS 주소,
       CITY 시티,
       C.COUNTRY_ID 나라아이디,
       COUNTRY_NAME 나라이름
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON C.COUNTRY_ID = L.COUNTRY_ID
ORDER BY COUNTRY_NAME;
       
 
--문제 11.
--문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
SELECT LOCATION_ID 로케이션아이디,
       STREET_ADDRESS 주소,
       CITY 시티,
       (SELECT COUNTRY_ID FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) 나라아이디,
       (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID) 나라이름
FROM LOCATIONS L
ORDER BY 나라이름;

SELECT * FROM COUNTRIES;
SELECT * FROM LOCATIONS;