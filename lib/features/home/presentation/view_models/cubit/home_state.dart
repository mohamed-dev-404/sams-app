import 'package:flutter/material.dart';
import 'package:sams_app/features/home/data/models/course_model.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<CourseModel> courses;
  HomeSuccess(this.courses);
}

final class HomeFailure extends HomeState {
  final String errMessage;
  HomeFailure(this.errMessage);
}

sealed class CourseActionState extends HomeState {}

final class CreateCourseLoading extends CourseActionState {}

final class CreateCourseSuccess extends CourseActionState {
  final String message;
  CreateCourseSuccess(this.message);
}

final class CreateCourseFailure extends CourseActionState {
  final String errMessage;
  CreateCourseFailure(this.errMessage);
}
