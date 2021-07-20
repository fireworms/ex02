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

create sequence seq_reply;

create table tbl_reply(
	rno number(10,0),
	bno number(10,0) not null,
	reply varchar2(1000) not null,
	replyer varchar2(50) not null,
	replyDate date default sysdate,
	updateDate date default sysdate,
	replycnt number default 0
);

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board (bno) on delete cascade;

create index idx_reply on tbl_reply (bno desc, rno asc);

create table tbl_attach(
	uuid varchar2(100) not null,
	uploadPath varchar2(200) not null,
	fileName varchar2(100) not null,
	filetype char(1) default 'I',
	bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid);

alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno) on delete cascade;

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

alter table tbl_member_auth add constraint fk_member_auth foreign key (userid) references tbl_member(userid) on delete cascade;