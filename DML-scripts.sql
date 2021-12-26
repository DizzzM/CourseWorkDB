-- 1.show theory test result of specific student

select theory_test_answers.answerIndex Number, theory_questions.question Question, theory_questions.answer CorrectAnswer, theory_test_answers.answer Answer from test_results
join theory_test_results on theory_test_results.id = test_results.theory_result_id
join theory_test_answers on theory_test_results.answers_id=theory_test_answers.answers_id
join theory_tests_questions on theory_test_results.test_id = theory_tests_questions.test_id
join theory_questions on theory_questions.id = theory_tests_questions.question_id
where test_results.student_id = 8 and theory_tests_questions.questionIndex = theory_test_answers.answerIndex;

-- 2.show driving test result of specific student

select driving_test_results.id DrivingId, test_results.student_id StudentId, students.name StudentName, (driving_test_results.task1+driving_test_results.task2+driving_test_results.task3+driving_test_results.task4+driving_test_results.task5+driving_test_results.task6+driving_test_results.task7+driving_test_results.task8+driving_test_results.task9+driving_test_results.task10+driving_test_results.task11+driving_test_results.task12+driving_test_results.task13+driving_test_results.task14) DrivingScore 
from test_results
join driving_test_results on driving_test_results.id = test_results.driving_result_id
join students on test_results.student_id = students.id 
where test_results.student_id = 8;

-- 3.show students` total info 

select students.id StudentId, students.name StudentName, students.phone_number StudentPhone, students.email StudentEmail, instructors.name Instructor, lecturers.name Lecturer, cars.name Car, students.finished_studying from students
join instructors on instructors.id = students.instructor_id
join lecturers on lecturers.id = students.lecturer_id
join cars on cars.id = students.car_id
order by students.id;

-- 4.how many students each instructor teaches

select instructors.id InstructorId, instructors.name InstructorName, count(*) CountStudents from students
join instructors on instructors.id = students.instructor_id
group by instructors.id;

-- 5.how many students each lecturer teaches

select lecturers.id LecturerId, lecturers.name LecturerName, count(*) CountStudents from students
join lecturers on lecturers.id = students.lecturer_id
group by lecturers.id;

-- 6.how many students drive the same car

select cars.id CarId, cars.name CarName, count(*) CountStudents from students
join cars on cars.id = students.car_id
group by cars.id;

-- 7.stats of each lecturer

select lecturers.id LecturerId, lecturers.name LecturerName,
(count_students_by_finishing_studying_and_lecturer(lecturers.id, 0)) Studying,
(count_students_by_passing_tests_and_lecturer(lecturers.id, 1)) Passed,
(count_students_by_passing_tests_and_lecturer(lecturers.id, 0)) NotPassed,
(count_students_by_lecturer(lecturers.id)-count_students_by_finishing_studying_and_lecturer(lecturers.id, 0)-count_students_by_passing_tests_and_lecturer(lecturers.id, 1)-count_students_by_passing_tests_and_lecturer(lecturers.id, 0)) WithoutTestYet
from lecturers;

-- 8.stats of each instructor

select instructors.id InstructorId, instructors.name InstructorName,
(count_students_by_finishing_studying_and_instructor(instructors.id, 0)) Studying,
(count_students_by_passing_tests_and_instructor(instructors.id, 1)) Passed,
(count_students_by_passing_tests_and_instructor(instructors.id, 0)) NotPassed,
(count_students_by_instructor(instructors.id)-count_students_by_finishing_studying_and_instructor(instructors.id, 0)-count_students_by_passing_tests_and_instructor(instructors.id, 1)-count_students_by_passing_tests_and_instructor(instructors.id, 0)) WithoutTestYet
from instructors;

-- 9.show students who didn`t passed

select students.id StudentId, students.name, lecturers.name Lecturer, instructors.name Instructor, total_results.TotalScore TotalScore from students
join total_results on students.id = total_results.StudentId
join instructors on instructors.id = students.instructor_id
join lecturers on lecturers.id = students.lecturer_id
where total_results.Passed = 0
order by TotalScore desc;

-- 10.show students who passed

select students.id StudentId, students.name, lecturers.name Lecturer, instructors.name Instructor, total_results.TotalScore TotalScore from students
join total_results on students.id = total_results.StudentId
join instructors on instructors.id = students.instructor_id
join lecturers on lecturers.id = students.lecturer_id
where total_results.Passed = 1
order by TotalScore desc;

-- 11.show students with licence

select students.id StudentId, students.name, lecturers.name Lecturer, instructors.name Instructor, driving_licences.id LicenceId, driving_licences.category Category, driving_licences.valid_until ValidUntil from students
join driving_licences on driving_licences.student_id=students.id
join instructors on instructors.id = students.instructor_id
join lecturers on lecturers.id = students.lecturer_id;

-- 12.shop 10 best students in theory, who didn`t passed

select students.id StudentId, students.name StudentName,total_results.TheoryScore from students
join total_results on total_results.StudentId = students.id
where total_results.Passed = 0
order by total_results.TheoryScore desc
limit 10;

-- 13.shop 10 best students in driving, who didn`t passed

select students.id StudentId, students.name StudentName,total_results.DrivingScore from students
join total_results on total_results.StudentId = students.id
where total_results.Passed = 0
order by total_results.DrivingScore desc
limit 10;

-- 14.the hardest 10 theory tests

select distinct(theory_result_id) TestId, theory_results.TheoryScore Score from test_results
join theory_results on theory_results.StudentId = test_results.student_id
order by Score
limit 10;

-- 15.show students who drive on cars with manual transmission
select students.id StudentId, students.name StudentName, cars.id CarId, cars.name CarName from students
join cars on cars.id = students.car_id
where cars.transmission = 'manual'
order by StudentId;

-- 16.show students who drive on cars with power higher than 100

select students.id StudentId, students.name StudentName, cars.id CarId, cars.name CarName from students
join cars on cars.id = students.car_id
where cars.power > 100
order by StudentId;

-- 17.show students who drive on cars which do not start with letter M
select students.id StudentId, students.name StudentName, cars.id CarId, cars.name CarName from students
join cars on cars.id = students.car_id
where not cars.name regexp('^(M)')
order by StudentId;

-- 18.show students who drive on cars which do not contain letter G
select students.id StudentId, students.name StudentName, cars.id CarId, cars.name CarName from students
join cars on cars.id = students.car_id
where not lower(cars.name) regexp('([a-z]*)(g[a-z]*)+')
order by StudentId;

-- 19.show averege score for theory test of students from each lecturer
select lecturers.id LecturerId, lecturers.name LecturerName, (select avg(theory_results.TheoryScore) from theory_results join students on students.id=theory_results.StudentId where students.lecturer_id=LecturerId) AverageScore from students
join lecturers on lecturers.id = students.lecturer_id
group by lecturers.id
order by AverageScore desc;

-- 20.show averege score for driving test of students from each instructor
select instructors.id InstructorId, instructors.name LecturerName, (select avg(theory_results.TheoryScore) from theory_results join students on students.id=theory_results.StudentId where students.instructor_id=InstructorId) AverageScore from students
join instructors on instructors.id = students.instructor_id
group by instructors.id
order by AverageScore desc;