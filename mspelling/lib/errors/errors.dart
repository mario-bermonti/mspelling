/// Base exception on which to baes all other exceptions
abstract class MSpellingExeption implements Exception {
  String userMessage();
}

/// Generic exception for handling unknown errors
class GenericMSpellingException implements MSpellingExeption {
  String exceptionMessage;

  GenericMSpellingException(this.exceptionMessage);

  @override
  String userMessage() => 'Unknown error:\n $exceptionMessage';

  @override
  String toString() => exceptionMessage;
}

class WorkspaceAccessException implements MSpellingExeption {
  String exceptionMessage =
      'Could not access the workspace. It is probably not set';

  @override
  String userMessage() => 'El área de trabajo no fue encontrado';

  @override
  String toString() => exceptionMessage;
}

class StimFileNotFoundException implements MSpellingExeption {
  String exceptionMessage = 'Stim file not found in workspace';

  @override
  String userMessage() =>
      'Los estímulos no fueron encontrados en el área de trabajo';

  @override
  String toString() => exceptionMessage;
}

class PermissionNotGrantedException implements MSpellingExeption {
  String exceptionMessage =
      'Could not read or write data to file due to a permission error';

  @override
  String userMessage() => 'No tienes acceso para leer o escribir datos';

  @override
  String toString() => exceptionMessage;
}
