use greentour;

create table t_admin_info(                  -- 관리자 정보
   ai_idx int auto_increment unique,         -- 일련번호
    ai_id varchar(20) primary key,            -- 아이디
    ai_pw varchar(20) not null,               -- 비밀번호
    ai_name varchar(20) not null,            -- 이름
    ai_use char(1) default 'y',               -- 사용여부
    ai_date datetime default now()            -- 등록일
);
insert into t_admin_info (ai_idx, ai_id, ai_pw, ai_name) 
   values (1, 'admin1', 1234, '홍길동');

create table t_member_info(                  -- 회원정보
    mi_id varchar(20) primary key,            -- 아이디
    mi_pw varchar(20) not null,               -- 비밀번호
    mi_name varchar(20) not null,            -- 이름
    mi_gender char(1) not null,               -- 성별
    mi_registration char(14) not null unique,   -- 주민번호
    mi_phone varchar(13) not null unique,      -- 번호
    mi_email varchar(50) not null unique,      -- 이메일
    mi_mileage int default 0,               -- 보유 마일리지
    mi_lastlogin datetime default now(),      -- 최종로그인
    mi_joindate datetime default now(),         -- 가입일
    mi_status char(1) default 'a'            -- 회원상태
);
insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_registration, mi_phone, mi_email, mi_mileage) 
   values ('test1', '1234', '홍길동', '남', '000000-1234567', '010-1234-5678', 'hong@test.com', 1000);
insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_registration, mi_phone, mi_email, mi_mileage) 
   values ('test2', '1234', '전우치', '남', '000000-1234568', '010-1234-5679', 'wu@test.com', 1000);

create table t_member_mileage(               -- 회원 마일리지 내역
   mm_idx int auto_increment primary key,      -- 일련번호
    mi_id varchar(20),                     -- 아이디
    mm_su char(1) default 's',               -- 사용/적립 
    mm_mileage int default 0,               -- 마일리지
    mm_desc varchar(20) not null,            -- 사용/적립 내역
    mm_detail varchar(20) not null,            -- 내역 상세
    mm_date datetime default now(),            -- 사용/적립일
    constraint fk_member_mileage_mi_id foreign key (mi_id) references t_member_info(mi_id)
);

create table t_ctgr_city(                  -- 분류(도시)
   cc_id char(6) primary key,               -- 도시 코드
   cc_name varchar(20) not null,            -- 도시 이름
   cc_img1 varchar(50) not null,            -- 도시이미지1
   cc_img2 varchar(50),                  -- 도시이미지2
   cc_img3   varchar(50),                  -- 도시이미지3
   cc_img4   varchar(50),                  -- 도시이미지4
   cc_img5   varchar(50),                   -- 도시이미지5
   cc_img6   varchar(50)                     -- 도시이미지6
);

create table t_hotel_info(                  -- 호텔정보
   hi_code char(11) primary key,            -- 호텔코드
   hi_idx int unique auto_increment ,         -- 호텔일련번호
    cc_id char(6),                        -- 도시코드 
    hi_name varchar(20) not null,             -- 호텔명 
    hi_grade char(1) not null,                -- 호텔등급 
    hi_addr varchar(200) not null,              -- 호텔 주소 
    hi_tel varchar(50) not null,             -- 호텔 번호
    hi_desc varchar(1000) not null,             -- 호텔 설명 
    hi_notice varchar(1000) not null,          -- 안내사항 
    hi_img1 varchar(50) not null,             -- 호텔이미지 
    hi_img2 varchar(50),
    hi_img3 varchar(50),
    hi_img4 varchar(50),
    hi_img5 varchar(50),
    hi_date datetime default now(),          -- 호텔 등록일 
    ai_id varchar(20),                      -- 최종 수정자 
    hi_price int not null,                   -- 호텔 기본가격 
    hi_score float,                      -- 평점 컬럼
    hi_standard   int default 0,               -- 스탠다드가격
    hi_deluxe int default 0,               -- 디럭스가격
    hi_suite int default 0,                  -- 스위트가격
    constraint fk_hotel_info_cc_id foreign key (cc_id) references t_ctgr_city(cc_id),
    constraint fk_hotel_info_ai_id foreign key (ai_id) references t_admin_info(ai_id)
);

