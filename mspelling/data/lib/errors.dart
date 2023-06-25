class PermissionNotGrantedException implements Exception {
  String message =
      'Could not read or write data to file due to a permission error';

  @override
  String toString() => message;
}
