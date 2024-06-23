USE ADOPT;

CREATE TABLE 회원 (
	회원ID INTEGER NOT NULL,
	이름 VARCHAR(30) NOT NULL,
	나이 INTEGER,
	전화번호 INTEGER,
	거주지 VARCHAR(50) NOT NULL,
	PRIMARY KEY(회원ID)
);

CREATE TABLE 지역대분류 (
대분류ID INTEGER NOT NULL,
지역명 VARCHAR(30) NOT NULL,
PRIMARY KEY(대분류ID)
);

CREATE TABLE 지역중분류 (
중분류ID INTEGER NOT NULL,
대분류ID INTEGER NOT NULL,
지역명 VARCHAR(30) NOT NULL,
PRIMARY KEY (중분류ID, 대분류ID),
FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID)
);

CREATE TABLE 지역소분류 (
대분류ID INTEGER NOT NULL,
중분류ID INTEGER NOT NULL,
소분류ID INTEGER NOT NULL,
지역명 VARCHAR(30) NOT NULL,
PRIMARY KEY (중분류ID, 대분류ID, 소분류ID),
FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID)
);

CREATE TABLE 보호소 (
대분류ID INTEGER NOT NULL,
중분류ID INTEGER NOT NULL,
소분류ID INTEGER NOT NULL,
등록순서 INTEGER NOT NULL,
보호소명 VARCHAR(50) NOT NULL,
기타정보 VARCHAR(60),
PRIMARY KEY (등록순서, 중분류ID, 대분류ID, 소분류ID),
FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID),
FOREIGN KEY(소분류ID) REFERENCES 지역소분류(소분류ID)
);

CREATE TABLE 보호소_연락처 (
대분류ID INTEGER NOT NULL,
중분류ID INTEGER NOT NULL,
소분류ID INTEGER NOT NULL,
등록순서 INTEGER NOT NULL,
연락처 INTEGER,
PRIMARY KEY (연락처, 등록순서, 대분류ID, 중분류ID, 소분류ID),
FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID),
FOREIGN KEY(소분류ID) REFERENCES 지역소분류(소분류ID),
FOREIGN KEY(등록순서) REFERENCES 보호소(등록순서)
);

CREATE TABLE 등록동물 (
대분류ID INTEGER NOT NULL,
중분류ID INTEGER NOT NULL,
소분류ID INTEGER NOT NULL,
보호소등록순서 INTEGER NOT NULL,
등록순서 INTEGER NOT NULL,
등록년 YEAR NOT NULL,
등록월 INTEGER NOT NULL CHECK (등록월 >= 1 AND 등록월 <= 12),
등록일 INTEGER NOT NULL CHECK (등록일 >= 1 AND 등록일 <= 31),
나이 INTEGER,
성별 VARCHAR(10) CHECK (성별 IN ('암컷', '수컷')),
보호상태 VARCHAR(20) NOT NULL CHECK (보호상태 IN ('보호(입양가능)', '브호(공고중)', '입양', '사망', '귀가')),
개 VARCHAR(30),
고양이 VARCHAR(30) ,
기타 VARCHAR(30) ,
특이사항 VARCHAR(60),
PRIMARY KEY(등록순서, 등록년, 대분류ID, 중분류ID, 소분류ID, 보호소등록순서),
FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID),
FOREIGN KEY(소분류ID) REFERENCES 지역소분류(소분류ID),
FOREIGN KEY(보호소등록순서) REFERENCES 보호소(등록순서)
);

/* 등록동물 테이블의 등록순서, 등록년을 외래키로 가져오려니 오류 떠서 등록동물의 등록년 열에 인덱스 추가하여 수정
CREATE TABLE 입양 (
	회원ID INTEGER NOT NULL,
	대분류ID INTEGER NOT NULL,
	중분류ID INTEGER NOT NULL,
    소분류ID INTEGER NOT NULL,
    보호소등록순서 INTEGER NOT NULL,
    동물등록순서 INTEGER NOT NULL,
    등록년 YEAR NOT NULL,
    입양날짜 DATE,
    PRIMARY KEY(동물등록순서, 등록년, 회원ID, 대분류ID, 중분류ID, 소분류ID, 보호소등록순서),
    FOREIGN KEY(회원ID) REFERENCES 회원(회원ID),
    FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
    FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID),
    FOREIGN KEY(소분류ID) REFERENCES 지역소분류(소분류ID),
    FOREIGN KEY(보호소등록순서) REFERENCES 보호소(등록순서),
    FOREIGN KEY(동물등록순서) REFERENCES 등록동물(등록순서),
    FOREIGN KEY(등록년) REFERENCES 등록동물(등록년)
);
*/