create table t_flight_realprice(            -- 항공 가격
   fr_idx int primary key auto_increment,      -- 가격번호
    cc_id char(6),                        -- 도착지 도시코드
   fr_name varchar(20) not null,            -- 항공사 이름
   fr_grade char(1) default 'a',            -- 좌석등급
   fr_adult int default 0,                  -- 성인
   fr_child int default 0,                  -- 아동
   constraint fk_flight_realprice_cc_id foreign key (cc_id) references t_ctgr_city(cc_id)
);

create table t_flight_info(                  -- 항공정보
   fi_code char(11) primary key,            -- 항공정보 코드
    cc_id char(6),                        -- 항공 가격 일련 번호
   fi_origin char(6) not null,               -- 출발지
   fi_departure char(16) not null,            -- 출국일
   fi_cityarrive char(16) not null,         -- 여행지 도착일
   fi_cityleave char(16) not null,            -- 여행지에서 출발일
   fi_entry char(16) not null,               -- 입국일
    fi_passenger int default 100,            -- 탑승가능인원 
    constraint fk_flight_info_cc_id foreign key (cc_id) references  t_ctgr_city(cc_id)
);

create table t_package_notice(                  -- 패키지 유의사항
   pn_idx int primary key auto_increment,         -- 일련번호
   cc_id char(6),                           -- 도시
   pn_insur varchar(200) default '여행자 보험 가입',   -- 보험      
   pn_guide varchar(200) default '가이드 포함',      -- 가이드
   pn_include varchar(200) default '텍스트',         -- 포함사항
   pn_declude varchar(200) default '텍스트',         -- 불포함사항
   pn_warning varchar(200) default '유희사항',      -- 유의사항
    pn_date datetime default now(),
    constraint fk_package_notice_cc_id foreign key (cc_id) references t_ctgr_city(cc_id)
);

create table t_package_info(               -- 패키지 상품
   pi_code   char(11) primary key,             -- 패키지 상품 코드
    cc_id char(6),                         -- 도시코드(도착지)
    hi_code char(11),                      -- 호텔 일련번호
   pn_idx int,                           -- 유의사항
    pi_name varchar(50)   not null,             -- 패키지명
   pi_period varchar(20) not null,          -- 패키지 기간
    pi_keyword varchar(200),                -- 키워드
    pi_dc int default 0,                   -- 할인율
    pi_img1 varchar(50) not null,             -- 상품 이미지1
    pi_img2 varchar(50),                   -- 상품 이미지2
    pi_img3 varchar(50),                   -- 상품 이미지3
    pi_img4 varchar(50),                   -- 상품 이미지4
    pi_img5 varchar(50),                   -- 상품 이미지5
    pi_desc varchar(200) not null,             -- 상품 설명
    pi_special varchar(200) default '기사/가이드 포함', -- 스페셜 혜택
    pi_tour varchar(200) not null,             -- 관광상품
    pi_food varchar(200) not null,             -- 식사
    pi_stock int default 100,                -- 재고량
    pi_sale int default 0,                   -- 판매량
    pi_read int default 0,                   -- 조회수
    pi_isview varchar(1) default 'n',          -- 게시여부
    pi_date datetime default now(),          -- 등록일
    pi_score float default 0,                -- 패키지평점(리뷰)
    pi_review int default 0,                -- 패키지 리뷰수
    pi_last datetime default now(),          -- 최종수정일
    pi_price int default 0,                -- 총 가격 (기본 성인 1인가격)
    pi_adult int default 1,                  -- 성인가격
    pi_child int default 0,                -- 아동 가격
    pi_suggest char(1) default 'n',            -- 추천상품 게시여부    
    constraint fk_package_info_cc_id foreign key (cc_id) references t_ctgr_city(cc_id),
    constraint fk_package_info_hi_code foreign key (hi_code) references t_hotel_info(hi_code),
    constraint fk_package_info_pn_idx foreign key (pn_idx) references t_package_notice(pn_idx)
);

