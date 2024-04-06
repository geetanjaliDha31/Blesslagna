import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blesslagna/API/miscellaneous.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    showBadge: true,
    enableLights: true,
    playSound: true);

Future<void> sendUserNotificationPermission() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            priority: Priority.high,
            playSound: true,
            channelShowBadge: true,
            onlyAlertOnce: true,
            enableVibration: true,
            // icon: 'applogo',
          ),
        ),
      );
    }
  });

  await getFCM();
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> setupInteractedMessage({
  required BuildContext context,
  required WidgetRef ref,
}) async {
  // Get any messages which caused the application to open
  await FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      // handleMessage(message: message.data, context: context, ref: ref);
    }
  });

  var ios = const DarwinInitializationSettings();
  var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
  var setting = InitializationSettings(android: android, iOS: ios);

  await flutterLocalNotificationsPlugin.initialize(
    setting,
    onDidReceiveNotificationResponse: (notificationResponse) async {
      if (notificationResponse.payload == null) return;
      var payload = jsonDecode(notificationResponse.payload.toString());
      handleMessage(message: payload["data"], context: context, ref: ref);
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      handleMessage(message: message.data, context: context, ref: ref);
    },
    cancelOnError: true,
    onError: (error) {
      // Handle error
    },
  );
}

//get fcm usercheck

getFCM() async {
  // Get the token each time the application loads

  if (Platform.isIOS) {
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();

    if (apnsToken == null) {
      log(apnsToken.toString());
      return;
    }
  }

  String? token = await FirebaseMessaging.instance.getToken();

  Future saveTokenToDatabase(String fcmToken) async {
    log(fcmToken);
    await Miscellaneous().sendFcmToken(fcmtoken: fcmToken);
  }

  // Save the initial token to the database
  await saveTokenToDatabase(token!);
  // Any time the token refreshes, store this in the database too.
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
}

void handleMessage(
    {required Map message,
    required BuildContext context,
    required WidgetRef ref}) async {
  // write(message.toString());
  if (message["type"] == null) {
    return;
  }
  String screenToOpen = message['type'];
  // Navigate to the screen.

  if ("chatScreen" == screenToOpen) {
    // ref.watch(screenIndexProvider.notifier).state = 3;
    // Navigator.push(context, MaterialPageRoute(builder: (_) => const Navbar()));
  }
  if ("chat" == screenToOpen) {
    var data = jsonDecode(message['body']);
    print(data);
    data['firebaseId'] == ""
        ? toast("Not Allowed")
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatingScreen(
                    photo: "http://app.blesslagna.com/${data['image']}",
                    name: data['userName'],
                    oppsitid: data['senderId'],
                    opossitefirebaseid: data["firebaseId"])));
    // write(data.toString());
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => ChatRoomScreen(
    //         myid: ref.read(userDataProvider).id.toString(),
    //         userName: data["userName"],
    //         image: data["image"],
    //         isAccepted: data["isAccepted"] ?? false,
    //         isDisable: data["isDisable"] ?? false,
    //         tripId: data["tripId"].toString(),
    //         orderId: data["orderId"].toString(),
    //         chatId: data["chatId"],
    //         istraveller: data["isTraveller"] ?? false,
    //         recieverid: data["senderId"].toString()),
    // ),
    // );
  }
}
