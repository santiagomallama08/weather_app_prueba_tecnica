class ServerException implements Exception {
  final String message;

  const ServerException([
    this.message = 'Ocurrió un error consultando el servidor.',
  ]);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  const CacheException([
    this.message = 'No hay información guardada en el dispositivo.',
  ]);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  const NetworkException([
    this.message = 'No hay conexión a internet.',
  ]);

  @override
  String toString() => message;
}

class LocationException implements Exception {
  final String message;

  const LocationException([
    this.message = 'No se pudo obtener la ubicación actual.',
  ]);

  @override
  String toString() => message;
}

class PermissionException implements Exception {
  final String message;

  const PermissionException([
    this.message = 'Permiso de ubicación denegado.',
  ]);

  @override
  String toString() => message;
}