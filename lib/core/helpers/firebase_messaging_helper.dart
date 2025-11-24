import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseMessagingHelper {
  static requestFirebaseMessagingPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static registerFirebaseToken() async {
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    print("token: $token");
  }

  static Future<void> checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      firebaseMessageHandler(initialMessage);
    }
  }

  static Future<void> firebaseMessageHandler(
      RemoteMessage remoteMessage) async {
    final String notificationTitle = remoteMessage.notification?.title ?? "";
    final String notificationBody = remoteMessage.notification?.body ?? "";

    if (notificationTitle.isNotEmpty && notificationBody.isNotEmpty) {}
  }

  static Future<void> initMessaging() async {
    /*ApiConstants.baseUrl = dotenv.env['URL_PROD']!;
    ApiConstants.hbBaseUrl = dotenv.env['HB_URL_PROD']!;
    await AppPreferences().init();
    SecurePreferences();
    TimeZoneConfig.initTimeZone();
    await NotificationsConfig().initNotification();*/
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    initMessaging();
    //send Request
  }

  static setListenMessageHandler() {
    FirebaseMessaging.onMessage.listen(firebaseMessageHandler);
  }

  static setOpenedAppMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen(firebaseMessageHandler);
  }

  static setBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }
}
