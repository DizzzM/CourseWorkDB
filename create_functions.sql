DELIMITER $$

CREATE FUNCTION count_students_by_finishing_studying_and_lecturer(
	lecturerId integer,
    finishedStudying bit(1)
) 
RETURNS integer
DETERMINISTIC
BEGIN
	RETURN (select count(*) from students
join lecturers on lecturers.id = students.lecturer_id
where finished_studying=finishedStudying and lecturers.id = lecturerId);
END$$
DELIMITER ;

DELIMITER $$

CREATE FUNCTION count_students_by_passing_tests_and_lecturer(
	lecturerId integer,
    hasPassed bit
) 
RETURNS integer
DETERMINISTIC
BEGIN
	RETURN (select count(*) from students
join lecturers on lecturers.id = students.lecturer_id
join total_results on students.id = total_results.StudentId
where Passed=hasPassed and lecturers.id = lecturerId);
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION count_students_by_lecturer(
	lecturerId integer
) 
RETURNS integer
DETERMINISTIC
BEGIN
	RETURN (select count(*) from students
join lecturers on lecturers.id = students.lecturer_id
where lecturers.id = lecturerId);
END$$
DELIMITER ;

DELIMITER $$

CREATE FUNCTION count_students_by_finishing_studying_and_instructor(
	instructorId integer,
    finishedStudying bit(1)
) 
RETURNS integer
DETERMINISTIC
BEGIN
	RETURN (select count(*) from students
join instructors on instructors.id = students.instructor_id
where finished_studying=finishedStudying and instructors.id = instructorId);
END$$
DELIMITER ;

DELIMITER $$

CREATE FUNCTION count_students_by_passing_tests_and_instructor(
	instructorId integer,
    hasPassed bit
) 
RETURNS integer
DETERMINISTIC
BEGIN
	RETURN (select count(*) from students
join instructors on instructors.id = students.instructor_id
join total_results on students.id = total_results.StudentId
where Passed=hasPassed and instructors.id = instructorId);
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION count_students_by_instructor(
	instructorId integer
) 
RETURNS integer
DETERMINISTIC
BEGIN
	RETURN (select count(*) from students
join instructors on instructors.id = students.instructor_id
where instructors.id = instructorId);
END$$
DELIMITER ;