CREATE TABLE 입양 (
	회원ID INTEGER NOT NULL,
	대분류ID INTEGER NOT NULL,
	중분류ID INTEGER NOT NULL,
    소분류ID INTEGER NOT NULL,
    보호소등록순서 INTEGER NOT NULL,
    동물등록순서 INTEGER NOT NULL,
    등록년 YEAR NOT NULL,
    입양날짜 DATE,
    PRIMARY KEY(동물등록순서, 등록년, 회원ID, 대분류ID, 중분류ID, 소분류ID, 보호소등록순서),
    FOREIGN KEY(회원ID) REFERENCES 회원(회원ID),
    FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
    FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID),
    FOREIGN KEY(소분류ID) REFERENCES 지역소분류(소분류ID),
    FOREIGN KEY(보호소등록순서) REFERENCES 보호소(등록순서),
    FOREIGN KEY(동물등록순서) REFERENCES 등록동물(등록순서)
);

CREATE INDEX INDEX_등록년 ON 등록동물(등록년);

ALTER TABLE 입양
ADD FOREIGN KEY(등록년) REFERENCES 등록동물(등록년);

CREATE TABLE 입양문의 (
	회원ID INTEGER NOT NULL,
	대분류ID INTEGER NOT NULL,
	중분류ID INTEGER NOT NULL,
    소분류ID INTEGER NOT NULL,
    보호소등록순서 INTEGER NOT NULL,
    PRIMARY KEY(회원ID, 대분류ID, 중분류ID, 소분류ID, 보호소등록순서),
    FOREIGN KEY(회원ID) REFERENCES 회원(회원ID),
    FOREIGN KEY(대분류ID) REFERENCES 지역대분류(대분류ID),
    FOREIGN KEY(중분류ID) REFERENCES 지역중분류(중분류ID),
    FOREIGN KEY(소분류ID) REFERENCES 지역소분류(소분류ID),
    FOREIGN KEY(보호소등록순서) REFERENCES 보호소(등록순서)
);

CREATE TABLE 회원_입양내역 (
	회원ID INTEGER NOT NULL,
    입양내역 VARCHAR(70),
    PRIMARY KEY(입양내역, 회원ID),
    FOREIGN KEY(회원ID) REFERENCES 회원(회원ID)
);

