// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     importance: Importance.high,
//     showBadge: true,
//     enableLights: true,
//     playSound: true);

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

// getFCM({required String userId}) async {
//   // Get the token each time the application loads

//   if (Platform.isIOS) {
//     String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();

//     if (apnsToken == null) {
//       log(apnsToken.toString());
//       return;
//     }
//   }

//   String? token = await FirebaseMessaging.instance.getToken();

//   Future saveTokenToDatabase(String fcmToken) async {
//     // await Miscellaneous().sendFcmToken(fcmtoken: fcmToken);
//   }

//   // Save the initial token to the database
//   await saveTokenToDatabase(token!);
//   // Any time the token refreshes, store this in the database too.
//   FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
// }

// void handleMessage(
//     {required Map message,
//     required BuildContext context,
//     required WidgetRef ref}) async {
//   // write(message.toString());
//   if (message["type"] == null) {
//     return;
//   }
//   String screenToOpen = message['type'];
//   // Navigate to the screen.

//   if ("chatScreen" == screenToOpen) {
//     // ref.watch(screenIndexProvider.notifier).state = 3;
//     // Navigator.push(context, MaterialPageRoute(builder: (_) => const Navbar()));
//   }
//   if ("chat" == screenToOpen) {
//     var data = jsonDecode(message['body']);
//     // write(data.toString());
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (_) => ChatRoomScreen(
//     //         myid: ref.read(userDataProvider).id.toString(),
//     //         userName: data["userName"],
//     //         image: data["image"],
//     //         isAccepted: data["isAccepted"] ?? false,
//     //         isDisable: data["isDisable"] ?? false,
//     //         tripId: data["tripId"].toString(),
//     //         orderId: data["orderId"].toString(),
//     //         chatId: data["chatId"],
//     //         istraveller: data["isTraveller"] ?? false,
//     //         recieverid: data["senderId"].toString()),
//     // ),
//     // );
//   }
// }
