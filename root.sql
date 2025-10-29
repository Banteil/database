use sakila; 

select * from customer;

-- first_name이 MARIA인 데이터 조회
select * from customer where first_name = 'MARIA';

-- first_name 열에서 데이터가 A,B,C 순으로 'MARIA' 보다 앞에 위치한 데이터 조회
select * from customer where first_name < 'MARIA' order by first_name;

-- first_name이 M ~ O 사이의 데이터가 아닌 데이터 조회 
select * from customer where first_name not between 'M' and 'O' order by first_name;

-- first_name이 'MARIA', 'LINDA'인 데이터 조회
select * from customer where first_name in ('MARIA', 'LINDA');

-- first_name이 'A'로 시작하는 데이터 조회
select * from customer where first_name like 'A%';

-- first_name이 'A'로 시작하고 문자열 길이가 3인 데이터 조회
select * from customer where first_name like 'A__';

-- first_name이 'A'로 시작하고 끝나면서 문자열 길이가 4인 데이터 조회
select * from customer where first_name like 'A__A';

-- file 테이블
-- special_features를 기준으로 그룹화 후 count() 사용
select f.special_features, count(*) from film f group by f.special_features; 

-- special_features, rating을 기준으로 그룹화 후 rating이 G인 데이터 조회
select f.special_features, f.rating from film f group by f.special_features, f.rating having f.rating = 'G';

-- address 테이블
-- address_id가 200 미만 데이터 조회
select * from address a where a.address_id < 200;

-- address_id가 5~10 범위에 해당하는 데이터 조회
select * from address a where a.address_id between 5 and 10;

-- address2 열 데이터가 null이 아닌 데이터 조회
select * from address a where a.address2 is not null;

-- city 테이블
-- COUNTRY_ID가 103 or 86이면서 city 열이 'Cheju', 'Sunnyvale', 'Dallas'인 데이터 조회
select * from city c where c.country_id in (103, 86) and c.city in ('Cheju', 'Sunnyvale', 'Dallas');

-- payment 테이블
-- payment_date가 2005-07-09 미만인 행 조회
select * from payment p where p.payment_date < '2005-07-09';

-- limit : 특정 조건에 해당하는 데이터 중에서 상위 n개의 데이터 보기 or 범위 지정해서 보기 (MySQL 전용)
-- customer 테이블에서 store_id 내림차순, first_name 오름차순으로 10개 데이터 보기
select * from customer c order by c.store_id desc, c.first_name asc limit 10;

-- 101번째부터 10개 (MySQL 전용)
select * from customer c order by c.store_id desc, c.first_name asc limit 100, 10;

-- limit ~ offset (표준 SQL 문법)
-- offset n개를 건너뛰고 limit n개 출력
select * from customer c order by c.customer_id asc limit 10 offset 100;

-- 데이터베이스 생성
create database if not exists EXAM;

use EXAM;
-- 테이블 생성
create table TABLE1(
	COL1 INT,
	COL2 VARCHAR(50),
	COL3 DATETIME
);

create table TABLE2(
	COL1 INT auto_increment primary KEY,
	COL2 VARCHAR(50),
	COL3 DATETIME
);

insert
	into
	TABLE2(COL2, COL3)
values('TEST', '2025-10-29'); 
select * from table2;