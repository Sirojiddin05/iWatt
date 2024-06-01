// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class PushNotificationService {
//   static NotificationBloc bloc = NotificationBloc();
//   static late FirebaseMessaging messaging;
//
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       "high importance channel", "High importance Notifications",
//       description: "This channel is used for important notifications", importance: Importance.max);
//
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     // bloc.add(NotificationCountEvent());
//   }
//
//   static Future<void> resolvePlatformSpecificImplementationAndroid() async {
//     if (Platform.isAndroid) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//     }
//   }
//
//   static Future<void> resolvePlatformSpecificImplementationIos() async {
//     if (Platform.isIOS) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
//           ?.requestPermissions(alert: true, badge: true, sound: true);
//     }
//   }
//
//   static Future<void> setForegroundNotificationPresentationOptions() async => await FirebaseMessaging.instance
//       .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
//
//   static Future<void> messagingRequestPermission() async => await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true);
//
//   static Future<void> configurationFirebaseNotification() async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     resolvePlatformSpecificImplementationAndroid();
//     resolvePlatformSpecificImplementationIos();
//
//     messaging = FirebaseMessaging.instance;
//     print('fcm token: ${await FirebaseMessaging.instance.getToken()}');
//
//     StorageRepository.putBool(key: 'notification_token', value: true);
//     // bloc.add(RegisterNotification(() {}, showError: false));
//
//     await setForegroundNotificationPresentationOptions();
//     await FirebaseMessaging.instance.subscribeToTopic("all");
//     await messagingRequestPermission();
//   }
//
//   static void initializeFlutterLocalNotificationsPlugin() {
//     var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = const DarwinInitializationSettings();
//     var initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   static void listenFireBaseOnMessage() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Message received: ${message.notification?.body}");
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       // bloc.add(NotificationCountEvent());
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             1,
//             notification.body,
//             notification.title,
//             NotificationDetails(
//                 android: AndroidNotificationDetails(channel.id, channel.name,
//                     channelDescription: channel.description, icon: android.smallIcon)));
//       }
//     }, onError: (error) {
//       print("Error in receiving message: $error");
//     });
//   }
//
//   static void initializeAndListenFirebaseMessaging() {
//     initializeFlutterLocalNotificationsPlugin();
//     listenFireBaseOnMessage();
//     FirebaseMessaging.instance.getInitialMessage();
//   }
// }