INSERT INTO 회원 VALUES (1, '노원호', 31, 01011111111, '서울특별시');
INSERT INTO 회원 VALUES (2, '임미주', 32, 01011111112, '서울특별시');
INSERT INTO 회원 VALUES (3, '박신영', 41, 01011111113, '부산광역시');
INSERT INTO 회원 VALUES (4, '백희석', 50, 01011111114, '대구광역시');
INSERT INTO 회원 VALUES (5, '백지희', 22, 01011111115, '부산광역시');
INSERT INTO 회원 VALUES (6, '조기훈', 26, 01011111116, '인천광역시');
INSERT INTO 회원 VALUES (7, '안혜미', 26, 01011111117, '부산광역시');
INSERT INTO 회원 VALUES (8, '전태웅', 14, 01011111118, '광주광역시');
INSERT INTO 회원 VALUES (9, '허대준', 28, 01011111119, '경기도');
INSERT INTO 회원 VALUES (10, '정지숙', 45, 01011111110, '광주광역시');
INSERT INTO 회원 VALUES (11, '윤소원', 17, 01011111120, '대전광역시');
INSERT INTO 회원 VALUES (12, '봉상철', 42, 01011111121, '울산광역시');
INSERT INTO 회원 VALUES (13, '손주옥', 36, 01011111122, '강원특별자치도');
INSERT INTO 회원 VALUES (14, '박승식', 53, 01011111123, '충청북도');
INSERT INTO 회원 VALUES (15, '최명준', 33, 01011111124, '서울특별시');
INSERT INTO 회원 VALUES (16, '장도희', 16, 01011111125, '충청남도');
INSERT INTO 회원 VALUES (17, '오창민', 15, 01011111126, '충청북도');
INSERT INTO 회원 VALUES (18, '정병철', 24, 01011111127, '경상남도');
INSERT INTO 회원 VALUES (19, '최태수', 16, 01011111128, '경상북도');
INSERT INTO 회원 VALUES (20, '양다운', 11, 01011111129, '전북특별자치도');
INSERT INTO 회원 VALUES (21, '성한길', 20, 01011111130, '전라남도');
INSERT INTO 회원 VALUES (22, '문미르', 20, 01011111131, '전라남도');
INSERT INTO 회원 VALUES (23, '남버들', 21, 01011111132, '전라남도');
INSERT INTO 회원 VALUES (24, '조으뜸', 29, 01011111133, '제주특별자치도');
INSERT INTO 회원 VALUES (25, '유우람', 29, 01011111134, '서울특별시');
INSERT INTO 회원 VALUES (26, '류초롱', 31, 01011111135, '전라남도');
INSERT INTO 회원 VALUES (27, '전슬기', 31, 01011111136, '전라남도');
INSERT INTO 회원 VALUES (28, '이온', 32, 01011111137, '광주광역시');
INSERT INTO 회원 VALUES (29, '한가을', 24, 01011111138, '서울특별시');
INSERT INTO 회원 VALUES (30, '최아라', 23, 01011111139, '서울특별시');

INSERT INTO 지역대분류 VALUES (1, '서울특별시');
INSERT INTO 지역대분류 VALUES (2, '부산광역시');
INSERT INTO 지역대분류 VALUES (3, '대구광역시');
INSERT INTO 지역대분류 VALUES (4, '인천광역시');
INSERT INTO 지역대분류 VALUES (5, '광주광역시');
INSERT INTO 지역대분류 VALUES (6, '대전광역시');
INSERT INTO 지역대분류 VALUES (7, '울산광역시');
INSERT INTO 지역대분류 VALUES (8, '세종특별자치시');
INSERT INTO 지역대분류 VALUES (9, '경기도');
INSERT INTO 지역대분류 VALUES (10, '강원특별자치도');
INSERT INTO 지역대분류 VALUES (11, '충청북도');
INSERT INTO 지역대분류 VALUES (12, '충청남도');
INSERT INTO 지역대분류 VALUES (13, '전북특별자치도');
INSERT INTO 지역대분류 VALUES (14, '전라남도');
INSERT INTO 지역대분류 VALUES (15, '경상북도');
INSERT INTO 지역대분류 VALUES (16, '경상남도');
INSERT INTO 지역대분류 VALUES (17, '제주특별자치도');

