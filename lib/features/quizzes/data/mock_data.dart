import 'package:sams_app/features/quizzes/data/model/data_models/all_submission_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/quiz_model.dart';

import 'package:sams_app/features/quizzes/data/model/data_models/question/question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/choice_question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/written_question_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/question/option_model.dart';
import 'package:sams_app/features/quizzes/data/model/data_models/submission_details_model.dart';

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
    totalPoints: 15,
    submittedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    isGraded: true,
  ),
  AllSubmissionModel(
    id: 'sub_2',
    quizId: 'q1',
    academicId: '20113565',
    studentName: 'Yomna Abdelmegeed',
    score: 8,
    totalPoints: 15,
    submittedAt: DateTime.now().subtract(const Duration(hours: 1)),
    isGraded: true,
  ),
  AllSubmissionModel(
    id: 'sub_3',
    quizId: 'q1',
    academicId: '20113566',
    studentName: 'Mohamed Ibrahim',
    score: 0,
    totalPoints: 15,
    submittedAt: DateTime.now().subtract(const Duration(minutes: 5)),
    isGraded: false,
  ),

  // AllSubmissionModel(
  //   id: 'sub_4',
  //   quizId: 'q1',
  //   academicId: '20113567',
  //   studentName: 'Ahmed Hassan',
  //   score: 9,
  //   submittedAt: DateTime.now().subtract(const Duration(minutes: 30)),
  //   isGraded: true,
  // ),

  // AllSubmissionModel(
  //   id: 'sub_5',
  //   quizId: 'q1',
  //   academicId: '20113568',
  //   studentName: 'Sara Ali',
  //   score: 6,
  //   submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
  //   isGraded: true,
  // ),

  // AllSubmissionModel(
  //   id: 'sub_6',
  //   quizId: 'q1',
  //   academicId: '20113569',
  //   studentName: 'Omar Khaled',
  //   score: 0,
  //   submittedAt: DateTime.now().subtract(const Duration(minutes: 10)),
  //   isGraded: false,
  // ),

  // AllSubmissionModel(
  //   id: 'sub_7',
  //   quizId: 'q1',
  //   academicId: '20113570',
  //   studentName: 'Nour ElDin',
  //   score: 10,
  //   submittedAt: DateTime.now().subtract(const Duration(hours: 3)),
  //   isGraded: true,
  // ),

  // AllSubmissionModel(
  //   id: 'sub_8',
  //   quizId: 'q1',
  //   academicId: '20113571',
  //   studentName: 'Laila Mahmoud',
  //   score: 3,
  //   submittedAt: DateTime.now().subtract(const Duration(hours: 4)),
  //   isGraded: true,
  // ),

  // AllSubmissionModel(
  //   id: 'sub_9',
  //   quizId: 'q1',
  //   academicId: '20113572',
  //   studentName: 'Hassan Tarek',
  //   score: 0,
  //   submittedAt: DateTime.now().subtract(const Duration(seconds: 30)),
  //   isGraded: false,
  // ),

  // AllSubmissionModel(
  //   id: 'sub_10',
  //   quizId: 'q1',
  //   academicId: '20113573',
  //   studentName: 'Abdelrahman Mohamed Abdelaziz',
  //   score: 7,
  //   submittedAt: DateTime.now().subtract(const Duration(hours: 5)),
  //   isGraded: true,
  // ),
];

