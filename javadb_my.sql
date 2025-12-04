-- SQL
-- 1. 데이터 정의 언어(DDL)
-- 2. 데이터 조작 언어(DML) : SELECT, INSERT, UPDATE, DELETE => CRUD 작업
-- 3. 데이터 제어 언어(DCL)

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

-- 집합연산자
-- 합집합(UNION, UNION ALL), 교(INTERSECT), 차(MINUS)

-- 합집합 : 출력하려는 열 개수와 자료형이 일치
-- UNION : 중복 제거
SELECT
	*
FROM
	emp
WHERE
	DEPTNO = 10
UNION
SELECT
	*
FROM
	emp
WHERE
	DEPTNO = 20;

-- UNION ALL
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	emp
WHERE
	DEPTNO = 10
UNION ALL
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	emp
WHERE
	DEPTNO = 10;

-- MINUS
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	emp
MINUS
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	emp
WHERE
	DEPTNO = 10;

-- INTERSECT
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	emp
INTERSECT
SELECT
	EMPNO, ENAME, SAL, DEPTNO
FROM
	emp
WHERE
	DEPTNO = 10;

-- [실습]
-- 1. 사원 이름이 S로 끝나는 사원데이터 조회
SELECT
	*
FROM
	emp
WHERE
	ENAME LIKE '%S';
-- 2. 30번 부서에 근무하고 있는 사원 중에 JOB이 SALESMAN 인 사원의 사원번호, 이름, 직책, 급여, 부서번호 조회
SELECT
	EMPNO, ENAME, JOB, SAL, DEPTNO
FROM
	emp
WHERE 
	DEPTNO = 30 AND JOB = 'SALESMAN';
-- 3. 20, 30분 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원을 다음 두 방식의 SELECT 문을 사용하여 사원번호, 이름, 직책, 급여, 부서 번호를 출력
-- 집합 연산자, 집합 연산자를 사용X
SELECT
	EMPNO, ENAME, JOB, SAL, DEPTNO
FROM
	emp
WHERE 
	DEPTNO IN (20, 30) AND SAL > 2000;

SELECT
	EMPNO, ENAME, JOB, SAL, DEPTNO
FROM
	emp
WHERE 
	DEPTNO IN (20, 30)
INTERSECT 
SELECT
	EMPNO, ENAME, JOB, SAL, DEPTNO
FROM
	emp
WHERE 
	SAL > 2000;
-- 4. NOT BETWEEN A AND B 연산자 사용X 급여열이 2000 이상 3000이하 범위 이외의 값을 가진 데이터 조회
SELECT
	*
FROM
	emp
WHERE 
	SAL < 2000 OR SAL > 3000;
-- 5. 사원 이름에 E가 포함된 30번 부서의 사원 중 급여가 1000 ~ 2000 사이가 아닌 사원명, 사번, 급여, 부서번호 조회
SELECT
	ENAME,
	JOB,
	SAL,
	DEPTNO
FROM
	emp
WHERE
	DEPTNO = 30
	AND SAL NOT BETWEEN 1000 AND 2000
	AND ENAME LIKE '%E%';
-- 6. 추가 수당이 없고 상급자가 있고 직책이 MANAGER, CLERK 인 사원 중에서 사원이름의 두번째 글자가 L이 아닌 사원의 정보를 조회
SELECT
	*
FROM
	emp
WHERE
	COMM IS NULL
	AND MGR IS NOT NULL
	AND JOB IN ('MANAGER', 'CLERK')
	AND ENAME NOT LIKE '_L%';

-- 함수
-- 1. 문자함수
-- UPPER(문자열) : 대문자 변환, LOWER(문자열) : 소문자 변환
-- INITCAP(문자열) : 첫글자만 대문자
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열의 바이트 길이
-- SUBSTR(문자열, 시작위치, 추출길이) : 문자열 부분 추출
-- INSTR(대상문자열, 위치 찾으려는 문자, 위치찾기 시작위치, 찾으려는 문자가 몇번째인지) : 문자열데이터 안에서 특정 문자 위치 찾기
-- REPLACE(문자열, 찾는문자, 바꿀문자) : 문자 바꾸기
-- CONCAT(문자열1, 문자열2) : 두 문자열 데이터 합치기
-- TRIM(삭제옵션(선택), 삭제할문자(선택) FROM 원본문자열)
-- 1) 옵션 : LEADING or TRAILING or BOTH
-- LTRIM(원본문자열, 삭제할 문자열)
-- RTRIM(원본문자열, 삭제할 문자열)

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM emp;

SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME)
FROM emp;

-- DUAL(SYS 소유의 더미 테이블)
-- 한글 한자당 3byte 사용
SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL;

-- 사원명 길이가 5이상인 사원 조회
-- 직책명이 6자 이상인 사원 조회
SELECT *
FROM EMP 
WHERE LENGTH(ENAME) >= 5;

SELECT *
FROM EMP 
WHERE LENGTH(JOB) >= 6;

SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB, 5)
FROM emp;

-- emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT ENAME, SUBSTR(ENAME, 3)
FROM emp;

SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)), SUBSTR(JOB, -LENGTH(JOB), 2), SUBSTR(JOB, -3)
FROM emp;

SELECT INSTR('HELLO, ORACLE!', 'L') AS "첫번째", INSTR('HELLO, ORACLE!', 'L', 5) AS "두번째", INSTR('HELLO, ORACLE!', 'L', 2, 2) AS "세번째"
FROM DUAL;

-- 문자S가 이름에 포함된 사원 조회
-- 1) LIKE, 2) INSTR() > 0
SELECT ENAME
FROM emp
WHERE INSTR(ENAME, 'S') > 0;

