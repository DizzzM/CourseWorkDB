-- if student finished studying
delimiter |
create trigger validate_driving_licence
before insert on driving_licences
for each row 
begin
	call validate_studying_finish(new.student_id);
	if(select total_results.Passed from total_results where total_results.StudentId = new.student_id) = 0
	then signal sqlstate '45000';
	end if;
end;

-- if driving licence expires any day after today
delimiter |
create trigger validate_driving_licence_expiration_time
before insert on driving_licences
for each row 
begin
	if new.valid_until<curdate()
	then signal sqlstate '45000';
	end if;
end;

-- if student finished studying
delimiter |
create trigger validate_test_results
before insert on test_results
for each row 
begin
	call validate_studying_finish(new.student_id);
end;

-- check for question duplicates in test
delimiter |
create trigger validate_adding_test_questions
before insert on theory_tests_questions
for each row
begin
	if exists(select * from theory_tests_questions where theory_tests_questions.question_id = new.question_id and theory_tests_questions.test_id=new.test_id)
	then signal sqlstate '45000';
	end if;
end;

-- check for questionIndex duplicates in test
delimiter |
create trigger validate_adding_test_questions_by_index
before insert on theory_tests_questions
for each row
begin
	if exists(select * from theory_tests_questions where theory_tests_questions.questionIndex = new.questionIndex and theory_tests_questions.test_id=new.test_id)
	then signal sqlstate '45000';
	end if;
end;

-- check for answerIndex duplicates in test
delimiter |
create trigger validate_adding_test_answers_by_index
before insert on theory_test_answers
for each row
begin
	if exists(select * from theory_test_answers where theory_test_answers.answerIndex = new.answerIndex and theory_test_answers.answers_id=new.answers_id)
	then signal sqlstate '45000';
	end if;
end;

-- check number of questions in test <=20
delimiter |
create trigger validate_adding_test_by_count
before insert on theory_tests_questions
for each row
begin
	if (select count(*) count from theory_tests_questions where theory_tests_questions.test_id=new.test_id)=20
	then signal sqlstate '45000';
	end if;
end;

-- check number of answers in test <=20
delimiter |
create trigger validate_adding_test_answers_by_count
before insert on theory_test_answers
for each row
begin
	if (select count(*) count from theory_test_answers where theory_test_answers.answers_id=new.answers_id)=20
	then signal sqlstate '45000';
	end if;
end;

-- if instructor phone number is like regex
delimiter |
create trigger validate_instructors_phone_number_on_insert
before insert on instructors
for each row
begin
	call validate_phone_number(new.phone_number);
end;

delimiter |
create trigger validate_instructors_phone_number_on_update
before update on instructors
for each row
begin
	call validate_phone_number(new.phone_number);
end;

-- if instructor email is like regex
delimiter |
create trigger validate_instructors_email_on_insert
before insert on instructors
for each row
begin
	call validate_email(new.email);
end;

delimiter |
create trigger validate_instructors_email_on_update
before update on instructors
for each row
begin
	call validate_email(new.email);
end;

-- if student phone number is like regex
delimiter |
create trigger validate_students_phone_number_on_insert
before insert on students
for each row
begin
	call validate_phone_number(new.phone_number);
end;

delimiter |
create trigger validate_students_phone_number_on_update
before update on students
for each row
begin
	call validate_phone_number(new.phone_number);
end;

-- if student email is like regex
delimiter |
create trigger validate_students_email_on_insert
before insert on students
for each row
begin
	call validate_email(new.email);
end;

delimiter |
create trigger validate_students_email_on_update
before update on students
for each row
begin
	call validate_email(new.email);
end;

-- if lecturer phone number is like regex
delimiter |
create trigger validate_lecturers_phone_number_on_insert
before insert on lecturers
for each row
begin
	call validate_phone_number(new.phone_number);
end;

delimiter |
create trigger validate_lecturers_phone_number_on_update
before update on lecturers
for each row
begin
	call validate_phone_number(new.phone_number);
end;

-- if lecturer email is like regex
delimiter |
create trigger validate_lecturers_email_on_insert
before insert on lecturers
for each row
begin
	call validate_email(new.email);
end;

delimiter |
create trigger validate_lecturers_email_on_update
before update on lecturers
for each row
begin
	call validate_email(new.email);
end;

-- after insert to test results, if student passed test automatically add new record to driving_licences
delimiter |
create trigger auto_add_driving_licence
after insert on test_results
for each row 
begin
	if(select total_results.Passed from total_results where total_results.StudentId = new.student_id) = 1
	then Insert Into driving_licences (student_id, category, valid_until) Values (new.student_id, (select category from students where id = new.student_id), date_add(curdate(), interval 30 year));
	end if;
end;