INSERT INTO 지역중분류 VALUES (1, 1, '종로구');
INSERT INTO 지역중분류 VALUES (2, 1, '중구');
INSERT INTO 지역중분류 VALUES (3, 1, '용산구');
INSERT INTO 지역중분류 VALUES (4, 1, '성동구');
INSERT INTO 지역중분류 VALUES (5, 1, '광진구');
INSERT INTO 지역중분류 VALUES (6, 1, '동대문구');
INSERT INTO 지역중분류 VALUES (7, 1, '중랑구');
INSERT INTO 지역중분류 VALUES (8, 1, '성북구');
INSERT INTO 지역중분류 VALUES (1, 14, '목포시');
INSERT INTO 지역중분류 VALUES (2, 14, '여수시');
INSERT INTO 지역중분류 VALUES (3, 14, '순천시');
INSERT INTO 지역중분류 VALUES (4, 14, '나주시');
INSERT INTO 지역중분류 VALUES (5, 14, '광양시');
INSERT INTO 지역중분류 VALUES (6, 14, '담양군');
INSERT INTO 지역중분류 VALUES (7, 14, '곡성군');
INSERT INTO 지역중분류 VALUES (8, 14, '구례군');
INSERT INTO 지역중분류 VALUES (9, 14, '고흥군');
INSERT INTO 지역중분류 VALUES (10, 14, '보성군');
INSERT INTO 지역중분류 VALUES (11, 14, '화순군');
INSERT INTO 지역중분류 VALUES (12, 14, '장흥군');
INSERT INTO 지역중분류 VALUES (13, 14, '강진군');
INSERT INTO 지역중분류 VALUES (14, 14, '해남군');
INSERT INTO 지역중분류 VALUES (15, 14, '영암군');
INSERT INTO 지역중분류 VALUES (16, 14, '무안군');
INSERT INTO 지역중분류 VALUES (17, 14, '함평군');
INSERT INTO 지역중분류 VALUES (18, 14, '영광군');
INSERT INTO 지역중분류 VALUES (19, 14, '장성군');
INSERT INTO 지역중분류 VALUES (20, 14, '완도군');
INSERT INTO 지역중분류 VALUES (21, 14, '진도군');
INSERT INTO 지역중분류 VALUES (22, 14, '신안군');

INSERT INTO 지역소분류 VALUES (14, 3, 1, '승주읍');
INSERT INTO 지역소분류 VALUES (14, 3, 2, '해룡면');
INSERT INTO 지역소분류 VALUES (14, 3, 3, '서면');
INSERT INTO 지역소분류 VALUES (14, 3, 4, '황전면');
INSERT INTO 지역소분류 VALUES (14, 3, 5, '월등면');
INSERT INTO 지역소분류 VALUES (14, 3, 6, '주암면');
INSERT INTO 지역소분류 VALUES (14, 3, 7, '송광면');
INSERT INTO 지역소분류 VALUES (14, 3, 8, '외서면');
INSERT INTO 지역소분류 VALUES (14, 3, 9, '낙안면');
INSERT INTO 지역소분류 VALUES (14, 3, 10, '별량면');
INSERT INTO 지역소분류 VALUES (14, 3, 11, '상사면');
INSERT INTO 지역소분류 VALUES (14, 3, 12, '향동');
INSERT INTO 지역소분류 VALUES (14, 3, 13, '매곡동');
INSERT INTO 지역소분류 VALUES (14, 3, 14, '삼산동');
INSERT INTO 지역소분류 VALUES (14, 3, 15, '조곡동');
INSERT INTO 지역소분류 VALUES (14, 3, 16, '덕연동');
INSERT INTO 지역소분류 VALUES (14, 3, 17, '풍덕동');
INSERT INTO 지역소분류 VALUES (14, 3, 18, '남제동');
INSERT INTO 지역소분류 VALUES (14, 3, 19, '저전동');
INSERT INTO 지역소분류 VALUES (14, 3, 20, '장천동');
INSERT INTO 지역소분류 VALUES (14, 3, 21, '중앙동');
INSERT INTO 지역소분류 VALUES (14, 3, 22, '도사동');
INSERT INTO 지역소분류 VALUES (14, 3, 23, '왕조1동');
INSERT INTO 지역소분류 VALUES (14, 3, 24, '왕조2동');
INSERT INTO 지역소분류 VALUES (14, 5, 1, '광양읍');
INSERT INTO 지역소분류 VALUES (14, 5, 2, '골약동');
INSERT INTO 지역소분류 VALUES (14, 5, 3, '중마동');
INSERT INTO 지역소분류 VALUES (14, 5, 4, '광영동');
INSERT INTO 지역소분류 VALUES (14, 5, 5, '태인동');
INSERT INTO 지역소분류 VALUES (14, 5, 6, '금호동');

