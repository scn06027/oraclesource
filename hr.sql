--문제12 '2004'년도에 고용된 모든 사람들의 last_name, hire_date를 조회하여 입사일 기준으로 오름차순 정렬
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '%04%'
ORDER BY
    hire_date;
    
--문제13 last_name에 u가 포함되는 사원들의 사번 및 last_name 조회
SELECT
    employee_id 사번,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%u%';

--문제14 last_name의 네번째 글자가 a인 사원들의 사번 및 last_name 조회
SELECT
    employee_id 사번,
    last_name
FROM
    employees
WHERE
    last_name LIKE '___a%';

--문제 15 last_name에 a혹은 e가 들어있는 사원들의 last_nmae 조회 후 last_name 오름차순 출력
SELECT
    last_name
FROM
    employees
WHERE
    ( last_name LIKE '%a%'
      OR last_name LIKE '%e%' )
ORDER BY
    last_name;

--문제 16 last_name에 a와 e가 들어있는 사원들의 last_nmae 조회 후 last_name 오름차순 출력
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%e%'
ORDER BY
    last_name;

SELECT
    *
FROM
    employees;

--IS NULL 연산자


--문제 매니저가 없는 사원들의 last_name, job_id 조회
SELECT
    last_name,
    job_id
FROM
    employees
WHERE
    manager_id IS NULL;

--문제 st_clerk 인 jo_id를 가진 사원이 없는 부서 id 조회.
--단, 부서번호가 null인 값은 제외한다 ㅇㅇ
SELECT
    job_id
FROM
    employees
WHERE
    job_id NOT IN ( 'ST_CLERK' )-------------------------------------------------------------------------
    AND job_id IS NOT NULL;

--문제 commision_pct가 널이 아닌 사원중에서 commission=salary*commission_pct를 구하여,
--employee_id, first_name,job_id와 함께 출력

SELECT
    salary * commission_pct commission,
    employee_id,
    first_name,
    job_id
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
    
--문제 first_name 이 Curtis인 사람의 퍼스트네임 라스트네임 폰넘버 잡아이디 조회 단 잡아이디의 결과는 소문자로 출력해라
SELECT
    first_name,
    last_name,
    phone_number,
    lower(job_id) job_id
FROM
    employees
WHERE
    first_name = 'Curtis';
--문제 부서번호가 60 70 80 90인 사람들의 임플로이아이디 퍼스트네임 라스트네임 디파트먼트아이디 잡아이디 조회하기 
--단 잡아이디가 IT_FROG인 사원의 ㄱㅇ우 프로그래머로 변경하여 출력하라
SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    replace(job_id, 'IT_PROG', '프로그래머') --해당하는것만 이렇게 바뀜
FROM
    employees
WHERE
    department_id IN ( 60, 70, 80, 90 );
--문제 job_id가 AD_PRES, PU_CLERK인 사원들의 임플로이아이디 퍼스트네임 라스트네임 디파트먼트아이디 잡아이디 조회하기 
--단 사원명은 퍼스트네임과 라스트네임을 연ㄱㄹ하여 ㅊ력
SELECT
    employee_id,
    first_name
    || ' '
    || last_name AS name,
    department_id,
    job_id
FROM
    employees
WHERE
    job_id IN ( 'AD_PRES', 'PU_CLERK' );

SELECT
    last_name,
    salary,
    decode(trunc(salary / 2000), 0, 0.00, 1, 0.09,
           2, 0.20, 3, 0.30, 4,
           0.40, 5, 0.42, 6, 0.44,
           0.45) AS tax_rete
FROM
    employees;

SELECT
    *
FROM
    employees;
--회사 내의 최대 연봉 및 최소 연봉 차 출력
SELECT
    MAX(salary) 최대연봉,
    MIN(salary) 최소연봉,
    ( MAX(salary) - MIN(salary) )
FROM
    employees;
