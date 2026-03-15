import 'package:flutter/material.dart';
import 'package:sams_app/features/materials/data/model/material_model.dart';

//* Base state for Materials feature.
@immutable
sealed class MaterialsState {}

/// Initial state before any action.
final class MaterialInitial extends MaterialsState {}

//? Emitted while loading materials or details.
final class MaterialLoading extends MaterialsState {}

//* Emitted when materials list loaded successfully.
final class MaterialSuccess extends MaterialsState {
  final List<MaterialModel> materials;
  MaterialSuccess(this.materials);
}

//* Emitted when a single material's details are loaded successfully.
final class MaterialDetailsSuccess extends MaterialsState {
  final MaterialModel material;
  MaterialDetailsSuccess(this.material);
}

//! Emitted when loading fails and no cached data is available.
final class MaterialFailure extends MaterialsState {
  final String errMessage;
  MaterialFailure(this.errMessage);
}
