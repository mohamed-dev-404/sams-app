class UploadUrlModel {
  final String key;
  final String uploadUrl;

  UploadUrlModel({required this.key, required this.uploadUrl});

  factory UploadUrlModel.fromJson(Map<String, dynamic> json) {
    return UploadUrlModel(
      key: json['key'] ?? '',
      uploadUrl: json['uploadUrl'] ?? '',
    );
  }
}
