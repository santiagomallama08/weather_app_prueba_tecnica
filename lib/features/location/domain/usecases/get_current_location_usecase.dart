import 'package:geolocator/geolocator.dart';

import '../../../../core/error/exceptions.dart';

class GetCurrentLocationUseCase {
  Future<String> call() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw const LocationException(
        'El servicio de ubicación está desactivado.',
      );
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const PermissionException('Permiso de ubicación denegado.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw const PermissionException(
        'El permiso de ubicación fue denegado permanentemente.',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return '${position.latitude},${position.longitude}';
  }
}
