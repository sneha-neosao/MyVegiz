import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:myvegiz_flutter/src/app.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/constants/list_translation_locale.dart';
import 'package:myvegiz_flutter/src/core/services/location_service.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:path_provider/path_provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // ✅ Initialize Firebase
  await Firebase.initializeApp();

  // ✅ Initialize GETIt service locators
  configureDepedencies();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  // ✅ Ask for location permission + save location
  final servicesOk = await LocationService.ensureServiceEnabled();
  if (servicesOk) {
    final permission = await LocationService.checkAndRequestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      print("Location permission granted ✅");

      // Fetch current position
      final pos = await LocationService.getCurrentPosition();
      if (pos != null) {
        // Reverse geocode to address
        final addr = await LocationService.getAddressFromLatLng(pos);

        // Save to SessionManager
        await SessionManager.saveLiveLocation(
          latitude: pos.latitude,
          longitude: pos.longitude,
          address: addr,
        );

        print("Saved location: $addr (${pos.latitude}, ${pos.longitude})");
      }
    } else {
      print("Location permission denied ❌");
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocale],
      path: "assets/translations",
      startLocale: englishLocale,
      child: const MyApp(),
    ),
  );
}