create table t_package_date(               -- 패키지 일정
   pd_idx int primary key,                  -- 패키지 일정 일련번호
    pi_code char(11),                     -- 패키지 상품 일련번호
    fi_code char(11),                     -- 항공정보 코드
    ai_id varchar(20),                     -- 최종수정자
    constraint fk_package_date_pi_code foreign key (pi_code) references t_package_info(pi_code),
    constraint fk_package_date_fi_code foreign key (fi_code) references t_flight_info(fi_code),
    constraint fk_package_date_ai_id foreign key (ai_id) references t_admin_info(ai_id)
);

create table t_package_tour(               -- 패키지 관광상품
   pt_code char(11) primary key,            -- 관광상품 코드
    cc_id char(6),                        -- 도시코드
    pt_name varchar(30) not null unique,      -- 이름
    pt_addr varchar(200),                  -- 관광 상품 주소
    pt_page varchar(200),                  -- 홈페이지
    pt_summary varchar(200) not null,         -- 개요
    pt_desc varchar(500) not null,            -- 설명
    pt_image varchar(50) not null,            -- 이미지
    pt_price int default 0,                  -- 관광상품 가격
    constraint fk_package_tour_cc_id foreign key (cc_id) references t_ctgr_city(cc_id)
);

create table t_mypackage_my(                  -- 나만의 패키지
   mm_code char(11) primary key ,                -- 예약 코드
   mi_id varchar(20),                        -- 회원 아이디
   mm_name varchar(20) not null,                -- 패키지명 
   mm_spoint char(6) default 'KORICN',            -- 출발지 코드 
   cc_id char(6),                            -- 목적지 도시코드 
   fi_code char(11),                        -- 항공정보 코드
   hi_code char(11),                         -- 호텔코드
   fr_idx int,                            -- 항공 가격 번호 
   mm_tour varchar(200) default '자유여행',          -- 관광상품(메모필독) 
   mm_adult int default '1',                   -- 인원수 (성인)
   mm_child int default '0',                   -- 인원수 (아동) 
   mm_date datetime default now(),             -- 동록일(구매일) 
   mm_price int default '0',                   -- 가격
   constraint fk_mypackage_my_mi_id foreign key (mi_id) references t_member_info(mi_id),
   constraint fk_mypackage_my_cc_id foreign key (cc_id) references t_ctgr_city(cc_id),
      constraint fk_mypackage_my_fi_code foreign key (fi_code) references t_flight_info(fi_code),
   constraint fk_mypackage_my_hi_idx foreign key (hi_code) references t_hotel_info(hi_code),
   constraint fk_mypackage_my_fr_idx foreign key (fr_idx) references t_flight_realprice(fr_idx)
);

create table t_order_painfo(                  -- 패키지 주문 정보
   op_code char(11) primary key,               -- 예약코드
       pi_code char(11),                        -- 패키지 상품코드
   mi_id varchar(20),                         -- 회원 ID
   fi_code char(11),                         -- 항공 정보코드
   op_name varchar(50),                     -- 상품명
   op_leave char(16) not null,                  -- 출발일
   op_period varchar(20) not null,               -- 여행기간
   op_spoint char(6) default 'KORICN',            -- 출발지
   cc_id char(6),                            -- 도착 도시 코드
   op_customer varchar(20),                   -- 예약자명
   op_phone varchar(13) not null,                -- 연락처
   op_email varchar(20),                     -- 이메일
   op_payment char(1),                        -- 결제수단
   op_pay int,                            -- 금액
   op_adult int default 1,                     -- 성인
   op_child int default 0,                   -- 아동
   op_umile int default 0,                   -- 사용 포인트
   op_smile int default 0,                   -- 적립 포인트
   op_status char(1) default 'a',                -- 예약상태
   op_time   datetime default now(),             -- 결제일
   constraint fk_order_painfo_pi_code foreign key (pi_code) references t_package_info(pi_code),
   constraint fk_order_painfo_mi_id foreign key (mi_id) references t_member_info(mi_id),
   constraint fk_order_painfo_fi_code foreign key (fi_code) references t_flight_info(fi_code),
   constraint fk_order_painfo_cc_id foreign key (cc_id) references t_ctgr_city(cc_id)
);

