create table member(
    id number(8) primary key,
    name varchar2(20) not null,
    addr varchar2(50) not null,
    email varchar2(30) not null,
    age number(3) 
);

create sequence member_seq;

select * from member;

delete from member where id=12;