INSERT INTO 보호소 VALUES (14, 3, 1, 1, '승주읍동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 2, 1, '해룡유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 3, 1, '서면유기동물보호소', '공고 10일 후 안락사');
INSERT INTO 보호소 VALUES (14, 3, 4, 1, '황전동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 5, 1, '월등동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 6, 1, '주암면동물보호센터', '');
INSERT INTO 보호소 VALUES (14, 3, 7, 1, '송광보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 8, 1, '외서면동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 9, 1, '낙안동물보호센터', '공고 20일 후 안락사');
INSERT INTO 보호소 VALUES (14, 3, 10, 1, '별량면동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 11, 1, '상사면유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 12, 1, '향동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 13, 1, '매곡동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 14, 1, '삼산동동물보호센터', '');
INSERT INTO 보호소 VALUES (14, 3, 15, 1, '조곡동물보호소', '안락사 없음');
INSERT INTO 보호소 VALUES (14, 3, 16, 1, '덕연동물보호소', '안락사 없음');
INSERT INTO 보호소 VALUES (14, 3, 17, 1, '풍덕동물보호센터', '');
INSERT INTO 보호소 VALUES (14, 3, 18, 1, '남제유기동물보호센터', '');
INSERT INTO 보호소 VALUES (14, 3, 19, 1, '저전유기동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 20, 1, '장천동물보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 21, 1, '중앙동물보호센터', '공고 10일 후 안락사');
INSERT INTO 보호소 VALUES (14, 3, 22, 1, '도사유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 23, 1, '왕조1동유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 3, 24, 1, '왕조2동유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 5, 1, 1, '광양읍유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 5, 2, 1, '골약동동물보호소', '');
INSERT INTO 보호소 VALUES (14, 5, 3, 1, '중마동유기견보호소', '');
INSERT INTO 보호소 VALUES (14, 5, 4, 1, '광영동유기동물보호소', '');
INSERT INTO 보호소 VALUES (14, 5, 5, 1, '태인동물보호소', '');
INSERT INTO 보호소 VALUES (14, 5, 6, 1, '금호동유기견보호소', '');

INSERT INTO 보호소_연락처 VALUES (14, 3, 1, 1, '0617777773');
INSERT INTO 보호소_연락처 VALUES (14, 3, 2, 1, '0617777771');
INSERT INTO 보호소_연락처 VALUES (14, 3, 3, 1, '0617777772');
INSERT INTO 보호소_연락처 VALUES (14, 3, 4, 1, '0617777773');
INSERT INTO 보호소_연락처 VALUES (14, 3, 5, 1, '0617777774');
INSERT INTO 보호소_연락처 VALUES (14, 3, 6, 1, '0617777775');
INSERT INTO 보호소_연락처 VALUES (14, 3, 7, 1, '0617777776');
INSERT INTO 보호소_연락처 VALUES (14, 3, 8, 1, '0617777777');
INSERT INTO 보호소_연락처 VALUES (14, 3, 9, 1, '0617777778');
INSERT INTO 보호소_연락처 VALUES (14, 3, 10, 1, '0617777779');
INSERT INTO 보호소_연락처 VALUES (14, 3, 11, 1, '0617777710');
INSERT INTO 보호소_연락처 VALUES (14, 3, 12, 1, '0617777711');
INSERT INTO 보호소_연락처 VALUES (14, 3, 13, 1, '0617777712');
INSERT INTO 보호소_연락처 VALUES (14, 3, 14, 1, '0617777713');
INSERT INTO 보호소_연락처 VALUES (14, 3, 15, 1, '0617777714');
INSERT INTO 보호소_연락처 VALUES (14, 3, 16, 1, '0617777715');
INSERT INTO 보호소_연락처 VALUES (14, 3, 17, 1, '0617777716');
INSERT INTO 보호소_연락처 VALUES (14, 3, 18, 1, '0617777717');
INSERT INTO 보호소_연락처 VALUES (14, 3, 19, 1, '0617777718');
INSERT INTO 보호소_연락처 VALUES (14, 3, 20, 1, '0617777719');
INSERT INTO 보호소_연락처 VALUES (14, 3, 21, 1, '0617777720');
INSERT INTO 보호소_연락처 VALUES (14, 3, 22, 1, '0617777721');
INSERT INTO 보호소_연락처 VALUES (14, 3, 23, 1, '0617777722');
INSERT INTO 보호소_연락처 VALUES (14, 3, 24, 1, '0617777723');
INSERT INTO 보호소_연락처 VALUES (14, 5, 1, 1, '0617777724');
INSERT INTO 보호소_연락처 VALUES (14, 5, 2, 1, '0617777725');
INSERT INTO 보호소_연락처 VALUES (14, 5, 3, 1, '0617777726');
INSERT INTO 보호소_연락처 VALUES (14, 5, 4, 1, '0617777727');
INSERT INTO 보호소_연락처 VALUES (14, 5, 5, 1, '0617777728');
INSERT INTO 보호소_연락처 VALUES (14, 5, 6, 1, '0617777729');