//! get Submission Details
//! get Submission Details (30 Mock Questions for testing)
final List<SubmissionDetailsModel> mockSubmissionDetails = [
  // 1-10: Original & Basic Mix
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d94370043b',
    text: "Which HTTP status code means 'Unauthorized'?",
    questionType: 'WRITTEN',
    timeLimit: 60,
    points: 4,
    writtenAnswer: '404 Not Found',
    earnedPoints: 0,
    isCorrect: null,
    isGraded: false,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d94370043c',
    text: "Explain the purpose of Middleware in an Express.js application.",
    questionType: 'WRITTEN',
    timeLimit: 500,
    points: 10,
    writtenAnswer: "I don't know",
    earnedPoints: 0,
    isCorrect: null,
    isGraded: false,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d94370043d',
    text: "What is the difference between final and const in Dart?",
    questionType: 'WRITTEN',
    timeLimit: 60,
    points: 4,
    writtenAnswer: null, // Empty answer test
    earnedPoints: 0,
    isCorrect: false,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d94370043e',
    text: "Which HTTP status code means 'Unauthorized'?",
    questionType: 'MCQ',
    timeLimit: 20,
    points: 2,
    options: [
      AnswerOptionModel(
        id: 'f1',
        text: '401',
        isCorrect: true,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'f2',
        text: '403',
        isCorrect: false,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'f3',
        text: '404',
        isCorrect: false,
        isSelected: true,
      ),
      AnswerOptionModel(
        id: 'f4',
        text: '400',
        isCorrect: false,
        isSelected: false,
      ),
    ],
    selectedOptionId: 'f3',
    earnedPoints: 0,
    isCorrect: false,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d943700443',
    text: "Flutter uses Skia as its primary 2D rendering engine.",
    questionType: 'TRUE_FALSE',
    timeLimit: 30,
    points: 5,
    options: [
      AnswerOptionModel(
        id: 'tf1',
        text: 'True',
        isCorrect: true,
        isSelected: true,
      ),
      AnswerOptionModel(
        id: 'tf2',
        text: 'False',
        isCorrect: false,
        isSelected: false,
      ),
    ],
    selectedOptionId: 'tf1',
    earnedPoints: 5,
    isCorrect: true,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d943700446',
    text: 'Which status code indicates a "Created" resource?',
    questionType: 'MCQ',
    timeLimit: 30,
    points: 2,
    options: [
      AnswerOptionModel(
        id: 'c1',
        text: '200',
        isCorrect: false,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'c2',
        text: '201',
        isCorrect: true,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'c3',
        text: '204',
        isCorrect: false,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'c4',
        text: '400',
        isCorrect: false,
        isSelected: true,
      ),
    ],
    selectedOptionId: 'c4',
    earnedPoints: 0,
    isCorrect: false,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d94370044b',
    text: '403 status code indicates "Forbidden".',
    questionType: 'TRUE_FALSE',
    timeLimit: 50,
    points: 2,
    options: [
      AnswerOptionModel(
        id: 'tf3',
        text: 'True',
        isCorrect: true,
        isSelected: true,
      ),
      AnswerOptionModel(
        id: 'tf4',
        text: 'False',
        isCorrect: false,
        isSelected: false,
      ),
    ],
    selectedOptionId: 'tf3',
    earnedPoints: 2,
    isCorrect: true,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d943700450',
    text: 'What does a 500 Internal Server Error signify?',
    questionType: 'MCQ',
    timeLimit: 30,
    points: 2,
    options: [
      AnswerOptionModel(
        id: 's1',
        text: 'Bad Request',
        isCorrect: false,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 's2',
        text: 'Unexpected Condition',
        isCorrect: true,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 's3',
        text: 'Not Found',
        isCorrect: false,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 's4',
        text: 'Timeout',
        isCorrect: false,
        isSelected: true,
      ),
    ],
    selectedOptionId: 's4',
    earnedPoints: 0,
    isCorrect: false,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d943700455',
    text: 'DTOs should live in the Data Layer in Clean Architecture.',
    questionType: 'TRUE_FALSE',
    timeLimit: 30,
    points: 2,
    options: [
      AnswerOptionModel(
        id: 'tf5',
        text: 'True',
        isCorrect: true,
        isSelected: true,
      ),
      AnswerOptionModel(
        id: 'tf6',
        text: 'False',
        isCorrect: false,
        isSelected: false,
      ),
    ],
    selectedOptionId: 'tf5',
    earnedPoints: 2,
    isCorrect: true,
    isGraded: true,
  ),
  const SubmissionDetailsModel(
    id: '69c00b00c02d96d94370045a',
    text: 'Which SOLID principle stands for S?',
    questionType: 'MCQ',
    timeLimit: 30,
    points: 2,
    options: [
      AnswerOptionModel(
        id: 'so1',
        text: 'Open-Closed',
        isCorrect: false,
        isSelected: true,
      ),
      AnswerOptionModel(
        id: 'so2',
        text: 'Liskov',
        isCorrect: false,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'so3',
        text: 'Single Responsibility',
        isCorrect: true,
        isSelected: false,
      ),
      AnswerOptionModel(
        id: 'so4',
        text: 'Dependency Inversion',
        isCorrect: false,
        isSelected: false,
      ),
    ],
    selectedOptionId: 'so1',
    earnedPoints: 0,
    isCorrect: false,
    isGraded: true,
  ),

  // 11-20: Advanced Testing (Mainly Pending/Written)
  ...List.generate(
    10,
    (index) => SubmissionDetailsModel(
      id: 'pending_${index + 11}',
      text: 'Detailed explanation for advanced topic #${index + 11}?',
      questionType: 'WRITTEN',
      timeLimit: 120,
      points: 5,
      writtenAnswer: 'Sample student answer for question ${index + 11}',
      earnedPoints: 0,
      isCorrect: null,
      isGraded: false,
    ),
  ),

  // 21-30: Quick Mix (Correct/Incorrect)
  ...List.generate(10, (index) {
    bool isCorrect = index % 2 == 0;
    return SubmissionDetailsModel(
      id: 'mix_${index + 21}',
      text: 'Automated test question number ${index + 21} (True/False)',
      questionType: 'TRUE_FALSE',
      timeLimit: 15,
      points: 1,
      options: [
        AnswerOptionModel(
          id: 'a',
          text: 'True',
          isCorrect: isCorrect,
          isSelected: true,
        ),
        AnswerOptionModel(
          id: 'b',
          text: 'False',
          isCorrect: !isCorrect,
          isSelected: false,
        ),
      ],
      selectedOptionId: 'a',
      earnedPoints: isCorrect ? 1 : 0,
      isCorrect: isCorrect,
      isGraded: true,
    );
  }),
];
