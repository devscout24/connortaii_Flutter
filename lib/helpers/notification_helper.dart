import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constants/app_constants.dart';
import 'di.dart';

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: "This is notification description",
    importance: Importance.defaultImportance,
  );

  final _localNotification = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // navigation route
    // Get.to(()=> const NotificationScreen());
    // NavigationService.navigateTo(Routes.navigationScreen);
  }

  Future initLocalNotification() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotification.initialize(
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
        handleMessage(message);
      },
      settings: settings,
    );

    final platform = _localNotification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Handle when app is launched initially via a notification
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle when the app is opened via a notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        // Display local notification for foreground messages
        _localNotification.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_notification',
            ),
            iOS: const DarwinNotificationDetails(),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log("Title ${message.notification?.title ?? ""}");
    log("Body ${message.notification?.body ?? ""}");
    log("data ${message.data}");
  }

  Future<void> initNotification() async {
    try {
      // Request permission for notifications
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      String? fcmToken;
      // String? apnsToken;
      // Platform-specific handling for token retrieval
      if (Platform.isIOS) {
        log("Come here");
        log(FirebaseMessaging.instance.toString());
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        //  Fluttertoast.showToast(msg: apnsToken.toString());
        fcmToken = await _firebaseMessaging.getToken();
        log("FCM Token is =======> $fcmToken");
        // Fluttertoast.showToast(msg: fcmToken.toString());
        if (apnsToken != null) {
          fcmToken = apnsToken;
          fcmToken = await _firebaseMessaging.getToken();
          log("FCM Token =====>>> $fcmToken");
          log("APNS Token =====>>> $apnsToken");
        } else {
          log("Error: APNS token is not set.");
        }
      } else {
        fcmToken = await _firebaseMessaging.getToken();
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();

        log("FCM Token =====>>> $fcmToken");
        log("Apns Token =====>>> $apnsToken");
      }

      // Save the FCM token globally and persist it
      var globalfcmToken = fcmToken ?? 'noFCMToken';
      appData.write(kKeyFCMToken, fcmToken);
      // var globalApnsToken = apnsToken ?? 'noAPNSToken';
      // appData.write(kKeyAPNSToken, globalApnsToken);

      // Log device-specific details
      log("Device ID =====>>> ${appData.read(kKeyDeviceID)}");
      log("FCM Token =====>>> $globalfcmToken");

      //  fcmTokenRxObj.fcmToken(
      //     token: appData.read(kKeyFCMToken).toString(),
      //     deviceId: appData.read(kKeyDeviceID).toString());

      // Push notification and local notification initialization
      await initPushNotification();
      await initLocalNotification();

      // (Optional) Perform any additional API calls with token and device details
      // Example:
      // addTokenRx.addToken(
      //   id: userId,
      //   token: globalfcmToken,
      //   deviceId: appData.read(kKeyDeviceID),
      // );
    } catch (e) {
      log("Error initializing notifications: $e");
    }

    // notificaation api call pass user id , fcm token , device token, is active
    // addTokenRx.addToken(id: id, token: fcmToken!, deviceId: appData.read(kKeyDeviceID));

    initPushNotification();
    initLocalNotification();
  }
}
