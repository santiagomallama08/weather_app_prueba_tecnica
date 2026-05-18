# Weather Events App

Aplicación móvil desarrollada en Flutter para consultar eventos meteorológicos y el pronóstico climático de los últimos 5 días a partir de una ubicación ingresada por el usuario o de la ubicación actual del dispositivo.

Este proyecto fue desarrollado como prueba técnica para el puesto de Desarrollador junior Flutter, aplicando buenas prácticas de arquitectura, separación de responsabilidades, consumo de APIs externas, manejo de estado, persistencia local, flavors, modo offline y pruebas unitarias.

---

## Arquitectura general

La aplicación está organizada por módulos funcionales y capas, separando presentación, dominio, datos e infraestructura compartida.

## Objetivo del proyecto

El objetivo principal es construir una aplicación Flutter para Android/iOS que permita:

- Consultar eventos meteorológicos basados en ubicación.
- Consultar el clima actual y diario de los últimos 5 días.
- Permitir ingreso manual de localización.
- Permitir uso de ubicación actual.
- Presentar datos en español.
- Presentar medidas en sistema métrico.
- Manejar favoritos almacenados localmente.
- Soportar modo offline con última información guardada.
- Implementar flavors dev/prod.
- Incluir pruebas unitarias.
- Aplicar una arquitectura clara y mantenible.
## Funcionalidades implementadas

### Ubicación

- Ingreso manual de ubicación.
- Sugerencias de ubicación mientras el usuario escribe.
- Uso de ubicación actual mediante GPS.
- Consulta por ciudad, municipio, país, dirección o coordenadas.

### Eventos meteorológicos

- Consulta de eventos desde VisualCrossing Timeline Weather API.
- Uso de `include=events`.
- Listado de eventos encontrados.
- Pantalla de detalle del evento.
- Visualización de tipo, descripción, fecha, ubicación y coordenadas.
- Opción de agregar o eliminar favoritos.
- Opción de ver la ubicación en mapa.

### Pronóstico últimos 5 días

- Consulta del clima actual.
- Consulta del clima diario de los últimos 5 días.
- Temperatura actual.
- Temperatura mínima y máxima.
- Humedad.
- Viento.
- Precipitación.
- Condiciones climáticas.
- Coordenadas.
- Datos en español y sistema métrico.

### Favoritos

- Agregar eventos a favoritos.
- Eliminar eventos de favoritos.
- Mensajes visuales al usuario:
  - `Añadido a favoritos.`
  - `Eliminado de favoritos.`
- Cambio visual del corazón en tarjetas.
- Pantalla independiente de favoritos.
- Lectura local de favoritos.

### Modo offline

La aplicación detecta cuando no hay conexión a internet.

Con internet:

- Consulta VisualCrossing.
- Muestra datos actualizados.
- Guarda información localmente.

Sin internet:

- Carga la última información guardada cuando existe.
- Notifica al usuario que no tiene conexión.
- Permite consultar favoritos guardados.

Mensaje mostrado:

Sin conexión. Mostrando la última información guardada.

Mapa
Vista de mapa con OpenStreetMap.
Implementación usando flutter_map.
No requiere API Key de Google Maps.
Marcador de ubicación.
Visualización de coordenadas.
Flavors

La app cuenta con dos flavors:

dev
prod

Cada flavor tiene:

Entry point independiente.
Nombre diferente.
Icono diferente.
Configuración separada.

Arquitectura

El proyecto está organizado por features y capas.

lib/
├── core/
│   ├── config/
│   ├── di/
│   ├── error/
│   ├── network/
│   ├── theme/
│   └── utils/
│
├── features/
│   ├── events/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── forecast/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── location/
│       ├── domain/
│       └── presentation/
│
├── router/
├── app.dart
├── main_dev.dart
└── main_prod.dart
Capa presentation

Contiene:

Screens.
Widgets.
Notifiers.
Estados de carga.
Estados de error.
Estados offline.
Capa domain

Contiene:

Entidades.
Contratos de repositorios.
Casos de uso.

Esta capa no depende de Flutter ni de implementaciones externas.

Capa data

Contiene:

APIs.
Modelos.
Repositorios implementados.
Almacenamiento local.
Capa core

Contiene elementos transversales:

Configuración global.
Inyección de dependencias.
Cliente HTTP.
Manejo de red.
Tema visual.
Constantes.
Errores.
Decisiones técnicas
Riverpod

Se usó Riverpod para manejar el estado de la aplicación de forma clara y separada de la UI.

Estados principales:

Loading.
Error.
Data.
Offline.
Favoritos.
GetIt

GetIt centraliza la creación de dependencias como:

Dio.
Repositorios.
Casos de uso.
Servicios locales.
NetworkInfo.
Dio

Se utilizó Dio para consumir APIs externas por su manejo claro de:

Base URL.
Query parameters.
Interceptores.
Timeouts.
Realm

Realm se utilizó para persistencia local y soporte offline.

GoRouter