INSERT INTO 등록동물 VALUES (14, 3, 1, 1, 11, 2024, 6, 11, NULL, '암컷', '보호(입양가능)', '포메라니안', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 2, 1, 1, 2024, 6, 22, 6, '암컷', '브호(공고중)', '말티즈', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 3, 1, 12, 2024, 6, 14, NULL, '암컷', '브호(공고중)', '푸들', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 4, 1, 3, 2024, 6, 13, 7, '수컷', '입양', '푸들', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 5, 1, 21, 2024, 6, 17, NULL, '수컷', '브호(공고중)', '말티즈', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 6, 1, 51, 2024, 6, 17, 11, '암컷', '브호(공고중)', '말티즈', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 7, 1, 41, 2024, 5, 17, 11, NULL, '보호(입양가능)', '믹스', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 8, 1, 61, 2024, 5, 18, NULL, '암컷', '보호(입양가능)', '', '코리안숏헤어', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 9, 1, 71, 2024, 5, 18, 1, '수컷', '귀가', '말티즈', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 10, 1, 18, 2024, 5, 1, NULL, '암컷', '입양', '푸들', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 11, 1, 24, 2024, 5, 6, 1, '암컷', '입양', '믹스', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 12, 1, 24, 2024, 5, 30, NULL, '수컷', '브호(공고중)', '말티즈', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 13, 1, 26, 2024, 5, 24, 1, '수컷', '보호(입양가능)', '믹스', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 14, 1, 35, 2024, 5, 29, 1, NULL, '귀가', '포메라니안', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 15, 1, 33, 2024, 5, 29, NULL, '암컷', '보호(입양가능)', '말티즈', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 16, 1, 55, 2024, 5, 28, 2, '수컷', '브호(공고중)', '믹스', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 17, 1, 13, 2024, 4, 29, NULL, '암컷', '보호(입양가능)', '', '코리안숏헤어', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 18, 1, 10, 2024, 4, 21, 1, '수컷', '브호(공고중)', '말티즈', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 19, 1, 9, 2024, 4, 27, NULL, NULL, '보호(입양가능)', '', '터키쉬앙고라', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 20, 1, 7, 2024, 4, 28, 2, '암컷', '브호(공고중)', '믹스', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 21, 1, 7, 2024, 6, 19, 2, NULL, '보호(입양가능)', '푸들', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 3, 22, 1, 7, 2024, 5, 28, 2, '수컷', '브호(공고중)', '믹스', '', '', '');
INSERT INTO 등록동물 VALUES (14, 3, 23, 1, 7, 2024, 6, 18, 6, '수컷', '귀가', '', '', '햄스터', '');
INSERT INTO 등록동물 VALUES (14, 3, 24, 1, 7, 2024, 6, 18, 3, '수컷', '보호(입양가능)', '', '믹스', '', '');
INSERT INTO 등록동물 VALUES (14, 5, 1, 1, 7, 2024, 6, 15, 4, '암컷', '브호(공고중)', '믹스', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 5, 2, 1, 7, 2024, 6, 15, 5, NULL, '보호(입양가능)', '믹스', '', '', '');
INSERT INTO 등록동물 VALUES (14, 5, 3, 1, 7, 2024, 6, 12, 6, '수컷', '입양', '', '', '거북이', '');
INSERT INTO 등록동물 VALUES (14, 5, 4, 1, 7, 2024, 6, 17, 4, '암컷', '브호(공고중)', '믹스', '', '', '중성화 완료');
INSERT INTO 등록동물 VALUES (14, 5, 5, 1, 7, 2024, 6, 18, 3, '암컷', '브호(공고중)', '믹스', '', '', '');
INSERT INTO 등록동물 VALUES (14, 5, 6, 1, 7, 2024, 6, 19, NULL, '암컷', '보호(입양가능)', '믹스', '', '', '중성화 완료');

