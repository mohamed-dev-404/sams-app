import 'package:flutter/material.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';

//* Base state for Home feature.
//* All Home states extend this class.
@immutable
sealed class HomeState {}

/// Initial state before any action.
final class HomeInitial extends HomeState {}

//? Emitted while loading courses.
final class HomeLoading extends HomeState {}

//* Emitted when courses loaded successfully and emits list of courses.
final class HomeSuccess extends HomeState {
  final List<CourseModel> courses;
  HomeSuccess(this.courses);
}

//! Emitted when loading courses fails and emits error message.
final class HomeFailure extends HomeState {
  final String errMessage;
  HomeFailure(this.errMessage);
}

//* Base state for course actions .
//* Used for create/join operations.
sealed class CourseActionState extends HomeState {}

//? Emitted while creating a course.
final class CreateCourseLoading extends CourseActionState {}

//* Emitted when course created successfully and emits success message.
final class CreateCourseSuccess extends CourseActionState {
  final String message;
  CreateCourseSuccess(this.message);
}

//! Emitted when course creation fails and emits error message.
final class CreateCourseFailure extends CourseActionState {
  final String errMessage;
  CreateCourseFailure(this.errMessage);
}

//? Emitted while joining a course.
final class JoinCourseLoading extends CourseActionState {}

//* Emitted when course joined successfully and emits success message.
final class JoinCourseSuccess extends CourseActionState {
  final String message;
  JoinCourseSuccess(this.message);
}

//! Emitted when joining course fails and emits error message.
final class JoinCourseFailure extends CourseActionState {
  final String errMessage;
  JoinCourseFailure(this.errMessage);
}