-- 010-4526-7858 => 010 4526 7858 or 01045267858
SELECT '010-4526-7858' AS BEFORE, REPLACE('010-4526-7858','-',' ') AS REPLACE1, REPLACE('010-4526-7858','-') AS REPLACE2
FROM DUAL;

-- EMPNO, ENAME 합치기
-- concat() or ||
SELECT CONCAT(EMPNO, ENAME), CONCAT(EMPNO, CONCAT(':', ENAME)), ENAME || EMPNO
FROM emp;

--TRIM()
SELECT '[' || TRIM(' __Oracle__ ') || ']' AS trim, --BOTH가 기본
	   '[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS TRIM_LEADING,
	   '[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS TRIM_TRAILING,
	   '[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS TRIM_BOTH
FROM DUAL;

--LTRIM(), RTRIM()
SELECT '[' || TRIM('  _Oracle_  ') || ']' AS trim, --BOTH가 기본
	   '[' || LTRIM('  _Oracle_  ') || ']' AS LTRIM,
	   '[' || LTRIM('<_Oracle_>', '_<') || ']' AS LTRIM2,
	   '[' || RTRIM('  _Oracle_  ') || ']' AS RTRIM,
	   '[' || RTRIM('<_Oracle_>', '>_') || ']' AS RTRIM2
FROM DUAL;

-- 숫자함수
-- ROUND(숫자, 반올림위치)
-- TRUNC(숫자, 버림위치)
-- CEIL(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수
-- FLOOR(숫자) : 지정된 숫자보다 작은 정수 중 가장 큰 정수
-- MOD(숫자, 나눌숫자) : 나눈 나머지 반환

SELECT ROUND(1234.5678) AS ROUND,
ROUND(1234.5678, 0) AS ROUND0,
ROUND(1234.5678, 1) AS ROUND1,
ROUND(1234.5678, 2) AS ROUND2,
ROUND(1234.5678, -1) AS ROUND_MINUS1,
ROUND(1234.5678, -2) AS ROUND_MINUS2
FROM DUAL;

SELECT TRUNC(1234.5678) AS TRUNC,
TRUNC(1234.5678, 0) AS TRUNC0,
TRUNC(1234.5678, 1) AS TRUNC1,
TRUNC(1234.5678, 2) AS TRUNC2,
TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

SELECT MOD(15, 6), MOD(10, 2), MOD(11, 2)
FROM DUAL;

-- 날짜함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이전 날짜 반환
-- 날짜 데이터 - 날짜데이터 : 두 날짜 데이터 간의 일수 차이 반환
-- 날짜 데이터 + 날짜데이터 : 연산불가
-- ADD_MONTHS(날짜데이터, 더할 개월 수)
-- MONTHS_BETWEEN(날짜데이터1, 날짜데이터2)
-- NEXT_DAY(날짜데이터1, 요일문자)
-- LAST_DAY(날짜데이터)

-- 오라클에서 시스템 날짜 출력 : SYSDATE
SELECT SYSDATE, SYSDATE + 1, SYSDATE - 1, CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사 50주년이 되는 날짜 구하기
SELECT HIREDATE, ADD_MONTHS(HIREDATE, 600)
FROM emp;

-- 오늘 기준 입사한지 40년이 넘은 사원 조회
SELECT *
FROM emp
WHERE ADD_MONTHS(HIREDATE, 480) < SYSDATE;


SELECT
	EMPNO,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM
	emp;

SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '월요일')
FROM DUAL;

-- 형변환 함수
-- TO_CHAR() : 날짜, 숫자를 문자로(중요)
-- TO_NUMBER() : 문자를 숫자로
-- TO_DATE() : 문자를 날짜로

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;

--자동 형변환
SELECT EMPNO, ENAME, EMPNO + '500'
FROM emp
WHERE ENAME ='SMITH';

--SELECT EMPNO, ENAME, EMPNO + 'ABCD'
--FROM emp
--WHERE ENAME ='SMITH';

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON'),
	TO_CHAR(SYSDATE, 'MONTH'),
	TO_CHAR(SYSDATE, 'DD'),
	TO_CHAR(SYSDATE, 'DY'),
	TO_CHAR(SYSDATE, 'DAY')
FROM
	DUAL;

-- 오전, 오후 표시 : AM, PM, A.M., P.M.
SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH24:MI:SS'),
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),
	TO_CHAR(SYSDATE, 'HH:MI:SS P.M.')
FROM
	DUAL;

-- L : 지역 화폐 단위
SELECT SAL, TO_CHAR(SAL, '$999,999'), TO_CHAR(SAL, 'L999,999')
FROM emp;


SELECT '1300' - '1500', '1300' + 1500
FROM DUAL;

--수치 부적합 에러
SELECT '1,300' - '1500', '1300' + 1500
FROM DUAL;

SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM DUAL;

SELECT TO_DATE('20251027', 'YYYY/MM/DD')
FROM DUAL;

-- null 처리 함수
-- 1. NVL(NULL에 해당하는 값, 반환할 데이터) : NULL인 경우만 반환할 데이터로 돌아옴
-- 2. NV2L(NULL에 해당하는 값, NULL이 아닐때 반환할 데이터, 반환할 데이터)
-- NULL + NULL = NULL
-- 숫자 + NULL = NULL
SELECT EMPNO, ENAME, SAL, COMM, COMM + SAL FROM emp;
SELECT EMPNO, ENAME, SAL, COMM, NVL(COMM, 0) + SAL FROM emp;
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, 'O', 'X'), NVL2(COMM, SAL * 12 + COMM, SAL * 12) FROM emp;

