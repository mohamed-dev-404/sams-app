import 'package:flutter/material.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';

//* Base state for Material Actions (Create, Update, Delete).
@immutable
sealed class MaterialCrudState {}

/// Initial state before any action.
final class MaterialCrudInitial extends MaterialCrudState {}

//? Emitted while performing an action (e.g., uploading to S3 & Backend).
final class MaterialCrudLoading extends MaterialCrudState {}

//* Emitted when a material action completes successfully.
final class MaterialCrudSuccess extends MaterialCrudState {
  final MaterialModel material;
  final String message;
  MaterialCrudSuccess({required this.material, required this.message});
}

//! Emitted when an action fails.
final class MaterialCrudFailure extends MaterialCrudState {
  final String errMessage;
  MaterialCrudFailure(this.errMessage);
}
