import 'package:flutter/material.dart';
import 'package:sams_app/core/extentions/filter_files_helper.dart';
import 'package:sams_app/core/utils/constants/api_keys.dart';

class AssignmentItemModel {
  final String? originalFileName;
  final String? key;
  final String? displayUrl;

  AssignmentItemModel({
    this.originalFileName,
    this.key,
    this.displayUrl,
  });

  bool get isVideoItem => originalFileName?.isVideo ?? false;
  IconData get icon => originalFileName?.fileIcon ?? Icons.insert_drive_file;
  Color get color => originalFileName?.fileColor ?? Colors.grey;

  factory AssignmentItemModel.fromJson(Map<String, dynamic> json) {
    return AssignmentItemModel(
      originalFileName: json[ApiKeys.originalFileName] as String?,
      key: json[ApiKeys.key] as String?,
      displayUrl: json[ApiKeys.displayUrl] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    ApiKeys.originalFileName: originalFileName,
    ApiKeys.key: key,
    ApiKeys.displayUrl: displayUrl,
  };
}