-- c##을 사용안하도록 설정
-- 오라클 버전이 업데이트 되면서 사용자 설정할 때 아이디 앞에 c##을 붙이도록 설정되어 있음
-- hr 사용자 생성 => c##hr
ALTER SESSION SET "_oracle_script"=TRUE;

--@C:\database\db-sample-schemas-main\human_resources\hr_install.SQL
--@C:\app\soldesk\product\21c\dbhomeXE\rdbms\admin\scott.SQL
--sys AS sysdba

-- 권한부여 : GRANT
GRANT CREATE VIEW TO SCOTT;
GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

-- 사용자
-- DB에 접속하여 데이터 관리하는 계정

-- 오라클 DB
-- 테이블, 뷰, 인덱스, 시퀀스... => 업무별로 사용자 생성 후 객체 생성할 수 있는 권한 부여

-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호;
-- C## 접두어가 무조건 필요
--CREATE USER TEST1 IDENTIFIED BY 12345;
CREATE USER C##TEST1 IDENTIFIED BY 12345;

-- C## 안 붙이려면 같이 실행
ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER TEST2 IDENTIFIED BY 12345;

-- 사용자 TEST2는 CREATE SESSSION 권한을 가지고 있지 않음. 로그온 거절
GRANT CREATE SESSION TO TEST2;

-- 개별권한 묶어서 관리 => 롤
GRANT CONNECT, RESOURCE TO TEST2;

-- 테이블 스페이스 'USERS'에 대한 권한
ALTER USER TEST2 DEFAULT TABLESPACE USERS QUOTA 2M ON USERS;

-- 사용자 권한 + 생성
-- 대소문자 구별안함 / 비번은 구별함
CREATE USER TEST3 IDENTIFIED BY 12345 
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 2M ON USERS;

-- 대부분의 권한
GRANT CONNECT, RESOURCE TO TEST3;

-- 사용자 삭제
DROP USER test3 CASCADE;

-- 권한 취소
-- REVOKE 취소할권한이름 FROM 사용자명
REVOKE CREATE SESSION FROM test2;

-- 비밀번호 변경
-- ALTER USER 사용자 IDENTIFIED BY 변경할비번

ALTER SESSION SET "_oracle_script"=TRUE;

CREATE USER javadb IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

GRANT CONNECT, RESOURCE TO javadb;