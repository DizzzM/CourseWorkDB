CREATE TABLE `cars` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `transmission` varchar(50) NOT NULL,
  `power` int NOT NULL,
  `production_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  CONSTRAINT `cars_chk_1` CHECK (((`transmission` = _utf8mb4'manual') or (`transmission` = _utf8mb4'automatic'))),
  CONSTRAINT `cars_chk_2` CHECK ((`power` > 0))
);

CREATE TABLE `driving_licences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `category` varchar(3) NOT NULL,
  `valid_until` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `driving_licences_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `driving_licences_chk_1` CHECK (((`category` = _utf8mb4'A1') or (`category` = _utf8mb4'A') or (`category` = _utf8mb4'B1') or (`category` = _utf8mb4'B') or (`category` = _utf8mb4'C1') or (`category` = _utf8mb4'C') or (`category` = _utf8mb4'D1') or (`category` = _utf8mb4'D') or (`category` = _utf8mb4'C1E') or (`category` = _utf8mb4'BE') or (`category` = _utf8mb4'CE') or (`category` = _utf8mb4'D1E') or (`category` = _utf8mb4'DE') or (`category` = _utf8mb4'T1') or (`category` = _utf8mb4'T2')))
);

CREATE TABLE `driving_test_results` (
  `id` int NOT NULL,
  `task1` int NOT NULL,
  `task2` int NOT NULL,
  `task3` int NOT NULL,
  `task4` int NOT NULL,
  `task5` int NOT NULL,
  `task6` int NOT NULL,
  `task7` int NOT NULL,
  `task8` int NOT NULL,
  `task9` int NOT NULL,
  `task10` int NOT NULL,
  `task11` int NOT NULL,
  `task12` int NOT NULL,
  `task13` int NOT NULL,
  `task14` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `driving_test_results_chk_1` CHECK (((`task1` >= 0) and (`task1` <= 2))),
  CONSTRAINT `driving_test_results_chk_10` CHECK (((`task10` >= 0) and (`task10` <= 4))),
  CONSTRAINT `driving_test_results_chk_11` CHECK (((`task11` >= 0) and (`task11` <= 6))),
  CONSTRAINT `driving_test_results_chk_12` CHECK (((`task12` >= 0) and (`task12` <= 4))),
  CONSTRAINT `driving_test_results_chk_13` CHECK (((`task13` >= 0) and (`task13` <= 6))),
  CONSTRAINT `driving_test_results_chk_14` CHECK (((`task14` >= 0) and (`task14` <= 5))),
  CONSTRAINT `driving_test_results_chk_2` CHECK (((`task2` >= 0) and (`task2` <= 2))),
  CONSTRAINT `driving_test_results_chk_3` CHECK (((`task3` >= 0) and (`task3` <= 2))),
  CONSTRAINT `driving_test_results_chk_4` CHECK (((`task4` >= 0) and (`task4` <= 4))),
  CONSTRAINT `driving_test_results_chk_5` CHECK (((`task5` >= 0) and (`task5` <= 2))),
  CONSTRAINT `driving_test_results_chk_6` CHECK (((`task6` >= 0) and (`task6` <= 2))),
  CONSTRAINT `driving_test_results_chk_7` CHECK (((`task7` >= 0) and (`task7` <= 4))),
  CONSTRAINT `driving_test_results_chk_8` CHECK (((`task8` >= 0) and (`task8` <= 2))),
  CONSTRAINT `driving_test_results_chk_9` CHECK (((`task9` >= 0) and (`task9` <= 8)))
);

CREATE TABLE `instructors` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `instructors_chk_1` CHECK ((`email` like _utf8mb4'%@%.%'))
);

CREATE TABLE `lecturers` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `email` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `lecturers_chk_1` CHECK ((`email` like _utf8mb4'%@%.%'))
);

CREATE TABLE `students` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `lecturer_id` int NOT NULL,
  `instructor_id` int NOT NULL,
  `car_id` int NOT NULL,
  `finished_studying` bit(1) NOT NULL,
  `phone_number` varchar(12) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `category` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `lecturer_id` (`lecturer_id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `car_id` (`car_id`),
  KEY `finished_studying` (`finished_studying`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`id`),
  CONSTRAINT `students_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`),
  CONSTRAINT `students_ibfk_3` FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`),
  CONSTRAINT `students_chk_1` CHECK (((`category` = _utf8mb4'A1') or (`category` = _utf8mb4'A') or (`category` = _utf8mb4'B1') or (`category` = _utf8mb4'B') or (`category` = _utf8mb4'C1') or (`category` = _utf8mb4'C') or (`category` = _utf8mb4'D1') or (`category` = _utf8mb4'D') or (`category` = _utf8mb4'C1E') or (`category` = _utf8mb4'BE') or (`category` = _utf8mb4'CE') or (`category` = _utf8mb4'D1E') or (`category` = _utf8mb4'DE') or (`category` = _utf8mb4'T1') or (`category` = _utf8mb4'T2')))
);

CREATE TABLE `test_results` (
  `id` int NOT NULL,
  `student_id` int NOT NULL,
  `theory_result_id` int NOT NULL,
  `driving_result_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `theory_result_id` (`theory_result_id`),
  KEY `driving_result_id` (`driving_result_id`),
  CONSTRAINT `test_results_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `test_results_ibfk_2` FOREIGN KEY (`theory_result_id`) REFERENCES `theory_test_results` (`id`),
  CONSTRAINT `test_results_ibfk_3` FOREIGN KEY (`driving_result_id`) REFERENCES `driving_test_results` (`id`)
);

CREATE TABLE `theory_questions` (
  `id` int NOT NULL,
  `question` varchar(200) NOT NULL,
  `answer` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer` (`answer`),
  KEY `questions` (`question`)
);

CREATE TABLE `theory_test_answers` (
  `id` int NOT NULL,
  `answers_id` int NOT NULL,
  `answer` varchar(1) DEFAULT NULL,
  `answerIndex` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answers_id` (`answers_id`),
  KEY `answerIndex` (`answerIndex`),
  KEY `answer` (`answer`),
  CONSTRAINT `theory_test_answers_ibfk_1` FOREIGN KEY (`answers_id`) REFERENCES `theory_test_results` (`answers_id`),
  CONSTRAINT `theory_test_answers_chk_1` CHECK (((`answer` = _utf8mb4'a') or (`answer` = _utf8mb4'b') or (`answer` = _utf8mb4'c') or (`answer` = _utf8mb4'd')))
);

CREATE TABLE `theory_test_results` (
  `id` int NOT NULL,
  `test_id` int NOT NULL,
  `answers_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `answers_id` (`answers_id`),
  KEY `theory_test_results_ibfk_1_idx` (`test_id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `theory_test_results_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `theory_tests_questions` (`test_id`)
);

CREATE TABLE `theory_tests_questions` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  `test_id` int NOT NULL,
  `questionIndex` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  KEY `theory_tests_questions_ibfk_2_idx` (`test_id`),
  KEY `questionIndex` (`questionIndex`),
  CONSTRAINT `theory_tests_questions_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `theory_questions` (`id`)
);