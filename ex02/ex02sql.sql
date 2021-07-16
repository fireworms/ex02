create sequence seq_board;

create table tbl_board(
bno number(10,0),
title varchar2(200) not null,
content varchar2(2000) not null,
writer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate
);

alter table tbl_board add constraint pk_board primary key (bno);

insert into tbl_board (bno, title, content, writer) values (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');

select * from tbl_board;

select * from tbl_reply;

select /*+ INDEX_ASC(tbl_board pk_board) */ * from tbl_board;

create table tbl_reply(
	rno number(10,0),
	bno number(10,0) not null,
	reply varchar2(1000) not null,
	replyer varchar2(50) not null,
	replyDate date default sysdate,
	updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board (bno) on delete cascade;

alter table tbl_reply drop constraint fk_reply_board;

select * from tbl_reply order by rno desc;

create index idx_reply on tbl_reply (bno desc, rno asc);

select /*+INDEX(tbl_reply idx_reply) */
	rownum rn, bno, rno, reply, replyer, replyDate, updatedate
	from tbl_reply
	where bno = 85
	and rno > 0;
	
create table tbl_sample1( col1 varchar2(500));
create table tbl_sample2( col2 varchar2(50));

select * from tbl_sample1;

delete tbl_sample1;
delete tbl_sample2;

alter table tbl_board add (replycnt number default 0);

update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

select * from tbl_board;

create table tbl_attach(
	uuid varchar2(100) not null,
	uploadPath varchar2(200) not null,
	fileName varchar2(100) not null,
	filetype char(1) default 'I',
	bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid);

alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);

select * from tbl_attach;

create table users(
	username varchar2(50) not null primary key,
	password varchar2(50) not null,
	enabled char(1) default '1'
);

create table authorities(
	username varchar2(50) not null,
	authority varchar2(50) not null,
	constraint fk_authorities_users foreign key(username) references users(username)
);

create unique index ix_auth_username on authorities (username, authority);

insert into users (username, password) values ('user00', 'pw00');
insert into users (username, password) values ('member00', 'pw00');
insert into users (username, password) values ('admin00', 'pw00');

insert into authorities (username, authority) values ('user00', 'ROLE_USER');
insert into authorities (username, authority) values ('member00', 'ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00', 'ROLE_MANAGER');
insert into authorities (username, authority) values ('admin00', 'ROLE_ADMIN');

create table tbl_member(
	userid varchar2(50) not null primary key,
	userpw varchar2(100) not null,
	username varchar2(100) not null,
	email varchar2(100) not null unique,
	regdate date default sysdate,
	updatedate date default sysdate,
	enabled char(1) default '1'
);

create table tbl_member_auth(
	userid varchar2(50) not null,
	auth varchar2(50) not null
);
insert into tbl_member_auth values('qq', 'ROLE_ADMIN');
select * from tbl_member_auth;
alter table tbl_member_auth add constraint fk_member_auth foreign key (userid) references tbl_member(userid) on delete cascade;

select * from tbl_member;
delete from tbl_member;
select * from tbl_member_auth;

create table persistent_logins(
username varchar2(64) not null,
series varchar2(64) primary key,
token varchar2(64) not null,
last_used timestamp not null
);

select * from TBL_BOARD;

select * from TBL_reply ;

select * from all_constraints where table_name = 'TBL_MEMBER_AUTH';

alter table tbl_member_auth drop constraint fk_member_auth;

insert into tbl_member(userid, userpw, username, email) values('ad90', 'ad90', 'ad90', 'fireworms0@gmail.com');

insert into tbl_member_auth(userid, auth) values('qqq', 'ROLE_ADMIN');