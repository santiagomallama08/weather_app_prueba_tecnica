import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'No se pudo consultar la información climática.',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([
    super.message = 'No existe información guardada localmente.',
  ]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'No hay conexión a internet.',
  ]);
}

class LocationFailure extends Failure {
  const LocationFailure([
    super.message = 'No se pudo obtener la ubicación.',
  ]);
}

class PermissionFailure extends Failure {
  const PermissionFailure([
    super.message = 'El permiso de ubicación fue denegado.',
  ]);
}