--매니저로 근무하는 사원들의 총 숫자 출력 (중복 제거하셈)

SELECT
    COUNT(DISTINCT manager_id)
FROM
    employees;

--부서별 직원의수 를 구하여 , 부서번호의 오름차순으로 출력해보세요
SELECT
    department_id,
    COUNT(employee_id) 직원수
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id;
-- 부서별 급여의 평균 연봉 출력(부서번호, 평균 연봉 출력(부서번호별 오름차순)
SELECT
    department_id,
    round(AVG(salary)) 평균연봉
FROM
    employees
GROUP BY
    department_id
ORDER BY
    department_id;
    
--동일한 직업을 가진 사원들의 수 출력
SELECT
    job_id,
    COUNT(employee_id) 동일한직업
FROM
    employees
GROUP BY
    job_id;

SELECT
    *
FROM
    employees;
    
    
    --자신의 담당 매니저의 고용일보다 빠른 입사자 찾기 employees 셀프 조인
SELECT
    e1.first_name,
    e1.hire_date,
    e2.first_name,
    e2.hire_date
FROM
         employees e1
    JOIN employees e2 ON e1.department_id = e2.department_id
WHERE
        e1.manager_id = e2.employee_id
    AND e1.hire_date < e2.hire_date;

    --도시 이름이 t로 시작하는 지역에 사는 사원들의 사번 , last_name,department_id,city 출력
    --employees departments locations 테이블 조인
SELECT
    e1.employee_id,
    last_name,
    de2.department_id,
    city
FROM
         employees e1
    JOIN departments de2 ON e1.department_id = de2.department_id
    JOIN locations   lo3 ON lo3.location_id = de2.location_id
    
-- 지역에 살고있는 사원들의 사번이라 right out join을 쓰지 않음..
WHERE
    city LIKE 'T%';
    
    -- 위치 id가 1700인 사원들의 employee_id, last_name,department_id,salary
    --출력 employees, departments 조인
SELECT
    *
FROM
    departments;

SELECT
    e1.employee_id,
    e1.last_name,
    de2.department_id,
    e1.salary
FROM
         employees e1
    JOIN departments de2 ON e1.department_id = de2.department_id
WHERE
    de2.location_id = 1700;
    -- 각 부서별 평균 연봉(소수점 2자리까지) 사원수 조회
    --department_name  location_id, sal_avg, cnt 출력
   -- employees, departments 조인
SELECT
    department_name,
    location_id,
    round(AVG(salary), 2) AS sal_acg,
    COUNT(employee_id)    AS cnt
FROM
         employees e1
    JOIN departments de2 ON e1.department_id = de2.department_id
GROUP BY
    location_id,
    department_name; 
   
   --Exeutive 부서에 근무하는 모든 사원들의 department_id,last_name,job_id 출력
   -- employees, departments 조인
SELECT
    e1.department_id,
    e1.last_name,
    e1.job_id
FROM
         employees e1
    JOIN departments de2 ON e1.department_id = de2.department_id
WHERE
    de2.department_name = 'Executive';


--기존의 직업을 여전히 가지고 있는 사원들의 employee_id, job_id 출력
--, job_history 내부조인

SELECT
    e1.employee_id,
    e1.job_id
FROM
         employees e1
    JOIN job_history job ON job.employee_id = e1.employee_id
WHERE
    e1.job_id = job.job_id;
    
--각 사원별 소속부섯에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이
-- department_id, last_name,salary, hire_date 출력
--employees 셀프조인

SELECT
    distinct e2.department_id,
    e2.last_name,
    e2.salary,
    e2.hire_date
FROM
         employees e1
    JOIN employees e2 ON e1.department_id = e2.department_id
    where e1.hire_date<e2.hire_date and e1.salary<e2.salary order by e2.department_id;
--왜 난 50개가 뜨는거지? ..



create index idx_indextbl_firstname on indextbl(first_name);