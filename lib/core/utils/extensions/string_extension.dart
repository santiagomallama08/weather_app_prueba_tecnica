extension StringExtension on String {
  bool get isBlank => trim().isEmpty;

  String get normalizedLocation => trim().replaceAll(' ', '%20');

  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}