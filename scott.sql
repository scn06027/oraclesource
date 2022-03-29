-- 뷰 (view):가상테이블
--          하나 이상의 테이블을 조회하는 select 문을 저장한 객체;
--          편리성 - select 문의 복잡도를 완화시킨다.
--          보안성 - 테이블의 특정 열을 노출하고 싶지 않은 경우...

--생성
create view vm_emp20 as (select empno,ename,job,deptno from emp where deptno=20);
select * from vm_emp20;
delete from vm_emp20 where empno='7151';


insert into vm_emp20 values(7151,'king','MANAGER',20);

--view와 원본테이블 연결 여부
select * from emp;


--생성된 뷰들의 속성 확인하기
select * from user_updatable_columns where table_name='vm_emp20';

--뷰 생성시 원본 데이터 수정 불가하도록 작성 
create view vm_emp_read as
(select empno,ename,job from emp) with read only;

select * from user_updatable_columns where table_name='VM_EMP20';
select * from user_updatable_columns where table_name='VM_EMP_READ';

insert into vm_emp_read values(7151,'king','MANAGER');
drop view vm_emp20;
drop view vm_emp_read;

--인덱스 ? : 빠른 검색을 위한 것...
 --인덱스 사용 여부에 따라 table full scan,index scan

--scott가 가지고 있는 인덱스 확인하기!
select * from user_indexes; --pk 설정된 값들은 인덱스로 사용된다

--인덱스 생성

--create index 인덱스명 on 테이블명 (열이름1asc 열이름 2ㅡ desc....)=)
create index idx_emp_sal on emp(sal);
--index가 설정된 컬럼 조회해ㅈ보기
select * from user_ind_columns;

select * from emp where deptno=20;


drop index idx_emp_sal;