GoRouter se usó para navegación entre pantallas usando rutas centralizadas.

Flutter Map

Se eligió Flutter Map con OpenStreetMap para evitar dependencia de Google Maps Platform y no requerir API Key adicional.

API utilizada

La aplicación consume VisualCrossing Timeline Weather API.

Base URL:

https://weather.visualcrossing.com

Endpoint base:

/VisualCrossingWebServices/rest/services/timeline
Eventos

Para eventos meteorológicos:

include=events
Últimos 5 días

Para clima actual y diario:

include=days,current
Parámetros comunes
unitGroup=metric
lang=es
contentType=json
Variables de entorno

El proyecto usa un archivo .env.

Crear en la raíz del proyecto:

.env

Contenido:

VISUAL_CROSSING_API_KEY=TU_API_KEY
VISUAL_CROSSING_BASE_URL=https://weather.visualcrossing.com

También se incluye:

.env.example

Contenido:

VISUAL_CROSSING_API_KEY=YOUR_API_KEY
VISUAL_CROSSING_BASE_URL=https://weather.visualcrossing.com

La API Key real no debe subirse al repositorio.

Instalación

Clonar el repositorio:

git clone <url-del-repositorio>

Entrar al proyecto:

cd weather_events_app

Instalar dependencias:

flutter pub get

Generar archivos de Realm:

dart run realm generate
Ejecución
Dev
flutter run --flavor dev -t lib/main_dev.dart

Si el emulador presenta problemas con DDS:

flutter run --flavor dev -t lib/main_dev.dart --no-dds
Prod
flutter run --flavor prod -t lib/main_prod.dart
Generar APK
Dev
flutter build apk --flavor dev -t lib/main_dev.dart
Prod
flutter build apk --flavor prod -t lib/main_prod.dart

Los APK se generan en:

build/app/outputs/flutter-apk/
Flavors
Dev
Flavor: dev
App name: Weather Events Dev
Application ID: com.example.weather_events_app.dev
Entry point: lib/main_dev.dart
Prod
Flavor: prod
App name: Weather Events
Application ID: com.example.weather_events_app
Entry point: lib/main_prod.dart
Iconos por flavor

Se configuraron iconos separados usando flutter_launcher_icons.

Archivos:

flutter_launcher_icons-dev.yaml
flutter_launcher_icons-prod.yaml

Rutas:

assets/dev/icons/app_icon_dev.png
assets/prod/icons/app_icon_prod.png

Comandos:

dart run flutter_launcher_icons -f flutter_launcher_icons-dev.yaml
dart run flutter_launcher_icons -f flutter_launcher_icons-prod.yaml
Pruebas unitarias

El proyecto incluye pruebas unitarias para validar la lógica principal de dominio.

Ejecutar:

flutter test

Casos cubiertos:

Obtener eventos por ubicación.
Validar ubicación vacía en eventos.
Agregar o eliminar favorito.
Obtener clima actual y últimos días.
Validar ubicación vacía en forecast.
Verificar llamadas a repositorios mediante mocks.

Archivos:

test/features/events/domain/usecases/get_events_test.dart
test/features/events/domain/usecases/toggle_favorite_test.dart
test/features/forecast/domain/usecases/get_last_five_days_test.dart

Resultado esperado:

All tests passed
Análisis estático

Ejecutar:

flutter analyze

El proyecto debe mantenerse sin errores ni warnings relevantes.

Permisos Android

La app requiere permisos para internet y ubicación.

En AndroidManifest.xml:

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
Manejo offline

El modo offline funciona de la siguiente forma:

Con internet
1. Se consulta la API.
2. Se muestran datos actualizados.
3. Se guarda información localmente.
Sin internet
1. Se detecta falta de conexión.
2. Se consulta el almacenamiento local.
3. Se muestra la última información guardada.
4. Se informa al usuario que está sin conexión.
Favoritos offline

Los favoritos no dependen de conexión a internet.

El usuario puede:

Consultar favoritos guardados.
Eliminar favoritos.
Ver aviso si no tiene internet.
Consideraciones

Los eventos meteorológicos dependen de la disponibilidad de reportes en VisualCrossing.

Puede pasar que una ciudad no tenga eventos disponibles en el rango consultado. En ese caso la aplicación muestra un mensaje de estado vacío, pero la consulta puede estar funcionando correctamente.

Comandos útiles
flutter pub get
dart run realm generate
flutter analyze
flutter test
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor dev -t lib/main_dev.dart --no-dds
flutter run --flavor prod -t lib/main_prod.dart
flutter build apk --flavor dev -t lib/main_dev.dart
flutter build apk --flavor prod -t lib/main_prod.dart

Autor

Desarrollado por Santiago Mallama como prueba técnica para Desarrolador Flutter Junior.

El objetivo del proyecto fue construir una solución funcional, mantenible y clara, aplicando buenas prácticas de Flutter, arquitectura por features, persistencia local, consumo de APIs externas, manejo offline, flavors y pruebas unitarias.