-- DECODE, CASE 함수 : 상황에 따라 다른 데이터 반환
-- DECODE(검사 대상이 될 열 또는 데이터, [조건1], [조건1과 일치할때 반환할 결과], [조건2], [조건2와 일치할떄...] ... [위에 나열한 조건과 일치하지 않는 경우 반환할 결과])

-- CASE 검사 대상이 될 열 또는 데이터 
-- WHEN [조건1] THEN [조건1과 일치할때 반환할 결과]
-- WHEN [조건2] THEN [조건2와 일치할때 반환할 결과] ...
-- ELSE [위에 나열한 조건과 일치하지 않는 경우 반환할 결과]
-- END

-- 직책이 MANAGER인 사원은 급여의 10%, SALESMAN인 사원은 5%, ANALYST인 사원은 그대로, 나머지는 3% 만큼 인상된 급여 구하기
SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS 급여
FROM
	emp;

SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	CASE JOB 
	WHEN 'MANAGER' THEN SAL * 1.1
	WHEN 'SALESMAN' THEN SAL * 1.05 
	WHEN 'ANALYST' THEN SAL
	ELSE SAL * 1.03 
	END AS 급여
FROM
	emp;

-- COMM이 NULL인 경우에는 해당X, 0인 경우에는 수당X, 0보다 크면 수당 : 800
SELECT
	EMPNO,
	ENAME,
	COMM,
	CASE 
		WHEN COMM IS NULL THEN '해당없음'
		WHEN COMM = 0 THEN '수당없음'
		WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS COMM_TEXT
FROM
	emp;

-- EMP 테이블에서 사원의 월 평균 근무일수는 21.5일이다.
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루급여(DAY_PAY), 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고, 시급은 소수 둘째 자리에서 반올림
SELECT
	ENAME,
	SAL,
	TRUNC(SAL / 21.5, 2) AS DAY_PAY,
	ROUND((SAL / 21.5) / 8, 1) AS TIME_PAY
FROM
	emp;
-- EMP 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원이 정직원이 되는 날짜(R_JOB)을
-- YYYY-MM-DD 형식으로 출력. 단, 추가 수당이 없는 사원의 추가 수당은 N/A로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM 출력
SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL2(COMM, TO_CHAR(COMM), 'N/A') AS COMM
FROM
	emp;
-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)을 아래의 조건을 기준으로 변환해서 CHG_MGR 열에 출력
-- 직속 상관의 번호가 없는 경우 0000
-- 직속 상관의 사원번호 앞 두자리가 75일 때 5555
-- 직속 상관의 사원번호 앞 두자리가 76일 때 6666
-- 직속 상관의 사원번호 앞 두자리가 77일 때 7777
-- 직속 상관의 사원번호 앞 두자리가 78일 때 8888
-- 그 외 직속상관 사원 번호일 때 : 본래 직속상관의 사원번호 그대로 출력
SELECT
	ENAME,
	MGR,
	CASE 
		WHEN MGR IS NULL THEN '0000'
		WHEN TO_CHAR(MGR) LIKE '75%' THEN '5555'
		WHEN TO_CHAR(MGR) LIKE '76%' THEN '6666'
		WHEN TO_CHAR(MGR) LIKE '77%' THEN '7777'
		WHEN TO_CHAR(MGR) LIKE '78%' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
	emp;

SELECT
	TO_CHAR(MGR)
FROM emp;

-- 다중행 함수
-- SUM(), AVG(), COUNT(), MAX(), MIN()

SELECT SUM(SAL), AVG(SAL), MAX(SAL), MIN(SAL), COUNT(SAL)
FROM emp;

-- 단일 그룹의 그룹 함수가 아닙니다
--SELECT SUM(SAL), ENAME
--FROM emp;

--중복 제거 가능
SELECT SUM(DISTINCT SAL), AVG(SAL), MAX(SAL), MIN(SAL), COUNT(*)
FROM emp
WHERE DEPTNO = 10;

-- 20번 부서의 제일 오래된 입사일
SELECT MIN(HIREDATE)
FROM emp
WHERE DEPTNO = 20;

-- 20번 부서의 제일 최신 입사일
SELECT MAX(HIREDATE)
FROM emp
WHERE DEPTNO = 20;

-- GROUP BY : 결과값을 원하는 열로 묶어 출력
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 컬럼은 GROUP BY에 사용한 컬럼만 가능
SELECT DEPTNO, AVG(SAL)
FROM emp
GROUP BY DEPTNO;

-- 부서별, 직무별 급여 평균 조회
SELECT DEPTNO, JOB, AVG(SAL)
FROM emp
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

-- 부서별 추가수당 평균 조회
SELECT DEPTNO, AVG(NVL(COMM, 0))
FROM emp
GROUP BY DEPTNO;

-- GROUP BY 열이름 HAVING 출력 그룹 제한
-- 부서별, 직무별 급여 평균 조회 (단, 평균이 2000 이상 그룹 조회)
SELECT
	DEPTNO,
	JOB,
	AVG(SAL)
FROM
	emp
HAVING
	AVG(SAL) >= 2000
GROUP BY
	DEPTNO,
	JOB
ORDER BY
	DEPTNO,
	JOB;

SELECT
	DEPTNO,
	JOB,
	AVG(SAL)
FROM
	emp
WHERE
	SAL <= 3000
GROUP BY
	DEPTNO,
	JOB
HAVING
	AVG(SAL) >= 2000
ORDER BY
	DEPTNO,
	JOB;

-- emp 테이블을 이용하여 부서번호, 평균급여(avg_sal), 최고급여(max_sal), 최저급여(min_sal), 사원수(cnt) 조회
-- 단, 평균급여 출력 시 소수점을 제외하고 각 부서번호별로 출력
SELECT
	DEPTNO,
	TRUNC(AVG(SAL)) AS avg_sal,
	MAX(SAL) AS max_sal,
	MIN(SAL) AS min_sal,
	COUNT(*) AS cnt
