-- Active: 1706776139341@@127.0.0.1@3306@estate
# Entity
# - 고객
# - 디자이너
# - 관리자
# - 이메일 인증번호
# - 공지사항 게시물
# - 트렌드 게시물
# - 고객 게시물
# - 디자이너 게시물
# - Q&A 게시물

# Atribute
# - 고객 (아이디*, 비밀번호, 이메일, 성별, 연령대, 거주지역, 권한, 가입경로)
# - 디자이너 (아이디*, 비밀번호, 이메일, 성별, 연령대, 근무지역, 업체명, 면허증사진, 권한, 가입경로)
# - 관리자 (아이디*, 비밀번호, 이메일, 성별, 연령대, 거주지역, 권한, 가입경로)

# - 이메일 인증번호 (이메일*, 인증번호)

# - 공지사항 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 트렌드 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 고객 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 디자이너 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - Q&A 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수)

# Relationship
# 고객 - 이메일 인증번호 : 이메일 인증번호 테이블에 등록된 이메일만 사용자의 이메일로 사용할 수 있음 (1 : 1)
# 디자이너 - 이메일 인증번호 : 이메일 인증번호 테이블에 등록된 이메일만 사용자의 이메일로 사용할 수 있음 (1 : 1)
# 관리자 - 이메일 인증번호 : 이메일 인증번호 테이블에 등록된 이메일만 사용자의 이메일로 사용할 수 있음 (1 : 1)

# 관리자 - 공지사항 게시물 : 사용자가 게시물을 작성할 수 있음 (1 : n)
# 관리자 - 트렌드 게시물 : 사용자가 게시물을 작성할 수 있음 (1 : n)
# 관리자 - Q&A 게시물 : 사용자가 게시물을 작성할 수 있음 (1 : n)
# 고객 - 고객 게시물 : 사용자가 게시물을 작성할 수 있음 (1 : n)
# 디자이너 - 디자이너 게시물 : 사용자가 게시물을 작성할 수 있음 (1 : n)
#
# # - 사용자 (아이디*, 비밀번호, 이메일, 권한, 가입경로)
# table name : customer
# customer_id : VARCHAR(50) PK
# customer_password : VARCHAR(255) NN
# customer_email : VARCHAR(100) NN UQ FK email_auth_number(email)
# customer_
# customer_
# customer_
# customer_role : VARCHAR(15) NN DEFAULT('ROLE_USER') CHECK('ROLE_USER', 'ROLE_ADMIN')
# join_path : VARCHAR(5) NN DEFAULT('HOME') CHECK('HOME', 'KAKAO', 'NAVER')
#
# - 이메일 인증번호 (이메일*, 인증번호)
#  table name : email_auth_number
#  email : VARCHAR(100) PK
#  auth_number : VARCHAR(4) NN
#
# - 게시물 (접수번호*, 상태, 제목, 내용, 작성자, 작성일, 조회수,  답변)
# table name : board
# reception_number : INT PK AI
# status : BOOLEAN NN DEFAULT(false)
# title : VARCHAR(100) NN
# contents : TEXT NN
# writer_id : VARCHAR(50) NN FK user(user_id)
# write_datetime : DATETIME NN DEFAULT(now())
# view_count : INT NN DEFAULT(0)
# comment : TEXT

## 데이터베이스 생성
CREATE DATABASE estate;

USE estate;

## 이메일 인증 번호 테이블 생성
CREATE TABLE email_auth_number (
    email VARCHAR(100) PRIMARY KEY,
    auth_number VARCHAR(4) NOT NULL
);

## 유저 테이블 생성
CREATE TABLE user (
    user_id VARCHAR(50) PRIMARY KEY,
    user_password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_role VARCHAR(15) NOT NULL DEFAULT('ROLE_USER') CHECK (
        user_role IN ('ROLE_USER', 'ROLE_ADMIN')
    ),
    join_path VARCHAR(5) NOT NULL DEFAULT('HOME') CHECK (
        join_path IN ('HOME', 'KAKAO', 'NAVER')
    ),
    CONSTRAINT user_email_fk FOREIGN KEY (user_email) REFERENCES email_auth_number (email)
);

## Q&A 게시물 테이블 생성
CREATE TABLE board (
    reception_number INT PRIMARY KEY AUTO_INCREMENT,
    status BOOLEAN NOT NULL DEFAULT(false),
    title VARCHAR(100) NOT NULL,
    contents TEXT NOT NULL,
    writer_id VARCHAR(50) NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT(now()),
    view_count INT NOT NULL DEFAULT(0),
    comment TEXT,
    CONSTRAINT writer_id_fk FOREIGN KEY (writer_id) REFERENCES user (user_id)
);

## 개발자 계정 생성
CREATE USER 'developer' @'%' IDENTIFIED BY 'P!ssw0rd';

GRANT ALL PRIVILEGES ON estate.* TO 'developer' @'%';