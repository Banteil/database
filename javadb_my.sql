-- 1. DEPARTMENT (학과)
-- 학과코드(dept_id), 학과명(dept_name, not null)
use exam;
CREATE TABLE DEPARTMENT (
    DEPT_ID VARCHAR(4) PRIMARY KEY, -- 오라클의 VARCHAR2는 MySQL에서 VARCHAR로 사용
    DEPT_NAME VARCHAR(40) NOT NULL
);

INSERT INTO DEPARTMENT VALUES('A001', '데이터사이언스');
INSERT INTO DEPARTMENT VALUES('A002', '경영학과');

---

-- 2. STUDENT (학생)
-- 학번(student_id), 이름(name), 키(height), 학과코드(dept_id)
CREATE TABLE STUDENT (
    STUDENT_ID VARCHAR(8) PRIMARY KEY,
    NAME VARCHAR(20),
    -- 키는 소수점 포함할 수 있으므로 DECIMAL(총자릿수, 소수점 자릿수) 사용
    HEIGHT DECIMAL(4, 1), 
    DEPT_ID VARCHAR(4),
    -- 외래 키 제약 조건
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID) ON DELETE CASCADE 
);

INSERT INTO STUDENT VALUES('20250001', '홍길동', 163.5, 'A001');
INSERT INTO STUDENT VALUES('20250002', '성춘향', 155.7, 'A002');

---

-- 3. PROFESSOR (교수)
-- 교수코드(prof_id), 교수명(prof_name), 학과코드(dept_id)
CREATE TABLE PROFESSOR (
    PROF_ID VARCHAR(4) PRIMARY KEY,
    PROF_NAME VARCHAR(20),
    DEPT_ID VARCHAR(4),
    -- 외래 키 제약 조건
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID) ON DELETE CASCADE
);

INSERT INTO PROFESSOR VALUES('P001', '김유진', 'A001');

---

-- 4. SUBJECT (과목)
-- 과목코드(subj_id), 과목명(subj_name), 시작일(start_date), 종료일(end_date), 교수코드(prof_id)
CREATE TABLE SUBJECT (
    SUBJ_ID VARCHAR(4) PRIMARY KEY,
    SUBJ_NAME VARCHAR(40),
    START_DATE DATE, -- 날짜 타입
    END_DATE DATE,   -- 날짜 타입
    PROF_ID VARCHAR(4),
    -- 외래 키 제약 조건
    FOREIGN KEY (PROF_ID) REFERENCES PROFESSOR(PROF_ID) ON DELETE CASCADE
);

-- 날짜 삽입 시 TO_DATE 없이 문자열 그대로 사용하며, 컬럼 순서를 맞춰야 합니다.
INSERT INTO SUBJECT VALUES('S001', '파이썬', '2025-03-01', '2025-06-30', 'P001');

---

-- 5. ENROLLMENT (수강)
-- 수강코드(enroll_id), 수강일자(enroll_date), 학번(student_id), 과목코드(subj_id)

-- 오라클 시퀀스 대신 MySQL AUTO_INCREMENT 설정
CREATE TABLE ENROLLMENT (
    -- AUTO_INCREMENT를 PRIMARY KEY와 함께 사용
    ENROLL_ID INT PRIMARY KEY AUTO_INCREMENT, 
    STUDENT_ID VARCHAR(8),
    SUBJ_ID VARCHAR(4),
    ENROLL_DATE DATE,
    
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE,
    FOREIGN KEY (SUBJ_ID) REFERENCES SUBJECT(SUBJ_ID) ON DELETE CASCADE
);

-- 시퀀스를 사용하지 않으므로, ENROLL_ID 컬럼에 NULL을 넣거나 컬럼을 생략합니다.
-- AUTO_INCREMENT 컬럼에 NULL을 넣으면 자동으로 다음 번호가 할당됩니다.
INSERT INTO ENROLLMENT (STUDENT_ID, SUBJ_ID, ENROLL_DATE)
VALUES ('20250001', 'S001', '2025-06-30');

select * from department d;
select curdate();
select LOWER('Do it SQL'), UPPER('Do it SQL');