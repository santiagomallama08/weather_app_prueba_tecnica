class LocationSuggestion {
  final String displayName;
  final double latitude;
  final double longitude;

  const LocationSuggestion({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  String get apiValue => '$latitude,$longitude';
}