create table t_order_mpinfo(                  -- 마이 패키지 주문 정보
   om_code char(11) primary key,               -- 예약코드
   mi_id varchar(20),                         -- 회원 ID
   fi_code char(11),                         -- 항공 정보코드
   om_name varchar(50),                     -- 상품명
   om_leave char(16) not null,                  -- 출발일
   om_arrive char(16) not null,               -- 도착일
   om_spoint char(6) default 'KORICN',            -- 출발지
   cc_id char(6),                            -- 도착 도시 코드
   om_customer varchar(20),                   -- 예약자명
   om_phone varchar(13) not null,                -- 연락처
   om_email varchar(20),                     -- 이메일
   om_payment char(1),                        -- 결제수단
   om_pay int,                            -- 금액
   om_adult int default 1,                     -- 성인
   om_child int default 0,                   -- 아동
   om_umile int default 0,                   -- 사용 포인트
   om_smile int default 0,                   -- 적립 포인트
   om_status char(1) default 'a',                -- 예약상태
   om_time   datetime default now(),             -- 결제일
   mm_code	char(11), 							-- 나만의패키지 코드,
   constraint fk_order_mpinfo_mi_id foreign key (mi_id) references t_member_info(mi_id),
   constraint fk_order_mpinfo_fi_code foreign key (mi_id) references t_flight_info(fi_code),
   constraint fk_order_mpinfo_cc_id foreign key (cc_id) references t_ctgr_city(cc_id),
   constraint fk_order_mpinfo_mm_code foreign key (mm_code) references t_mypackage_my(mm_code)
);

create table t_member_pa_cancel(               -- 패키지 취소 요청 내역
   mpc_idx int primary key auto_increment,         -- 일련번호
   op_code char(11),                        -- 예약코드
   mpc_reason char(1) default 'a',               -- 취소사유
   mpc_rsndetail varchar(20) not null,            -- 취소사유
   mpc_date datetime default now(),             -- 신청일 
   mpc_status char(1) default 'a',               -- 처리상태
    constraint fk_member_pa_cancel_op_code foreign key (op_code) references t_order_painfo(op_code)
);

create table t_member_my_cancel(               -- 마이패키지 취소요청 내역
   mmc_idx int primary key auto_increment,         -- 일련번호
   om_code char(11),                        -- 예약코드
   mmc_reason char(1) default 'a',               -- 취소사유
   mmc_rsndetail varchar(20) not null,            -- 취소사유
   mmc_date datetime default now(),             -- 신청일 
   mmc_status char(1) default 'a',               -- 처리상태
    constraint fk_member_my_cancel_om_code foreign key (om_code) references t_order_mpinfo(om_code)
);

create table t_cs_notice(                     -- 공지사항
   cn_idx int auto_increment primary key,          -- 글번호 
    cn_ctgr varchar(10) not null,                -- 분류 
    ai_id varchar(20),                        -- 답변 관리자
    cn_title varchar(100) not null,                -- 제목
    cn_content text not null,                   -- 내용 
    cn_read int default 0,                      -- 조회수 
    cn_always char(1) default 'n',                -- 상시여부 
    cn_isview char(1) default 'n',                -- 게시여부 
    cn_date datetime default now(),             -- 작성일
    constraint fk_cs_notice_ai_id foreign key(ai_id) references t_admin_info(ai_id)
);

create table t_cs_faq(                        -- 자주 찾는 질문
   cf_idx int primary key,                     -- 글번호
    cf_ctgr varchar(10) default 'a',            -- 분류
    cf_title varchar(50) not null,               -- 제목
    cf_content text not null,                  -- 내용
    cf_date datetime default now()               -- 작성일
);