FROM
	emp
GROUP BY
	DEPTNO
ORDER BY
	DEPTNO;
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT
	JOB,
	COUNT(JOB) AS CNT
FROM
	emp
HAVING
	COUNT(JOB) >= 3
GROUP BY
	JOB;
-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력 to_char(1111-11-11, 'YYYY')
SELECT
	TO_CHAR(HIREDATE, 'YYYY') AS HIREDATE,
	DEPTNO,	
	COUNT(*) AS cnt
FROM
	emp
GROUP BY
	DEPTNO,
	TO_CHAR(HIREDATE, 'YYYY')
ORDER BY
	DEPTNO;

-- JOIN
-- 여러 테이블을 하나의 테이블처럼 사용
-- 1. 내부조인 (INNER JOIN)
-- 2. 외부조인 (OUTER JOIN)
--	(1) LEFT OUTER JOIN
--	(2) RIGHT OUTER JOIN
--	(3) FULL OUTER JOIN
-- DB 설계는 최소한의 중복을 지향

-- 사원정보 + 부서정보 조회
-- 내부조인 + 등가조인
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO;


SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO
	AND e.SAL >= 2000;

-- 비등가 조인 + 내부조인
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	s.LOSAL,
	s.HISAL
FROM
	EMP e
JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 셀프조인
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS 매니저명
FROM
	EMP e1
JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;

-- 외부조인
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS 매니저명
FROM
	EMP e1
LEFT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;

SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS 매니저명
FROM
	EMP e1
RIGHT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;
	
-- 부서명도 조회
SELECT
	e.DEPTNO,
	d.DNAME,
	TRUNC(AVG(e.SAL)) AS avg_sal,
	MAX(e.SAL) AS max_sal,
	MIN(e.SAL) AS min_sal,
	COUNT(*) AS cnt
FROM
	emp e
	JOIN DEPT d ON e.DEPTNO  = d.DEPTNO
GROUP BY
	e.DEPTNO,
	d.DNAME
ORDER BY
	e.DEPTNO;

-- 테이블 3개 연동
-- 부서번호, 부서명, 사번, 사원명, 매니저번호, 급여, 급여등급 (salgrade)

SELECT
	e.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.MGR, e.SAL, s.GRADE AS salgrade
FROM
	emp e
	JOIN DEPT d ON e.DEPTNO  = d.DEPTNO
	JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	e.DEPTNO;

-- 서브쿼리 : 메인쿼리 외에 select 구문이 여러개 존재, 괄호안에 작성
-- 1) 단일행 서브쿼리 : 서브쿼리 실행 결과가 행 하나
--	ㄴ 연산자 종류 : >, <. >=, <=, <>, !=, ^=, =
-- 2) 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러 행
--	ㄴ 연산자 종류 : IN, ANY(= SOME), ALL, EXIST
-- IN : 서브쿼리 결과 중 하나라도 일치한 데이터가 있다면 TRUE
-- ANY, SOME : 서브쿼리 결과가 하나 이상이면 TRUE
-- ALL : 서브쿼리 결과가 모두 만족하면 TRUE
-- EXISTS : 서브쿼리 결과가 있으면 TRUE

-- SELECT e.ENAME, (SELECT * FROM EMP e2)
-- FROM EMP e JOIN (SELECT )
-- WHERE e.DEPTNO = (SELECT )

-- JONES의 급여보다 높은 급여를 받는 사원 데이터 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'JONES');

-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 연산자가 있다면 무조건 하나만 리턴되어야함
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.JOB  = 'MANAGER');

