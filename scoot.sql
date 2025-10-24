-- sql 구문은 대소문자를 구별하지 않음 (단, 비밀번호 제외)
-- 조회(select)
-- select 컬럼명 : (5)번 순서
-- from 테이블명 : (1)번 순서
-- where 조건절 : (2)번 순서
-- group by : (3)번 순서
-- having : (4)번 순서
-- order by 컬럼명 asc or desc : (6)번 순서

-- emp(사원) 테이블
-- empno(사번) : number(4, 0) => 숫자, 4자리, 소수점 아래 자릿수는 0
-- ename(이름) : varchar2(10) => 문자
-- job(직무)
-- mgr(매니저-상사 사원번호)
-- hiredate(입사일) : date 
-- sal(급여) : number(7,2)
-- comm(수당)
-- deptno(부서번호)

-- dept(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)

--조회 기본 구문
-- SELECT 열이름 FROM 테이블명;
-- SELECT 열이름 FROM 테이블명 WHERE 조건 나열;

-- 1) 전체 사원 조회 시 사원 모든 정보 추출
SELECT * FROM EMP e;

-- 2) 전체 사원 조회 시 사원 이름만 추출
SELECT ename FROM EMP e;

-- 3) 전체 사원 조회 시 사번, 사원명, 부서번호만 추출
SELECT e.empno, ename, deptno FROM EMP e;

-- 4) 전체 사원 조회 시 부서번호만 추출
SELECT deptno FROM emp e;

-- 5) 전체 사원 조회 시 부서번호만 추출 + 중복된 데이터 제거 후
SELECT DISTINCT deptno FROM EMP e;

-- 6_ alais(별칭)
SELECT ename "사원명" FROM EMP e;
SELECT ename 사원명 FROM EMP e;
SELECT ename AS "사원명" FROM EMP e;

-- 연봉구하기 (sal * 12 + comm)
SELECT empno, sal * 12 + comm AS 연봉 FROM EMP e;

--SELECT ename AS 사원 이름 FROM  EMP e; < 이렇게 하면 에러
SELECT ename AS "사원 이름" FROM  EMP e;

-- 오름차순, 내림차순 정렬 : ORDER BY 정렬기준 열이름.... ASC(오름) or DESC(내림)
--급여의 오름차순 정렬

SELECT  * FROM emp ORDER BY sal ASC;
SELECT  * FROM emp ORDER BY sal; --조건 없으면 기본 ASC
SELECT  * FROM emp ORDER BY sal DESC;
-- 급여의 내림차순, 이름의 오름차순
SELECT  * FROM emp ORDER BY sal DESC, ename ASC;

-- [실습]
-- empno : employee_no
-- ename : employee_name
-- mgr : manager
-- sal : salary
-- comm : commission
-- deptno : department_no
-- 별칭 지정, 부서번호 기준 내림차순 정렬(단 부서번호가 같다면 이름 오름차순)
SELECT 
	empno "employee_no", 
	ename "employee_name", 
	mgr "manager", 
	sal "salary", 
	comm "commission", 
	deptno "department_no" 
FROM 
	emp 
ORDER BY 
	deptno DESC, 
	ename ASC;
	
-- 부서번호가 30번인 사원정보 조회
SELECT * FROM emp WHERE DEPTNO = 30;
-- 사번이 7698인 사원정보 조회
SELECT * FROM emp WHERE empno = 7698;
-- 부서번호가 30, 직책이 salesman
SELECT * FROM emp WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
-- 부서번호가 30이거나 직책이 analyst
SELECT * FROM emp WHERE DEPTNO = 30 OR JOB = 'ANALYST';

--연봉이 36000인 사원
SELECT * FROM emp WHERE sal * 12 = 36000;
--급여가 3000 초과인 사원
SELECT * FROM emp WHERE sal > 3000;
--이름이 'F' 이후의 문자로 시작하는 사원
SELECT * FROM emp WHERE ENAME >= 'F';
-- 급여가 3000이 아닌 사원
SELECT * FROM emp WHERE sal != 3000;
SELECT * FROM emp WHERE sal <> 3000;
SELECT * FROM emp WHERE sal ^= 3000;

--직무가 manager, salesman, clerk인 사원 조회 + IN
SELECT * FROM emp WHERE JOB IN ('SALESMAN', 'MANAGER', 'CLERK'); 

--직무가 manager, salesman, clerk가 아닌 사원 조회 + NOT IN
SELECT * FROM emp WHERE JOB NOT IN ('SALESMAN', 'MANAGER', 'CLERK'); 

--부서번호가 10, 20번인 사원 조회(OR, IN)
SELECT * FROM emp WHERE DEPTNO = 30 OR DEPTNO = 20;
SELECT * FROM emp WHERE DEPTNO IN (20, 30);

-- between a and b
-- 급여가 2000이상 3000이하 직원 조회
SELECT * FROM emp WHERE sal >= 2000 AND sal <= 3000; 
SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000; 
-- 급여가 2000~3000이 아닌 직원
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000; 

-- LIKE + 와일드카드(%, _)
-- % : 길이와 상관없이(문자없는 경우도) 모든 문자 데이터를 의미
-- _ : 한개의 문자 데이터를 의미
-- 사원명이 S로 시작하는 사원들의 정보 조회
SELECT * FROM emp WHERE ENAME LIKE 'S%';
-- 사원명의 두번째 글자가 L인 사원들 정보 조회
SELECT * FROM emp WHERE ENAME LIKE '_L%';
-- 사원 이름에 AM이 포함된 사원들의 정보 조회
SELECT * FROM emp WHERE ENAME LIKE '%AM%';
-- 사원 이름에 AM이 포함되지 않은 사원들의 정보 조회
SELECT * FROM emp WHERE ENAME NOT LIKE '%AM%';

-- NULL 값
SELECT * FROM emp WHERE comm IS NULL;
SELECT * FROM emp WHERE comm IS NOT NULL;
