DELIMITER $$
CREATE PROCEDURE `validate_phone_number`(in phone_number varchar(12))
BEGIN
	if (phone_number regexp '^(380)(([679]3)|(66)|(99)|(96)|([69]8))[0-9]{7}')=0
	then signal sqlstate '45000';
	end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `validate_email`(in email varchar(25))
BEGIN
	if (email regexp '^([a-z]{8,15})(\@gmail\.com)$')=0
	then signal sqlstate '45000';
	end if;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `validate_studying_finish`(in studentId integer)
BEGIN
	if(select students.finished_studying from students where students.id = studentId ) = 0
	then signal sqlstate '45000';
	end if;
END$$
DELIMITER ;