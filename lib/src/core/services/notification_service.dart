import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;



class NoficationService {

  /// ✅ Declare the local notification plugin here
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> requestNotificationPermission() async {
    /// Request permission for notifications
    FirebaseMessaging messaging = FirebaseMessaging.instance;



    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    NotificationSettings settings=await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<String?> getToken() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      print("FCM Token: $token");
      return token;
    } catch (e) {
      print("Error getting FCM token: $e");
      return null;
    }
  }

  /// ✅ Initialize local notifications (for foreground messages)
  static void initLocalNotifications() {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    print("Local notifications initialized (if applicable).");
  }

  static void showLocalNotification(RemoteMessage message) async {
    // Skip manual local notification on iOS
    if (Platform.isIOS) return;

    final String? imageUrl = message.notification?.android?.imageUrl ?? message.notification?.apple?.imageUrl;

    BigPictureStyleInformation? bigPictureStyleInformation;

    if(imageUrl != null && imageUrl.isNotEmpty){
      final String filePath = await _downloadAndSaveImage(imageUrl, 'notif_img.jpg');
      bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(filePath),
        contentTitle: message.notification?.title,
        summaryText: message.notification?.body,
      );
    }

    final  AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation ?? const DefaultStyleInformation(true, true),
    );

    final NotificationDetails platformDetails  = NotificationDetails(android: androidDetails );

    _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformDetails ,
      payload: message.data['payload'], // Optional payload
    );
  }

  static void initNotificationListener() {
    /// Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message: ${message.notification?.title}');
      print("📩 Foreground Message: ${message.notification?.title}");
      print("📩 Message Body: ${message.notification?.body}");
      print("📩 Message Data: ${message.data}");
      // Handle the message here, e.g., show a dialog or notificatio

      // Log everything from the message
      print('📬 Full RemoteMessage payload: ${message.toMap()}');

      // Print structured logs
      print("🔔 Title: ${message.notification?.title}");
      print("📝 Body: ${message.notification?.body}");
      print("📦 Data: ${message.data}");

      // Print the image URL if present (Android or Apple)
      final String? imageUrl = message.notification?.android?.imageUrl ?? message.notification?.apple?.imageUrl;
      if (imageUrl != null && imageUrl.isNotEmpty) {
        print("🖼️ Image URL: $imageUrl");
      } else {
        print("🖼️ No image URL found in notification");
      }

      // ✅ Show local notification for foreground messages
      showLocalNotification(message);

    });

    /// Listen for background messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      /// Handle the message when the app is opened from a notification
    });
  }

  static Future<String> _downloadAndSaveImage(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}