-- WARD 사원보다빨리 입사한 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.HIREDATE < (
	SELECT
		e2.HIREDATE
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가로 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20 AND e.SAL > (SELECT AVG(e2.SAL) FROM EMP e2);


SELECT
	*
FROM
	EMP e
WHERE
	e.SAL IN (
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL = ANY (
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL = SOME (
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);

-- < any
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < ANY (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > ANY (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > ALL (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < ALL (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);

--서브쿼리 결과가 하나이상 나오면 true
SELECT
	*
FROM
	EMP e
WHERE
	EXISTS (
	SELECT
		d.DNAME
	FROM
		DEPT d
	WHERE
		d.DEPTNO = 30);


-- 다중열 서브쿼리
SELECT
	*
FROM
	EMP e
WHERE
	(e.DEPTNO,
	e.SAL) IN (
	SELECT
		e2.DEPTNO,
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO )
		
-- from 절 서브쿼리(= 인라인 뷰)
SELECT
	e10.*,
	d.*
FROM
	(
	SELECT
		*
	FROM
		EMP e
	WHERE
		e.DEPTNO = 10) e10,
	(
	SELECT
		*
	FROM
		DEPT) d
WHERE
	e10.DEPTNO = d.DEPTNO;

-- select 절 서브쿼리(= 스칼라 서브쿼리)
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.sal BETWEEN s.LOSAL AND s.HISAL) AS salgrade,
	e.DEPTNO,
	(
	SELECT
		d.DNAME
	FROM
		DEPT d
	WHERE
		e.DEPTNO = d.DEPTNO) AS dname
FROM
	EMP e;

-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서정보 조회
-- 정보 : 사번, 이름, 직무, 급여, 부서번호, 부서명
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	e.DEPTNO,
	(
	SELECT
		d.DNAME
	FROM
		DEPT d
	WHERE
		e.DEPTNO = d.DEPTNO) AS DEPNAME
FROM
	EMP e
WHERE
	e.JOB IN (
	SELECT
		e1.JOB
	FROM
		EMP e1
	WHERE
		e1.ENAME = 'ALLEN');
-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e1
WHERE
	e1.SAL IN
(
	SELECT
		MAX(e2.SAL)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO)
ORDER BY
	e1.DEPTNO;
-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사번, 이름, 직무, 부서번호, 부서명, 부서위치 조회
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME, 
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 10
	AND e.JOB NOT IN (
	SELECT
		e2.JOB
	FROM
		EMP e2
	WHERE
		e2.DEPTNO = 30);


-- insert : 테이블에 데이터 추가
-- INSERT INTO 테이블명(열이름1, 열이름2) VALUES(값1, 값2...);
-- 연습용 테이블 생성
CREATE TABLE dept_temp AS SELECT * FROM dept;
CREATE TABLE EMP_temp AS SELECT * FROM EMP WHERE 1<>1;
SELECT * FROM dept_temp;

-- 50, DATABASE, SEOUL
INSERT INTO dept_temp(DEPTNO, DNAME, LOC) VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO dept_temp VALUES(60, 'NETWORK', 'BUSAN');
--값으로 NULL 명시적 삽입
INSERT INTO dept_temp(DEPTNO, DNAME, LOC) VALUES(70, 'WEB', NULL);
INSERT INTO dept_temp(DEPTNO, DNAME, LOC) VALUES(80, 'MOBILE', '');
--NULL 암시적 처리
INSERT INTO dept_temp(DEPTNO, DNAME) VALUES(90, 'OS');


SELECT * FROM EMP_temp;

INSERT
	INTO
	EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(1111, '성춘향', 'MANAGER', 9999, '2010-10-25', 4000, NULL, 20);

INSERT
	INTO
	EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2010-01-25', 8000, 1000, 10);

INSERT
	INTO
	EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(2222, '김수호', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);

-- EMP 테이블에서 SALGRADE가 1인 사원만 EMP_TEMP로 삽입
INSERT
	INTO
	EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT e.EMPNO, e.ENAME, e.JOB, e.MGR, e.HIREDATE, e.SAL, e.COMM, e.DEPTNO
FROM EMP e JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 1;

-- UPDATE
-- UPDATE 테이블명 SET 열이름 = 수정할값, 열이름2 = 수정할값 WHERE 수정할조건
SELECT * FROM DEPT_TEMP dt;

-- 10번 부서의 위치 SEOUL 변경
UPDATE DEPT_TEMP dt
SET dt.LOC = 'SEOUL'
WHERE dt.DEPTNO  = 10;

-- EMP_TEMP 테이블의 사원중에서 SAL이 2500 이하인 사원만 추가 수당을 50으로 수정
SELECT * FROM EMP_temp;

UPDATE EMP_TEMP et
SET et.COMM = 50
WHERE et.SAL <= 2500;

-- dept 테이블의 40번 부서의 dname, loc 정보를 가져와서 dept_temp 40번 부서의 내용으로 변경
SELECT * FROM DEPT d;

UPDATE DEPT_TEMP dt
SET (dt.DNAME, dt.LOC) = (SELECT d.DNAME, d.LOC FROM DEPT d WHERE d.DEPTNO = 40)
WHERE dt.DEPTNO = 40;

-- 전부 다 UPDATE
SELECT * FROM DEPT_TEMP dt;
UPDATE DEPT_TEMP dt
SET LOC = 'BUSAN';

-- DELETE : 데이터 삭제
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;

-- 7902 사원 삭제
DELETE FROM EMP_TEMP2 WHERE EMPNO = 7902;
DELETE EMP_TEMP2 WHERE EMPNO = 7844;
DELETE FROM EMP_TEMP2;

-- EMP 테이블을 복사하여 EXAM_EMP 테이블 생성
-- DEPT 테이블을 복사하여 EXAM_DEPT 테이블 생성
-- SALGRADE 테이블을 복사하여 EXAM_SALGRADE 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;
SELECT * FROM EXAM_EMP;
SELECT * FROM EXAM_DEPT;
SELECT * FROM EXAM_SALGRADE;

-- EXAM_DEPT 테이블에 5~80번 부서를 등록하는 SQL구문 작성
-- 50, ORACLE, BUSAN
-- 60, SQL, ILSAN
-- 70, SELECT, INCHEON
-- 80, DML, BUNDANG
INSERT INTO EXAM_DEPT (DEPTNO, DNAME, LOC)
VALUES(50, 'ORACLE', 'BUSAN');
INSERT INTO EXAM_DEPT (DEPTNO, DNAME, LOC)
VALUES(60, 'SQL', 'ILSAN');
INSERT INTO EXAM_DEPT (DEPTNO, DNAME, LOC)
VALUES(70, 'SELECT', 'INCHEON');
INSERT INTO EXAM_DEPT (DEPTNO, DNAME, LOC)
VALUES(80, 'DML', 'BUNDANG');

-- EXAM_EMP 테이블에 8명의 사원정보를 등록하는 SQL 구문 작성
-- 8명은 임의의 값(50~80 사이로 지정)
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE1', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE2', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE3', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE4', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE5', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE6', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE7', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES((SELECT MAX(EMPNO) + 1 FROM EXAM_EMP), 'ORACLE8', 'SALESMAN', NULL, SYSDATE, 600, NULL, 20);

-- EXAM_EMP에서 50번 부서에 근무하는 사원의 평균 급여보다 많이 받는 사원을 70번 부서로 옮기는 SQL 구문 작성
UPDATE EXAM_EMP dt
SET dt.DEPTNO = 70
WHERE dt.SAL > (SELECT AVG(dt2.SAL) FROM EXAM_EMP dt2 WHERE dt2.DEPTNO = 50);

-- EXAM_EMP에 속한 사원 중 입사일이 가장 빠른 60번 부서 사원보다 늦게 입사한 사원의 급여를 10% 인상하고
-- 80번 부서로 옮기는 SQL 구분 작성
UPDATE EXAM_EMP dt
SET dt.SAL = dt.SAL * 1.1, dt.DEPTNO = 80
WHERE dt.HIREDATE > (SELECT MIN(dt2.HIREDATE) FROM EXAM_EMP dt2 WHERE dt2.DEPTNO = 60);

-- EXAM_EMP에 속한 사원 중 급여 등급이 5인 사원을 삭제하는 SQL 구문 작성
DELETE FROM EXAM_EMP
WHERE EMPNO IN (
    SELECT E2.EMPNO
    FROM EXAM_EMP E2
    JOIN EXAM_SALGRADE S ON E2.SAL BETWEEN S.LOSAL AND S.HISAL
    WHERE S.GRADE = 5
);

-- DML : INSERT, UPDATE, DELETE => 데이터 변경이 일어나는 작업
-- 트랜잭션 : 하나의 단위로 데이터 처리
-- ROLLBACK; 되돌리기
-- COMMIT; 데이터베이스 반영

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TCL;

INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
UPDATE DEPT_TCL dt SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESERCH';
SELECT * FROM DEPT_TCL;
ROLLBACK;
COMMIT;

-- 세션 : 데이터베이스 접속을 시작으로 작업을 수행한 후 접속을 종료하기까지 전체 기간을 의미

SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL WHERE deptno = 50;
COMMIT;

-- 트랜잭션 시작
UPDATE DEPT_TCL dt SET LOC = 'SEOUL' WHERE DEPTNO = 30;
SELECT * FROM DEPT_TCL;
COMMIT;

-- 데이터 정의 언어(DDL)
-- 객체를 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 명령어

-- 1) 테이블 생성
-- CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
-- CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT WHERE 1<>1;

-- CREATE TABLE 테이블명(열이름1 타입(20), 열이름2 타입(20)) 

-- 타입
-- 문자 : CHAR / NCHAR / VARCHAR2 / NVARCHAR2
--		 CHAR (고정크기) / VARCHAR (가변크기)
--		 char(10) : abc => 10자리를 그대로 사용
--		 varchar2(10) : abc => 3자리를 사용
--		 nvarchar2(10) : 안녕하세요 입력 가능 (byte 크기가 아닌 길이라고 인식 가능)
-- 숫자 : number(7, 2) : 소수 둘째 자리를 포함해서 총 7자리 숫자 지정 가능
-- 날짜 : date

-- 테이블명 : 문자로 시작, 특수문자(_, $, #) 가능, 숫자 가능 / 예약어(select, order, from...)는 사용 안됨
-- 열 이름 : 문자로 시작, 특수문자(_, $, #) 가능, 숫자 가능 / 예약어(select, order, from...)는 사용 안됨
 

-- 자료형을 정의하여 새 테이블 생성
SELECT * FROM EMP_DDL;
CREATE TABLE EMP_DDL(EMPNO NUMBER(4), ENAME VARCHAR2(10), JOB VARCHAR2(9), MGR NUMBER(4), HIREDATE DATE, SAL NUMBER(7, 2), COMM NUMBER(7, 2), DEPTNO NUMBER(4));
-- 테이블 변경 : ALTER
-- 1. 컬럼 추가 : ADD
-- 2. 열 이름 변경 : RENAME
-- 3. 열 자료형 변경 : MODIFY
-- 4. 열 삭제 : DROP

-- HP 열 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);
-- 이름 변경
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;
-- EMPNO(4) => 5 변경
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);
-- TEL 컬럼 삭제
ALTER TABLE EMP_DDL DROP COLUMN TEL;

--테이블 이름 변경 : RENAME 기존명 TO 변경명;
RENAME EMP_DDL TO EMP_RENAME;
SELECT * FROM EMP_RENAME;

--테이블 삭제 DROP
DROP TABLE EMP_RENAME;

-- MEMBER 테이블 생성
-- ID 가변형문자열 15
-- PASSWORD 가변형문자열 20
-- NAME 가변형문자열 10
-- TEL 가변형문자열 15
-- EMAIL 가변형문자열 20
-- AGE 숫자 4

CREATE TABLE MEMBER(ID VARCHAR(15), PASSWORD VARCHAR(20), NAME VARCHAR(10), TEL VARCHAR(15), EMAIL VARCHAR(20), AGE NUMBER(4));
SELECT * FROM MEMBER;

ALTER TABLE "MEMBER" ADD BIGO VARCHAR2(10);
ALTER TABLE "MEMBER" MODIFY BIGO VARCHAR2(30);
ALTER TABLE "MEMBER" RENAME COLUMN BIGO TO REMARK;


-- 인덱스 : 테이블 검색 성능 향상
-- 인덱스 사용 여부
-- 1) 테이블 풀 스캔
-- 2) 인덱스 스캔

SELECT * FROM EMP WHERE EMPNO = 7844;

-- 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(컬럼명)
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

-- 뷰 : 가상테이블
--		하나 이상의 테이블을 조회하는 SELECT 문을 저장한 객체
-- 1. 보안성
-- 2. 편리성 : SQL 구문의 복잡도 완화

-- CREATE VIEW 뷰이름(열이름1, 열이름2....) AS (저장할 SELECT문) WITH CHECK OPTION 제약조건 WITH READ ONLY 제약조건;
CREATE VIEW VW_EMP20 AS (SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO = 20);
CREATE VIEW VW_EMP_READ AS SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WITH READ ONLY;

-- DROP VIEW 뷰이름;
SELECT * FROM VW_EMP20;
SELECT * FROM VW_EMP_READ;
SELECT * FROM EMP;
INSERT INTO VW_EMP20 VALUES(7777, '홍길동', 'SALESMAN', 10);
INSERT INTO VW_EMP_READ VALUES(7777, '홍길동', 'SALESMAN', 10);

-- USER_ : 현재 DB에 접속한 사용자가 소유한 객체 정보
SELECT * FROM USER_TABLES;
SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME='VM_EMP20';

DROP VIEW VW_EMP20;
DROP VIEW VW_EMP_READ ;

-- 시퀀스 (MySQL limit)
-- 오라클 DB에서 특정 규칙에 따른 연속 숫자를 생성하는 객체

-- CREATE SEQUENCE 시퀸스명
-- INCREAMENT BY N (기본값은 1)
-- START WITH N (기본값은 1)
-- MAXVALUE N | NOMAXVALUE
-- MINVALUE N | NOMINVALUE
-- CYCLE | NOCYCLE
-- CACHE N : NOCACHE

CREATE SEQUENCE SEQ_DEPT_SEQUENCE;

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

DROP SEQUENCE SEQ_DEPT_SEQUENCE;

CREATE TABLE DEPT_SEQUENCE AS SELECT * FROM DEPT WHERE 1<>1;
SELECT * FROM DEPT_SEQUENCE;
INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'NETWORK', 'BUSAN');
DROP TABLE DEPT_SEQUENCE;

ALTER SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 3
MAXVALUE 99
CYCLE;

-- SEQ_DEPT_SEQUENCE.CURRVAL : 현재 시퀀스 값 조회
SELECT SEQ_DEPT_SEQUENCE.CURRVAL FROM DUAL;

-- 동의어 : synonym (별칭)
-- 테이블, 뷰, 시퀀스

CREATE synonym e FOR emp;
SELECT * FROM E;

-- 제약조건
-- 1. 빈값을 허용하지 않는 NOT NULL
-- 2. 중복값을 허용하지 않는 UNIQUE
-- 3. 유일하게 하나만 존재하는 PRIMARY KEY
-- 4. 다른 테이블과 관계를 맺는 FOREIGN KEY
-- 5. 설정한 조건식을 만족하는 데이터 확인 CHECK
-- 6. 기본값을 지정하는 DEFAULT


-- 데이터 무결성 : 데이터 정확성과 일관성 보장

-- NOT NULL
-- 1. 테이블 생성 시 
CREATE TABLE TABLE_NOTNULL(LOGIN_ID VARCHAR2(20) NOT NULL, LOGIN_PWD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));
SELECT * FROM TABLE_NOTNULL;

