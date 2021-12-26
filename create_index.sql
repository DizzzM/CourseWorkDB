create index questions on theory_questions(question);
create index answer on theory_questions(answer);
create index questionIndex on theory_tests_questions(questionIndex);
create index answerIndex on theory_test_answers(answerIndex);
create index answer on theory_test_answers(answer);
create index finished_studying on students(finished_studying);