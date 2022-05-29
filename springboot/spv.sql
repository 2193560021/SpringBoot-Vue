use springboot_vue;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS user;
create table user
(
    id        int auto_increment comment 'ID' primary key,
    username  varchar(255) null,
    password  varchar(255) null,
    nick_name varchar(255) null,
    age       int          null,
    sex       varchar(255) null,
    address   varchar(255) null
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;


DROP TABLE IF EXISTS book;
create table book
(
    id        int auto_increment primary key,
    name    varchar(255) null,
    price decimal (10,2) null,
    author    varchar(255) null,
    create_time   datetime  null
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;




SET FOREIGN_KEY_CHECKS = 1;

