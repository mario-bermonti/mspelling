class StimFileAccessException implements Exception {
  String message = 'stim.txt file not found in the specified workspace';

  @override
  String toString() => message;
}
