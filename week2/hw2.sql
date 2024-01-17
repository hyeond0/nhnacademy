CREATE TABLE IF NOT EXISTS `nhn_week2`.`location`
(
    `location_id` INT          NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(100) NOT NULL,
    PRIMARY KEY (`location_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 5
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nhn_week2`.`person`
(
    `person_id`       INT         NOT NULL AUTO_INCREMENT,
    `resident_number` VARCHAR(15) NOT NULL,
    `name`            VARCHAR(10) NOT NULL,
    `gender`          VARCHAR(1)  NOT NULL,
    `email`           VARCHAR(50) NULL DEFAULT NULL,
    `phone_number`    VARCHAR(20) NULL DEFAULT NULL,
    PRIMARY KEY (`person_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 24
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`address`
(
    `address_id`  INT         NOT NULL AUTO_INCREMENT,
    `person_id`   INT         NOT NULL,
    `location_id` INT         NOT NULL,
    `report_date` VARCHAR(30) NOT NULL,
    `state`       VARCHAR(45) NOT NULL,
    PRIMARY KEY (`address_id`),
    INDEX `fk_address_person1_idx` (`person_id` ASC) VISIBLE,
    INDEX `fk_address_location1_idx` (`location_id` ASC) VISIBLE,
    CONSTRAINT `fk_address_location1`
        FOREIGN KEY (`location_id`)
            REFERENCES `nhn_week2`.`location` (`location_id`),
    CONSTRAINT `fk_address_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 7
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`birth`
(
    `person_id`      INT         NOT NULL,
    `birth_date`     VARCHAR(20) NOT NULL,
    `birth_place`    VARCHAR(50) NOT NULL,
    `birth_datetime` DATETIME    NOT NULL,
    UNIQUE INDEX `person_id` (`person_id` ASC) VISIBLE,
    INDEX `fk_birth_person1_idx` (`person_id` ASC) VISIBLE,
    CONSTRAINT `fk_birth_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`reporter`
(
    `reporter_id`     INT         NOT NULL AUTO_INCREMENT,
    `name`            VARCHAR(50) NOT NULL,
    `resident_number` VARCHAR(20) NOT NULL,
    `eligibility`     VARCHAR(10) NOT NULL,
    `email`           VARCHAR(30) NULL DEFAULT NULL,
    `phone_number`    VARCHAR(20) NULL DEFAULT NULL,
    PRIMARY KEY (`reporter_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 4
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nhn_week2`.`certificate`
(
    `certificate_id` INT        NOT NULL AUTO_INCREMENT,
    `issued_at`      DATE       NOT NULL,
    `type`           VARCHAR(5) NOT NULL,
    `person_id`      INT        NOT NULL,
    `reporter_id`    INT        NOT NULL,
    PRIMARY KEY (`certificate_id`),
    INDEX `fk_death_certificate_person1_idx` (`person_id` ASC) VISIBLE,
    INDEX `fk_death_certificate_reporter1_idx` (`reporter_id` ASC) VISIBLE,
    CONSTRAINT `fk_death_certificate_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`),
    CONSTRAINT `fk_death_certificate_reporter1`
        FOREIGN KEY (`reporter_id`)
            REFERENCES `nhn_week2`.`reporter` (`reporter_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `nhn_week2`.`death`
(
    `person_id`   INT         NOT NULL,
    `death_date`  DATETIME    NOT NULL,
    `death_place` VARCHAR(45) NOT NULL,
    `death_type`  VARCHAR(10) NOT NULL,
    UNIQUE INDEX `person_id` (`person_id` ASC) VISIBLE,
    INDEX `fk_death_person1_idx` (`person_id` ASC) VISIBLE,
    CONSTRAINT `fk_death_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`family`
(
    `family_id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`family_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 3
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`family_certificate`
(
    `family_certificate_id` INT         NOT NULL AUTO_INCREMENT,
    `confirmation_number`   VARCHAR(20) NOT NULL,
    `issued_at`             DATE        NOT NULL,
    `person_id`             INT         NOT NULL,
    PRIMARY KEY (`family_certificate_id`),
    INDEX `fk_family_certificate_person1_idx` (`person_id` ASC) VISIBLE,
    CONSTRAINT `fk_family_certificate_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 3
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`role_family`
(
    `role_id` INT         NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(10) NOT NULL,
    PRIMARY KEY (`role_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 6
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`family_relation`
(
    `family_relation_id` INT NOT NULL AUTO_INCREMENT,
    `family_id`          INT NOT NULL,
    `my_id`              INT NOT NULL,
    `other_id`           INT NOT NULL,
    `role_id`            INT NOT NULL,
    PRIMARY KEY (`family_relation_id`),
    INDEX `fk_family_relation_family_idx` (`family_id` ASC) VISIBLE,
    INDEX `fk_family_relation_my_id_idx` (`my_id` ASC) VISIBLE,
    INDEX `fk_family_relation_other_id_idx` (`other_id` ASC) VISIBLE,
    INDEX `fk_family_relation_role_idx` (`role_id` ASC) VISIBLE,
    CONSTRAINT `fk_family_relation_family`
        FOREIGN KEY (`family_id`)
            REFERENCES `nhn_week2`.`family` (`family_id`),
    CONSTRAINT `fk_family_relation_my_id`
        FOREIGN KEY (`my_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`),
    CONSTRAINT `fk_family_relation_other_id`
        FOREIGN KEY (`other_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`),
    CONSTRAINT `fk_family_relation_role`
        FOREIGN KEY (`role_id`)
            REFERENCES `nhn_week2`.`role_family` (`role_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 14
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `nhn_week2`.`house_info`
(
    `person_id`     INT         NOT NULL,
    `report_date`   DATE        NOT NULL,
    `change_reason` VARCHAR(20) NOT NULL,
    INDEX `fk_household_info_person1_idx` (`person_id` ASC) VISIBLE,
    CONSTRAINT `fk_household_info_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`household`
(
    `household_id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`household_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 3
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS `nhn_week2`.`role_resident`
(
    `role_id` INT         NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(20) NOT NULL,
    PRIMARY KEY (`role_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 5
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `nhn_week2`.`household_relation`
(
    `household_relation_id` INT NOT NULL AUTO_INCREMENT,
    `household_id`          INT NOT NULL,
    `my_id`                 INT NOT NULL,
    `other_id`              INT NOT NULL,
    `role_id`               INT NOT NULL,
    PRIMARY KEY (`household_relation_id`),
    INDEX `fk_household_relation_household1_idx` (`household_id` ASC) VISIBLE,
    INDEX `fk_household_relation_person1_idx` (`my_id` ASC) VISIBLE,
    INDEX `fk_household_relation_person2_idx` (`other_id` ASC) VISIBLE,
    INDEX `fk_household_relation_role` (`role_id` ASC) VISIBLE,
    CONSTRAINT `fk_household_relation_household1`
        FOREIGN KEY (`household_id`)
            REFERENCES `nhn_week2`.`household` (`household_id`),
    CONSTRAINT `fk_household_relation_person1`
        FOREIGN KEY (`my_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`),
    CONSTRAINT `fk_household_relation_person2`
        FOREIGN KEY (`other_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`),
    CONSTRAINT `fk_household_relation_role`
        FOREIGN KEY (`role_id`)
            REFERENCES `nhn_week2`.`role_resident` (`role_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 9
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `nhn_week2`.`resident_registration`
(
    `resident_registration_id` INT         NOT NULL AUTO_INCREMENT,
    `confirmation_number`      VARCHAR(45) NOT NULL,
    `issued_at`                DATE        NOT NULL,
    `person_id`                INT         NOT NULL,
    PRIMARY KEY (`resident_registration_id`),
    INDEX `fk_resident_registration_person1_idx` (`person_id` ASC) VISIBLE,
    CONSTRAINT `fk_resident_registration_person1`
        FOREIGN KEY (`person_id`)
            REFERENCES `nhn_week2`.`person` (`person_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 3
    DEFAULT CHARACTER SET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;


# 주민등록번호 상단 조회영역
select issued_at 발급일, confirmation_number 증명서확인번호, name 세대주, report_date 세대구성일자, change_reason 세대구성사유
from resident_registration r
         join person p on r.person_id = p.person_id
         join house_info hi on p.person_id = hi.person_id
where p.person_id = 4;
# 전입주소 조회영역
select state 상태, l.name 주소, report_date 신고일
from location l
         join address a on l.location_id = a.location_id
         join person p on a.person_id = p.person_id
where p.person_id = 4;
### 세대구성원 조회영역
SELECT r.name                  세대주관계,
       p_other.name            성명,
       p_other.resident_number 주민등록번호,
       hi_other.report_date    신고일,
       hi_other.change_reason  변동사유
FROM person p
         join household_relation hr on p.person_id = hr.my_id
         join house_info hi on p.person_id = hi.person_id
         join household h on hr.household_id = h.household_id
         join person p_other on hr.other_id = p_other.person_id
         join house_info hi_other on p_other.person_id = hi_other.person_id
         join role_resident r on hr.role_id = r.role_id
WHERE p.person_id = 1
order by r.role_id;
# 가족관계증명서 상단 조회영역
select issued_at 발급일, confirmation_number 증명서확인번호, l.name 등록기준지
from family_certificate hr
         join person p on hr.person_id = p.person_id
         join address a on p.person_id = a.person_id
         join location l on a.location_id = l.location_id
where p.person_id = 4;
# 가족구성원 조회영역
select rf.name                 관계,
       p_other.name            이름,
       b_other.birth_date      출생년월일,
       p_other.resident_number 주민등록번호,
       p_other.gender          성별
from person p
         join birth b on p.person_id = b.person_id
         join family_relation fr on p.person_id = fr.my_id
         join family f on fr.family_id = f.family_id
         join person p_other on p_other.person_id = fr.other_id
         join birth b_other on p_other.person_id = b_other.person_id
         join role_family rf on fr.role_id = rf.role_id
where p.person_id = 1
order by rf.role_id;