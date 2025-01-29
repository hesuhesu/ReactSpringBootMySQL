
CREATE TABLE board
(
  board_number   INT         NOT NULL AUTO_INCREMENT COMMENT '번호',
  title          TEXT        NOT NULL COMMENT '제목',
  content        TEXT        NOT NULL COMMENT '내용',
  write_datetime DATETIME    NOT NULL COMMENT '작성일시',
  favorite_count INT         NOT NULL DEFAULT 0 COMMENT '좋아요 수',
  comment_count  INT         NOT NULL DEFAULT 0 COMMENT '댓글 수',
  view_count     INT         NOT NULL DEFAULT 0 COMMENT '조회 수',
  writer_email   VARCHAR(50) NOT NULL COMMENT '작성자 이메일',
  PRIMARY KEY (board_number)
) COMMENT '게시물';

CREATE TABLE comment
(
  comment_number INT         NOT NULL COMMENT '댓글 번호',
  content        TEXT        NOT NULL COMMENT '댓글 내용',
  user_email     VARCHAR(50) NOT NULL COMMENT '이메일',
  board_number   INT         NOT NULL COMMENT '번호',
  write_datetime DATETIME    NOT NULL COMMENT '작성일시',
  PRIMARY KEY (comment_number)
) COMMENT '댓글 테이블';

CREATE TABLE favorite
(
  user_email   VARCHAR(50) NOT NULL COMMENT '이메일',
  board_number INT         NOT NULL COMMENT '번호',
  PRIMARY KEY (user_email, board_number)
) COMMENT '좋아요 테이블';

CREATE TABLE image
(
  board_number INT  NOT NULL COMMENT '번호',
  image        TEXT NOT NULL COMMENT '게시물 이미지 URL'
) COMMENT '게시물 이미지 테이블';

CREATE TABLE search_log
(
  sequence      INT     NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  search_word   TEXT    NOT NULL COMMENT '검색어',
  relation_word TEXT    NULL     COMMENT '관련 검색어',
  relation      BOOLEAN NOT NULL COMMENT '관련 검색어 여부',
  PRIMARY KEY (sequence)
) COMMENT '검색 기록 테이블';

CREATE TABLE user
(
  email          VARCHAR(50)  NOT NULL COMMENT '이메일',
  password       VARCHAR(100) NOT NULL COMMENT '비밀번호',
  nickname       VARCHAR(20)  NOT NULL UNIQUE COMMENT '닉네임',
  tel_number     VARCHAR(15)  NOT NULL UNIQUE COMMENT '전화번호',
  address        TEXT         NOT NULL COMMENT '주소',
  address_detail TEXT         NULL     COMMENT '상세 주소',
  profile_image  TEXT         NULL     COMMENT '프로필 사진',
  PRIMARY KEY (email)
) COMMENT '사용자';

ALTER TABLE image
  ADD CONSTRAINT FK_board_TO_image
    FOREIGN KEY (board_number)
    REFERENCES board (board_number);

ALTER TABLE board
  ADD CONSTRAINT FK_user_TO_board
    FOREIGN KEY (writer_email)
    REFERENCES user (email);

ALTER TABLE favorite
  ADD CONSTRAINT FK_user_TO_favorite
    FOREIGN KEY (user_email)
    REFERENCES user (email);

ALTER TABLE favorite
  ADD CONSTRAINT FK_board_TO_favorite
    FOREIGN KEY (board_number)
    REFERENCES board (board_number);

ALTER TABLE comment
  ADD CONSTRAINT FK_user_TO_comment
    FOREIGN KEY (user_email)
    REFERENCES user (email);

ALTER TABLE comment
  ADD CONSTRAINT FK_board_TO_comment
    FOREIGN KEY (board_number)
    REFERENCES board (board_number);

CREATE USER 'developer'@'*' IDENTIFIED BY 'P!ssw0rd'; /* 개발자 */

CREATE VIEW board_list_view AS
SELECT
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS title_image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count, 
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    B.writer_email AS writer_email,
    U.nickname AS write_nickname,
    U.profile_image AS write_profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image FROM image GROUP BY board_number) AS I
ON B.board_number = I.board_number