--INSERT
INSERT INTO TABLE_NOTNULL VALUES('test01', 'test01', '010-1111-2222');
INSERT INTO TABLE_NOTNULL VALUES('test01', null, '010-1111-2222');

UPDATE TABLE_NOTNULL SET LOGIN_ID = NULL WHERE LOGIN TEL = '010-1111-2222';
-- 삭제는 제약X
DROP TABLE TABLE_NOTNULL;

--제약조건 이름 지정
CREATE TABLE TABLE_NOTNULL(LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN_LGNID_NN NOT NULL, LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN_LGNPWD_NN NOT NULL, TEL VARCHAR2(20));
-- TEL 제약조건 추가
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);
-- TEL 제약조건 추가(이름 지정)
ALTER TABLE TABLE_NOTNULL MODIFY(TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);
--제약조건 이름 변경
ALTER TABLE TABLE_NOTNULL RENAME CONSTRAINT SYS_C008356 TO TBLNN_TEL_NN;
--제약조건 삭제
ALTER TABLE TABLE_NOTNULL DROP CONSTRAINT TBLNN_TEL_NN;

-- 2. UNIQUE
CREATE TABLE TABLE_UNIQUE(LOGIN_ID VARCHAR2(20) UNIQUE, LOGIN_PWD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));
SELECT * FROM TABLE_UNIQUE;
INSERT INTO TABLE_UNIQUE VALUES('test01', 'test01', '010-1111-2222');
-- 무결성 제약 조건 오류
INSERT INTO TABLE_UNIQUE VALUES('test01', 'test02', '010-1234-5678');
-- NULL은 중복의 의미 X
INSERT INTO TABLE_UNIQUE VALUES(NULL, 'test02', '010-1234-5678');
INSERT INTO TABLE_UNIQUE VALUES('test02', 'test02', '010-1234-5678');
UPDATE TABLE_UNIQUE SET LOGIN_ID = 'test01' 