create table t_cs_request (                        -- 1:1 문의         
   cq_idx int   primary key,                  -- 글번호
   mi_id varchar(20),                         -- 회원 ID
   cq_kind varchar(20),                     -- 예약 내역
   cq_code varchar(20),                      -- 예약번호
   cq_ctgr char(1) default 'a',               -- 질문 분류
   cq_title varchar(50) not null,                -- 질문 제목
   cq_content text not null,                   -- 질문 내용
   cq_rdate datetime default now(),             -- 질문 일자
   ai_id varchar(20),                         -- 답변 관리자
   cq_answer text not null,                  -- 답변 내용
   cq_adate datetime,                         -- 답변 일자
   cq_isend char(1) default 'n',               -- 답변 완료 여부
   constraint fk_cs_qna_mi_id foreign key (mi_id) references t_member_info(mi_id),
   constraint fk_cs_qna_ai_id foreign key (ai_id) references t_admin_info(ai_id)
);

create table t_cs_pareview(                       -- 패키지 리뷰
   cp_idx int auto_increment unique,              -- 글번호
   mi_id varchar(20),                          -- 회원 ID
   op_code char(12),                           -- 예약코드
   cp_name varchar(100) not null,                 -- 상품명
   cp_title varchar(100) not null,                -- 제목
   cp_content text not null,                        -- 내용
   cp_score float default 0,                      -- 평점
   cp_read int default 0,                         -- 조회수
   cp_date datetime default now(),                -- 작성일
   cp_isdel char(1) default 'n',                  -- 삭제여부
   constraint pk_cs_pareview primary key (mi_id, op_code),
   constraint fk_cs_pareview_mi_id foreign key(mi_id) references t_member_info(mi_id),
   constraint fk_cs_pareview_op_code foreign key(op_code) references t_order_painfo(op_code)
);

insert into t_ctgr_city (cc_id, cc_name, cc_img1, cc_img2,cc_img3) values ('JPNOSK', '오사카',  'jpnosk001.jpg', 'jpnosk002.jpg', 'jpnosk003.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1, cc_img2,cc_img3) values ('JPNTYO', '도쿄',  'jpntyo001.jpg', 'jpntyo002.jpg', 'jpntyo003.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1, cc_img2,cc_img3,cc_img4,cc_img5) values ('JPNOKI', '오키나와',  'jpnoka001.jpg', 'jpnoka002.jpg', 'jpnoka003.jpg', 'jpnoka004.jpg', 'jpnoka005.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('THAHKT', '푸켓',  'thahkt001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('THABKK', '방콕', 'phkbkk001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('PHLMPH', '보라카이', 'phlmph001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('PHLCEB', '세부',  'phlceb001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('HKGHKG', '홍콩', 'hkghkg001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('SGPSGP', '홍콩', 'sgpsgp001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('VNMDAD', '다낭', 'vnmdad001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('VNMNHA', '나트랑', 'vnmnha001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('TWNTPE', '타이페이', 'twntpe001.jpg');
insert into t_ctgr_city (cc_id, cc_name, cc_img1) values ('TWNKHH', '가오슝', 'twnkhh001.jpg');

ALTER TABLE `greentour`.`t_package_notice` 
CHANGE COLUMN `pn_insur` `pn_insur` VARCHAR(1000) CHARACTER SET 'utf8mb3' NULL DEFAULT '여행자 보험 가입' ,
CHANGE COLUMN `pn_guide` `pn_guide` VARCHAR(1000) CHARACTER SET 'utf8mb3' NULL DEFAULT '가이드 포함' ,
CHANGE COLUMN `pn_include` `pn_include` VARCHAR(1000) CHARACTER SET 'utf8mb3' NULL DEFAULT '텍스트' ,
CHANGE COLUMN `pn_declude` `pn_declude` VARCHAR(1000) CHARACTER SET 'utf8mb3' NULL DEFAULT '텍스트' ,
CHANGE COLUMN `pn_warning` `pn_warning` VARCHAR(1000) CHARACTER SET 'utf8mb3' NULL DEFAULT '유희사항' ,
CHANGE COLUMN `pn_safe` `pn_safe` VARCHAR(1000) CHARACTER SET 'utf8mb3' NULL DEFAULT '안전사항' ;



