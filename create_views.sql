-- show all students` theory scores
create view theory_results as
select test_results.student_id StudentId, students.name StudentName, count(*) TheoryScore from test_results
join theory_test_results on theory_test_results.id = test_results.theory_result_id
join theory_test_answers on theory_test_results.answers_id=theory_test_answers.answers_id
join theory_tests_questions on theory_test_results.test_id = theory_tests_questions.test_id
join theory_questions on theory_questions.id = theory_tests_questions.question_id
join students on test_results.student_id = students.id
where theory_tests_questions.questionIndex = theory_test_answers.answerIndex and theory_questions.answer=theory_test_answers.answer group by test_results.student_id order by StudentId;

select * from theory_results;

-- show all students` driving scores
create view driving_results as
select test_results.student_id StudentId, students.name StudentName, (driving_test_results.task1+driving_test_results.task2+driving_test_results.task3+driving_test_results.task4+driving_test_results.task5+driving_test_results.task6+driving_test_results.task7+driving_test_results.task8+driving_test_results.task9+driving_test_results.task10+driving_test_results.task11+driving_test_results.task12+driving_test_results.task13+driving_test_results.task14) DrivingScore 
from test_results
join driving_test_results on driving_test_results.id = test_results.driving_result_id
join students on test_results.student_id = students.id order by StudentId;

select * from driving_results;

-- show all students` total scores
create view total_results as
select theory_results.StudentId, theory_results.StudentName, theory_results.TheoryScore, driving_results.DrivingScore, (theory_results.TheoryScore+driving_results.DrivingScore) TotalScore, if(theory_results.TheoryScore>17 and driving_results.DrivingScore>50, 1, 0) Passed  from theory_results
join driving_results on theory_results.StudentId = driving_results.StudentId order by TotalScore desc;

select * from total_results;