DROP TABLE TABLE_UNIQUE;

-- UNIQUE 제약조건 이름 지정
CREATE TABLE TABLE_UNIQUE(LOGIN_ID VARCHAR2(20) CONSTRAINT TNLNN_LGNID_UQ UNIQUE, LOGIN_PWD VARCHAR2(20) CONSTRAINT TNLNN_LGNPWD_NN NOT NULL, TEL VARCHAR2(20));
-- TEL 제약조건 추가
ALTER TABLE TABLE_UNIQUE MODIFY(TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);

-- 3. PRIMARY KEY(기본키)
-- UNIQUE + NOT NULL
-- 보통 INDEX 역할로 쓰임
CREATE TABLE TABLE_PK(LOGIN_ID VARCHAR2(20) PRIMARY KEY, LOGIN_PWD VARCHAR2(20) NOT NULL, TEL VARCHAR2(20));
SELECT * FROM TABLE_PK;
INSERT INTO TABLE_PK VALUES('test01', 'test01', '010-1111-2222');
INSERT INTO TABLE_PK VALUES(NULL, 'test01', '010-1111-2222');

-- WHERE PK 컬럼 = 1;

-- 4. FOREIGN KEY(외래키)
-- 다른 테이블과 관계

CREATE TABLE DEPT_FK(DEPTNO NUMBER(2) PRIMARY KEY, ENAME VARCHAR2(14), LOC VARCHAR2(13));
CREATE TABLE EMP_FK(EMPNO NUMBER(4), ENAME VARCHAR2(10), JOB VARCHAR2(9), MGR NUMBER(4), HIREDATE DATE, SAL NUMBER(7, 2), COMM NUMBER(7, 2), DEPTNO NUMBER(2) REFERENCES DEPT_FK(DEPTNO));

