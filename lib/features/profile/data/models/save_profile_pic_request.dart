class SaveProfilePicRequest{
  final String key;

  SaveProfilePicRequest({required this.key});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
    };
  }
}
