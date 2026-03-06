extension StringFormat on String {
  String get firstTwoNames {
    List<String> names = trim().split(RegExp(r'\s+'));
    if (names.length <= 2) return this;
    return '${names[0]} ${names[1]}';
  }
}
