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