create user 'student'@'localhost' identified by 'student123';
grant select on driving_school.* to 'student'@'localhost';

create user 'lecturer'@'localhost' identified by 'lecturer123';
grant select on driving_school.* to 'lecturer'@'localhost';
grant insert on driving_school.theory_questions to 'lecturer'@'localhost';
grant insert on driving_school.theory_test_answers to 'lecturer'@'localhost';
grant insert on driving_school.theory_test_results to 'lecturer'@'localhost';
grant insert on driving_school.theory_tests_questions to 'lecturer'@'localhost';

create user 'instructor'@'localhost' identified by 'instructor123';
grant select on driving_school.* to 'instructor'@'localhost';
grant insert on driving_school.driving_licences to 'instructor'@'localhost';
grant insert on driving_school.driving_test_results to 'instructor'@'localhost';

create user 'admin'@'localhost' identified by 'admin123';
grant all privileges on driving_school.* to 'admin'@'localhost';