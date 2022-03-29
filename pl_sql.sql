-- PL/SQL
-- SQL 만으로는 구현이 어렵거나 구현 불가능한 작업들을 수행하기 위해서
-- 제공하는 프로그래밍 언어

-- 키워드
-- delare(선언부) : 변수,상수,커서 등을 선언(선택)
-- begin(실행부): 조건문,반복문,select,DML 함수등을 정의한다(필수)
-- EXCEPTION(예외처리부): 오류(예외상황) 해결(선택)

--실행결과를 화면에 출력해줘~!
SET SERVEROUTPUT ON;

--
BEGIN
    dbms_output.put_line('Hello! PL/SQL');
END;
/

DECLARE
    --변수선언
    v_empno NUMBER := 7788;
    v_ename varchar2(10);
BEGIN
    v_ename := 'SCOTT';
    dbms_output.put_line('현재 empno: ' || v_empno); --화면출력
    dbms_output.put_line('V_ENAME: ' || v_ename);
END;
/

DECLARE
    --상수선언
    v_tax CONSTANT NUMBER := 3;
BEGIN
    dbms_output.put_line('V_TAX: ' || v_tax);
END;
/ 
--변수의 기본값 지정
DECLARE
    --상수선언
    v_deptno NUMBER(2) DEFAULT 10;
BEGIN
    dbms_output.put_line('V_DEPTNO: ' || v_deptno);
END;
/ 
 --NOT NULL선언
DECLARE
    v_deptno NUMBER(2) NOT NULL := 10;
BEGIN
    dbms_output.put_line('V_DEPTNO: ' || v_deptno);
END;
/ 



--if 조건문 
--if ~then
--IF ~TEHN ~ELSE
--IF ~THEN ~ELSIF

--V_NUMBER 변수 선언하고 13값을 할당한 뒤 해당변수가 홀,짝인지 출력



DECLARE
    v_number NUMBER := 13;
BEGIN
    IF MOD(v_number, 2) = 1 THEN
        dbms_output.put_line('홀수');
    ELSE
        dbms_output.put_line('짝수');
    END IF;
END;
/


DECLARE
    test1 number:=19;
    test2 number:=4;
BEGIN
     dbms_output.put_line('나머지 값은? '||mod(test1,test2));
END;
/

DECLARE
    v_number NUMBER := 87;
BEGIN
    IF v_number >= 90 THEN
        dbms_output.put_line('A학점');
    ELSIF v_number >= 80 THEN
        dbms_output.put_line('B학점');
    ELSIF v_number >= 70 THEN
        dbms_output.put_line('C학점');
    ELSIF v_number >= 60 THEN
        dbms_output.put_line('D학점');
    ELSE
        dbms_output.put_line('F학점');
    END IF;
END;
/

--CASE ~WITH
DECLARE
    v_score NUMBER := 98;
BEGIN
    CASE trunc(v_score / 10)
        WHEN 10 THEN
            dbms_output.put_line('A학점');
        WHEN 9 THEN
            dbms_output.put_line('B학점');
        WHEN 8 THEN
            dbms_output.put_line('C학점');
        WHEN 7 THEN
            dbms_output.put_line('D학점');
        ELSE
            dbms_output.put_line('F학점');
    END CASE;
END;
/
-- 반복문
-- LOOP ~ END LOOP
-- WHILE LOOP ~ END LOOP
-- FOR LOOP
-- Cursor FOR LOOP
DECLARE
    v_deptno NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('현재 V_DEPTNO: ' || v_deptno);
        v_deptno := v_deptno + 1;
        EXIT WHEN v_deptno > 4;
    END LOOP;
END;
/
--WHILE
DECLARE
    v_deptno NUMBER := 0;
BEGIN
    WHILE v_deptno < 6 LOOP
        dbms_output.put_line('현재 V_DEPTNO: ' || v_deptno);
        v_deptno := v_deptno + 1;
    END LOOP;
END;
/

--FOR LOOP   
--시작값..종료값 : 반복문을 통해서 시작값 ~ 종료값을 출력한다...
--포인트는 온점 두개인듯 
BEGIN
    FOR i IN 0..4 LOOP
        dbms_output.put_line('현재 i: ' || i);
    END LOOP;
END;
/

--리버스 붙이면 거꾸로 나옴 ㅋ
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        dbms_output.put_line('현재 i: ' || i);
    END LOOP;
END;
/

--숫자를 1~ 10까지 출력하세요(홀수만)
BEGIN
    FOR i IN 1..10 LOOP
        IF MOD(i, 2) = 1 THEN
            dbms_output.put_line('i의 값: ' || i);
        END IF;
    END LOOP;
