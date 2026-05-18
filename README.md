Descripción
Weather Events App consume la VisualCrossing Timeline Weather API para mostrar eventos climáticos (tornados, granizo, vientos fuertes, sismos) y el estado del clima de los últimos 5 días. El usuario puede ingresar una ubicación manualmente, usar su GPS, guardar eventos favoritos y consultar la información sin conexión a internet gracias al almacenamiento local con Realm.
El proyecto aplica:

Clean Architecture organizada por features
Riverpod para manejo de estado
Realm para persistencia offline
Flavors dev y prod con recursos independientes
Tests unitarios en la capa de dominio


Funcionalidades
Ubicación

Ingreso manual con sugerencias en tiempo real
Detección automática por GPS
Soporte para ciudad, municipio, país, dirección o coordenadas

Eventos meteorológicos

Listado de eventos desde VisualCrossing (include=events)
Pantalla de detalle con tipo, descripción, fecha, ubicación y coordenadas
Agregar y eliminar favoritos
Ver ubicación del evento en mapa

Pronóstico últimos 5 días

Clima actual: temperatura, humedad, viento, precipitación, condiciones
Clima diario: temperatura mínima y máxima por día
Datos en español y sistema métrico

Favoritos

Agregar / eliminar desde cualquier tarjeta de evento
Feedback visual inmediato: Añadido a favoritos / Eliminado de favoritos
Icono de corazón con estado visual
Pantalla independiente de favoritos
Disponibles sin conexión a internet

Modo offline
EstadoComportamientoCon internetConsulta la API, muestra datos frescos y guarda localmenteSin internetCarga la última información guardada y notifica al usuario

Mensaje mostrado: Sin conexión. Mostrando la última información guardada.

Mapa

Vista con OpenStreetMap usando flutter_map (sin API Key de Google Maps)
Marcador de ubicación
Visualización de coordenadas en pantalla


Arquitectura
El proyecto sigue Clean Architecture organizado por features. Cada feature contiene sus propias capas de datos, dominio y presentación, sin mezclar responsabilidades entre módulos.
<img width="791" height="473" alt="image" src="https://github.com/user-attachments/assets/e3eaa1c3-f787-4ca1-819a-17f6e6977af2" />


Capa domain
Entidades puras Dart, contratos de repositorios (interfaces abstractas) y casos de uso. No depende de Flutter ni de implementaciones externas. Esto permite testearla de forma completamente aislada.
Capa data
Implementaciones de repositorios con estrategia offline-first: intenta la red primero, guarda en Realm, y devuelve cache si no hay conexión.
Capa presentation
Screens ConsumerWidget, widgets reutilizables y notifiers Riverpod (AsyncNotifier, StateNotifier). Los estados manejados son: loading, data, error y offline.
Capa core
Elementos transversales a todos los features: cliente HTTP, inyección de dependencias, tema visual, manejo de errores y configuración por flavor.

Decisiones técnicas
HerramientaJustificaciónRiverpodManejo de estado reactivo con AsyncNotifier. Separa la lógica de la UI, facilita testing y gestiona los estados loading / error / data de forma nativaGetItInyección de dependencias sin BuildContext. Permite registrar y proveer repositorios y casos de uso de forma centralizadaDioCliente HTTP con soporte de interceptors para autenticación, logging y detección de conectividadRealmPersistencia local para cache offline y favoritos. Soporta esquemas tipados y queries sin SQLGoRouterNavegación declarativa con rutas nombradas, compatible con el paradigma de Riverpodflutter_map + OpenStreetMapVista de mapa sin requerir API Key adicional de Google Maps PlatformClean ArchitectureSeparación clara de responsabilidades. La capa de dominio es independiente de Flutter, lo que hace los tests unitarios simples y confiables

API utilizada
VisualCrossing Timeline Weather API
Base URL: https://weather.visualcrossing.com
Endpoint: /VisualCrossingWebServices/rest/services/timeline
Endpoints
# Eventos meteorológicos
GET /timeline/{lat},{lng}?include=events&unitGroup=metric&lang=es&contentType=json

# Pronóstico últimos 5 días
GET /timeline/{lat},{lng}/last5days?include=days,current&unitGroup=metric&lang=es&contentType=json
Parámetros globales
ParámetroValorDescripciónunitGroupmetricTemperaturas en °C, viento en km/hlangesRespuestas en españolcontentTypejsonFormato de respuesta

Configuración del proyecto
Requisitos previos

Flutter 3.19+ / Dart 3.3+
Android Studio o Xcode configurado
API Key gratuita en visualcrossing.com

Variables de entorno
Crear el archivo .env en la raíz del proyecto:
envVISUAL_CROSSING_API_KEY=INGRESE_API_KEY
VISUAL_CROSSING_BASE_URL=https://weather.visualcrossing.com
Un archivo .env.example está incluido como referencia.
Instalación
bash# 1. Clonar el repositorio
git clone https://github.com/santiagomallama08/weather_app_prueba_tecnica.git
cd weather_events_app

# 2. Instalar dependencias
flutter pub get

# 3. Generar archivos de Realm
dart run realm generate

# 4. Verificar análisis estático
flutter analyze

Ejecución por flavor
Dev
bashflutter run --flavor dev -t lib/main_dev.dart

# Si el emulador presenta problemas con DDS:
flutter run --flavor dev -t lib/main_dev.dart --no-dds
Prod
bashflutter run --flavor prod -t lib/main_prod.dart
Build APK
bash# Dev
flutter build apk --flavor dev -t lib/main_dev.dart

# Prod
flutter build apk --flavor prod -t lib/main_prod.dart

Los APK se generan en build/app/outputs/flutter-apk/

Diferencias entre flavors
DevProdApp nameWeather Events DevWeather EventsApplication IDcom.example.weather_events_app.devcom.example.weather_events_appIconoassets/dev/icons/app_icon_dev.pngassets/prod/icons/app_icon_prod.pngEntry pointlib/main_dev.dartlib/main_prod.dart
Generar iconos por flavor
bashdart run flutter_launcher_icons -f flutter_launcher_icons-dev.yaml
dart run flutter_launcher_icons -f flutter_launcher_icons-prod.yaml

Tests unitarios
Las pruebas unitarias del proyecto se encuentran organizadas dentro de la carpeta `test`, siguiendo la misma separación por funcionalidades usada en la aplicación. En el módulo de eventos se incluyen pruebas para los casos de uso `get_events_test.dart` y `toggle_favorite_test.dart`, ubicadas en `test/features/events/domain/usecases/`. Estas pruebas validan la obtención de eventos por ubicación, el manejo de ubicaciones vacías y la acción de agregar o eliminar eventos favoritos. En el módulo de pronóstico se encuentra la prueba `get_last_five_days_test.dart`, ubicada en `test/features/forecast/domain/usecases/`, encargada de validar la obtención del clima actual y del pronóstico de los últimos cinco días mediante el repositorio correspondiente.

Resultado esperado: All tests passed


Permisos
Declarados en android/app/src/main/AndroidManifest.xml:
xml<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

Consideraciones
Los eventos meteorológicos dependen de la disponibilidad de reportes activos en VisualCrossing para la ubicación consultada. Si una ciudad no tiene eventos registrados en el rango de fechas, la aplicación muestra un estado vacío. Esto es comportamiento esperado de la API, no un error de la aplicación.

Comandos de referencia rápida
flutter pub get
dart run realm generate
flutter analyze
flutter test
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor prod -t lib/main_prod.dart
flutter build apk --flavor dev -t lib/main_dev.dart
flutter build apk --flavor prod -t lib/main_prod.dart
