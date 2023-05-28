// Define errors: exception and name

Map<String, dynamic> errorWorkspaceAccess = <String, dynamic>{
  'userMessage': 'El área de trabajo no fue encontrado',
  'exceptionMessage': 'Could not access the workspace. It is probably not set',
};
Map<String, dynamic> errorStimFileNotFound = <String, dynamic>{
  'userMessage': 'Los estímulos no fueron encontrados en el área de trabajo',
  'exceptionMessage': 'Stim file not found in workspace',
};
Map<String, dynamic> errorPermissionNotGranted = <String, dynamic>{
  'userMessage': 'No tienes acceso para leer o escribir datos',
  'exceptionMessage': 'Could not read or write data to file due to permission',
};

class WorkspaceAccessException implements Exception {
  String exceptionMessage =
      'Could not access the workspace. It is probably not set';
  String userMessage = 'El área de trabajo no fue encontrado';

  @override
  String toString() => exceptionMessage;
}

class StimFileNotFoundException implements Exception {
  String exceptionMessage = 'Stim file not found in workspace';
  String userMessage =
      'Los estímulos no fueron encontrados en el área de trabajo';

  @override
  String toString() => exceptionMessage;
}

class PermissionNotGrantedException implements Exception {
  String exceptionMessage =
      'Could not read or write data to file due to a permission error';
  String userMessage = 'No tienes acceso para leer o escribir datos';

  @override
  String toString() => exceptionMessage;
}
// define function for throwing errors

// define exceptions
// workspace not found
// Data not found - stim file
// permission not granted