END;
/




--변수 타입 선언시 특정 테이블의 컬럼값 참조

--변수의 기본값 지정
DECLARE
    v_deptno dept.deptno%TYPE := 50;
BEGIN
    dbms_output.put_line('deptno의 값: ' || v_deptno);
END;


--변수 타입 선언시 특정 테이블의 컬럼값 참조

--변수의 기본값 지정


--변수타입 선언시 특정 테이블의 하나의 컬럼이 아닌 행 ㄹ구조 전체 참조 


DECLARE
    v_dept_row dept%rowtype;
BEGIN
    SELECT
        deptno,
        dname,
        loc
    INTO v_dept_row
    FROM
        dept
    WHERE
        deptno = 40;

    dbms_output.put_line('deptno의 값: ' || v_dept_row.deptno);
    dbms_output.put_line('dname의 값: ' || v_dept_row.dname);
    dbms_output.put_line('loc의 값: ' || v_dept_row.loc);
END;

--커서(cursor)
--select,delete, update,insert 이런sql문 실행시 해당 sql문을 처리하는 정보를
--저장한 메모리 공간

--select into 방식 : 결과값이 하나일때 사용가능
--결과값이 몇개인지 알 수 없을 경우cursor를 사용한다

--1)명시적 커서
-- declare: 커서를 선언한다
-- open: 커서를 연다
-- fetch: 커서에서 읽어 온 데이터를 사용한다
-- close: 커서 닫기

declare 
    --커서데이터를 입력할 변수를 선언한다
    v_dept_row dept%rowtype;
    --명시적 커서 선언
    CURSOR c1 IS
    select deptno,dname,loc
    from dept
    where deptno=40;
begin
--커서열기
    open c1;
    --읽어온 데이터 사용
    FETCH c1 into v_dept_row;
    dbms_output.put_line('deptno의 값: ' || v_dept_row.deptno);
    dbms_output.put_line('dname의 값: ' || v_dept_row.dname);
    dbms_output.put_line('loc의 값: ' || v_dept_row.loc);
    close c1;
end;
/


--여러 행이 조회되는 경우
declare 
    v_dept_row dept%rowtype;
    --명시적 커서 선언
    CURSOR c1 IS
    select deptno,dname,loc
    from dept;
begin
--커서열기
    open c1;
    loop
    --읽어온 데이터 사용 ->fetch
     FETCH c1 into v_dept_row;
     
     --커서에서 더이상 읽어올 행이 없을떄까지~! ->notfound
     exit when c1%notfound;
        dbms_output.put_line('deptno의 값: ' || v_dept_row.deptno);
        dbms_output.put_line('dname의 값: ' || v_dept_row.dname);
        dbms_output.put_line('loc의 값: ' || v_dept_row.loc);
    end loop;
    close c1;
end;
/


--cursor for loop로 변경해주자 

declare 
    --명시적 커서 선언
    CURSOR c1 IS
    select deptno,dname,loc
    from dept;
begin
--자동 open,fetch,close 다해줌 ㅋ 작업이 간단해지는구나
    for c1_rec in c1 loop 
        dbms_output.put_line('deptno의 값: ' || c1_rec.deptno
       ||' dname의 값: ' || c1_rec.dname
        ||' loc의 값: ' || c1_rec.loc);
    end loop;

end;
/


declare 
--사용자가 입력한 부서 번호를 저장하는 변수 선언
--deptno랑 같은타입이다~ 라고 알려주는겅미
v_deptno dept.deptno%type;
    --명시적 커서 선언
    CURSOR c1(p_deptno dept.deptno%type) IS
     select deptno,dname,loc
     from dept
     where deptno=p_deptno;
begin
--input_deptno에 부서번호 입력받고 v_deptno에 대입
v_deptno:= &input_deptno;
--자동 open,fetch,close 다해줌 ㅋ 작업이 간단해지는구나
    for c1_rec in c1(v_deptno) loop 
        dbms_output.put_line('deptno의 값: ' || c1_rec.deptno
       ||' dname의 값: ' || c1_rec.dname
        ||' loc의 값: ' || c1_rec.loc);
    end loop;

