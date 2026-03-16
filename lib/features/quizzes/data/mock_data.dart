import 'package:sams_app/features/quizzes/data/model/data_models/all_submission_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';

import 'package:sams_app/features/quizzes/data/model/data_models/question/question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/choice_question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/written_question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/option_model.dart';

//! get all Quizes
List<QuizModel> mockQuizzes = [
  // 1. UPCOMING QUIZ (Starts in 2 days)
  QuizModel(
    id: 'q_upcoming_02',
    title: 'Quiz 2: Advanced Queries',
    description:
        'Chapter 3: Joins, subqueries, and indexing strategie Joins, subqueries, and indexing strategies.s.',
    startTime: DateTime.now().add(const Duration(days: 2)),
    endTime: DateTime.now().add(const Duration(days: 2, hours: 2)),
    totalTime: 45,
    totalScore: 50,
    numberOfQuestions: 15,
    isPublished: true,
  ),

  // 2. ACTIVE QUIZ (Started 2 hours ago, ends tomorrow)
  QuizModel(
    id: 'q_active_01',
    title: 'Quiz 1: Database Fundamentals',
    description: 'Chapter 2: Relational models, normalization, and SQL basics.',
    startTime: DateTime.now().subtract(const Duration(hours: 2)),
    endTime: DateTime.now().add(const Duration(hours: 24)),
    totalTime: 60,
    totalScore: 100,
    numberOfQuestions: 20,
    isPublished: true,
  ),

  QuizModel(
    id: 'q_edge_04',
    title: 'Pop Quiz: ER Diagrams',
    description: null, // Testing your null safety!
    startTime: DateTime.now().subtract(const Duration(minutes: 30)),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    totalTime: 15,
    totalScore: 10,
    numberOfQuestions: 5,
    isPublished: true,
  ),

  // 3. ENDED QUIZ (Ended yesterday)
  QuizModel(
    id: 'q_ended_03',
    title: 'Quiz 0: Intro to Systems',
    description: 'Chapter 1: Overview of database management systems.',
    startTime: DateTime.now().subtract(const Duration(days: 2)),
    endTime: DateTime.now().subtract(const Duration(days: 1)),
    totalTime: 30,
    totalScore: 20,
    numberOfQuestions: 10,
    isPublished: true,
  ),
];

//! get Questions
final List<QuestionModel> mockQuestions = [
  // 1. MCQ Question (Matching your screenshot)
  const ChoiceQuestionModel(
    id: 'q1',
    text: 'What is the full form of DBMS?',
    questionType: 'mcq',
    timeLimit: 60,
    points: 1,
    options: [
      OptionModel(id: 'o1', text: 'Data of Binary Management System.'),
      OptionModel(id: 'o2', text: 'Database Management System.'),
      OptionModel(id: 'o3', text: 'Database Management Service.'),
      OptionModel(id: 'o4', text: 'Data Backup Management System.'),
    ],
  ),

  // 2. True/False Question
  const ChoiceQuestionModel(
    id: 'q2',
    text: 'SQL stands for Structured Question Language.',
    questionType: 'trueFalse',
    timeLimit: 30,
    points: 1,
    options: [
      OptionModel(id: 't1', text: 'True'),
      OptionModel(id: 't2', text: 'False'),
    ],
  ),

  // 3. Written Question
  const WrittenQuestionModel(
    id: 'q3',
    text: 'Explain the concept of First Normal Form (1NF) in your own words.',
    questionType: 'written',
    timeLimit: 120,
    points: 5,
  ),
];

//! get All Submission

final List<AllSubmissionModel> mockSubmissions = [
  AllSubmissionModel(
    id: 'sub_1',
    quizId: 'q1',
    academicId: '20113564',
    studentName: 'Monica Maged Awad',
    score: 10,
    submittedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    isGraded: true,
  ),
  AllSubmissionModel(
    id: 'sub_2',
    quizId: 'q1',
    academicId: '20113565',
    studentName: 'Yomna Abdelmegeed',
    score: 8,
    submittedAt: DateTime.now().subtract(const Duration(hours: 1)),
    isGraded: true,
  ),
  AllSubmissionModel(
    id: 'sub_3',
    quizId: 'q1',
    academicId: '20113566',
    studentName: 'Mohamed Ibrahim',
    score: 0,
    submittedAt: DateTime.now().subtract(const Duration(minutes: 5)),
    isGraded: false,
  ),
];
