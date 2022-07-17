extension StringEctensions on String {
  String get shortSentence {
    if (length > 30) {
      return '${substring(0, 30)}...';
    } else {
      return this;
    }
  }
}