end;
/
--묵시적커서: 커서 선언 없이 사용 `!
--Data Modeler 보고서
--select ~ into / DML (업뎃 딜맅 인섵)
--sql%rowcount: 묵시적 커서 안에 추출된 행이 있으면 행의 수 출력
--sql%found:묵시적 커서 안에 추출된 행이 있으면 true, 없으면 false
--sql%isopen: 자동으로 sql 문을 실행한 후 close되기때문에 항상 false상태임.ㄹㄹ.ㄹ.
--sql%notfound: 커서 안에 추출된 행이 있으면 true, 없으면 false
begin
    update dept_temp set dname='DATABASE' where deptno=60;
    dbms_output.put_line('갱신된 행의 수:'|| sql%rowcount);
    
    if sql%found then 
       dbms_output.put_line('갱신 대상 행 존재 여부: true');
    else
        dbms_output.put_line('갱신 대상 행 존재 여부: false');
    end if;
    
     if sql%isopen then 
       dbms_output.put_line('커서의 open 여부: true');
    else
        dbms_output.put_line('커서의 open 여부: false');
    end if;
    
end;
/

--저장 서브프로그램(이름지정,저장,저장할때 한번 컴파일,공유해서 사용가능
-- 다른 응용프로그램에서 호출도 가능하다.
--저장 프로시저: sql 문에서는 사용불가!
--저장 함수 :sql 구문에서 사용 가능하다
--트리거: 특정 상황이 발생할 때 자동으로 연달아 수행할 기능을 구현하는데 사용
--패키지: 저장 서브 프로그램을 그룹화할때 사용 ..

create procedure pro_noparam
is
    v_empno number(4) := 7788;
    v_ename varchar2(10);
begin
    v_ename:='scott';
    dbms_output.put_line('V_EMPNO:'||v_empno);
    dbms_output.put_line('V_ENAME:'||v_ename);
end;
/

execute pro_noparam;

-- 다른 pl/sql 블록에서 프로시저 실행
begin
    pro_noparam;
    
end;
/

create or replace procedure pro_noparam_in
(
    param1 in number,
   param2 number,
   param3 number :=3,
   param4 number default 4
)
is
begin
    dbms_output.put_line('V_EMPNO:'||param1);
    dbms_output.put_line('V_ENAME:'||param2);
    dbms_output.put_line('V_EMPNO:'||param3);
    dbms_output.put_line('V_ENAME:'||param4);
end;
/

execute pro_noparam_in(1);

/
create or replace procedure pro_param_out
(
    in_empno in emp.empno%type,
  out_ename out emp.ename%type,
   out_sal out emp.sal%type
)
is
begin
    select ename,sal into out_ename,out_sal
    from emp
    where empno=in_empno;
end;
/

declare 
    v_ename emp.ename%type;
    v_sal emp.sal%type;
begin
    pro_param_out(7369,v_ename,v_sal);
    dbms_output.put_line('ename: '||v_ename);
    dbms_output.put_line('sal: '||v_sal);
    
end;
/
--in out 모드
create or replace procedure pro_param_in_out
(
    in_out_no in out number
)
is
begin
   in_out_no:=in_out_no*2;
end;
/

declare
    no number;
begin
    no:=5;
    pro_param_in_out(no);
    dbms_output.put_line('no: '||no);
end;
/
--트리거
--dml 트리거
--create or replace trigger 트리거이름
--before | after
--insert | update | delete on 테이블이름
--declare
--begin
--end

create table emp_trg as select * from emp;

--emp_trg insert(주말에 사원정보 추가시 에러),update,delete
create or replace trigger emp_trg_weekend

before
insert or update or delete on emp_trg
begin
if to_char(sysdate,'DY') in ('토','일') then
    if inserting then
        raise_applocation_error(-30000,' 주말 사원정보 추가 불가입니다.');
    elsif updating then
        raise_application_error(-30001,' 주말 사원정보 수정 불가');
    elsif deleting then
        raise_application_error(-30002,' 주말 사원정보 삭제 불가');
    else
        raise_application_error(-30003,' 주말 사원정보 변경 불가');
        end if;
end if;
end;
/
update emp_trg
set sal=3500
where empno=7739;

--트리거 발생 저장 테이블 생성 \
create table emp_trg_log(
    tablename varchar2(20), --dml이 수행된 테이블 이름
    dml_type varchar2(10), -- dml 명령어 종류
    empno number(4),        --dml 대상이 된 사원번호
    user_name varchar(30), --dml을 수행한 user aud
    change_date date); --dmlk 시도 날짜
    
/
  
create or replace trigger emp_trg_weekend_log
after
insert or update or delete on emp_trg
for each row
begin
if inserting  then
    insert into emp_trg_log('emp_trg','insert', :new.empno,
    sys_context('userenv','session_user'),sysdate);
elsif updating then
     insert into emp_trg_log('emp_trg','insert', :old.empno,
    sys_context('userenv','session_user'),sysdate);

end if;
end;
/