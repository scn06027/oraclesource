

ALTER USER hr IDENTIFIED BY hr
    ACCOUNT UNLOCK;
--비번 몇번 실패하면 롹~됨..
    
    --오라클 데이터베이스 특징
    --테이블, 인덱스,뷰... 여러가지 객체가 사용자별로 생성되고 관리됨
    --사용자 ==스키마 (데이터베이스 구조 범위)
    
--사용자 생성
--create user 아이디 IDENTIFIED by 비밀번호;

create user test1 IDENTIFIED by 12345;

--ORA-01045: user TEST1 lacks CREATE SESSION privilege; logon denied
--사용자생성을 했다고 해서 권한이 바로 생기는게 아님. 내가 권한을 부여해줘야됨
--시스템만 이런거 할수있음

--권한 부여
--grant create 권한명 to 사용자;

grant create session to test1;
--session: 세션 접속가능하게만들어줌
--table 생성 권한 부여
grant create table to test1;

--롤(여러권한들을 묶어놓은 개념)
grant resource,connect to test1;

--resource: 시퀀스, tabler,trigger... 같은 객체를 생성할 수 있는 권한을 부여해줌
--connect: create session 이 들어있다..

--맨 첨엔 진짜 아무것도 할 수 없기 때문에 권한을 부여해줘야된다아

--사용자 비밀번호 변경
alter user test1 IDENTIFIED BY 54321;
alter user hr IDENTIFIED BY 12345;
--사용자 삭제하고싶음
drop user test1;
drop user test1 cascade; --이렇게 뒤에다 cascade 붙이면 걔가 갖고있는거 싹다 삭제하는거임

create user javadb IDENTIFIED BY 12345;
grant resource,connect to javadb;

--scott에게 view 생성 권한 부여해준다아ㅏ
grant create view to scott;

grant connect to hr;