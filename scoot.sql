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

-- GROUP BY
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 컬럼은 GROUP BY에 사용한 컬럼만 가능
SELECT DEPTNO, AVG(SAL)
FROM emp
GROUP BY DEPTNO;