SELECT * FROM DEPT_FK;
SELECT * FROM EMP_FK;

-- 부모 키가 없습니다
INSERT INTO EMP_FK (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(7201, 'ORACLE1', 'SALESMAN', NULL, SYSDATE, 600, NULL, 10);

-- 입력 시 부모 테이블 데이터 먼저 입력
INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');

-- 수정 시
-- 부모키가 없음 (부모에 20이 없으니 안됨)
UPDATE EMP_FK 
SET DEPTNO = 20
WHERE EMPNO = 7201;

-- 삭제 시
-- 자식 레코드가 발견됨 (자식에 DEPTNO 10번 데이터가 있으니 안됨)
-- 자식 레코드 먼저 삭제 후 부모 삭제 필요
DELETE FROM DEPT_FK WHERE DEPTNO = 10;
DELETE FROM EMP_FK WHERE EMPNO = 7201;

DROP TABLE DEPT_FK;
DROP TABLE EMP_FK;

-- 제약조건명 + 부모 데이터 삭제 시 자식 데이터 처리 방법 지정
-- 1) ON DELETE CASCADE : 부모 데이터 삭제 시 참조하는 데이터도 함께 삭제
-- 2) ON DELETE SET NULL : 부모 데이터 삭제 시 참조하는 데이터에 NULL 설정
CREATE TABLE DEPT_FK(DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY, ENAME VARCHAR2(14), LOC VARCHAR2(13));
CREATE TABLE EMP_FK(EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY, ENAME VARCHAR2(10), JOB VARCHAR2(9), MGR NUMBER(4), HIREDATE DATE, SAL NUMBER(7, 2), COMM NUMBER(7, 2), DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE);
CREATE TABLE EMP_FK(EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY, ENAME VARCHAR2(10), JOB VARCHAR2(9), MGR NUMBER(4), HIREDATE DATE, SAL NUMBER(7, 2), COMM NUMBER(7, 2), DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL);

-- 외래키 제약 조건을 따로 지정
CREATE TABLE DEPT_FK(
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY, 
ENAME VARCHAR2(14), 
LOC VARCHAR2(13));

CREATE TABLE EMP_FK(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY, 
ENAME VARCHAR2(10), 
JOB VARCHAR2(9), 
MGR NUMBER(4), 
HIREDATE DATE, 
SAL NUMBER(7, 2), 
COMM NUMBER(7, 2), 
DEPTNO NUMBER(2));

ALTER TABLE EMP_FK  ADD FOREIGN KEY(DEPTNO) REFERENCES DEPT_FK(DEPTNO);

-- 5. CHECK
CREATE TABLE TABLE_CHECK(LOGIN_ID VARCHAR2(20) NOT NULL, LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3), TEL VARCHAR2(20));
INSERT INTO TABLE_CHECK VALUES('test01', 'tes', '010-1111-2222');
DROP TABLE TABLE_CHECK;


-- 6. DEFAULT
-- 값을 지정하지 않은 열에 기본값을 지정
CREATE TABLE TABLE_DEFAULT(
LOGIN_ID VARCHAR2(20) NOT NULL, 
LOGIN_PWD VARCHAR2(20) DEFAULT '1234', 
TEL VARCHAR2(20));

SELECT * FROM TABLE_DEFAULT;
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL) VALUES('test01', '010-1111-2222');
INSERT INTO TABLE_DEFAULT VALUES('test02', NULL, '010-1111-2222');

-- LENGTHB() : 실제 바이트 수(오라클)
-- LENGTH() : MYSQL에선 실제 바이트 수, 오라클은 문자길이
-- CHAR_LENGTH() : MySQL 에서 문자 길이 구할때
CREATE TABLE TABLE_CHECK(LOGIN_ID VARCHAR(20) NOT NULL, LOGIN_PWD VARCHAR(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (CHAR_LENGTH(LOGIN_PWD) > 3), TEL VARCHAR(20));
insert into TABLE_CHECK VALUES('test01','test','010-1234-1234');

use springdb;
select * from stutbl;
insert into stutbl(name, addr, gender) values('홍길동','서울','M');
insert into stutbl(name, gender) values('성춘향','F');
insert into stutbl(name, gender) values('강감찬','D');


use springdb;
create table teamtbl(
id int auto_increment primary key,
name varchar(255) not null
);

create table team_member(
id int auto_increment primary key,
name varchar(255) not null,
team_id int not null,
foreign key(team_id) references teamtbl(id)
);


-- 외래키 제약조건이면 부모 키 부터
insert into teamtbl(name) values('team1');
insert into teamtbl(name) values('team2');
insert into team_member(name, team_id) values('홍길동', 1);
insert into team_member(name, team_id) values('홍경민', 2);

-- 삭제 시 자식 키 먼저 삭제
delete from team_member where id = 1;
delete from teamtbl where id = 1;