INSERT INTO 입양 VALUES (1, 14, 3, 4, 1, 3, 2024, '2024-06-15');
INSERT INTO 입양 VALUES (2, 14, 3, 10, 1, 18, 2024, '2024-05-06');
INSERT INTO 입양 VALUES (3, 14, 3, 11, 1, 24, 2024, '2024-05-15');
INSERT INTO 입양 VALUES (4, 14, 5, 3, 1, 7, 2024, '2024-06-17');

INSERT INTO 입양문의 VALUES (1, 14, 3, 4, 1);
INSERT INTO 입양문의 VALUES (2, 14, 3, 10, 1);
INSERT INTO 입양문의 VALUES (3, 14, 3, 11, 1);
INSERT INTO 입양문의 VALUES (4, 14, 5, 3, 1);

INSERT INTO 회원_입양내역 VALUES (1, '2024년 6월 15일, 수컷 푸들 입양');
INSERT INTO 회원_입양내역 VALUES (2, '2024년 5월 6일, 암컷 푸들 입양');
INSERT INTO 회원_입양내역 VALUES (3, '2024년 5월 15일, 암컷 믹스견 입양');
INSERT INTO 회원_입양내역 VALUES (4, '2024년 6월 17일, 암컷 거북이 입양');

-- 데이터 삽입
INSERT INTO 보호소 VALUES (14, 3, 13, 2, '강아지나라', '안락사 없음');

INSERT INTO 보호소_연락처 VALUES (14, 3, 13, 2, '01033333333');

INSERT INTO 등록동물 VALUES (14, 3, 13, 2, 1, 2024, 6, 24, 3, '수컷', '브호(공고중)', '믹스', '', '', '');

-- 데이터 검색
SELECT 보호소명
FROM 보호소
WHERE 대분류ID = (SELECT 대분류ID
				 FROM 지역대분류
                 WHERE 지역명 = '전라남도');

SELECT 보호소명
FROM 보호소
WHERE 중분류ID = (SELECT 중분류ID
				 FROM 지역중분류
                 WHERE 지역명 = '순천시');
                 
SELECT *
FROM 등록동물
WHERE 개 = '말티즈';

SELECT *
FROM 등록동물
WHERE 중분류ID = (SELECT 중분류ID
				 FROM 지역중분류
                 WHERE 지역명 = '순천시');
                 
SELECT *
FROM 등록동물
ORDER BY 등록월, 등록일;

SELECT 지역명 AS '서울특별시의 구'
FROM 지역중분류
WHERE 대분류ID = (SELECT 대분류ID
				 FROM 지역대분류
                 WHERE 지역명 = '서울특별시');
                 
SELECT H.이름 AS '회원명', D.등록년, D.등록월, D.등록일, D.나이, D.성별, D.개, D.고양이, D.기타, D.특이사항
FROM 회원 AS H INNER JOIN 입양 AS A ON H.회원ID = A.회원ID
	INNER JOIN 등록동물 AS D ON A.대분류ID = D.대분류ID
AND D.보호상태 = '입양';

SELECT *
FROM 보호소
WHERE 기타정보 = '안락사 없음';

SELECT *
FROM 등록동물
WHERE 등록월 = 6
ORDER BY 등록일;

SELECT *
FROM 등록동물
WHERE (등록월 = 5 AND 등록일 >= 15) OR (등록월 = 6 AND 등록일 <= 21)
ORDER BY 등록월, 등록일;

SELECT DISTINCT 개
FROM 등록동물
WHERE 개 <> '';

SELECT *
FROM 등록동물
WHERE 성별 IS NULL;

SELECT COUNT(개) AS '등록된 유기견 수'
FROM 등록동물
WHERE 개 <> '';

-- 데이터 삭제
DELETE FROM 회원_입양내역
WHERE 회원ID = 4;