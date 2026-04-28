import 'package:sams_app/features/assignments/data/model/assignment_item_model.dart';
import 'package:sams_app/features/assignments/data/model/assignment_model.dart';
import 'package:sams_app/features/assignments/data/model/helper/assignment_status_enum.dart';

List<AssignmentModel> mockAssignments = [
  // 1. STUDENT: Available (assigned + before dueDate)
  AssignmentModel(
    id: 'a_available_01',
    title: 'Assignment 1: Database Design',
    description:
        'Chapter 2: Design a relational schema for a university system with proper normalization.',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    dueDate: DateTime.now().add(const Duration(days: 3)),
    points: 100,
    status: AssignmentStatus.ongoing,
    enablePlagiarismCheck: false,
    plagiarismThreshold: null,
    classworkId: 'cw_01',
    assignmentItems: [
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
    ], submittedItems: [],
  ),

  // 2. STUDENT: Submitted (handed_in)
  AssignmentModel(
    id: 'a_submitted_02',
    title: 'Assignment 2: SQL Queries',
    description:
        'Chapter 3: Write complex JOIN and subquery statements for the given dataset.',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    dueDate: DateTime.now().add(const Duration(days: 1)),
    points: 50,
    status: AssignmentStatus.handedIn,
    enablePlagiarismCheck: true,
    plagiarismThreshold: 30,
    classworkId: 'cw_01',
    assignmentItems: [
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
    ], submittedItems: [],
  ),

  // 3. STUDENT: Missed (status: missed)
  AssignmentModel(
    id: 'a_missed_03',
    title: 'Assignment 3: ER Diagrams',
    description:
        'Chapter 1: Draw a complete ER diagram for an e-commerce platform.',
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    dueDate: DateTime.now().subtract(const Duration(days: 2)),
    points: 30,
    status: AssignmentStatus.missed,
    enablePlagiarismCheck: false,
    plagiarismThreshold: null,
    classworkId: 'cw_01',
    assignmentItems: [
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
    ], submittedItems: [],
  ),

  // 4. STUDENT: Missed (assigned + overdue - edge case)
  AssignmentModel(
    id: 'a_missed_overdue_04',
    title: 'Pop Quiz: Normalization',
    description:
        'Chapter 2: Design a relational schema for a university system with proper normalization.',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    dueDate: DateTime.now().subtract(const Duration(hours: 3)),
    points: 20,
    status: AssignmentStatus.assigned,
    enablePlagiarismCheck: false,
    plagiarismThreshold: null,
    classworkId: 'cw_01',
    assignmentItems: [
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
    ], submittedItems: [],
  ),

  // 5. INSTRUCTOR: Ongoing
  AssignmentModel(
    id: 'a_ongoing_05',
    title: 'Assignment 4: Indexing Strategies',
    description:
        'Chapter 4: Analyze and optimize query performance using indexing.',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    dueDate: DateTime.now().add(const Duration(days: 5)),
    points: 80,
    status: AssignmentStatus.ongoing,
    enablePlagiarismCheck: true,
    plagiarismThreshold: 20,
    classworkId: 'cw_02',
    assignmentItems: [
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
    ], submittedItems: [],
  ),

  // 6. INSTRUCTOR: Closed
  AssignmentModel(
    id: 'a_closed_06',
    title: 'Assignment 0: Intro Report',
    description:
        'Chapter 1: Write a brief report on the history of database systems.',
    createdAt: DateTime.now().subtract(const Duration(days: 14)),
    dueDate: DateTime.now().subtract(const Duration(days: 7)),
    points: 10,
    status: AssignmentStatus.closed,
    enablePlagiarismCheck: false,
    plagiarismThreshold: null,
    classworkId: 'cw_02',
    assignmentItems: [
      AssignmentItemModel(
        originalFileName: 'ERD_Requirements.pdf',
        key: 'files/erd_req.pdf',
        displayUrl:
            'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
      ),
      AssignmentItemModel(
        originalFileName: 'Sample_Schema.png',
        key: 'images/sample.png',
        displayUrl: 'https://placeholder.com/600x400',
      ),
    ], submittedItems: [],
  ),
];
